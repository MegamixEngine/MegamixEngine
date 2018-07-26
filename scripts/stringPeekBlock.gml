/// string_peek_block(str)
/// retrieves a block of code from the prefix of the given code
// global.retval_error is set to 1 if an error occurred

var str = argument0;
var strInit = str;
var len = 0;
while (stringStartsWith(str, " ") || stringStartsWith(str, global.newLine) || stringStartsWith(str, chr(10)) || stringStartsWith(str, chr(11))
|| stringStartsWith(str, chr(12)) || stringStartsWith(str, chr(13)))
{
    len += 1;
    str = stringSubstring(str, 2);
}

var bracketCounter = 0;
var encounteredBracket = false;
while (true)
{
    len++;
    if (string_length(str) == 0)
    {
        printErr("error executing string: could not identify block at start of
        ```````"
            + strInit + "
        ```````");
        global.retval_error = true;
        return "";
    }
    var char = string_char_at(str, 1);
    str = stringSubstring(str, 2);
    if ((char == ";" || char == global.newLine) && bracketCounter == 0)
    {
        break;
    }
    if (char == "{" || char == "(" || char == "[")
    {
        bracketCounter++;
        encounteredBracket = true;
    }
    if (char == "}" || char == ")" || char == "]")
    {
        bracketCounter--;
        encounteredBracket = true;
    }
    // returned to 0
    if (bracketCounter == 0 && encounteredBracket)
    {
        break;
    }
}

len++;

return stringSubstring(strInit, 1, len);
