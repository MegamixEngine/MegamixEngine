/// number_of(array, element)
// returns the number of occurrences of the given element of the array

var array = argument0;
var elt = argument1;
var count = 0;

for (var i = 0; i < array_length_1d(array); i++)
{
    if (array[@ i] == elt)
    {
        count++;
    }
}

return count;
