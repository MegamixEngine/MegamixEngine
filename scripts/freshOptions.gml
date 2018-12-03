/// freshOptions()
// resets all options-specific variables to their default value

global.healthEffect = 0;
global.musicvolume = 80;
global.soundvolume = 100;
global.damagePopup = 0;
global.mmColor = 0;
global.chargeBar = 0;
global.showFPS = 0;
global.familyFriendlyText = false;
global.escapeBehavior = 0;
global.pickupGraphics = 0;
global.deathEffect = 0;
global.jumpSound = 0;
global.teleportSound = 0;
global.checkpointNotification = 1;

global.showControllerOverlay = false;
global.showMovingText = true;
global.showControllerOverlay = false;
global.showColoredTextOverlays = false;
global.showColoredTextOverlaysRed = 1;
global.showColoredTextOverlaysGreen = 1;
global.showColoredTextOverlaysBlue = 1;
global.showColoredTextOverlaysOpacity = 1;
global.vsync = 0;

global.playerSpriteMax = 4;
for (i = 0; i < global.playerSpriteMax; i += 1)
{
    global.playerSprite[i] = sprRockman;
}
global.playerSprite[1] = sprProtoman;
global.playerSprite[2] = sprBass;
global.playerSprite[3] = sprRoll;

// Options - Default values
for (i = 0; i < 4; i += 1)
{
    global.leftKey[i] = vk_left;
    global.rightKey[i] = vk_right;
    global.upKey[i] = vk_up;
    global.downKey[i] = vk_down;
    global.jumpKey[i] = ord('Z');
    global.shootKey[i] = ord('X');
    global.slideKey[i] = ord('C');
    global.pauseKey[i] = vk_space;
    global.weaponSwitchLeftKey[i] = ord('A');
    global.weaponSwitchRightKey[i] = ord('S');
    
    global.joystick_jumpKey[i] = gp_face1;
    global.joystick_shootKey[i] = gp_face3;
    global.joystick_slideKey[i] = gp_face4;
    global.joystick_pauseKey[i] = gp_start;
    global.joystick_weaponSwitchLeftKey[i] = gp_shoulderlb;
    global.joystick_weaponSwitchRightKey[i] = gp_shoulderrb;
}

global.leftKey[1] = vk_numpad4;
global.rightKey[1] = vk_numpad6;
global.upKey[1] = vk_numpad8;
global.downKey[1] = vk_numpad2;
global.jumpKey[1] = vk_numpad5;
global.shootKey[1] = vk_numpad0;
global.slideKey[1] = vk_numpad3;
global.pauseKey[1] = vk_enter;
global.weaponSwitchLeftKey[1] = vk_numpad7;
global.weaponSwitchRightKey[1] = vk_numpad9;
