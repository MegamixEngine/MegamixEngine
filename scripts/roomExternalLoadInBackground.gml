/// roomExternalLoadInBackground(filename, [hash])
// Starts loading an external room in the background in advance of when it is needed.
// returns instance ID of loader, or -1 if room already loaded.

var _name = argument[0]
assert(_name != "");

// Already loaded -- no need to make a new loader!
if (!is_undefined(global.roomExternalCache[? _name]))
{
    return -1;
}
    
var preferredProcessRate = 100;

// Check if there is already a loader for this, and if so, return it.
with (objExternalRoomLoader)
{
    if (fileNameWithoutExtension == _name)
    {
        if (processRate == 0)
        {
            preferredProcessRate = 100;
        }
        return id;
    }
}

with (instance_create(0, 0, objExternalRoomLoader))
{
    fileNameWithoutExtension = _name;
    if (argument_count > 1)
    {
        confirmHash = argument[1]
    }
    preferredProcessRate = 100;
    
    return id;
}
