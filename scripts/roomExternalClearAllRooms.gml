/// roomExternalClearAllRooms
//NOTE: MAKE SURE YOU ARE NOT CURRENTLY IN AN EXTERNAL ROOM BEFORE CALLING THIS!
var element = ds_map_find_first(global.roomExternalCache);
for (var i = 0; i < ds_map_size(global.roomExternalCache); i++)
{
    
    
    var next = "";
    if (i < ds_map_size(global.roomExternalCache)-1)
    {
        next = ds_map_find_next(global.roomExternalCache,element);
    }
    print("Cleared " + element + " from room cache.")
    //printErr("CLEAR " + element);
    roomExternalClear(element);
    element = next;
}

ds_map_clear(global.roomExternalCache);
ds_map_clear(global.roomExternalSetupMap);
var key = ds_map_find_first(global.roomExternalBGCache)
while (!is_undefined(key))
{
    var nK = ds_map_find_next(global.roomExternalBGCache,key);
    ds_map_delete(global.roomExternalBGCache,key);
    key = nK;
}

ds_map_clear(global.roomExternalBGCache);


if (DEBUG_ENABLED)
{
    print("Cleared room cache",WL_SHOW);
}
