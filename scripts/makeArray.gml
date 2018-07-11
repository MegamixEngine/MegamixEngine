/// makeArray(args...)
// turns the given input into an array

var a;
if (argument_count == 0)
{
    // ridiculous hack to get a zero-length array
    return tile_get_ids_at_depth(23574890317283);
}
else
{
    // normal functionality
    for (var i = 0; i < argument_count; i++)
        a[i] = argument[i];
    
    return a;
}
