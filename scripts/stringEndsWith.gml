/// stringEndsWith(string, substring)
/// returns true if the given string ends with the given substring

if (string_length(argument1) > string_length(argument0))
    return false;

return stringAt(argument0, argument1, string_length(argument0) - string_length(argument1) + 1);
