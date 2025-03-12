/// setWeaponHidden(obj, [hidden], [reset weapon wheel])
// object: which weapon object to set locked/unlocked
// hidden. whether to hide (default, true) or not hide (false)
// reset weapon wheel: remove the weapon from weapon wheel (used for character blacklists)

var obj = argument[0];

var hidden = true;
if (argument_count > 1)
    hidden = argument[1];
    
var wheel = false;
if (argument_count > 2)
    wheel = argument[2];
    
if (obj == objBusterShot)
    exit;

global.weaponHidden[global.weaponID[? obj]] = hidden;

// weapon wheel
if (wheel && hidden)
{
    for (var i = 0; i < MAX_PLAYERS; i ++)
    {
        for (var j = 0; j < 8; j ++)
        {
            if (global.wheelSetWep[i, j] == getWeaponID(obj))
                global.wheelSetWep[i, j] = 0;
        }
    }
}
