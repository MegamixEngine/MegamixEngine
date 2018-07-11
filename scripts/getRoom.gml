/// getRoom(name, [external location], [hash])
// retrives the room of the given name, loading it externally
// if the room doesn't exist.
// returns -1 if failed to retrieve the room.

var roomInternalName = argument[0];
assert(is_string(roomInternalName), "getRoom must be supplied with the internal room name as a string");

if (asset_get_type(argument[0]) == asset_room)
{
    // internal
    return asset_get_index(argument[0]);
}
else
{
    // external
    if (argument_count == 2)
    {
        return roomExternalLoad(argument[1]);
    }
    if (argument_count > 2)
    {
        return roomExternalLoad(argument[1], argument[2]);
    }
}

return -1;
