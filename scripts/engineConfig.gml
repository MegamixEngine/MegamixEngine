/// engineConfig()
// Edit this script to change game-wide options.
// file-specific options belong in freshOptions/saveLoadOptions.
// options in here are not intended to be loaded or modified during gameplay. Caveat emptor.

// frame rate of game
global.gameSpeed = 60;

// colour palette
paletteSetup();

// what kind of print() warning levels should be displayed?
global.warningLevel = WL_ERR;

/// --- Screen size --- ///

// game's internal display resolution.
global.screenWidth = 256;
global.screenHeight = 224;

// width and height of quads (screens).
// alternatively set per-room by using bgQuadXXXX backgrounds
global.quadWidth = 256;
global.quadHeight = 240;

// borders for game area outside of display area -- screenHeight must equal quadHeight + quadMarginTop + quadMarginBottom
// (Note that these values are also set automatically given a grid room background)
global.quadMarginTop = 8;
global.quadMarginBottom = 8;

/// --- Player properties --- ///

// The default player used
for (i = 0; i < MAX_PLAYERS; i++)
{
    global.characterSelected[i] = CHAR_MEGAMAN;
    global.costumeSelected[i] = "Mega Man";
}

// Can the player charge the buster? (MM4 and onward)
global.enableCharge = true;

// Can the player slide? (MM3 and onward)
global.enableSlide = true;

// Co-op mode: how much HP does a player need to have in order to be eligible for donating
// to a respawned player?
global.respawnDonateThreshold = 5;

// How long it takes for players to respawn?
global.respawnTime = 5 * 60; 

// Multiplier to above when during a boss fight
global.respawnTimeBoss = 4;

/// --- Collectables --- ///

// if this is set to false, 1-ups restore health to full and game overs do not occur.
global.livesEnabled = false;

// number of lives before getting a game over.
global.defaultLives = 2;

// maximum number of lives
global.maxLives = 9;

// maximum number of tanks
global.maxETanks = 9;
global.maxWTanks = 9;
global.maxMTanks = 1;

// maximum number of bolts
global.maxBolts = 9999;

/// --- Other --- ///

// debug mode and keys (1, 2) are enabled.
/*global.debugEnabled = true; NO LONGER USED! Use DEBUG_ENABLED instead.

Best practice is:
if (DEBUG_ENABLED) <-Don't include other booleans! This will optimize below out when debug is off.
{
    do debugging things.
}
*/

// Can the player resume from a checkpoint after leaving mid-level?
// Note that when set to false checkpoint save files will still be created, but the "Resume from Checkpoint?" notification will never appear
global.checkpointSavesEnabled = true;

// what can light oil on fire?
// obtuse string formatting is to fool the lightweight generator
global.fireSource[1]  = "obj" + "FireBlockFire";
global.fireSource[2]  = "obj" + "FirePillar";
global.fireSource[3]  = "obj" + "FireWave";
global.fireSource[4]  = "obj" + "TackleFire";
global.fireSource[5]  = "obj" + "HotDogFire";
global.fireSource[6]  = "obj" + "LightningLordLightning";
global.fireSource[7]  = "obj" + "ApacheJoeProjectile";
global.fireSource[8]  = "obj" + "FireBoyShot";
global.fireSource[9]  = "obj" + "FireTellyShot";
global.fireSource[10] = "obj" + "FireSpike";
global.fireSource[11] = "obj" + "HeatMan";
global.fireSource[12] = "obj" + "HeatManFire";
global.fireSource[13] = "obj" + "MechaDragonFire";
global.fireSource[14] = "obj" + "PharaohManShot";
global.fireSource[15] = "obj" + "PharaohManShotBig";
global.fireSource[16] = "obj" + "PharaohShot";
global.fireSource[17] = "obj" + "SolarBlaze";
global.fireSource[18] = "obj" + "Napalm";
global.fireSource[19] = "obj" + "PopoHeliFire";
global.fireSource[20] = "obj" + "ChangkeyDragon";
global.fireSource[21] = "obj" + "ChangkeyDragonFire";
global.fireSource[22] = "obj" + "Suzak";
global.fireSource[23] = "obj" + "Fenix";
global.fireSource[24] = "obj" + "SFFire";
global.fireSource[25] = "obj" + "FlameMixer";
global.fireSource[26] = "obj" + "PUOilFire";

for (var i = 1; i < array_length_1d(global.fireSource); ++i)
{
    aIndex = asset_get_index(global.fireSource[i]);
    if (aIndex != -1)
    {
        global.fireSource[i] = aIndex;
    }
    else
    {
        global.fireSource[i] = noone;
    }
}

// Folder in datafiles containing the music
global.musicDirectory = "Music\";
