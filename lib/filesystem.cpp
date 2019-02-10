/* Basic file system operations. */

#include "common.h"

#include <windows.h>
#include <winbase.h>
#include <shlwapi.h>
#include <tchar.h>
#include <stdio.h>
#include <cstring>
#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <algorithm>

char g_ret_buffer[MAX_PATH + 1];
char empty{ 0 };

// Version number
external ty_real
fs_version()
{
	return 1.1;
}

// Username
external ty_string
fs_username()
{
	long unsigned int g_ret_buffer_len = sizeof(g_ret_buffer);
	if (GetUserName(g_ret_buffer, &g_ret_buffer_len))
	{
		g_ret_buffer[g_ret_buffer_len] = 0;
		return g_ret_buffer;
	}
	
	return &empty;
}

// Home Directory
external ty_string
fs_home_directory()
{
	if (SHGetFolderPath(
	  NULL,
	  CSIDL_PROFILE,
	  NULL,
	  0,
	  g_ret_buffer
	) == S_OK)
	{
		return g_ret_buffer;
	}
	else
	{
		return &empty;
	}
}

// Appdata/Roaming Directory
external ty_string
fs_appdata_directory()
{
	if (SHGetFolderPath(
	  NULL,
	  CSIDL_APPDATA,
	  NULL,
	  0,
	  g_ret_buffer
	) == S_OK)
	{
		return g_ret_buffer;
	}
	else
	{
		return &empty;
	}
}

// number of paths matching wildcard, or -1 if error.
// Ensure the path length does not exceed the operating system's MAX_PATH
external ty_real
fs_list_count(ty_string path)
{
	printf("(DEBUG) Received call at %s\n", path);
	if (strlen(path) >= MAX_PATH)
	{
		return -1;
	}
	
	WIN32_FIND_DATA ffd;
	HANDLE hFind;
	
	hFind = FindFirstFile(path, &ffd);
	if (hFind == INVALID_HANDLE_VALUE)
	{
		return 0;
	}
		
	size_t num_files = 1;
	while (FindNextFile(hFind, &ffd) != 0)
	{
		num_files++;
	}
	
	return num_files;
}

// returns true if the given path is a file, false otherwise.
external ty_real
fs_file_exists(ty_string path)
{
	if (strlen(path) >= MAX_PATH)
	{
		return -1;
	}
	
	WIN32_FIND_DATA ffd;
	HANDLE hFind;
	
	hFind = FindFirstFile(path, &ffd);
	if (hFind == INVALID_HANDLE_VALUE)
	{
		return false;
	}
		
	return !(ffd.dwFileAttributes & 0x10);
}

// returns true if the given path is a directory, false otherwise.
external ty_real
fs_directory_exists(ty_string path)
{
	if (strlen(path) >= MAX_PATH)
	{
		return -1;
	}
	
	WIN32_FIND_DATA ffd;
	HANDLE hFind;
	
	hFind = FindFirstFile(path, &ffd);
	if (hFind == INVALID_HANDLE_VALUE)
	{
		return false;
	}
		
	return ffd.dwFileAttributes & 0x10;
}


// ith path matching wildcard, or empty string if error.
external ty_string
fs_list_path(ty_string path, ty_real i)
{
	g_ret_buffer[0] = 0;
	if (strlen(path) >= MAX_PATH)
	{
		return g_ret_buffer;
	}
	
	WIN32_FIND_DATA ffd;
	HANDLE hFind;
	
	hFind = FindFirstFile(path, &ffd);
	if (hFind == INVALID_HANDLE_VALUE)
	{
		return g_ret_buffer;
	}
	
	if (i == 0)
	{
		// found file
		strcpy(g_ret_buffer, ffd.cFileName);
		return g_ret_buffer;
	}
		
	size_t num_files = 0;
	while (FindNextFile(hFind, &ffd) != 0)
	{
		num_files++;
		if (i == num_files)
		{
			// found file
			strcpy(g_ret_buffer, ffd.cFileName);
			return g_ret_buffer;
		}
	}
	
	return g_ret_buffer;
}

//move file or directory. Returns 0 if success, -1 if failure.
external ty_real
fs_move(ty_string src, ty_string dst)
{
	if (strlen(src) >= MAX_PATH || strlen(dst) >= MAX_PATH)
	{
		return -1;
	}
	return -1 + !!MoveFile(src, dst);
}


