/// toggleWeaponSet(new_set, play_sfx)
// Switch between weapon sets
//
// new_set: the new weapon set to equip. If a negative value is given, give the next set in the weapon set array
// play_sfx: should the switch sound play?

var new_set = argument0, play_sfx = argument1;

var prevWeaponSet = global.equippedWeaponSet;

if (new_set < 0) // Advance to the next weapon set
{
    global.equippedWeaponSet++;

    if (global.equippedWeaponSet >= array_length_1d(global.weaponSet))
    {
        global.equippedWeaponSet = 0;
    }
}
else // Direct assignment
{
    if(global.equippedWeaponSet == new_set){
        exit;
    }else{
        global.equippedWeaponSet = new_set;
    }
}

var nextReturnVal = true;

if (!global.lockBuster)
    nextReturnVal = false;

//Lock out usage of the weapon set switching here here.

if (nextReturnVal)
{
    playSFX(sfxError);
    global.equippedWeaponSet = prevWeaponSet;
    return false;
}

if (play_sfx)
{
    playSFX(sfxGravityFlip);
}

// AGHGHHHH alter weapons
for (var j = 0; j <= global.totalWeapons; j ++)
{
    setWeaponHidden(global.weaponObject[j], (indexOf(global.weaponSet[global.equippedWeaponSet], global.weaponObject[j]) < 0));
    print(object_get_name(global.weaponObject[j]) + string(global.weaponHidden[j]));
}

bassModeHandleSupports();
