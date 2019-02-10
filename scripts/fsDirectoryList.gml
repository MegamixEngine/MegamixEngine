/// fsDirectoryList(directory)
// Returns an array containing the paths in the given directory.
// Returns -1 if an error occurred.
// Ensure the path length does not exceed the operating system's MAX_PATH-3

var dir = argument0;
var n = fsDirectoryCount(dir);
var arr = -1;
for (var i = 0; i < n; i++)
{
    arr[i] = fsDirectoryPath(dir, i);
}

return arr;
