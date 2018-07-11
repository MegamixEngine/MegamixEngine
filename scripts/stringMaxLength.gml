/// stringMaxLength(string,maxlength,ender)
/// returns the string capped to the maximum length;
/// last few characters replaced by ender e.g. "..."

var s = argument0;
var l = argument1;
var e = argument2;

if (string_length(s) > l)
{
    return string_copy(s, 1, l - string_length(e)) + e;
}
else
{
    return s;
}