// delete file. Returns 0 if successful, -1 if error.
external  ty_real
fs_delete(ty_string path)
{
	if (strlen(path) >= MAX_PATH)
	{
		return -1;
	}
	return -1 + !!DeleteFile(path);
}

std::vector<char> g_ret_vector;

struct FileHandler
{
	enum FsState
	{
		READY,
		READING,
		WRITING
	} state{ READY };

	std::fstream fs;
	
	// only used for reading.
	std::vector<char> contents;
	size_t pos;
};

std::vector<FileHandler> g_handlers;

// open file, returns file index (or negative if error). Pass "w" write, "r" for read.
external ty_real
fs_open(ty_string path, ty_string rw)
{
	FileHandler::FsState state;
	if (strcmp(rw, "w") == 0)
	{
		state = FileHandler::WRITING;
	}
	else if (strcmp(rw, "r") == 0)
	{
		state = FileHandler::READING;
	}
	else
	{
		return -2;
	}
	
	// try to reuse an existing handler.
	size_t index;
	for (index = 0; index < g_handlers.size(); index++)
	{
		if (g_handlers[index].state == FileHandler::READY)
		{
			goto SETUP_HANDLER;
		}
	}
	
	// create a new handler
	index = g_handlers.size();
	g_handlers.resize(index + 1);
	
SETUP_HANDLER:
	FileHandler& handler = g_handlers[index];
	handler.state = state;
	handler.pos = 0;
	handler.contents.resize(0);
	handler.fs.open(path,
		(state == FileHandler::READING) ? std::ios_base::in : std::ios_base::out);
	
	if (!handler.fs.good())
	{
		handler.state = FileHandler::READY;
		return -1;
	}
	
	if (state == FileHandler::READING)
	{
		// read file contents now (for hashing)
		handler.fs.seekg(0, std::ios::end);
		std::streampos length = handler.fs.tellg();
		handler.fs.seekg(0, std::ios::beg);
		
		handler.contents.resize(length);
		handler.fs.read(&handler.contents[0], length);
	}
	
	return index;
}

// write string to file
// returns 0 on success, negative if error.
external ty_real
fs_write(ty_real index, ty_string s)
{
	FileHandler& handler = g_handlers[static_cast<size_t>(index)];
	if (handler.state != FileHandler::WRITING)
	{
		return -2;
	}
	if (!handler.fs.good())
	{
		return -3;
	}
	
	handler.fs << s << (char)0;
	
	if (!handler.fs.good())
	{
		return -1;
	}
	
	return 0;
}

// read full contents of file.
// WARNING: line endings depend on file.
external ty_string
fs_read(ty_real index)
{
	FileHandler& handler = g_handlers[static_cast<size_t>(index)];
	if (handler.state != FileHandler::READING)
	{
		return &empty;
	}
	return &handler.contents[0];
}

// return true if another line can be read, false if reached the end.
external ty_real
fs_readline_available(ty_real index)
{
	FileHandler& handler = g_handlers[static_cast<size_t>(index)];
	if (handler.state != FileHandler::READING)
	{
		return empty;
	}
	const char* contents = &handler.contents[0] + handler.pos;
	const char* end = strchr(contents, '\0');
	return contents < end;
}

// read one line from open file.
// \r\n and \n are cropped from the end of the line.
external ty_string
fs_readline(ty_real index)
{
	FileHandler& handler = g_handlers[static_cast<size_t>(index)];
	if (handler.state != FileHandler::READING)
	{
		return &empty;
	}
	const char* contents = &handler.contents[0] + handler.pos;
	size_t pos_add = 0;
	
	// find end of line
	const char* line_end = strchr(contents, '\n');
	if (line_end == 0)
	{
		// use end of file as end of line instead
		line_end = strchr(contents, 0);
	}
	else
	{
		// end of line found.
		pos_add = 1;
		
		// remove carriage return as well
		if (*(line_end - 1) == '\r')
		{
			line_end--;
			pos_add++;
		}
	}
	
	handler.pos = line_end - contents + pos_add;
	
	g_ret_vector.resize(line_end - contents + 1);
	memcpy(&g_ret_vector[0], contents, line_end - contents);
	g_ret_vector[line_end - contents] = 0;
	return &g_ret_vector[0];
}

