/// indexOf(array, value)
// returns index of value in array, or -1 if not in array.

var array = argument0;
var value = argument1;

for (var i = 0; i < array_length_1d(array); i++)
{
    if (array[i] == value)
        return i;
}

return -1;
