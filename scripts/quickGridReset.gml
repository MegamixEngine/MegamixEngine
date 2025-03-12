///quickGridReset()

//Script for resetting the quick-grid

if (global.quickGrid)
{
    mm_ds_grid_destroy(global.quickGrid);
    global.quickGrid = -1;
}


