/// roomExternalIsLoaded(filename)

if (asset_get_type(argument[0]) == asset_room)
// internal
{
    return 2;
}

if (!is_undefined(global.roomExternalCache[? roomExternalFindLocation(argument[0])]))
// cached
{
    return 1;
}
    
// not loaded yet.
return false;
