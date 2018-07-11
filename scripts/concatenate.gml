/// concatenate(arrays...)
// returns a new array which contains the contents of all the provided
// arrays in order
// if non-array arguments are provided, they are inserted into the array
// array in order as well.

var arr;
var arrN = 0;

for (var i = 0; i < argument_count; i++)
{
    if (is_array(argument[i]))
    {
        // concatenate arrays
        var inArr = argument[i];
        for (var j = 0; j < array_length_1d(argument[i]); j++)
        {
            arr[arrN++] = inArr[j];
        }
    }
    else
    {
        // append elts
        arr[arrN++] = argument[i];
    }
}

return arr;
