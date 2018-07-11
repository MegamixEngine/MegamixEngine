/// arrayAppendUnique(array, element)
// appends element to the given array if it is not already in the array.

var array = argument0;
var elt = argument1;
if (indexOf(array, elt) == -1)
{
    arrayAppend(array, elt);
}
