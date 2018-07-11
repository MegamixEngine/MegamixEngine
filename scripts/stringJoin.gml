/// stringJoin(array, delimiter)
// returns a string of the given array concatenated and joined by the delimiter.
// example: stringJoin(makeArray(4, 3, 2), ", ") gives "4, 3, 2"

var str = "";
var a = argument0;
var d = argument1;

for (var i = 0; i < array_length_1d(a); i++)
{
    if (i != 0)
    {
        str += d;
    }
    str += string(a[i]);
}

return str;
