/* Basic file system operations. */

#include "common.h"

#include <stdio.h>
#include <cstring>
#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <algorithm>

char g_ret_buffer[512 + 1];
char empty{ 0 };
char tilde{ '~' };

// Version number
external ty_real
fs_version()
{
	return 1.1;
}

// Username
ty_string
fs_username()
{
	return &empty;
}

// Home Directory
ty_string
fs_home_directory()
{
	return &tilde;
}

// Appdata/Roaming Directory
external ty_string
fs_appdata_directory()
{
	return &empty;
}

// number of paths matching wildcard, or -1 if error.
// Ensure the path length does not exceed the operating system's MAX_PATH
external ty_real
fs_list_count(ty_string path)
{
	return 0;
}

// returns true if the given path is a file, false otherwise.
external ty_real
fs_file_exists(ty_string path)
{
	return false;
}

// returns true if the given path is a directory, false otherwise.
external ty_real
fs_directory_exists(ty_string path)
{
	return false;
}

// ith path matching wildcard, or empty string if error.
external ty_string
fs_list_path(ty_string path, ty_real i)
{
	return &empty;
}

//move file or directory. Returns 0 if success, -1 if failure.
external ty_real
fs_move(ty_string src, ty_string dst)
{
	return -1;
}

// delete file. Returns 0 if successful, -1 if error.
external  ty_real
fs_delete(ty_string path)
{
	return -1;
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
	return -1;
}

// write string to file
// returns 0 on success, negative if error.
external ty_real
fs_write(ty_real index, ty_string s)
{
	return -1;
}

// read full contents of file.
// WARNING: line endings depend on file.
external ty_string
fs_read(ty_real index)
{
	return &empty;
}

// return true if another line can be read, false if reached the end.
external ty_real
fs_readline_available(ty_real index)
{
	return -1;
}

// read one line from open file.
// \r\n and \n are cropped from the end of the line.
external ty_string
fs_readline(ty_real index)
{
	return &empty;
}

// close file. Returns -1 if file was previously not open, otherwise 0.
external ty_real
fs_close(ty_real index)
{
	return -1;
}

#ifndef IS_DLL

int main(int argc, char** argv)
{
	TEST_INIT;
	
	TEST_ASSERT(true);
	
	TEST_END;
}
#endif