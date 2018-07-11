/// string_is_number(str)
/// returns true if the given string describes a number, e.g. "35" or ".04"

var str = argument0;
var decimal_pos = string_pos(".", str);
if (decimal_pos == 0)
    return string_digits(str) == str;
else
{
    var l_side = stringSubstring(str, 1, decimal_pos);
    var r_side = stringSubstring(str, decimal_pos + 1);
    return string_digits(l_side) == l_side && string_digits(r_side) == r_side;
}
