/// swap(array, a, b)
// swaps the two indices in the given array

var array = argument0;
var a = argument1;
var b = argument2;

var tmp = array[@ a];
array[@ a] = array[@ b];
array[@ b] = tmp;
