/// saveload_game(save?,[isReplay?],[makeSymbol?]);
// saves / loads game progress
// save? -- true: save; false: load
// isReplay? Used to exclude certain value loading for replays.
// makeSymbol? silent save that doesn't use save timer
// returns non-zero error code if an error occurred.

var isReplay = false;
if (argument_count > 1)
{
    isReplay = argument[1];
}

var useSaveTimer = true;
if (argument_count > 2)
    useSaveTimer = argument[2];

if (!isReplay)
{
    slBegin(argument[0], "gameProgress", 1, true);
}

// funny little save icon =) love that little man
if (argument[0] == true) 
{
    if (!isReplay && global.recordInputMode != 0)
    {
        exit;//The little man goes to JAIL when replays are on. Sad little man.
    }
    else if (useSaveTimer)
    {
        objGlobalControl.saveTimer = 40;
    }
}

if (argument[0] == SL_INIT)
{
    //Need to initialize this way with how the hotbar works.
    for (var i = 0; i <= global.totalWeapons; i++)
    {
        global.weaponHotbar[i] = i;
    }
    global.customCostumeFilename = allocateArray(MAX_PLAYERS,"");
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if (argument[0] != SL_SAVE)//A value you can use to alter data at the bottom of this script, if you ever need to add new things to the game's save file system.
{
    global.saveVersion = sl("saveVersion",VERSION_SAVEFILE);
    //If you need to invalidate too new of save files, do that below this comment.
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - -

global.gameTimer = sl("gameTimer");

global.difficulty = sl("difficulty", DIFF_NORMAL);
global.isCheatFile = sl("isCheatFile", true);

//Items that should not respawn after dying
global.dontRespawn  = sl("dontRespawn",makeArray(""));

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// LOCATIONS

// Main room of the stage
global.stage = sl("stage","","stageRoom");

// Checkpoint
global.checkpointName   = sl("checkpointName", "");
global.checkpointX      = sl("checkpointX", -1);
global.checkpointY      = sl("checkpointY", -1);

// Hub Return variables
global.returnLayers     = sl("returnLayers");

global.returnLayer      = sl("returnLayer", makeArray(0));
global.returnLayerX     = sl("returnLayerX", makeArray(0));
global.returnLayerY     = sl("returnLayerY", makeArray(0));
global.returnLayerDir   = sl("returnLayerDir", makeArray(0));

global.lockExitButton   = sl("lockExitButton");

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// PLAYER STATE
for (var i = 0; i < MAX_PLAYERS; i += 1)
{
    global.characterSelected[i] = sl("characterSelected", CHAR_MEGAMAN, "playerChar" + string(i), i);
    global.playerHealth[i] = sl("playerHealth", 28, "playerHealth" + string(i), i);
    
    for (var j = 0; j <= global.totalWeapons; j ++)
    {
        global.ammo[i, j] = sl("ammo", 28, "weaponAmmo" + string(i) + "_" + string(j),i,j);
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// COLLECTIBLES

// Minor
global.bolts    = sl("bolts");
global.eTanks   = sl("eTanks");
global.wTanks   = sl("wTanks");
global.mTanks   = sl("mTanks");

global.keyNumber        = sl("keyNumber");

// Main
global.energyElements = sl("energyElements", 0, "ee-total");
global.elementsCollected = sl("elementsCollected", makeArray(""), "elements");

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// UPGRADES

var itemEnd = itemData(0, "MAXITEM");
var variable, value;

for (var i = 0; i < itemEnd; i ++;) //Init all upgrades
{
    variable = itemData(i, "VAR");
    value = sl(variable, (i == 0));
    
    variable_global_set(variable, value);
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
// PLAYER COSMETICS
for (var i = 0; i < MAX_PLAYERS; i++)
{
    global.costumeSelected[i] = sl("costumeSelected", global.costumeName[i], "costumeSelect" + string(i), i);
    global.defaultPrimaryPalette[i] = global.costumePrimaryColor[global.costumeID[? global.costumeSelected[i]]];
    global.defaultSecondaryPalette[i] = global.costumeSecondaryColor[global.costumeID[? global.costumeSelected[i]]];
}

// Costume purchases
for (var i = 0; i < global.playerSpriteMax; i ++;)
{
    global.costumePurchased[i] = sl("costumePurchased", false, "has-costume" + string(i),i);
}
global.costumeStore = allocateArray(array_length_1d(global.customCostumeFilename),"");
//OK GMS is being weird with encoding so new variable it is.

//Variable length support for the costume store.
if (argument[0] == SL_SAVE)
{
    //Encode.
    for (var i = 0; i < array_length_1d(global.customCostumeFilename); i++)
    {
        global.costumeStore[i] = base64_encode(global.customCostumeFilename[i]);
    }
    global.costumeStore = sl("costumeStore", global.costumeStore, "custc-file");
    
}
else
{
    //Load in the b64 then decode.
    
    global.costumeStore = sl("customCostumeFilename", global.costumeStore, "custc-file");

    for (var i = 0; i < array_length_1d(global.customCostumeFilename); i++)
    {
        global.customCostumeFilename[i] = base64_decode(global.costumeStore[i]);
    }
    

}
global.customCostumeEquipped = sl("customCostumeEquipped",array_create(MAX_PLAYERS), "custc-equip");

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// save weapon unlock
global.equippedWeaponSet = sl("equippedWeaponSet");
for (var i = 0; i <= global.totalWeapons; i++;)
{
    global.weaponLocked[i] = sl("weaponLocked", 0, "LOCKED_" + object_get_name(global.weaponObject[i]),i);
    global.weaponHidden[i] = sl("weaponHidden", !(indexOf(global.weaponSet[global.equippedWeaponSet], global.weaponObject[i]) >= 0), "HIDDEN_" + object_get_name(global.weaponObject[i]),i);
}
global.lockBuster = sl("lockBuster");

for (var i = 0; i < MAX_PLAYERS; i++)
{
    for (var ii = 0; ii < 8; ii++)
    {
        global.wheelSetWep[i, ii] = sl("wheelSetWep",ii+1,"wepwheel_" + string(i) + "_" + string(ii),i,ii);
    }
}
if (!argument[0])
{
    bassModeHandleSupports(true);
}

global.mapKeyQuickItem = sl("mapKeyQuickItem", "");

global.cutscenesPlayed = sl("cutscenesPlayed", makeArray(-1), "cutscenes");

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// weapon hotbar order (should probably be file-specific?)
saveLoadHotbarHelper();

global.cheats = sl("cheats", array_create(cheatEnums.length));

global.checkpointKey = sl("checkpointKey", random_string(SAVES_ALPHANUMERIC,32));

//Place save file checks and fixes you need to make right above here.
if (argument[0] == SL_SAVE)
{
    global.saveVersion = sl("saveVersion", VERSION_SAVEFILE);
}

if (!isReplay)
{
    return slEnd();
}
