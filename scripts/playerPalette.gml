/// playerPalette()
// Change colors depending on the special weapon

// octone ink goes away
inked = false;

// Normal colors

global.primaryCol[playerID] = getWeaponPrimaryColor(global.weapon[playerID], costumeID,playerID);
//override above if using multiplayer colors.
if ((global.weaponPrimaryColor[global.weapon[playerID]] || global.weapon[playerID] == 0) && (global.playerCount > 1 && global.multiplayerColors))
    global.primaryCol[playerID] = global.multiplayerPalette[playerID,global.weapon[playerID]];
global.secondaryCol[playerID] = getWeaponSecondaryColor(global.weapon[playerID], costumeID);

// used later for charging.
global.outlineCol[playerID] = c_black;

// chill man freezing
if (isFrozen == 1)
{
    global.outlineCol[playerID] = make_color_rgb(0, 128, 136);
    global.primaryCol[playerID] = make_color_rgb(156, 248, 240);
    global.secondaryCol[playerID] = c_white;
}
else if (isFrozen == 2 && global.gameTimer % 8 < 4)
{
    global.outlineCol[playerID] = global.nesPalette[$28];
    global.primaryCol[playerID] = global.nesPalette[$38];
    global.secondaryCol[playerID] = global.nesPalette[$20];
}

// The pause menu also resets the colors as to not show charging colors in the Mega Man sprite at the bottom right
if (instance_exists(objPauseMenu))
{
    if (!global.keyPausePressed[playerID])
    {
        chargeTimer = 0;
        initChargeTimer = 0;
    }
}
//gamepad_set_color(objGlobalControl.controllerID[playerID],global.primaryCol[playerID]);
/*
I had a cool idea with this, but it only works with PS4 controllers *on* PS4. Maybe an extensnion but that's hella work for lights.
*/
