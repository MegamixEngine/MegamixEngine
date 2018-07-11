/// room_external_clear(filename)
/// clears the cache of the given external room so that the next time
/// the room is entered, it will be re-loaded from the disk.

/// filename works as in roomExternalLoad

if (!is_undefined(global.roomExternalCache[? argument0]))
{
    print("Clearing Cache for room " + argument0, WL_VERBOSE);
    ds_map_delete(global.roomExternalCache, argument0);
}
