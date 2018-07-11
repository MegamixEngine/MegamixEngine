/// xml_string_unescape(string)
// returns the given string with escape characters removed
// e.g. &gt; is replaced with >

var str = argument0;

str = string_replace_all(str, "&gt;", ">");
str = string_replace_all(str, "&lt;", "<");
str = string_replace_all(str, "&quot;", '"');
str = string_replace_all(str, "&#xA;", chr(10));
str = string_replace_all(str, "&amp;", "&amp");

return str;
