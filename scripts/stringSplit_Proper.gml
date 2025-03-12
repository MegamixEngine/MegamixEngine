/// stringSplit_Proper(string, delimiter, trim?)
//Splits the given string using the specified delimiter and returns an array of substrings.
//Fixes issues with the main version when an entry is empty.
//New script for 1.9, should replace old in Megamix 2.
var str = argument[0];
var del = argument[1];
var trim = false;
if (argument_count > 2)
{
    trim = argument[2];
}

if (str == "")
{
    return makeArray(str);
}

var prevSplit = 1;
var a = array_create(0);
var aN = 0;
for (var i = 1 + (del == ""); i <= string_length(str); i++)
{
    if (stringAt(str, del, i))
    {
        a[aN++] = stringSubstring(str, prevSplit, i);
        // Check if there are consecutive delimiters
        while (stringAt(str, del, i + string_length(del))) {
            a[aN++] = "";
            i += string_length(del);
        }
        i += string_length(del);
        prevSplit = i;
    }
}

a[aN++] = stringSubstring(str, prevSplit);

if (trim)
{
    for (var i = 0; i < aN; i++)
    {
        a[i] = stringTrim(a[i]);
    }
}

return a;
