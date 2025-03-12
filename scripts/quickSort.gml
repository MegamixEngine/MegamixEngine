/// quickSort(array, ...)
// quicksorts the given array (on the given interval, if provided)
// guarantees all elements less than or equal element afterward.

var array = argument[0];
var left = 0;
var right = array_length_1d(array);
if (argument_count > 1)
{
    left = argument[1];
    right = argument[2];
}

// base case
if (right - left <= 1)
    exit;

// choose pivot
var pivot_index = left + floor(random(right - left));
var pivot = array[@ pivot_index];
swap(array, left, pivot_index);

// sort by pivot
var pos = left + 1;
for (var i = left + 1; i < right; i++)
{
    if (array[@ i] < pivot)
        swap(array, pos++, i);
}

pos--;

// put pivot in center
swap(array, left, pos);

// recurse
quickSort(array, left, pos);
quickSort(array, pos + 1, right);
