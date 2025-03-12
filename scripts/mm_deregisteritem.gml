/// mm_deregisteritem
if (!MEMORYMANAGER_ENABLED)
{
    exit;
}
var ID = argument[0];
var dataType = argument[1];

if (MEMORYMANAGER_DEBUG)
{
    print("Delete " + string(ID) + "," + string(dataType),WL_SHOW);
}

ds_map_delete(global.memoryManager,string(ID) + "-" + string(dataType));
