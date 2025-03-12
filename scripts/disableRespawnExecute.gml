//disableRespawnExecute()

// Destroy instances inside the 'dontRespawn' array

var numberOfEntries = array_length_1d(global.dontRespawn);

var _i, _ii, _str;

for (_i = 0; _i < numberOfEntries; _i ++;)
{
    //Get array entry
    _str = global.dontRespawn[_i];
    
    //Check if empty
    if (_str == "")
    {
        continue;
    }
    
    //Unpack
    respawnCheck = stringSplit(_str, "/");
    
    //Check our criteria
    if (global.roomName == respawnCheck[0]) // Are we in the right room?
    {
        with (asset_get_index(respawnCheck[1])) // Survey all instances of the given type
        {
            if (    xstart  ==  real(other.respawnCheck[2])) // Check x-position
            {
                if (ystart  ==  real(other.respawnCheck[3])) // Check y-position
                {
                    visible = 0;
                    instance_destroy();
                    break;
                }
            }
        }
    }
}


