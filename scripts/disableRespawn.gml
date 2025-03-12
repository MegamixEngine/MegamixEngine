//disableRespawn(id)

// Prevents objects from respawning when reloading the stage after a death
// Needed for pickups

var _id = argument[0];

if (instance_exists(_id))
{
    var _str
    = global.roomName
    + "/" + object_get_name(_id.object_index)
    + "/" + string(_id.xstart)
    + "/" + string(_id.ystart);
    
    arrayAppendUnique(global.dontRespawn, _str);
}

