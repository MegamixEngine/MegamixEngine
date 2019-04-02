/// fsDirectoryPath(directory, n)
// Returns the nth file or subdirectory in the given directory.
// Use fsDirectoryCount to get the number of these files and subdirectories.
// Ensure the path length does not exceed the operating system's MAX_PATH-3

var dir = argument0;

if (stringEndsWith(dir, "/") || stringEndsWith(dir, "\"))
{
    dir += "*";
}
else
{
    dir += "/*";
}

return external_call(global._fsListPath, dir, argument1);
