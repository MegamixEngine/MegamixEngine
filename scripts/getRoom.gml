/// getRoom(name, [external path], [hash], [in background])
// retrives the room of the given name, loading it externally
// if the room doesn't exist.
// if argument 4 is true, load in the background (ID of loader instance is returned).
// returns -1 if failed to retrieve the room.

var roomInternalName = argument[0];

// if already a room, return that.
assert(is_string(roomInternalName), "getRoom must be supplied with the internal room name as a string");

if (asset_get_type(argument[0]) == asset_room)
{
    // internal
    return asset_get_index(argument[0]);
}
else
{
    // external
    var roomLocation = argument[0];
    if (argument_count > 1)
    {
        roomLocation = argument[1];
    }
    {
        // try searching for a room in many locations
        searchRooms = false;
        if (argument_count == 1)
        {
            searchRooms = true;
        }
        else if (argument[1] == "")
        {
            searchRooms = true;
        }
        if (searchRooms)
        {
            roomLocation = roomExternalFindLocation(argument[0]);
        }
    }
    if (argument_count < 3)
    {
        // TODO: consult global table of checksums for rooms if no hash provided.
        return roomExternalLoad(roomLocation);
    }
    
    var inBackground = false;
    if (argument_count >= 4)
    {
        inBackground = argument[3];
    }
    
    if (argument_count >= 3)
    {
        // load in background..?
        if (argument[2] == "" && !inBackground)
        {
            return roomExternalLoad(roomLocation);
        }
        if (argument[2] != "" && !inBackground)
        {
            return roomExternalLoad(roomLocation, argument[2]);
        }
        if (argument[2] == "" && inBackground)
        {
            return roomExternalLoadInBackground(roomLocation);
        }
        if (argument[2] != "" && inBackground)
        {
            return roomExternalLoadInBackground(roomLocation, argument[2]);
        }
    }
}

return -1;

