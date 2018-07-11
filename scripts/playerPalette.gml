/// playerPalette()
// Change colors depending on the special weapon

// octone ink goes away
inked = false;

// Default Color.
switch (global.playerSprite[costumeID])
{
    default: // default is mega man colors
    // TODO: these should not be implemented in code :P
    case sprRockman:
        if (global.mmColor)
        {
            rockPrimaryCol = make_color_rgb(0, 112, 236);
            rockSecondaryCol = make_color_rgb(56, 184, 248);
        }
        else
        {
            rockPrimaryCol = make_color_rgb(0, 120, 248);
            rockSecondaryCol = make_color_rgb(0, 232, 216);
        }
        
        rushPrimaryCol = make_color_rgb(216, 40, 0);
        rushSecondaryCol = make_color_rgb(255, 255, 255);
        
        sakugarnePrimaryCol = rockPrimaryCol; // make_color_rgb(0, 184, 0);
        sakugarneSecondaryCol = rockSecondaryCol; // make_color_rgb(184, 248, 120);
        
        break;
    case sprProtoman:
        rockPrimaryCol = make_color_rgb(220, 40, 0);
        rockSecondaryCol = make_color_rgb(188, 188, 188);
        
        rushPrimaryCol = make_color_rgb(216, 40, 0);
        rushSecondaryCol = make_color_rgb(255, 255, 255);
        
        sakugarnePrimaryCol = rockPrimaryCol; // make_color_rgb(0, 184, 0);
        sakugarneSecondaryCol = rockSecondaryCol; // make_color_rgb(184, 248, 120);
        
        break;
    case sprBass:
        rockPrimaryCol = make_color_rgb(112, 112, 112);
        rockSecondaryCol = make_color_rgb(248, 152, 56);
        
        rushPrimaryCol = make_color_rgb(112, 112, 112);
        rushSecondaryCol = make_color_rgb(128, 0, 240);
        
        sakugarnePrimaryCol = rockPrimaryCol; // make_color_rgb(0, 184, 0);
        sakugarneSecondaryCol = rockSecondaryCol; // make_color_rgb(184, 248, 120);
        
        break;
    case sprRoll:
        rockPrimaryCol = make_color_rgb(248, 56, 0);
        rockSecondaryCol = make_color_rgb(0, 168, 0);
        
        rushPrimaryCol = make_color_rgb(0, 160, 0);
        rushSecondaryCol = make_color_rgb(168, 224, 248);
        
        sakugarnePrimaryCol = rockPrimaryCol; // make_color_rgb(0, 184, 0);
        sakugarneSecondaryCol = rockSecondaryCol; // make_color_rgb(184, 248, 120);
        break;
}

// Setting weapon colors.
if (global.weaponPrimaryColor[global.weapon[playerID]] == -1)
{
    // base form colors
    global.primaryCol[playerID] = rockPrimaryCol;
    global.secondaryCol[playerID] = rockSecondaryCol;
}
else if (global.weaponPrimaryColor[global.weapon[playerID]] == -2)
{
    // rush colors
    global.primaryCol[playerID] = rushPrimaryCol;
    global.secondaryCol[playerID] = rushSecondaryCol;
}
else if (global.weaponPrimaryColor[global.weapon[playerID]] == -3)
{
    // sakugarne colors
    global.primaryCol[playerID] = sakugarnePrimaryCol;
    global.secondaryCol[playerID] = sakugarneSecondaryCol;
}
else
{
    // weapon colors
    global.primaryCol[playerID] = global.weaponPrimaryColor[global.weapon[playerID]];
    global.secondaryCol[playerID] = global.weaponSecondaryColor[global.weapon[playerID]];
}

// used later for charging.
global.outlineCol[playerID] = c_black;

// used for chill man freezing
if (isFrozen)
{
    global.outlineCol[playerID] = make_color_rgb(0, 128, 136);
    global.primaryCol[playerID] = make_color_rgb(156, 248, 240);
    global.secondaryCol[playerID] = c_white;
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
