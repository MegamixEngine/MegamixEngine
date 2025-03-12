/// real_fromHex(hex_string)
/// Converts a hexadecimal string into a real number. Do not provide the $ or 0x.
// Remove in 2.0 as this is a natural part of real() there.
// (Make sure to prepend the 0x and $ back when that's done).

var hex_string = argument0;
var len = string_length(hex_string);
var result = 0;
var i, digit, char;

for (i = 1; i <= len; i++) {
    char = string_lower(string_char_at(hex_string, i));
    if (char >= "0" && char <= "9") {
        digit = real(char);
    } else if (char >= "a" && char <= "f") {
        digit = ord(char) - ord("a") + 10;
    } else {
        show_error("Invalid hex string: " + hex_string, true);
        return 0;
    }
    result = result * 16 + digit;
}

return result;
