/// lockAllWeapons([toLock?], [includeBuster])
//Shorthand to lock/unlock all weapons
toLock = true;
if (argument_count >= 1)
    toLock = argument[0];

includeBuster = false;
if(argument_count>=2)
    includeBuster = argument[1];

if (includeBuster)
{
    setWeaponLocked(objBusterShot, toLock);
    global.lockBuster = toLock;
}

for (var i = 1; i <= global.totalWeapons; i ++)
{
    setWeaponLocked(global.weaponObject[i], toLock);
}
