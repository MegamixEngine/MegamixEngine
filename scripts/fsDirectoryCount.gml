/// fsDirectoryCount(directory)
// Returns number of files and subdirectories of the given directory.
// This count can include the special directories "." and "..", which are not guaranteed to exist.
// Use fsDirectoryPath to get the names of these files and subdirectories.
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

return external_call(global._fsListCount, dir);
