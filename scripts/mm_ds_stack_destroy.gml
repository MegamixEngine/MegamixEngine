/// mm_ds_stack_destroy(ID)
/// mm_ds_stack_destroy
var ID = argument0;
mm_deregisteritem(ID,MEMORYMANAGER_STACK);
ds_stack_destroy(ID);
