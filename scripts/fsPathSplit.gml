/// fsPathSplit(path)
// splits path into an array where the first element is the
// directory and the second is the basename.

var path = argument0;
var splitPoint = max(stringIndexOfReverse(path, "/"), stringIndexOfReverse(path, "\"));
var arr;
arr[0] = stringSubstring(path, 1, splitPoint + 1);
arr[1] = stringSubstring(path, splitPoint + 1);

return arr;
