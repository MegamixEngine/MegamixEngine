/// mm_ds_map_destroy(ID)

var ID = argument0;
mm_deregisteritem(ID,MEMORYMANAGER_MAP);
ds_map_destroy(ID);

