/// engineConfig()
// Edit this script to change game-wide options.
// file-specific options belong in freshOptions/saveLoadOptions.
// options in here are not intended to be loaded or modified during gameplay. Caveat emptor.

// frame rate of game
global.gameSpeed = 60;

// game's internal display resolution.
global.screenWidth = 256;
global.screenHeight = 224;

// colour palette
paletteSetup();

// Can the player charge the buster? (MM4 and onward)
global.enableCharge = true;

// Can the player slide? (MM3 and onward)
global.enableSlide = true;

// what kind of print() warning levels should be displayed?
global.warningLevel = WL_ERR;

// Co-op mode: how much HP does a player need to have in order to be eligible for donating
// to a respawned player?
global.respawnDonateThreshold = 5;

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

// debug mode and keys (1, 2) are enabled.
global.debugEnabled = true;
