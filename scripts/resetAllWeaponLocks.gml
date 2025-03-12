/// resetAllWeaponLocks()
/*
Should be called to reset all weapon locks after levels.
*/
for (i = 0; i <= global.totalWeapons; i += 1)
{
    if (global.weaponLocked[i] % 2 == 1)
        setWeaponLocked(global.weaponObject[i], clamp(global.weaponLocked[i] - 2, 0, 3));
    
    if (!arrayContains(global.weaponSet[global.equippedWeaponSet], global.weaponObject[i]))
        setWeaponHidden(global.weaponObject[i], 1);
        
    global.infiniteEnergy[i] = false;
}
