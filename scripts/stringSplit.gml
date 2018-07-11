/// stringSplit(string, delimiter, trim)
// returns an array of strings split on the given delimiter.
// if trim is true, then trim all whitespace

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
var a;
var aN = 0;
for (var i = 1 + (del == ""); i <= string_length(str); i++)
{
    if (stringAt(str, del, i))
    {
        a[aN++] = stringSubstring(str, prevSplit, i);
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
