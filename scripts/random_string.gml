/// random_string(charactersToUse,length)

var inputString = argument0;
var length = argument1;

var result = "";

// Check if input string is not empty and length is valid
if (string_length(inputString) > 0 && length > 0) {
    // Loop to generate random substring
    for (var i = 0; i < length; i++) {
        // Choose a random character index from the input string
        var randomIndex = irandom_range(1, string_length(inputString));
        // Add the character at the random index to the result string
        result += string_char_at(inputString, randomIndex);
    }
} else {
    show_debug_message("Invalid input string or length");
}

return result;
