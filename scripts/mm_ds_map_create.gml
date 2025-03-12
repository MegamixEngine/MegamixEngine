/// mm_ds_map_create([isGlobal?])

var newList = ds_map_create();
if (argument_count > 0)
{
    mm_registeritem(newList,MEMORYMANAGER_MAP,argument[0]);
}
else
{
    mm_registeritem(newList,MEMORYMANAGER_MAP);
}
return newList;
