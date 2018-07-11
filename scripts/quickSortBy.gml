/// quickSortBy(array, cmp, [left, right])
// quicksorts the given array (on the given interval, if provided),
// sorted according to the cmp (comparison) array (which also becomes sorted).
// guarantees all elements in cmp less than or equal to element afterward,
// and that the same permutation applied to cmp is applied to array.

var array = argument[0];
var cmp = argument[1];
var left = 0;
var right = array_length_1d(cmp);
if (argument_count > 2)
{
    left = argument[2];
    right = argument[3];
}

// base case
if (right - left <= 1)
    exit;

// choose pivot
var pivot_index = left + floor(random(right - left));
var pivot = cmp[@ pivot_index];
swap(cmp, left, pivot_index);
swap(array, left, pivot_index);

// sort by pivot
var pos = left + 1;
for (var i = left + 1; i < right; i++)
{
    if (cmp[@ i] < pivot)
    {
        swap(cmp, pos, i);
        swap(array, pos, i);
        pos++;
    }
}

pos--;

// put pivot in center
swap(cmp, left, pos);
swap(array, left, pos);

// recurse
quickSortBy(array, cmp, left, pos);
quickSortBy(array, cmp, pos + 1, right);
