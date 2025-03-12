/// mm_ds_grid_destroy(ID)
/// mm_ds_grid_destroy
var ID = argument0;
mm_deregisteritem(ID,MEMORYMANAGER_GRID);
ds_grid_destroy(ID);
