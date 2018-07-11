/// chooseFromArray(array)
// returns a random element of the given array

var array = argument0;
var arrayLength = array_length_1d(array);
var index = irandom(array_length_1d(array) - 1);
return array[index];
