// globalInit()
// these are global variables and constants that aren't really meant to be configured.
global.newLine = "
";

global.nextRoom = -1; // set this at any time during gameplay to fade to a particular room.
global.previousRoom = -1;

global.saveSlot = 0;

global.roomName  = "";

global.stage = "";
global.stageIsHub = 0;

global.consoleN = 0;
global.canCheat = 0;
global.cheatsActive = 0;

global.quickGrid = -1;

/// --- Subsystem initialization --- ///
mathTableSetup();
lockPoolInit();
globalLockInit();
gigInit();
scheduler_resolution_set(1);

/// --- Keys and input --- ///
global.keyLeft[MAX_PLAYERS] = 0;
global.keyRight[MAX_PLAYERS] = 0;
global.keyUp[MAX_PLAYERS] = 0;
global.keyDown[MAX_PLAYERS] = 0;
global.keyJump[MAX_PLAYERS] = 0;
global.keyShoot[MAX_PLAYERS] = 0;
global.keySlide[MAX_PLAYERS] = 0;
global.keyPause[MAX_PLAYERS] = 0;
global.keyMap[MAX_PLAYERS] = 0;
global.keyWeaponSwitchLeft[MAX_PLAYERS] = 0;
global.keyWeaponSwitchRight[MAX_PLAYERS] = 0;
global.keyWheelSwitch[MAX_PLAYERS] = 0;

global.keyLeftPressed[MAX_PLAYERS] = 0;
global.keyRightPressed[MAX_PLAYERS] = 0;
global.keyUpPressed[MAX_PLAYERS] = 0;
global.keyDownPressed[MAX_PLAYERS] = 0;
global.keyJumpPressed[MAX_PLAYERS] = 0;
global.keyShootPressed[MAX_PLAYERS] = 0;
global.keySlidePressed[MAX_PLAYERS] = 0;
global.keyPausePressed[MAX_PLAYERS] = 0;
global.keyMapPressed[MAX_PLAYERS] = 0;
global.keyWeaponSwitchLeftPressed[MAX_PLAYERS] = 0;
global.keyWeaponSwitchRightPressed[MAX_PLAYERS] = 0;
global.keyWheelSwitchPressed[MAX_PLAYERS] = 0;

//For button prompts/*possibly* fixing issues between the two?
global.DInputConversionTables = makeArray(
    12,13,14,15,9,8,10,11,4,5,6,7,0,1,2,3
    );

/*
REFERENCE TABLE

PromptImageIndex-CalibratorID-XboxName-DInputID

0-Up-Up-12
1-Down-Down-13
2-Left-Left-14
3-Right-Right-15
4-7-Start-9
5-8-Select-16
6-9-LS-10
7-10-RS-11
8-5-LB-4
9-6-RB-5
10-ZP-LT-6
11-ZN-RT-7
12-1-A-0
13-2-B-1
14-3-X-2
15-4-Y-3

8 is missing.
*/

//These values change to reflect the current X and Y positions of the top left of the screen
//to cross-reference mouse position when borders are on.
global.mouseStartX = 0;
global.mouseStartY = 0;
global.mouseScreenRatio = 1;

global.buttonPromptType = 0;

/// --- Player Variables --- ///
global.playerHealth[MAX_PLAYERS] = 28;
global.weapon[MAX_PLAYERS] = 0;

for (var i = 0; i <= MAX_PLAYERS; i ++)
    global.respawnTimer[i] = -1;

global.playerCount = 1; // the number of players playing

global.WheelEnabled = true;
global.manualTippytoe = true;

global.primaryCol[MAX_PLAYERS] = c_white;
global.secondaryCol[MAX_PLAYERS] = c_white;
global.outlineCol[MAX_PLAYERS] = c_black;

global.inkSurface[0] = -1; // used for octone ink

global.protoWhistle = false; // proto whistle plays once

// can dead players respawn?
global.respawnAllowed = true;

global.respawnAnimation = 0; // 0 = teleport land, 1 = teleport in, 2 = fall in, 3 = Jump in, 4 = stand there (set showDuringReady to true), 8 = Skull elevator
global.respawnGravityAngle = 1; // 1 = normal, -1 = reverse

/// --- Font setup --- ///
CHARACTERSET_LATIN = " !" + '"' + "#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz{|}~¿ÀÁÂÃÄÅÆÇÐÈÉÊËÌÍÎÏÑÒÓÔÕÖØŒŠÙÚÛÜÝŸŽàáâãäåæçèéêëìíîïñòóôõöøðœšùúûüýÿžßÞþ";
CHARACTERSET_HIRIGANA = "あぁいぃうぅえぇおぉかきくけこさしすせそたちつってとなにぬねのはひふへほまみむめもやゃゆゅよょらりるれろわをん";
CHARACTERSET_KATAKANA = "アァイィウゥエェオォカキクケコサシスセソタチツッテトナニヌネノハヒフヘホマミムメモヤャユュヨョラリルレロワヲン";
CHARACTERSET_JPUNCT = "×「」゛゜、。ー";

var standardSet = CHARACTERSET_LATIN + CHARACTERSET_HIRIGANA + CHARACTERSET_KATAKANA + CHARACTERSET_JPUNCT;
global.font = font_add_sprite_ext(sprMegamixFont, standardSet, false, 0);
global.font2 = font_add_sprite(sprFont, ord(' '), false, -1);
global.fontSmall = font_add_sprite_ext(sprMegamixFontSmall, standardSet, true, 0);
global.fontSmall2 = font_add_sprite_ext(sprMegamixFontSmall_NoShadow, standardSet, true, 1);
global.fontTiny = font_add_sprite(sprFontBabyBlocks,ord('!'),true,1);

