/// loadCustomCostume(filename, playerID) returns error code
/// Errors:
/// 0: Success
/// -1: Error loading sprite
/// -2: Image has unexpected dimensions
var filename = argument0, playerID = argument1;
/*
While the mechanism for loading custom costumes should still work,
the menu itself is left as an excercise to the programmer.
I recommend using console commands as a way to test. Console supports get_open_filename so you can even open them
in nonstandard locations, thanks to FMOD.

(Note: You should use an async variant for actually loading in release, if that's
how you want to handle it)
*/

filename = filename;
playerID = playerID;

var STARTX = 410;
var STARTY = 665;

var tempSprite = customCostume_AutogenWhitemasks(filename);
var error = 0;

if (global.customCostumePixelSurface == noone || 
    !surface_exists(global.customCostumePixelSurface))
{
    global.customCostumePixelSurface = mm_surface_create(16,3);
}

if (is_undefined(tempSprite) || !sprite_exists(tempSprite))
{
    if (sprite_exists(tempSprite))
    {
        sprite_delete(tempSprite);
        
    }
    error = -1;
    print("invalid sprite");
    mm_surface_free(global.customCostumePixelSurface);
    return error;
}
if (sprite_get_width(tempSprite) != sprite_get_width(sprRockman) || 
    sprite_get_height(tempSprite) != sprite_get_height(sprRockman))
{
    print( "image has different dimensions: " + string(sprite_get_width(tempSprite)) + 
        "," + string(sprite_get_height(tempSprite)) );
    print("expected: " + string(sprite_get_width(sprRockman)) + "," + 
        string(sprite_get_height(sprRockman)) );
    sprite_delete(tempSprite);
    error = -2;
    mm_surface_free(global.customCostumePixelSurface);
    return error;
}

