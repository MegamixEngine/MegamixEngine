/// room_external_clear(filename)
/// clears the cache of the given external room so that the next time
/// the room is entered, it will be re-loaded from the disk.

/// filename works as in roomExternalLoad

var filename = argument0;
assert(filename != "");

if (!is_undefined(global.roomExternalCache[? filename]))
{
    print("Clearing Cache for room " + filename, WL_VERBOSE);
    
    // clean up room grid
    var exrm = global.roomExternalCache[? filename];
    var setupGrid = global.roomExternalSetupMap[? exrm];
    assert(ds_exists(setupGrid, ds_type_grid));
    assert(room_exists(exrm));
    
    room_instance_clear(exrm);
    room_tile_clear(exrm);
    mm_ds_grid_destroy(setupGrid);
    
    // remove entry from cache
    ds_map_delete(global.roomExternalSetupMap,exrm);
    ds_map_delete(global.roomExternalCache,filename);//global.roomExternalCache[? filename] = undefined;
    
    
}