draw_set_font(global.font);

/// --- Screen and camera --- ///

// the default screen scaling.
global.screensize = max(1, floor(min(display_get_width() / global.screenWidth,
    (display_get_height() - 32) / global.screenHeight)));

global.adaptiveResolution = 1;
global.fullscreen = 0;
global.initfullscreen = 1;
global.fullscreenprevious = 0;
global.shakeTimer = 0;
global.shakeFactorX = 0;
global.shakeFactorY = 0;

global.flashTimer = 0;

global.displayCornerUI = true;

// Camera variables for users
global.prevXView = view_xview;
global.prevYView = view_yview;

// cached view -- view is fixed here if not following any object
global.cachedXView = 0;
global.cachedYView = 0;

// camera ignore, it's back from EZ baybee
global.cameraPanMode = false;
global.roundCamera = true;

/// --- In-level item tracking --- ///
global.keyNumber = 0;

global.dontRespawn = makeArray("");

/// --- Game progression --- ///
global.livesRemaining = global.defaultLives;

setCheckpoint(0);

//For returning to previous rooms
global.returnLayers = 0;

global.returnLayer[     0] = 0;
global.returnLayerX[    0] = 0;
global.returnLayerY[    0] = 0;
global.returnLayerDir[  0] = 0;

global.hasTeleported = 0;
global.usedDoor = 0;

global.teleportX = -1;
global.teleportY = -1;
global.teleportDir = 1;

global.lastTeleporterX = 128;
global.lastTeleporterY = 160;

global.roomTimer = 0;

global.displayCheck = false; //display name once
global.displayForce = true; //turned off for certain areas

global.previousRoom = rmFileSelect;

global.levelReward = makeArray(0);

// are we in a game room (mega man can jump around and stuff)
global.inGame = false;

// start a stage when the next room begins
global.endStageOnRoomEnd = false;
global.endMusicOnRoomEnd = false;
global.decrementLivesOnRoomEnd = true;

global.castleStagesBeaten = 0;
global.shownCastleIntro = false;

/// --- Sections and transitions --- ///
global.borderlist = mm_ds_list_create();

global.frozen = false;
global.lockTransition = false;
global.switchingSections = false;

global.sectionLeft = 0;
global.sectionRight = room_width;
global.sectionTop = 0;
global.sectionBottom = room_height;

global.borderLockLeft = 0;
global.borderLockRight = room_width;
global.borderLockTop = 0;
global.borderLockBottom = room_height;

/// --- Weapons and Weapon sets --- ////
weaponSetInit();
global.equippedWeaponSet = 0;

cheatInit(); // Moving up here for the sake of Proto Man utilities

// Weapon inventory
weaponSetup();

//multiplayer palette setups - here due to requiring information on weapon numbers
multiplayerPaletteSetup();

global.superArmInterface = makeArray();
global.tornadoBlow = 0;

/// --- Costumes --- ///
global.customCostumeEquipped = -1; // Added here so costumeInit() won't crash.

for (var i = 0; i < MAX_PLAYERS; i++)
{
    global.customCostumeEquipped[i] = 0;
    global.customCostumeChargeType[i] = 0;
    global.customCostumeRushTPs[i] = array_create(3);
    global.customCostumeVictoryPose[i] = false;
    global.customCostumeGender[i] = 2;
}

global.costumeID = -1;

costumeInit();

global.customSounds = -1;//Must be out here.

for (var j = 0; j < MAX_PLAYERS; j++)
{
    for (var i = 0; i < SFX_LENGTH; i++)
    {
        global.customSounds[j,i] = -1;
    }
    global.defaultPrimaryPalette[i] = c_blue;
    global.defaultSecondaryPalette[i] = c_aqua;
}

/// --- External Room Loading --- ///
global.roomExternalCache = mm_ds_map_create(true);
global.roomExternalFileName = mm_ds_map_create(true);
global.roomExternalSetupMap = mm_ds_map_create(true);
global.roomExternalBGCache = mm_ds_map_create(true);//Note: May be a good idea in the future to make this system clear assets when none of the rooms that use them are loaded.
//global.roomExternalSpriteCache = mm_ds_map_create(true);

/// --- Damage handling --- ///
global.damage = 0;
global.damageIsContact = false;

//If true, damage was derived directly from contact damage in damage calculation.
//If -1, damage was an override of some sort.
//Note: Overrides in EV_HURT for example will not change this value automatically.

factionInit();

scrCutsceneEnum();//This is placed here so the featherweight doesn't optimize it out.

/// --- Boss variables --- ///
global.bossTextShown = false;
global.aliveBosses = 0;

/// --- Custom borders --- ///

file_find_close();

global.customBorders = array_create(0);
var tmp = mm_surface_create(1920,1080);
global.customBorder_Sprite = sprite_create_from_surface(tmp,0,0,1920,1080,false,false,0,0);
mm_surface_free(tmp);

/// --- In-level song credits --- ///
global.songCredits = allocateArray(6,"");

global.songCredits_History = mm_ds_map_create(true);

/// --- Misc. --- ///
global.telTelWeather = 0;

// index of last background asset:
global.lastBackground = background_duplicate(bgNESPalette) - 1;
