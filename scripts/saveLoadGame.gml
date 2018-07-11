/// saveload_game(save?);
// saves / loads game progress
// save? -- true: save; false: load
// returns non-zero error code if an error occurred.

// exits if save file not set
if (global.saveFile == "")
    exit;

slBegin(argument0, global.saveFile);

objGlobalControl.saveTimer = 40;
global.bolts = sl(global.bolts);
global.eTanks = sl(global.eTanks);
global.mTanks = sl(global.mTanks);
global.energyElements = sl(global.energyElements);
global.elementsCollected = sl(global.elementsCollected, "elements", true);
global.chargeUpgrade = sl(global.chargeUpgrade);
global.shotUpgrade = sl(global.shotUpgrade);
global.dropUpgrade = sl(global.dropUpgrade);
global.skullAmulet = sl(global.skullAmulet);
global.sturdyHelmet = sl(global.sturdyHelmet);
global.converter = sl(global.converter);
global.difficulty = sl(global.difficulty, "difficulty");
global.debugSkipStageMode = sl(global.debugSkipStageMode, "skip-stages");

global.gameTimer = sl(global.gameTimer);

// save weapon unlock
for (var j = 1; j <= global.totalWeapons; j++)
{
    global.weaponLocked[j] = sl(global.weaponLocked[j], "LOCKED_" + object_get_name(global.weaponObject[j]), false, 2);
}

// weapon hotbar order (should probably be file-specific?)
saveLoadHotbarHelper();

return slEnd();
