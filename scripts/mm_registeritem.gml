/// mm_registeritem(ID, dataType, [isGlobal?])
if (!MEMORYMANAGER_ENABLED)
{
    exit;
}
var ID = argument[0];
var dataType = argument[1];
var evObject = object_get_name(event_object);
if (argument_count > 2 && argument[2])
{
    evObject = "!";//isGlobal = argument[2];
}
if (MEMORYMANAGER_DEBUG)
{
    print("Add " + string(ID) + "," + string(dataType) + string(evObject),WL_SHOW);
}

ds_map_add(global.memoryManager,string(ID) + "-" + string(dataType),makeArray(ID,dataType,evObject,event_type,event_number,current_time));
