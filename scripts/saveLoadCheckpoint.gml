/// saveload_game(save?, level);
// saves / loads game progress
// save? -- true: save; false: load
// isReplay? Used to exclude certain value loading for replays.
// returns non-zero error code if an error occurred.

slBegin(argument[0], argument[1], 1, true, global.checkpointKey + argument[1],true);

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// CHECKPOINT

global.stage = sl("stage", "", "stageRoom");

global.checkpointName   = sl("checkpointName","");
global.checkpointX      = sl("checkpointX");
global.checkpointY      = sl("checkpointY");

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// PLAYER STATE
for (var i = 0; i < MAX_PLAYERS; i += 1)
{
    global.playerHealth[i] = sl("playerHealth",28,"playerHealth" + string(i),i);
    
    for (var j = 0; j <= global.totalWeapons; j ++)
    {
        global.ammo[i, j] = sl("ammo",28,"weaponAmmo" + string(i) + "_" + string(j),i,j);
    }
}
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// COLLECTIBLES

global.keyNumber        = sl("keyNumber");

global.dontRespawn  = sl("dontRespawn",array_create(0));

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// WEAPONS

// save weapon unlock
for (var i = 0; i <= global.totalWeapons; i++;)
{
    global.weaponLocked[i] = sl("weaponLocked", 0, "LOCKED_" + object_get_name(global.weaponObject[i]),i);
    global.weaponHidden[i] = sl("weaponHidden", !(indexOf(global.weaponSet[global.equippedWeaponSet], global.weaponObject[i]) >= 0), "HIDDEN_" + object_get_name(global.weaponObject[i]),i);
}

global.lockBuster = sl("lockBuster");

global.equippedWeaponSet = sl("equippedWeaponSet");

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

return slEnd();

