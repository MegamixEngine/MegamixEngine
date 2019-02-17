/// saveLoadOptions(save?);
// saves / loads options
// save? -- true: save; false: load

slBegin(argument0, "options.sav")

// option flags
global.screensize            = sl(global.screensize,   "screensize");
global.musicvolume           = sl(global.musicvolume,  "mvol");
global.soundvolume           = sl(global.soundvolume,  "svol");
global.damagePopup           = sl(global.damagePopup,  "dpop");
global.mmColor               = sl(global.mmColor,      "mmcol");
global.chargeBar             = sl(global.chargeBar,    "cbar");
global.showFPS               = sl(global.showFPS,      "fps");
global.healthEffect          = sl(global.healthEffect, "healthfx");
global.playerCount           = sl(global.playerCount,  "player-count");
global.healthEffect          = sl(global.healthEffect,   "healthfx");
global.playerCount           = sl(global.playerCount,    "player-count");
playerGlobalInit(); // Initialize global variable arrays for all players.
global.pickupGraphics        = sl(global.pickupGraphics, "item-graphics");
global.deathEffect           = sl(global.deathEffect, "death-effect");
global.jumpSound             = sl(global.jumpSound, "jump-sound");
global.teleportSound         = sl(global.teleportSound, "teleport-sound");
global.checkpointNotification= sl(global.checkpointNotification, "checkpoint-notice");
global.vsync                 = sl(global.vsync,          "vsync");
global.showControllerOverlay = sl(global.showControllerOverlay, "controlleroverlay");
global.escapeBehavior         = sl(global.escapeBehavior, "escapebehavior");

// controls
for (var i = 0; i < global.maxPlayerCount; i += 1)
{
    // keyboard
    global.leftKey[i]  = sl(global.leftKey[i],  "key-l" + string(i));
    global.rightKey[i] = sl(global.rightKey[i], "key-r" + string(i));
    global.upKey[i]    = sl(global.upKey[i],    "key-u" + string(i));
    global.downKey[i]  = sl(global.downKey[i],  "key-d" + string(i));
    global.jumpKey[i]  = sl(global.jumpKey[i],  "key-j" + string(i));
    global.shootKey[i] = sl(global.shootKey[i], "key-x" + string(i));
    global.slideKey[i] = sl(global.slideKey[i], "key-s" + string(i));
    global.pauseKey[i] = sl(global.pauseKey[i], "key-pause" + string(i));
    global.weaponSwitchLeftKey[i]  = sl(global.weaponSwitchLeftKey[i],  "key-swl" + string(i));
    global.weaponSwitchRightKey[i] = sl(global.weaponSwitchRightKey[i], "key-swr" + string(i));
    
    // joystick
    global.joystick_jumpKey[i]  = sl(global.joystick_jumpKey[i],  "joy-j" + string(i));
    global.joystick_shootKey[i] = sl(global.joystick_shootKey[i], "joy-x" + string(i));
    global.joystick_slideKey[i] = sl(global.joystick_slideKey[i], "joy-s" + string(i));
    global.joystick_pauseKey[i] = sl(global.joystick_pauseKey[i], "joy-pause" + string(i));
    global.joystick_weaponSwitchLeftKey[i]  = sl(global.joystick_weaponSwitchLeftKey[i],  "joy-swl" + string(i));
    global.joystick_weaponSwitchRightKey[i] = sl(global.joystick_weaponSwitchRightKey[i], "joy-swr" + string(i));
}

slEnd();

//@noformat
