/// truncateURL(url)

//Removes parameters from a URL.
var url = argument[0]
var question_mark_pos = string_pos('?', url);
    
if (question_mark_pos > 0) {
    return string_copy(url, 1, question_mark_pos - 1);
} else {
    return url;
}
