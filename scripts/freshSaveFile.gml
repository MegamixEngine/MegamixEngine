/// freshSaveFile()
// resets all save-file-specific variables
// should be called at the start of a new game,
// or when returning to the main menu.
// When starting a new game, be sure to set the
// global.saveFile variable in order to save the game.

global.saveFile = "";
global.difficulty = DIFF_NORMAL;

// in the example game, save files can be set to skip over levels
global.debugSkipStageMode = false;
global.showColoredTextOverlays = false;
global.coloredTextOverlaysRed = 0;
global.coloredTextOverlaysGreen = 200;
global.coloredTextOverlaysBlue = 255;
global.coloredTextOverlaysOpacity = 170;

global.bolts = 0;
global.eTanks = 0;
global.wTanks = 0;
global.mTanks = 0;

global.energyElements = 0;
global.elementsCollected = makeArray("");
global.tricksterTokens = 0;
global.tTokensCollected = makeArray("");
global.chargeUpgrade = 0;
global.shotUpgrade = 0;
global.dropUpgrade = 0;
global.skullAmulet = 0;
global.sturdyHelmet = 0;
global.converter = 0;
global.energySaver = 0;

global.gameTimer = 0;

for (var j = 0; j <= global.totalWeapons; j++)
{
    global.weaponLocked[j] = false;
    global.weaponHotbar[j] = j;
}
