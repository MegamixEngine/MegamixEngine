/// zeroPad(integer: real, digits: real)
// returns a string of the given integer, adding zeroes to left of the integer until it is at least as many digits as given.

var i = argument0;
var d = argument1;
var s = string(floor(i));

repeat (d - string_length(s))
{
    s = "0" + s;
}

return (s);
