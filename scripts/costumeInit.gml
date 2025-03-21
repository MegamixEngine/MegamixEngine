/// costumeInit([dontOverwriteCustoms])

////////////////////////////////////////////////////////
// Script to initialize all costumes and their colors //
////////////////////////////////////////////////////////

if (global.costumeID!=-1) {
    mm_ds_map_destroy(global.costumeID);
}

global.costumeID = mm_ds_map_create(true);

/////// CORE FOUR ///////

// Mega Man
global.costumeID[? "Mega Man"] = 0;
global.playerSprite[0] = sprRockman;

global.costumeName[0] = "Mega Man";
global.costumeNameShort[0] = global.costumeName[0];
global.costumeReadyText[0] = "READY";
global.costumeShotOffset[0] = 0;
global.costumeExtendedSpin[0] = false;

global.costumeBusterName[0] = "MEGA BUSTER";
global.costumeBusterIcon[0] = sprWeaponIconsMegaBuster;
global.costumePrimaryColor[0] = make_color_rgb(0, 120, 248);
global.costumeSecondaryColor[0] = make_color_rgb(0, 232, 216);

global.costumeRushCoilPrimaryColor[0] = make_color_rgb(216, 40, 0);
global.costumeRushCoilSecondaryColor[0] = make_color_rgb(255, 255, 255);
global.costumeRushJetPrimaryColor[0] = global.costumeRushCoilPrimaryColor[0];
global.costumeRushJetSecondaryColor[0] = global.costumeRushCoilSecondaryColor[0];

global.costumeRushBikePrimaryColor[0] = global.costumeRushCoilPrimaryColor[0];
global.costumeRushBikeSecondaryColor[0] = global.costumeRushCoilSecondaryColor[0];
global.costumeSakugarnePrimaryColor[0] = global.costumePrimaryColor[0];
global.costumeSakugarneSecondaryColor[0] = global.costumeSecondaryColor[0];

global.costumePrice[0] = 0;
global.costumeSource[0] = "Mega Man";

// Proto Man
global.costumeID[? "Proto Man"] = 1;
global.playerSprite[1] = sprProtoman;

global.costumeName[1] = "Proto Man";
global.costumeNameShort[1] = global.costumeName[1];
global.costumeReadyText[1] = "READY";
global.costumeShotOffset[1] = 3;
global.costumeExtendedSpin[1] = false;

global.costumeBusterName[1] = "PROTO BUSTER";
global.costumeBusterIcon[1] = sprWeaponIconsMegaBuster;
global.costumePrimaryColor[1] = make_color_rgb(220, 40, 0);
global.costumeSecondaryColor[1] = make_color_rgb(188, 188, 188);

global.costumeRushCoilPrimaryColor[1] = make_color_rgb(216, 40, 0);
global.costumeRushCoilSecondaryColor[1] = make_color_rgb(255, 255, 255);
global.costumeRushJetPrimaryColor[1] = global.costumeRushCoilPrimaryColor[1];
global.costumeRushJetSecondaryColor[1] = global.costumeRushCoilSecondaryColor[1];

global.costumeRushBikePrimaryColor[1] = global.costumeRushCoilPrimaryColor[1];
global.costumeRushBikeSecondaryColor[1] = global.costumeRushCoilSecondaryColor[1];
global.costumeSakugarnePrimaryColor[1] = global.costumePrimaryColor[1];
global.costumeSakugarneSecondaryColor[1] = global.costumeSecondaryColor[1];

global.costumePrice[1] = 100;
global.costumeSource[1] = "Mega Man 3";

// Bass
global.costumeID[? "Bass"] = 2;
global.playerSprite[2] = sprBass;

global.costumeName[2] = "Bass";
global.costumeNameShort[2] = global.costumeName[2];
global.costumeReadyText[2] = "READY";
global.costumeShotOffset[2] = 0;
global.costumeExtendedSpin[2] = false;

global.costumeBusterName[2] = "BASS BUSTER";
global.costumeBusterIcon[2] = sprWeaponIconsBassBuster;
global.costumePrimaryColor[2] = make_color_rgb(112, 112, 112);
global.costumeSecondaryColor[2] = make_color_rgb(248, 152, 56);

global.costumeRushCoilPrimaryColor[2] = make_color_rgb(112, 112, 112);
global.costumeRushCoilSecondaryColor[2] = make_color_rgb(128, 0, 240);
global.costumeRushJetPrimaryColor[2] = global.costumeRushCoilPrimaryColor[2];
global.costumeRushJetSecondaryColor[2] = global.costumeRushCoilSecondaryColor[2];

global.costumeRushBikePrimaryColor[2] = global.costumeRushCoilPrimaryColor[2];
global.costumeRushBikeSecondaryColor[2] = global.costumeRushCoilSecondaryColor[2];
global.costumeSakugarnePrimaryColor[2] = global.costumePrimaryColor[2];
global.costumeSakugarneSecondaryColor[2] = global.costumeSecondaryColor[2];

global.costumePrice[2] = 100;
global.costumeSource[2] = "Mega Man 7";

// Roll
global.costumeID[? "Roll"] = 3;
global.playerSprite[3] = sprRoll;

