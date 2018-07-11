/// string_reverse(string)
/// returns the reverse of the given string

var str = argument0;
var rev = "";
for (var i = string_length(str); i > 0; i--)
    rev += string_char_at(str, i);

return rev;
