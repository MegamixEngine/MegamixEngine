/// fsDelete(src, dst)
// Moves the given path to the given destination. Destination can either be a new path or an existing directory.
// Returns 0 on success, negative if error.

if (fsFileExists(dst))
{
    return -3;
}

if (fsDirectoryExists(dst))
{
    var filename = argument0;
    filename = stringSubstring(stringIndexOfReverse(src, "\"));
    filename = stringSubstring(stringIndexOfReverse(src, "/"));
    var dst = argument1;
    if (!stringEndsWith(dst, "/") && !stringEndsWith(dst, "\"))
    {
        dst += "/";
    }
    return external_call(global._fsMove, argument0, dst + filename) * 2;
}
else
{
    return external_call(global._fsMove, argument0, argument1);
}
