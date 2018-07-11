/// string_peek_token(string)
// returns the first word in the string (up to whitespace).

var str = argument0;
var split, split_n, csplit;
csplit = string_length(str) + 1;
split[0] = " ";
split[1] = "    ";
split[2] = "
";
split[3] = chr(10);
split[4] = "=";
split[5] = "+";
split[6] = "-";
split[7] = ";";
split[8] = "(";
split[9] = ")";
split[10] = "/";
split[11] = "*";
split[12] = '"';
split[13] = "'";
split[14] = ",";
split[15] = "[";
split[16] = "]";
split[17] = "{";
split[18] = "}";
split[19] = "!";
split_n = 20; // must be 1 more than last split number

// return non-white space token boundary tokens:
for (var i = 4; i < split_n; i++)
{
    if (stringStartsWith(str, split[i]))
        return split[i];
}

// find earliest token boundary
for (var i = 0; i < split_n; i++)
{
    var strpos = string_pos(split[i], str);
    if (strpos > 0)
    {
        if (stringSubstring(str, 1, strpos + 1) != "global.") // global. hack
        {
            csplit = min(csplit, strpos);
        }
    }
}

return stringSubstring(str, 1, csplit);
