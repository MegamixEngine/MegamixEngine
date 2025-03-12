/// saveLoadOptions(save?, [isReplay?]);
// saves / loads options
// save? -- true: save; false: load
// isReplay? Used to exclude certain value loading for replays. Mainly needed for options that alter gameplay.

var isReplay = false;
if (argument_count > 1)
{
    isReplay = argument[1];
}
if (!isReplay)
{
    slBegin(argument[0], "options", 0, true);
}

// funny little save icon =) love that little man
if (argument[0] == SL_SAVE) 
{
    if (!isReplay && global.recordInputMode != 0)
    {
        exit;//The exits when replays are on to prevent actually overwriting save files.
    }
    else
    {
        objGlobalControl.saveTimer = 40;
    }
}
global.showColoredTextOverlays = sl("showColoredTextOverlays");
global.coloredTextOverlaysRed = sl("coloredTextOverlaysRed",0);
global.coloredTextOverlaysGreen = sl("coloredTextOverlaysGreen",200);
global.coloredTextOverlaysBlue = sl("coloredTextOverlaysBlue",255);
global.coloredTextOverlaysOpacity = sl("coloredTextOverlaysOpacity",170);
global.showMovingText = sl("showMovingText",true);


if (!isReplay)//Ignore these values when loading a replay.
{
    // option flags
    global.screensize            = sl("screensize",max(1, floor(min(display_get_width() / global.screenWidth,
    (display_get_height() - 32) / global.screenHeight))));
    global.fullscreen            = sl("fullscreen");
    global.mastervolume          = sl("mastervolume",70);
    global.musicvolume           = sl("musicvolume",80);
    global.soundvolume           = sl("soundvolume",100);
    global.musicShowCredits      = sl("musicShowCredits",true);
    global.damagePopup           = sl("damagePopup");
    global.mmColor               = sl("mmColor");
    global.chargeBar             = sl("chargeBar");
    global.showFPS               = sl("showFPS");
}

global.healthEffect          = sl("healthEffect");//Required for replays.
global.pickupGraphics        = sl("pickupGraphics");
global.deathEffect           = sl("deathEffect");
global.jumpSound             = sl("jumpSound");
global.teleportSound         = sl("teleportSound");
global.busterSound           = sl("busterSound");
global.hurtSound             = sl("hurtSound");
global.refillSound           = sl("refillSound");
global.splashSound           = sl("splashSound");
global.doorSound             = sl("doorSound");
global.deathSound            = sl("deathSound");
global.pauseSound            = sl("pauseSound");

global.checkpointNotification   = sl("checkpointNotification");
global.multiplayerColors        = sl("multiplayerColors");
global.colorBlindSheepBlocks    = sl("colorBlindSheepBlocks");
if (!isReplay)//*Shouldn't* cause issues in terms of replay syncing if we don't apply this.
{
    global.vsync                 = sl("vsync");
    global.showControllerOverlay = sl("showControllerOverlay");
    global.escapeBehavior        = sl("escapeBehavior");
}
global.textSounds            = sl("textSounds");
global.textAppearanceSounds  = sl("textAppearanceSounds");
global.downJumpSlide         = sl("downJumpSlide",true);

global.WheelEnabled          = sl("WheelEnabled",true);
global.manualTippytoe        = sl("manualTippytoe",true);
global.autoCutsceneSkip      = sl("autoCutsceneSkip");
global.resetShortcuts        = sl("resetShortcuts",1);

//Absolutely required for replays due to how much they change the mechanics:
global.holdToggle = sl("holdToggle");
global.autoFire = sl("autoFire");
global.autoCharge = sl("autoCharge");

global.wepIconShow = sl("wepIconShow",true);

if (!isReplay)
{
    
    // controls
    if (argument[0] != SL_INIT)//Handled differently for initialization.
    {//Figure this out
        for (var i = 0; i < MAX_PLAYERS; i++)
        {
            var currentBind = variable_global_get("keyboardBind" + string(i));
            variable_global_set("keyboardBind" + string(i),sl("keyboardBind" + string(i),currentBind, "key" + string(i)));
            
            var currentBind = variable_global_get("gamepadBind" + string(i));
            variable_global_set("gamepadBind" + string(i),sl("gamepadBind" + string(i), currentBind, "joy" + string(i)));
            
        }
    }
    else
    {
        controlMappingInit(-1);
    }
    
    global.joystick_rumbleType =  sl("joystick_rumbleType",allocateArray(MAX_PLAYERS,true));
    
    global.fullscreenBorder = sl("fullscreenBorder");
    global.borderBrightness = sl("borderBrightness",1);
    global.borderSaturation = sl("borderSaturation",1);
    global.borderColor = sl("borderColor",-1);
    global.hueApplication = sl("hueApplication");
    global.borderVisibility = sl("borderVisibility",1);
    global.fullscreenType = sl("fullscreenType");//0 is 'best fit' (whichever integer value closest matches), 1 is stretch.
    global.screenRatio = sl("screenRatio");//0 8:7, 1 is 4:3 conversion.
    global.screenShader = sl("screenShader");
    global.paletteShader = sl("paletteShader");
    global.hitFlashType = sl("hitFlashType");
    global.buttonPromptOverride = sl("buttonPromptOverride");
    global.mouseType = sl("mouseType",1);
    
}

global.customBorders = array_create(0);
var fileName = file_find_first(working_directory + "/Borders/" + "*.png", fa_directory);

while (fileName != "")
{
    global.customBorders[array_length_1d(global.customBorders)] = fileName;
    
    fileName = file_find_next();
}


file_find_close();

if (global.fullscreenBorder-1 >= sprite_get_number(sprBorders)+array_length_1d(global.customBorders))
{
    global.fullscreenBorder = 1;//Set to 1 to prevent issues with snapping to a res someone doesn't want.
}

customBorderLoad(global.fullscreenBorder);

global.bordersUnlocked = sl("bordersUnlocked",makeArray("NONE","SGB","GB","Switch Online"));//array_create(sprite_get_n)

if (!isReplay)
{
    slEnd();
}
//@noformat
