/// mm_ds_queue_destroy(ID)
/// mm_ds_queue_destroy
var ID = argument0;
mm_deregisteritem(ID,MEMORYMANAGER_QUEUE);
ds_queue_destroy(ID);
