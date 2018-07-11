/// arrayNearest(array, elt)
// returns the value of the element in the array nearest in value to `elt`
// if multiple values are equally close to `elt`, the first one in the array is returned.

var a = argument0;
var e = argument1;
var bestIndex = 0;
var bestDifference = abs(a[0] - e);
for (var i = 1; i < array_length_1d(a); i++)
{
    var difference = abs(a[i] - e);
    if (difference < bestDifference)
    {
        bestIndex = i;
        bestDifference = difference;
    }
}

return a[bestIndex];