global.costumeName[3] = "Roll";
global.costumeNameShort[3] = global.costumeName[3];
global.costumeReadyText[3] = "READY";
global.costumeShotOffset[3] = 2;
global.costumeExtendedSpin[3] = false;

global.costumeBusterName[3] = "ROLL BUSTER";
global.costumeBusterIcon[3] = sprWeaponIconsMegaBuster;
global.costumePrimaryColor[3] = make_color_rgb(248, 56, 0);
global.costumeSecondaryColor[3] = make_color_rgb(0, 168, 0);

global.costumeRushCoilPrimaryColor[3] = make_color_rgb(0, 160, 0);
global.costumeRushCoilSecondaryColor[3] = make_color_rgb(168, 224, 248);
global.costumeRushJetPrimaryColor[3] = global.costumeRushCoilPrimaryColor[3];
global.costumeRushJetSecondaryColor[3] = global.costumeRushCoilSecondaryColor[3];

global.costumeRushBikePrimaryColor[3] = global.costumeRushCoilPrimaryColor[3];
global.costumeRushBikeSecondaryColor[3] = global.costumeRushCoilSecondaryColor[3];
global.costumeSakugarnePrimaryColor[3] = global.costumePrimaryColor[3];
global.costumeSakugarneSecondaryColor[3] = global.costumeSecondaryColor[3];

global.costumePrice[3] = 100;
global.costumeSource[3] = "Mega Man";

//Add more internal costumes here.
//NOTE: Place new costumes after sprRoll in the sprite listings, but before sprCustomCostume_UsedForImporting.
//That acts as a marker for the sprite randomizer to ensure skins aren't randomized, which looks bad.

// Custom Costumes
var custCostume = array_length_1d(global.costumeName); //Use a flat value here so that the costume count isn't inflated every time the script is called
global.customCostumeIndex = custCostume;
global.costumePrice[custCostume] = 200;
global.costumeSource[custCostume] = "";

for (var i = 0; i < MAX_PLAYERS; i++)
{//Make a slot for each player to have their own custom costume.
    // Custom costume must be the last costume. 
    custCostume = (global.customCostumeIndex + i);
    
    // Custom costume variables. 
    global.costumeID[? "Custom Costume"] = custCostume;
    
    // To prevent custom costumes from getting overwritten by calls outside of globalInit. 
    if (argument_count == 0)
    {
        if (custCostume < array_length_1d(global.playerSprite))
        {//Player sprite was already created at this point, and should be deleted.
            sprite_delete(global.playerSprite[custCostume]);
        }
        global.playerSprite[custCostume] = sprite_duplicate(sprRockman);
        
        global.costumeName[custCostume] = "Custom Costume";
        global.costumeNameShort[custCostume] = "Custom";
        global.costumeReadyText[custCostume] = "READY";
        global.costumeShotOffset[custCostume] = 0;
        global.costumeExtendedSpin[custCostume] = false;
        
        global.costumeBusterName[custCostume] = "MEGA BUSTER";
        global.costumeBusterIcon[custCostume] = sprWeaponIconsMegaBuster;
        global.costumePrimaryColor[custCostume] = make_color_rgb(0, 0, 0);
        global.costumeSecondaryColor[custCostume] = make_color_rgb(0, 0, 0);
        
        global.costumeRushCoilPrimaryColor[custCostume] = make_color_rgb(216, 40, 0);
        global.costumeRushCoilSecondaryColor[custCostume] = make_color_rgb(255, 255, 255);
        global.costumeRushJetPrimaryColor[custCostume] = make_color_rgb(216, 40, 0);
        global.costumeRushJetSecondaryColor[custCostume] = make_color_rgb(255, 255, 255);
        
        global.costumeRushBikePrimaryColor[custCostume] =  make_color_rgb(216, 40, 0);
        global.costumeRushBikeSecondaryColor[custCostume] = make_color_rgb(255, 255, 255);
        global.costumeSakugarnePrimaryColor[custCostume] = make_color_rgb(216, 40, 0);
        global.costumeSakugarneSecondaryColor[custCostume] = make_color_rgb(255, 255, 255);
        
        global.customCostumeName = "Custom Costume";
        global.customCostumeNameColor = global.nesPalette[$30]; // Default name colour
        global.customCostumePixelSurface = noone;
        global.customCostumeTextLengths[i,0] = 0;
        global.customCostumeTextLengths[i,1] = 0;
        global.customCostumeTextLengths[i,2] = 0;
        global.customCostumeTextLengths[i,3] = 0;
        global.customCostumeTextLengths[i,4] = 0;
        global.customCostumeTextLengths[i,5] = 0;//global.customCostumeTextLengths[i,custCostume] = array_create(6);//This also holds whether READY is fancy or not for this skin.
        global.customCostumeChargeType[i] = 0;
        global.customCostumeChargePrimary[i] = 0;
        global.customCostumeChargeSecondary[i] = 0;
    }
}

// Moved to freshSaveFile(). 
//global.customCostumeFilename = "";
//global.customCostumeEquipped = false;

// Contains externally loaded sprites. 
// Made global so as to 25ear them out if resetting the game. 
for (var i = 0; i < 12; i++)//Increased to 12 for new menu.
{
    global.customCostumeDisplay[i] = noone;
}

/////// End this madness ///////
global.playerSpriteMax = global.customCostumeIndex + 1; // Costume max count

