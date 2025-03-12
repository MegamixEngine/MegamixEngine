/// roomExternalGetName(id)
/// returns the name of a given room ID (even if it is not an externally-loaded room)
/// if an error occurs, returns ""

var _id = argument0;

if (is_string(_id))
{
    return _id;
}

if (room_exists(_id))
{
    if (ds_map_empty(global.roomExternalCache))
        return room_get_name(_id);
    for (var key = ds_map_find_first(global.roomExternalCache); true; key = ds_map_find_next(global.roomExternalCache, key))
    {
        if (global.roomExternalCache[? key] == _id)
        {
            // return basename of external file
            key = stringSubstring(key, stringIndexOfReverse(key, "/") + 1);
            key = stringSubstring(key, stringIndexOfReverse(key, "\") + 1);
            return key;
        }
        if (key == ds_map_find_last(global.roomExternalCache))
            return room_get_name(_id);
    }
}
else
    return "";

