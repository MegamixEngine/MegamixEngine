/// setWeapon(weaponID, playerID)
//Shorthand to set the player to a particular weapon, makes sure to swap to the appropriate weapon set

var playerIn = argument[1];

global.weapon[playerIn] = argument[0];

// Check if this will lead to swapping weapon sets
if (global.weaponObject[global.weapon[playerIn]] != objBusterShot){
    var newSize = array_length_1d(global.weaponSet),
    var newSet  = global.equippedWeaponSet;
                
    // Check each weapon set for this weapon.
    // If it exists in a given set, switch over to that set
    for (var i = 0; i < newSize; i++){
        if (indexOf(global.weaponSet[i], global.weaponObject[global.weapon[playerIn]]) >= 0){
            newSet = i;
            break;
        }
    }
                
    if (newSet != global.equippedWeaponSet){
        toggleWeaponSet(newSet, false);
    }
}
