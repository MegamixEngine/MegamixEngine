/// fsInit()
// Loads the filesystem.dll library

var dllName = "filesystem.dll";
var callType = dll_cdecl;

global._fsVersion           = external_define(dllName, "fs_version",              callType, ty_real,   0);
global._fsAppDataDirectory  = external_define(dllName, "fs_appdata_directory",    callType, ty_real,   0);
global._fsListCount         = external_define(dllName, "fs_list_count",           callType, ty_real,   1, ty_string);
global._fsFileExists        = external_define(dllName, "fs_file_exists",          callType, ty_real,   1, ty_string);
global._fsDirectoryExists   = external_define(dllName, "fs_directory_exists",     callType, ty_real,   1, ty_string);
global._fsListPath          = external_define(dllName, "fs_list_path",            callType, ty_string, 2, ty_string, ty_real);
global._fsOpen              = external_define(dllName, "fs_open",                 callType, ty_real,   2, ty_string, ty_string);
global._fsWrite             = external_define(dllName, "fs_write",                callType, ty_real,   2, ty_real,   ty_string);
global._fsRead              = external_define(dllName, "fs_read",                 callType, ty_string, 1, ty_real);
global._fsReadLineAvailable = external_define(dllName, "fs_readline_available",   callType, ty_real,   1, ty_real);
global._fsReadLine          = external_define(dllName, "fs_readline",             callType, ty_string, 1, ty_real);
global._fsClose             = external_define(dllName, "fs_close",                callType, ty_real,   1, ty_real);
global._fsDelete            = external_define(dllName, "fs_delete",               callType, ty_real,   1, ty_string);
global._fsMove              = external_define(dllName, "fs_move",                 callType, ty_real,   2, ty_string, ty_string);

