/// stringTrim(string)
/// returns the given string with spaces trimmed from both ends

var str = argument0;

// left trim
while (stringStartsWith(str, " ") || stringStartsWith(str, chr(10)) || stringStartsWith(str, chr(13)) || stringStartsWith(str, "
"))
    str = stringSubstring(str, 2);

// right trim
while (stringEndsWith(str, " ") || stringEndsWith(str, chr(10)) || stringEndsWith(str, chr(13)) || stringEndsWith(str, "
"))
{
    str = stringSubstring(str, 1, string_length(str));
}

return str;
