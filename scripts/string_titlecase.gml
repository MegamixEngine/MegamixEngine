/// string_titlecase(inputString)
var outputString = "";
    
// Split the input string into words
var words = stringSplit(argument[0], " ",false);

// Loop through each word
for (var i = 0; i < array_length_1d(words); i++)
{
    // Capitalize the first letter of each word and append to the output string
    outputString += string_upper(string_char_at(words[i], 1)) + string_lower(string_copy(words[i], 2, string_length(words[i]))) + " ";
}

// Remove the trailing space and return the result
return string_copy(outputString, 1, string_length(outputString) - 1);
