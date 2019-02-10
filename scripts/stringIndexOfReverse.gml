/// stringIndexOfReverse(string, substring)
/// finds last index of substring in string; returns 0 if not found

var str = argument0;
var substr = argument1;

var l = string_length(substr);
var bound = string_length(str) - l + 1;

for (var i = bound; i >= 1; i--)
{
    if (string_copy(str, i, l) == substr)
        return i;
}

return 0;