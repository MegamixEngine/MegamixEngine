/// mm_ds_priority_destroy(ID)
/// mm_ds_priority_destroy
var ID = argument0;
mm_deregisteritem(ID,MEMORYMANAGER_PRIORITY);
ds_priority_destroy(ID);
