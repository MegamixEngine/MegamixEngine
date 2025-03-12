/// filename_removeExtension(filename)
var filename = argument0;
var dot_position = 0;
var len = string_length(filename);

// Loop through the string to find the last dot
for (var i = len; i > 0; i--) {
    if (string_char_at(filename, i) == ".") {
        dot_position = i;
    }
}
if (dot_position > 0) {
    return string_copy(filename, 1, dot_position - 1);
} else {
    return filename; // No dot found, return the original filename
}