if (error == 0)
{
    // set name
    var name = "";
    var len = string_length(filename);
    var _end = len -3;
    var i = _end;
    for(;i>=1;--i)
    {
        if (string_char_at(filename,i) == "\" || string_char_at(filename,i) == "/")
        {
            i+=1;
            break;
        }
    }
    
    global.customCostumeName = stringSubstring(filename, i, _end);
    
    // set colors
    surface_set_target(global.customCostumePixelSurface);
    draw_clear_alpha(c_black,0);//Clear everything.
    // main colors
    draw_sprite_part(tempSprite, 0, STARTX, STARTY, 1, 2, 0, 0);
    global.costumePrimaryColor[global.customCostumeIndex+playerID] = 
        surface_getpixel(global.customCostumePixelSurface,0,0);
    global.costumeSecondaryColor[global.customCostumeIndex+playerID] = 
        surface_getpixel(global.customCostumePixelSurface,0,1);
    
    draw_clear_alpha(c_black,0);
    // rush coil
    draw_sprite_part(tempSprite, 0, STARTX + 2, STARTY, 1, 2, 0, 0);
    var col = surface_getpixel_ext(global.customCostumePixelSurface, 0, 0);
    var alpha = (col >> 24) & 255;

    if (alpha >= 250)
    {
        global.costumeRushCoilPrimaryColor[global.customCostumeIndex+playerID] = 
            surface_getpixel(global.customCostumePixelSurface,0,0);
        global.costumeRushCoilSecondaryColor[global.customCostumeIndex+playerID] = 
            surface_getpixel(global.customCostumePixelSurface,0,1);
    }
    else
    {
        global.costumeRushCoilPrimaryColor[global.customCostumeIndex+playerID] = 
            make_color_rgb(216, 40, 0);
        global.costumeRushCoilSecondaryColor[global.customCostumeIndex+playerID] = 
            make_color_rgb(255, 255, 255);
    }
    draw_clear_alpha(c_black,0);
    // rush jet
    draw_sprite_part(tempSprite, 0, STARTX + 4, STARTY, 1, 2, 0, 0);
    var col = surface_getpixel_ext(global.customCostumePixelSurface,0,0);
    alpha = (col >> 24) & 255;

    if (alpha >= 250)
    {
        global.costumeRushJetPrimaryColor[global.customCostumeIndex+playerID] = 
            surface_getpixel(global.customCostumePixelSurface,0,0);
        global.costumeRushJetSecondaryColor[global.customCostumeIndex+playerID] = 
            surface_getpixel(global.customCostumePixelSurface,0,1);
    }
    else
    {
        global.costumeRushJetPrimaryColor[global.customCostumeIndex+playerID] = 
            make_color_rgb(216, 40, 0);
        global.costumeRushJetSecondaryColor[global.customCostumeIndex+playerID] = 
            make_color_rgb(255, 255, 255);
    }
    draw_clear_alpha(c_black,0);
    // rush bike
    draw_sprite_part(tempSprite, 0, STARTX + 6, STARTY, 1, 2, 0, 0);
    var col = surface_getpixel_ext(global.customCostumePixelSurface,0,0);
    alpha = (col >> 24) & 255;

    if (alpha >= 250)
    {
        global.costumeRushBikePrimaryColor[global.customCostumeIndex+playerID] = 
            surface_getpixel(global.customCostumePixelSurface,0,0);
        global.costumeRushBikeSecondaryColor[global.customCostumeIndex+playerID] = 
            surface_getpixel(global.customCostumePixelSurface,0,1);
    }
    else
    {
        global.costumeRushBikePrimaryColor[global.customCostumeIndex+playerID] = 
            make_color_rgb(216, 40, 0);
        global.costumeRushBikeSecondaryColor[global.customCostumeIndex+playerID] = 
            make_color_rgb(255, 255, 255);
    }
    /*
    Unless we make MaGMML2 weapons this is unnecessary.
    *If* we do though, you need to change the coordinates below in order to not conflict with simple mode.
    // sakugarne
    draw_sprite_part(tempSprite, 0, STARTX + 8, STARTY, 1, 2, 0, 0);
    var col = surface_getpixel_ext(global.customCostumePixelSurface,0,0);
    alpha = (col >> 24) & 255;

    if (alpha >= 250)
    {
        global.costumeSakugarnePrimaryColor[global.customCostumeIndex] = 
            surface_getpixel(global.customCostumePixelSurface,0,0);
        global.costumeSakugarneSecondaryColor[global.customCostumeIndex] = 
            surface_getpixel(global.customCostumePixelSurface,0,1);
    }
    else
    {
        global.costumeSakugarnePrimaryColor[global.customCostumeIndex] = 
            make_color_rgb(0, 120, 248);
        global.costumeSakugarneSecondaryColor[global.customCostumeIndex] = 
            make_color_rgb(0, 232, 216);
    }*/
    draw_clear_alpha(c_black,0);
    // Name Colour OH BOy
    draw_sprite_part(tempSprite, 0, STARTX, STARTY + 3, 1, 3, 0, 0);
    var col = surface_getpixel(global.customCostumePixelSurface,0,0);
    alpha = (surface_getpixel_ext(global.customCostumePixelSurface,0,0) >> 24) & 255;
    if (playerID == 0)//First player only.
    {
        if (alpha >= 250) // not empty
        {
            global.customCostumeNameColor = col;
        }
        else // unspecified
        {
            global.customCostumeNameColor = global.nesPalette[$30];
        }
    }
    
    // pronouns
    var col = surface_getpixel(global.customCostumePixelSurface,0,1);
    alpha = (surface_getpixel_ext(global.customCostumePixelSurface,0,1) >> 24) & 255;
    
    if (alpha >= 250) // If all three equal.
    {
        var r = color_get_red(col);
        var g = color_get_green(col);
        var b = color_get_blue(col);
        
        global.customCostumeGender[playerID] = 2;//Failsafes.
        global.customCostumeSpecies[playerID] = 0;
        if (r != b || b != g)//Fail if any of the colors are unequal.
        {
            print("Skin is a they.");
            global.customCostumeGender[playerID] = 2;
            global.customCostumeSpecies[playerID] = 0;//Assume robot, given most Mega Man characters will be.
        }
        else//Now we can check with only red.
        {
            if (r >= 252) // white
            {
                print("Skin is a he.");
                global.customCostumeGender[playerID] = 0;
            }
            else if (r <= 3) // black
            {
                print("Skin is a she.");
                global.customCostumeGender[playerID] = 1;
            }
            else // any shade of grey
            {
                print("Skin is a they.");
                global.customCostumeGender[playerID] = 2;
            }
            switch (r)
            {
                case 0://Robots.
                case 128:
                case 255:
                default:
                    global.customCostumeSpecies[playerID] = 0;
                    print("Skin is a robot.");
                break;
                case 1://Humans.
                case 129:
                case 254:
                    global.customCostumeSpecies[playerID] = 1;
                    print("Skin is a human.");
                break;
                case 2://Animals.
                case 130:
                case 253:
                    global.customCostumeSpecies[playerID] = 2;
                    print("Skin is an animal.");
                break;
                case 3://"Entity" (Abstract).
                case 131:
                case 252:
                    global.customCostumeSpecies[playerID] = 3;
                    print("Skin is an entity.");
                break;
            }
            
        }
    }
    else // non-greyscale
    {
        print("Skin is a they by no specification.");
        global.customCostumeGender[playerID] = 2;
        global.customCostumeSpecies[playerID] = 0;//Assume robot, given most Mega Man characters will be.
    }
    
    // landing particles (For big people)
    var col = surface_getpixel(global.customCostumePixelSurface,0,2);
    alpha = (surface_getpixel_ext(global.customCostumePixelSurface,0,2) >> 24) & 255;
    if (alpha >= 250) // If all three equal.
    {
        var r = color_get_red(col);
        var g = color_get_green(col);
        var b = color_get_blue(col);
        
        if (r == b && b == g && g == 255) // white
        {
            print("Skin uses landing particles");
            global.customCostumeLandParticles[playerID] = 1;
        }
        else // black
        {
            print("Skin does not use landing particles");
            global.customCostumeLandParticles[playerID] = 0;
        }
    }
    else // non-greyscale
    {
        print("Skin does not use landing particles no specification.");
        global.customCostumeLandParticles[playerID] = 0;
    }
    
    draw_clear_alpha(c_black,0);
    // shot firing types
    draw_sprite_part(tempSprite, 0, STARTX + 2, STARTY + 3, 1, 3, 0, 0);
    col = surface_getpixel(global.customCostumePixelSurface,0,0);
    alpha = (surface_getpixel_ext(global.customCostumePixelSurface,0,0) >> 24) & 255;
    if (alpha >= 250) // If all three equal.
    {
        var r = color_get_red(col);
        var g = color_get_green(col);
        var b = color_get_blue(col);
        
        if (r == b && b == g && g == 255) // white
        {
            print("Custom Shot Row");
            global.customCostumeShotSetting[playerID] = 2;
        }
        else if (r == b && b == g && g == 0) // black
        {
            print("General Shots");
            global.customCostumeShotSetting[playerID] = 0;
        }
        else // any shade of grey
        {
            print("Throwing Shots");
            global.customCostumeShotSetting[playerID] = 1;
        }
    }
    else // non-greyscale
    {
        print("General Shots by no specification.");
        global.customCostumeShotSetting[playerID] = 0;
    }
    // charge shot firing types
    col = surface_getpixel(global.customCostumePixelSurface,0,1);
    alpha = (surface_getpixel_ext(global.customCostumePixelSurface,0,1) >> 24) & 255;
    if (alpha >= 250) // If all three equal.
    {
        var r = color_get_red(col);
        var g = color_get_green(col);
        var b = color_get_blue(col);
        
        if (r == b && b == g && g == 255) // white
        {
            print("Custom Charge Shot Row");
            global.customCostumeChargeShotSetting[playerID] = 2;
        }
        else if (r == b && b == g && g == 0) // black
        {
            print("General Charge Shots");
            global.customCostumeChargeShotSetting[playerID] = 0;
        }
        else // any shade of grey
        {
            print("Throwing Charge Shots");
            global.customCostumeChargeShotSetting[playerID] = 1;
        }
    }
    else // non-greyscale
    {
        print("General Charge Shots by no specification.");
        global.customCostumeChargeShotSetting[playerID] = 0;
    }
    
    //scarf animation
    var col = surface_getpixel(global.customCostumePixelSurface,0,2);
    alpha = (surface_getpixel_ext(global.customCostumePixelSurface,0,2) >> 24) & 255;
    if (alpha >= 250) // If all three equal.
    {
        var r = color_get_red(col);
        var g = color_get_green(col);
        var b = color_get_blue(col);
        
        if (r == b && b == g && g == 255) // white
        {
            print("Skin uses scarf animation");
            global.customCostumeScarfAnimation[playerID] = 1;
        }
        else // black
        {
            print("Skin does not use scarf animation");
            global.customCostumeScarfAnimation[playerID] = 0;
        }
    }
    else // non-greyscale
    {
        print("Skin does not use scarf animation by no specification.");
        global.customCostumeScarfAnimation[playerID] = 0;
    }
    
    //Buster offset value.
    global.costumeShotOffset[global.customCostumeIndex+playerID] = 0;//Set to default in case below isn't used.
    draw_clear_alpha(c_black,0);
    // shot firing types
    draw_sprite_part(tempSprite, 0, STARTX + 4, STARTY + 3, 1, 3, 0, 0);
    col = surface_getpixel(global.customCostumePixelSurface,0,0);
    alpha = (surface_getpixel_ext(global.customCostumePixelSurface,0,0) >> 24) & 255;
    if (alpha >= 250) // If all three equal.
    {
        var r = color_get_red(col);
        var g = color_get_green(col);
        var b = color_get_blue(col);
        
        if (r == b && b == g) // if all colors match
        {
            global.costumeShotOffset[global.customCostumeIndex+playerID] = min(5,max(0,r-128));
            //printErr(global.costumeShotOffset[global.customCostumeIndex]);
        }
    }
    
    
    global.customCostumeTextLengths[playerID,0] = 0;
    global.customCostumeTextLengths[playerID,1] = 0;
    global.customCostumeTextLengths[playerID,2] = 0;
    global.customCostumeTextLengths[playerID,3] = 0;
    global.customCostumeTextLengths[playerID,4] = 0;
    global.customCostumeTextLengths[playerID,5] = 0;
    
    //Text lengths part 1.
    col = surface_getpixel(global.customCostumePixelSurface,0,1);
    alpha = (surface_getpixel_ext(global.customCostumePixelSurface,0,1) >> 24) & 255;
    if (alpha >= 250)
    {
        var r = color_get_red(col);
        var g = color_get_green(col);
        var b = color_get_blue(col);
        global.customCostumeTextLengths[playerID,0] = r;//READY
        global.customCostumeTextLengths[playerID,1] = g > 0;//Does READY use fancy text?
        global.customCostumeTextLengths[playerID,2] = b;//M. Buster
        
    }
    //Text lengths part 2.
    col = surface_getpixel(global.customCostumePixelSurface,0,2);
    alpha = (surface_getpixel_ext(global.customCostumePixelSurface,0,2) >> 24) & 255;
    if (alpha >= 250)
    {
        var r = color_get_red(col);
        var g = color_get_green(col);
        var b = color_get_blue(col);
        global.customCostumeTextLengths[playerID,3] = r;//R. COIL
        global.customCostumeTextLengths[playerID,4] = g;//R. JET
        global.customCostumeTextLengths[playerID,5] = b;//R. BIKE
        
    }
    
    //Victory Pose
    draw_clear_alpha(c_black,0);
    global.customCostumeVictoryPose[playerID] = false;
    draw_sprite_part(tempSprite, 0, STARTX + 6, STARTY + 3, 1, 3, 0, 0);
    col = surface_getpixel(global.customCostumePixelSurface,0,0);
    alpha = (surface_getpixel_ext(global.customCostumePixelSurface,0,0) >> 24) & 255;
    if (alpha >= 250) // If all three equal.
    {
        var r = color_get_red(col);
        var g = color_get_green(col);
        var b = color_get_blue(col);
        if (r == b && b == g && g == 255) // if all colors match
        {
            global.customCostumeVictoryPose[playerID] = true;
            //global.costumeShotOffset[global.customCostumeIndex] = min(5,max(-3,r-128));
            //printErr(global.costumeShotOffset[global.customCostumeIndex]);
        }
    }
    //Charge palette type: Primary.
    //global.customCostumeChargeType[i] = 0;
    col = surface_getpixel(global.customCostumePixelSurface,0,1);
    alpha = (surface_getpixel_ext(global.customCostumePixelSurface,0,1) >> 24) & 255;
    global.customCostumeChargeType[playerID] = 0;
    global.customCostumeChargePrimary[playerID] = 0;
    global.customCostumeChargeSecondary[playerID] = 0;
    if (alpha > 0)
    {
        
        global.customCostumeChargeType[playerID] = 1;
        global.customCostumeChargePrimary[playerID] = col;
        
        
    }
    
    //Secondary (Outline)
    col = surface_getpixel(global.customCostumePixelSurface,0,2);
    alpha = (surface_getpixel_ext(global.customCostumePixelSurface,0,2) >> 24) & 255;
    if (alpha > 0)
    {
        
        
        global.customCostumeChargeType[playerID] = 1;
        global.customCostumeChargeSecondary[playerID] = col;
        
        
    }
    
    //RC/RJ/RB Teleport Types.
    draw_clear_alpha(c_black,0);
    global.customCostumeRushTPs[playerID] = array_create(3);
    draw_sprite_part(tempSprite, 0, STARTX + 4, STARTY + 6, 1, 3, 0, 0);
    col = surface_getpixel(global.customCostumePixelSurface,0,0);
    alpha = (surface_getpixel_ext(global.customCostumePixelSurface,0,0) >> 24) & 255;
    if (alpha >= 250) // If all three equal.
    {
        var r = color_get_red(col);
        var g = color_get_green(col);
        var b = color_get_blue(col);
        
        global.customCostumeRushTPs[playerID] = makeArray(r == 255, g == 255, b == 255);
    }
    
    
    //Shades/Hat Value. Removed for Megamix but the position is left here for authenticty reasons.
    draw_clear_alpha(c_black,0);
    draw_sprite_part(tempSprite, 0, STARTX, STARTY + 8, 1, 3, 0, 0);
    col = surface_getpixel(global.customCostumePixelSurface,0,0);
    alpha = (surface_getpixel_ext(global.customCostumePixelSurface,0,0) >> 24) & 255;
    
    if (sprite_exists(global.playerSprite[global.customCostumeIndex+playerID]))
    {
        sprite_delete(global.playerSprite[global.customCostumeIndex+playerID]);
    }
    global.playerSprite[global.customCostumeIndex+playerID] = tempSprite;
    
    surface_reset_target();
    
    loadCustomCostume_Sounds(argument[0],argument[1]);
    
}
mm_surface_free(global.customCostumePixelSurface);
return error;