// close file. Returns -1 if file was previously not open, otherwise 0.
external ty_real
fs_close(ty_real index)
{
	FileHandler& handler = g_handlers[static_cast<size_t>(index)];
	if (handler.state == FileHandler::READY)
	{
		return -1;
	}
	
	handler.fs.close();
	handler.pos = 0;
	handler.contents.resize(0);
	handler.state = FileHandler::READY;
	return 0;
}

#ifndef IS_DLL

int main(int argc, char** argv)
{
	TEST_INIT;
	
	TEST_ASSERT(2 < fs_list_count(const_cast<ty_string>(".\\*")));
	
	TEST_ASSERT(fs_file_exists(const_cast<ty_string>("common.h")))
	TEST_ASSERT(fs_directory_exists(const_cast<ty_string>(".")))
	TEST_ASSERT(!fs_file_exists(const_cast<ty_string>(".")))
	TEST_ASSERT(!fs_directory_exists(const_cast<ty_string>("common.h")))
	
	TEST_ASSERT(strcmp(fs_list_path(const_cast<ty_string>(".\\*"), 0), "." ) == 0)
	TEST_ASSERT(strcmp(fs_list_path(const_cast<ty_string>(".\\*"), 1), "..") == 0)
	
	// test access file.
	{
		ty_string fs_test_txt = const_cast<ty_string>("fs_test.txt");
		ty_string fs_test_txt2 = const_cast<ty_string>("fs_test_tmp.txt");
		ty_string fs_test_txt3 = const_cast<ty_string>("fs_test_tmp2.txt");
		ty_string contents;
		ty_real index;
		ty_real index2;
		
		fs_delete(fs_test_txt2);
		fs_delete(fs_test_txt3);
		TEST_ASSERT(fs_file_exists(fs_test_txt));
		TEST_ASSERT(!fs_file_exists(fs_test_txt2));
		TEST_ASSERT(!fs_file_exists(fs_test_txt3));
		index = fs_open(fs_test_txt, const_cast<ty_string>("r"));
		TEST_ASSERT(index == 0);
		
		contents = fs_read(index);
		TEST_ASSERT(strcmp(contents, "hello, world!\nsecond line") == 0)
		TEST_ASSERT(fs_close(index) == 0);
		
		index = fs_open(fs_test_txt, const_cast<ty_string>("r"));
		TEST_ASSERT(index == 0);
		
		index2 = fs_open(fs_test_txt2, const_cast<ty_string>("w"));
		TEST_ASSERT(index2 == 1);
		
		TEST_ASSERT(fs_write(index2, const_cast<ty_string>("test")) == 0);
		TEST_ASSERT(fs_close(index2) == 0);
		TEST_ASSERT(fs_file_exists(fs_test_txt2));
		
		index2 = fs_open(fs_test_txt2, const_cast<ty_string>("r"));
		TEST_ASSERT(index2 == 1);
		contents = fs_read(index2);
		TEST_ASSERT(strcmp(contents, "test") == 0);
		TEST_ASSERT(fs_close(index2) == 0);
		
		TEST_ASSERT(!fs_move(fs_test_txt2, fs_test_txt3));
		TEST_ASSERT(!fs_file_exists(fs_test_txt2));
		TEST_ASSERT(fs_file_exists(fs_test_txt3));
		TEST_ASSERT(!fs_delete(fs_test_txt3));
		
		TEST_ASSERT(fs_readline_available(index));
		contents = fs_readline(index);
		TEST_ASSERT(strcmp(contents, "hello, world!") == 0);
		
		TEST_ASSERT(fs_readline_available(index));
		contents = fs_readline(index);
		TEST_ASSERT(strcmp(contents, "second line") == 0);
		
		TEST_ASSERT(fs_close(index) == 0);
	}
	
	// test misc functions
	{
		const char* username = fs_username();
		TEST_ASSERT(strlen(username) > 0);
		
		const char* userpath = fs_home_directory();
		TEST_ASSERT(strlen(userpath) > 0);
		
		const char* appdatapath = fs_appdata_directory();
		printf("%s\n", appdatapath);
		TEST_ASSERT(strlen(appdatapath) > 0);
	}
	
	TEST_END;
}
#endif