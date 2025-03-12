/// mm_ds_list_destroy(ID)

var ID = argument0;
mm_deregisteritem(ID,MEMORYMANAGER_LIST);
ds_list_destroy(ID);
