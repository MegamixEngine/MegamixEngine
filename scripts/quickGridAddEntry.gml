///quickGridAddEntry(x1, x2, x3, ...)

//Script for quickly setting up a grid

var arguments = argument_count;

var grid = global.quickGrid;
var width = 0;
var height = 0;

//Create new grid
if (grid == -1)
{
    grid = mm_ds_grid_create(1, arguments);
    
    global.quickGrid = grid;
}
else //Resize old grid
{
    width = ds_grid_width(grid);
    height = ds_grid_height(grid);
    
    ds_grid_resize(grid, (width + 1), height);
}

//Add data
for (var i = 0; i < arguments; i ++;)
{
    ds_grid_set(grid, width, i, argument[i]);
}

