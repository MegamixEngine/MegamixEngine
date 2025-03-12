/// saveLoadRecordInput()
/// sl() calls for start of input recording

// global values
var rm = roomExternalGetName(global.recordInputRoom);
var replayMoniker = "RP-";//Use to differentiate replay values from saveLoad values of main files.
if (stringStartsWith(rm, "+"))
{
    if (string_pos("datafiles", rm) > 0)
    {
        rm = stringSubstring(rm, string_pos("datafiles", rm) + string_length("datafiles/"), string_length(rm) - string_length(".room.gmx") + 1);
    }
    else
    {
        rm = "???"; // do not save absolute directory into save file.
    }
}
rm = sl(rm, replayMoniker + "room");
if (rm == "???" && global.sl_save)
{
    // prompt user to load external room
    rm = get_open_filename("Mega Man Recording|*.mrc", "");
    if (rm == "")
    {
        global.sl_error = -9;
        exit;
    }
}
else if (asset_get_type(rm) == asset_room)
    global.recordInputRoom = asset_get_index(rm);
else
    global.recordInputRoom = roomExternalLoad("Levels/Entries/" + rm); // Todo: check hash!
global.recordPlayerCount = sl(global.playerCount, replayMoniker + "playerCount");
global.recordInputMessage = sl(0, replayMoniker + "message");
global.recordInputSkipSpawn = sl(global.recordInputSkipSpawn, replayMoniker + "skipSpawn"); // skip the spawn sequence and warp directly to destination?


// Fidelity status is an error code which indicates whether the playback is faithful
// or not to the recording.
// 1: recording does not implement fidelity hash checks
// 0: recording has not been proven to be unfaithful
// -1: recording has lost fidelity.

if (global.sl_save)
    sl(0, replayMoniker + "checkFidelity");
else
    global.recordInputFidelity = sl(1, replayMoniker + "checkFidelity");

// save options
global.difficulty = sl(global.difficulty, replayMoniker + "difficulty");
saveLoadGame(global.recordInputMode == 1,true);
saveLoadOptions(global.recordInputMode == 1,true);
//saveLoadHotbarHelper();

// global player values
for (var i = 0; i < global.recordPlayerCount; i++)
{
    global.recordInputPlayerHealth[i] = sl(global.playerHealth[i], replayMoniker + "health" + string(i));
    global.recordInputRespawnTimer[i] = sl(global.respawnTimer[i], replayMoniker + "respawnTimer" + string(i));
    for (var j = 0; j <= global.totalWeapons; j++)
    {
        global.recordInputAmmo[i, j] = sl(global.ammo[i, j], replayMoniker + "ammo_" + string(i) + "_" + object_get_name(global.weaponObject[j]));
    }
    global.recordInputWeapon[i] = max(0, indexOf(global.weaponObject, asset_get_index(sl(object_get_name(global.weaponObject[global.weapon[i]]), replayMoniker + "weapon" + string(i)))));
    
    global.recordInputPlayerX[i] = 0;
    global.recordInputPlayerY[i] = 0;
    global.recordInputXScale[i] = 0;
    global.recordInputYScale[i] = 0;
    global.recordInputGravFactor[i] = 0;
    global.recordInputGravDir[i] = 0;
    global.recordInputActive[i] = false;
    
    // load local player values
    if (!global.sl_save)
    {
        global.recordInputPlayerX[i] = sl(0, replayMoniker + "playerX" + string(i));
        global.recordInputPlayerY[i] = sl(0, replayMoniker + "playerY" + string(i));
        global.recordInputXScale[i] = sl(0, replayMoniker + "playerXScale" + string(i));
        global.recordInputYScale[i] = sl(0, replayMoniker + "playerYScale" + string(i));
        global.recordInputGravFactor[i] = sl(0, replayMoniker + "playerGravFactor" + string(i));
        global.recordInputGravDir[i] = sl(0, replayMoniker + "playerGravDir" + string(i));
        global.recordInputActive[i] = sl(0, replayMoniker + "playerActive" + string(i));
    }
}

// save local player values
if (global.sl_save)
{
    with (objMegaman)
    {
        var i = playerID;
        global.recordInputPlayerX[i] = sl(x, replayMoniker + "playerX" + string(i));
        global.recordInputPlayerY[i] = sl(y, replayMoniker + "playerY" + string(i));
        global.recordInputXScale[i] = sl(image_xscale, replayMoniker + "playerXScale" + string(i));
        global.recordInputYScale[i] = sl(image_yscale, replayMoniker + "playerYScale" + string(i));
        global.recordInputGravFactor[i] = sl(gravfactor, replayMoniker + "playerGravFactor" + string(i));
        global.recordInputGravDir[i] = sl(gravDir, replayMoniker + "playerGravDir" + string(i));
        global.recordInputActive[i] = sl(true, replayMoniker + "playerActive" + string(i));
    }
}

// random seed

global.recordInputRandomSeed = (sl(irandom($fffffffffffff), replayMoniker + "RandomSeed"));//TODO: Move the setting of this seed to every room end from a hub (otherwise, creation code will be a problem).
