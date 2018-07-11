/// arrayShuffle(array)
// shuffles (randomly arranges) the given array.

var length = array_length_1d(argument0);
var randBy;
for (var i = 0; i < length; i++)
{
    randBy[i] = random(1);
}
quickSortBy(argument0, randBy);
