///arrayCopyDeleteIndexes(array, index 1, index 2...)
// this script only exists because I don't think the save script can save
// ds_lists and I have to delete stuff from the junk array so !!!!!!!!!!!!!!!

var array = argument[0];
var copy;

var ignoreIndexes;
if (argument_count > 1)
{
    for (var i = 1; i < argument_count; i ++)
        ignoreIndexes[i-1] = argument[i];
}

var copyIndex = 0;
for (var i = 0; i < array_length_1d(array); i ++)
{
    if (indexOf(ignoreIndexes, i) == -1)
    {
        copy[copyIndex] = array[i];
        copyIndex ++;
    }
}

return copy;
