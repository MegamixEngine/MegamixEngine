/// setWeaponLocked(object, [locked?])
// object: which weapon object to set locked/unlocked
// locked? whether to lock (default, true) or unlock (false), or hidden (2)

var obj = argument[0];
var locked = true;
if (argument_count > 1)
{
    locked = argument[1];
}

var wasHidden = global.weaponLocked[global.weaponID[? obj]] == 2;

global.weaponLocked[global.weaponID[? obj]] = locked;

// sort freshly unlocked hidden weapons to bottom of hotbar
if (wasHidden)
{
    var found = false;
    for (var i = 0; i < global.totalWeapons; i++)
    {
        if (i == global.weaponID[? obj])
        {
            found = true;
        }
        if (found)
        {
            swap(global.weaponHotbar, i, i + 1);
        }
    }
}
