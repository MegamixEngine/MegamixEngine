/// roomExternalLoad(filename, [hash])
/// loads a room from an external file and returns its room id, or a negative
/// number if an error occurred.

/// filename: assumed to be relative to the included files directory, and ".room.gmx" extension should be left off.
/// but for external files prepend a + symbol and include the extension

/// if a hash is supplied, the hash is checked and if the level file is corrupted then
/// the file will not be loaded.

/// if room already cached, return that.
if (!is_undefined(global.roomExternalCache[? argument[0]]))
    return global.roomExternalCache[? argument[0]];

// Create a loader for the given room.
if (argument_count == 1)
{
    roomExternalLoadInBackground(argument[0]);
}
else
{
    roomExternalLoadInBackground(argument[0], argument[1]);
}
    
// Find the loader which already exists and set its process rate to infinity.
with (objExternalRoomLoader)
{
    if (fileNameWithoutExtension == argument[0])
    {
        processRate = -1;
        event_user(0);
        return exrm;
    }
}
    
assert(false, "No loader found for room " + argument[0]);

