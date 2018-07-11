/// argMin(array)
// returns the index of the least element of the array, or -1 if array is empty
// in the case of a tie, the first element is returned

var array = argument0;

if (array_length_1d(array) == 0)
{
    return -1;
}

var minVal = array[0];
var minIndex = 0;

for (var i = 1; i < array_length_1d(array); i++)
{
    if (array[i] < minVal)
    {
        minVal = array[i];
        minIndex = i;
    }
}

return minIndex;
