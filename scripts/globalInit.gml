// globalInit()
// these are global variables and constants that aren't really meant to be configured.
global.newLine = "
";
global.nextRoom = -1;
global.previousRoom=-1;

// subsystem initialization
mathTableSetup();
lockPoolInit();
globalLockInit();
fsInit();
chronoInit();
gigInit();

// extension initialization
cleanMem('init');

// Keys
global.keyLeft[4] = 0;
global.keyRight[4] = 0;
global.keyUp[4] = 0;
global.keyDown[4] = 0;
global.keyJump[4] = 0;
global.keyShoot[4] = 0;
global.keySlide[4] = 0;
global.keyPause[4] = 0;
global.keyWeaponSwitchLeft[4] = 0;
global.keyWeaponSwitchRight[4] = 0;

global.keyLeftPressed[4] = 0;
global.keyRightPressed[4] = 0;
global.keyUpPressed[4] = 0;
global.keyDownPressed[4] = 0;
global.keyJumpPressed[4] = 0;
global.keyShootPressed[4] = 0;
global.keySlidePressed[4] = 0;
global.keyPausePressed[4] = 0;
global.keyWeaponSwitchLeftPressed[4] = 0;
global.keyWeaponSwitchRightPressed[4] = 0;

// width and height of quads (screens).
// alternatively set per-room by using bgQuadXXXX backgrounds
global.quadWidth = 256;
global.quadHeight = 240;

// borders for game area outside of display area -- screenHeight must equal quadHeight + quadMarginTop + quadMarginBottom
// (Note that these values are also set automatically given a grid room background)
global.quadMarginTop = 8;
global.quadMarginBottom = 8;

// index of each asset (+1):
global.lastBackground = bgNESPalette;
while (background_exists(global.lastBackground++))
    { }
global.lastObject = objGlobalControl;
while (object_exists(global.lastObject++))
    { }

// Variables
global.coop = false;
global.maxPlayerCount = 4;
global.playerCount = 1; // the number of players playing
global.playerCountInitialized = 0; // number of players whose global variables have been initialized.
weaponsInit();
playerGlobalInit();

// can dead players respawn?
global.respawnAllowed = true;
global.respawnTime = 3 * room_speed; // how long it takes for players to respawn
global.respawnTimeBoss = 4; // multiplier when there is a boss on-screen

global.respawnAnimation = 0; // 0 = teleport land, 1 = teleport in, 2 = fall in, 3 = Jump in, 4 = stand there (set showDuringReady to true), 8 = Skull elevator
global.respawnGravityAngle = 1; // 1 = normal, -1 = reverse

global.font = font_add_sprite(sprMM9Font, ord(' '), false, 0);
draw_set_font(global.font);

// the default screen scaling.
global.screensize = max(1, floor(min(display_get_width() / global.screenWidth,
    (display_get_height() - 32) / global.screenHeight)));

global.shakeTimer = 0;
global.shakeFactorX = 0;
global.shakeFactorY = 0;

global.flashTimer = 0;

// Camera variables for users
global.prevXView = view_xview;
global.prevYView = view_yview;

// Go to the next room if this is the initializing room
// Also, initialize some variables

global.keyCoinTotal = 0;
global.keyCoinCollected = 0;
global.keyNumber = 0;

// game progression
global.livesRemaining = global.defaultLives;
global.checkpoint = false;
global.checkpointX = -1;
global.checkpointY = -1;
global.hasTeleported = 0;

global.lastTeleporterX = 128;
global.lastTeleporterY = 160;
global.roomTimer = 0;

global.previousRoom = rmTitleScreen;
global.roomReturn = rmTitleScreen;
global.roomReturnIsStage = false;
global.levelReward = makeArray(0);

// are we in a game room (mega man can jump around and stuff)
global.inGame = false;

// start a stage when the next room begins
global.beginStageOnRoomBegin = false;
global.endStageOnRoomEnd = false;
global.decrementLivesOnRoomEnd = true;

global.castleStagesBeaten = 0;

global.telTelWeather = 0;
global.superArmInterface = makeArray();

global.borderlist = ds_list_create();

global.frozen = false;
global.queuePaused = 0;
global.lockTransition = false;
global.switchingSections = false;

global.inkSurface[0] = -1; // used for octone ink
global.keyCoinTotal = 0;
global.keyCoinCollected = 0;

// cached view -- view is fixed here if not following any object
global.cachedXView = 0;
global.cachedYView = 0;

// set this at any time during gameplay to fade to a particular room.
global.nextRoom = 0;

// boss variables
global.bossTextShown = false;
global.aliveBosses = 0;

// factions
global.factionStance[0, 0] = 0; // Neutral
global.factionStance[0, 1] = 0;
global.factionStance[0, 2] = 0;
global.factionStance[0, 3] = 0;
global.factionStance[0, 4] = 0;
global.factionStance[0, 5] = 0;
global.factionStance[0, 6] = 0;
global.factionStance[0, 7] = 0;

global.factionStance[1, 0] = 0; // Player
global.factionStance[1, 1] = 0;
global.factionStance[1, 2] = 0;
global.factionStance[1, 3] = 0;
global.factionStance[1, 4] = 0;
global.factionStance[1, 5] = 0;
global.factionStance[1, 6] = 0;
global.factionStance[1, 7] = 0;

global.factionStance[2, 0] = 0; // Player Projectiles
global.factionStance[2, 1] = 0;
global.factionStance[2, 2] = 0;
global.factionStance[2, 3] = 1;
global.factionStance[2, 4] = 1;
global.factionStance[2, 5] = 1;
global.factionStance[2, 6] = 0;
global.factionStance[2, 7] = 1;

global.factionStance[3, 0] = 0; // Enemies
global.factionStance[3, 1] = 1;
global.factionStance[3, 2] = 0;
global.factionStance[3, 3] = 0;
global.factionStance[3, 4] = 0;
global.factionStance[3, 5] = 0;
global.factionStance[3, 6] = 0;
global.factionStance[3, 7] = 0;

global.factionStance[4, 0] = 0; // Misc
global.factionStance[4, 1] = 1;
global.factionStance[4, 2] = 0;
global.factionStance[4, 3] = 1;
global.factionStance[4, 4] = 0;
global.factionStance[4, 5] = 0;
global.factionStance[4, 6] = 0;
global.factionStance[4, 7] = 0;

global.factionStance[5, 0] = 0; // Vs Everyone Else, immune to other enemy factions
global.factionStance[5, 1] = 1;
global.factionStance[5, 2] = 0;
global.factionStance[5, 3] = 1;
global.factionStance[5, 4] = 1;
global.factionStance[5, 5] = 1;
global.factionStance[5, 6] = 0;
global.factionStance[5, 7] = 1;

global.factionStance[6, 0] = 1; // Passive only towards the player
global.factionStance[6, 1] = 0;
global.factionStance[6, 2] = 1;
global.factionStance[6, 3] = 1;
global.factionStance[6, 4] = 1;
global.factionStance[6, 5] = 1;
global.factionStance[6, 6] = 0;
global.factionStance[6, 7] = 0;

global.factionStance[7, 0] = 0; // Passive towards players, but vulnerable to player projectiles
global.factionStance[7, 1] = 0;
global.factionStance[7, 2] = 1;
global.factionStance[7, 3] = 0;
global.factionStance[7, 4] = 0;
global.factionStance[7, 5] = 0;
global.factionStance[7, 6] = 0;
global.factionStance[7, 7] = 0;

// load external rooms
global.roomExternalCache = ds_map_create();
global.roomExternalFileName = ds_map_create();
global.roomExternalSetupMap = ds_map_create();
