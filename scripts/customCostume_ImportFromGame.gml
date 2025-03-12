/// customCostume_ImportFromGame(filename)
/*
WARNING: Spaghetti code inbound. This imports costumes from various MaGMML games.
Unfortunetely, each game had its own specification, so the code is forced to be
very messy.

2.0 Will hopefully come up with a new standard for skins, through which this
will act as the main import file.

GameIDs.
0 - 48H (Fully compatible minus 4 frames if even unnecessary frames were filled in)
1 - 1R (Fully compatible minus 4 frames and Break Dash/Rush Bike *without* every frame filled in, otherwise same as 48H)
2 - 2 (*Would* be compatible with almost everything but Rush Bike using the *true* spreadsheet, but the officially distributed/used frames not so much)
3 - MaGMML3
4 - (Submarker for MaGMML2)


*/
var tempSprite = sprite_add(argument[0],0,false,false,0,0);
var COSTUME_IMPORTER_VERSION = 10;
//MaGMML devteam note: Add up this version any time you edit the code post-release, no matter how small!
//(If you are an independent game project, ignore this lol).
/*
Importer version documentation:
0 - Initial version (MaGMML3 1 to 1.13)
1 - MaGMML3 1.13. Fixed issues with optional MaGMML2 values.
2 - MaGMML3 1.13a. Hotfix release, unlabeled, addresses various issues with the last release.
3+ - Any additional intermediary.
...
10 - Megamix Engine 1.9. Adds MaGMML3 import support, as Megamix changed some cells. Fixed some problems with 48H/1R import.
20 - Megamix 2.0? Unconfirmed, may need additional revisions beforehand. Plan is to just have this but then it all feeds through to a splitter in the end.


Note: MaGMML3 importer also has a bug where MaGMML2's 2nd climb-shoot frames being offset by 2, but *only* for aiming sprites which are unused, ergo it's only addressed here.
Additional Note: Some games had the spin frames offset wrong. This deliberately was left untouched by the importer so people's animations that aren't spins aren't messed up.
*/

//Dev note: For 2.0, just make a single copy of the current 1.9 skin for importing, so that we can keep this a black box.

var gameID_GameMarkers = makeArray(48,1,2,3,202);

var autoColorMode = false;

var gameID = -1;
var returnGameID = -1;
var keepGoing = true;
var originalImporterVersion = -1;
var MaGMML3_OGameMarker = -1;

var BASESPRITE_YCOMPENSATION = 1;
while (keepGoing)
{

    switch (sprite_get_height(tempSprite))
    {
        //case 713:
        case 662://48H or 3, determine which.
            var teensySurf = mm_surface_create(1,1);
            
            surface_set_target(teensySurf);
            draw_clear_alpha(c_black,0);
            //var offY = 614;
            //if (sprite_get_height(tempSprite)) == 713
            //{
            //    offY = 665;
            //}
            draw_sprite_part(tempSprite,0,456,614,1,1,0,0);
            var alpha = (surface_getpixel_ext(teensySurf, 0, 0)>> 24) & 255
            var col = surface_getpixel(teensySurf, 0, 0);
            originalImporterVersion = color_get_red(col);
            if (color_get_green(col) == 255 && color_get_blue(col) == 14 && alpha > 0)
            {
                gameID = 3;//3
                draw_sprite_part(tempSprite,0,455,614,1,1,0,0);
                alpha = (surface_getpixel_ext(teensySurf, 0, 0)>> 24) & 255
                col = surface_getpixel(teensySurf, 0, 0);
                MaGMML3_OGameMarker = color_get_red(col);
                if (alpha > 0 && originalImporterVersion == 0 && MaGMML3_OGameMarker == 202)
                {
                    MaGMML3_OGameMarker = 2;//Fix for error in previous versions.
                }
            }
            else if (sprite_get_width(tempSprite) == 917)
            {
                gameID = 3;
                MaGMML3_OGameMarker = 3;
                autoColorMode = true;
            }
            else
            {
                gameID = 0;//48H
            }
            surface_reset_target();
            mm_surface_free(teensySurf);
        break;
        case 611://1R
            gameID = 1;
        break;
        case 815://MaGMML2
            gameID = 2;
            var rushColorCheck = false;//Spin needs to send me the rush color coords: We'll use this to differentiate 2 OG from 2 Final Mix.
            
            var teensySurf = mm_surface_create(1,1);
            surface_set_target(teensySurf);
            draw_sprite_part(tempSprite,0,1430,772,1,1,0,0);
            
            var col = surface_getpixel_ext(teensySurf, 0, 0);
            var alpha = (col >> 24) & 255;
            
            if (alpha > 0)
            {
                rushColorCheck = true;
            }
            surface_reset_target();
            mm_surface_free(teensySurf);
            if (rushColorCheck)
            {
                gameID = 4;//2 Final Mix.
            }
            
        break;
    }
    
    if (returnGameID < 0)
    {
        returnGameID = gameID;
    }
    var imgs = (4*!autoColorMode)+(1*autoColorMode);
    
    var w = sprite_get_width(sprRockman)*imgs;
    var h = sprite_get_height(sprRockman);
    if (gameID < 3 || gameID == 4)
    {//Games before MaGMML3 are designed to import to MaGMML3, so do that first before importing MaGMML3 to Megamix 1.9.
        h = 662;
    }
    var tempSurf = mm_surface_create(w,h);
    surface_set_target(tempSurf);
    draw_clear_alpha(c_black,0);
    for (var i = 0; i < imgs; i++)
    {
        draw_sprite(sprCustomCostume_UsedForImporting,0,sprite_get_width(sprRockman)*i,0);//A blank template of squares, as we can't just draw sprRockman and clear him.
    }
    switch (gameID)
    {
        case 0://48H
        case 1://1R
        var CELLMAX_X = 18;
        var CELLMAX_Y = 13;
        var sqS = 48;//Note to self: Undo Stove's change to 46 in the actual drawing later.
        for (var a = 0; a < CELLMAX_X; a++)//Set to the X and Y Cells of the player.
        {
            for (var b = 0; b < CELLMAX_Y; b++)
            {
                if (b == 6)//New sprites added for 3.
                {
                    switch (a)
                    {
                        /*case 0://Clone wire frames, if they exist.
                        
                        break;
                        case 1:
                        
                        break;
                        Going to assume wire frames don't exist just cause 1R's other-game weapons cheat code isn't public yet.
                        It's easy for someone to copy-paste them in anyways.
                        */
                        case 3://Looking away: Clone from spin.
                            customCostume_MoveCell(tempSprite,autoColorMode,4,11 - (gameID == 1),3,6);
                        break;
                        default://No sprite to clone.
                            //Special fixup for cell changes.
                            if (a < 3)
                            {
                                customCostume_MoveCell(sprRockman,autoColorMode,a,11,a,6);
                            }
                        break;
                    }
                }
                else if (b < 6 && (b == 0 || b == 2) && a == 16 && (gameID == 1/* || gameID == 0*/))//Ladder sprites in the 2nd column need an offset fix, but only in MaGMML1R.
                {//Note: As of writing, the in-game skins are wrong in their offsets for Mega Man specifically on diags and up. This will make it inconsistent with a sample skin and should be corrected.
                    customCostume_MoveCell(tempSprite,autoColorMode,a,b,a,b,2 - (b == 2),0);
                }
                else if (b == 11)// && gameID == 1)
                {
                    if (a < 10)
                    {
                        if (inRange(a,1,4) && gameID == 0)
                        {
                            customCostume_MoveCell(tempSprite,autoColorMode,a,b,a,b,1,0);
                        }
                        else
                        {
                            customCostume_MoveCell(tempSprite,autoColorMode,a,b,a,b);
                        }
                    }
                    else//Rush Bike.
                    {
                        customCostume_MoveCell(sprRockman,autoColorMode,a,b+BASESPRITE_YCOMPENSATION,a,b);
                    }
                }
                else if (b == 10 && gameID == 1)//Add Tengu Frames, move spin frames ~~(if they exist)~~ down by 1.
                {//From the looks of things, 1R's importer *just* imports what's needed, so clone the spin frames too.
                    //var offsetArray = makeArray(0,1,1,1,0,1,1,1,1,1,0);//Offset spin frames specifically.
                    customCostume_MoveCell(sprRockman,autoColorMode,a,b,a,b,0, inRange(a,4,8)*-4 + inRange(a,8,12)*-2);
                    //customCostume_MoveCell(sprRockman,autoColorMode,a,b+1,a,b+1,0,0);//offsetArray[min(array_length_1d(offsetArray)-1,a)],0);
                }
                else if (b == 12 && a > 15 && (gameID <= 1))//1Up and Mug for 1R.
                {
                    if (gameID == 1)
                    {
                        customCostume_MoveCell(tempSprite,autoColorMode,a,b-1,a,b,0,(a==16));
                    }
                    else if (gameID == 0)
                    {
                        customCostume_MoveCell(tempSprite,autoColorMode,a,b,a,b,0,(a == 16));
                    }
                }
                else
                {
                    customCostume_MoveCell(tempSprite,autoColorMode,a,b,a,b);
                }
                //var X = 1+a*sqS+a*3;
                //var Y = 1+b*sqS+b*3;
                //draw_sprite_part_ext(gameID,0,X,Y,sqS,sqS,X,Y,1,1,c_white,1);
            }
        }
        var i = 0;
        if (gameID == 1)//Add buster shot graphics for 1R.
        {
            
            customCostume_MoveCell(sprRockman,autoColorMode,9+i,12+BASESPRITE_YCOMPENSATION,9+i,12);i++;
            customCostume_MoveCell(sprRockman,autoColorMode,9+i,12+BASESPRITE_YCOMPENSATION,9+i,12);i++;
            customCostume_MoveCell(sprRockman,autoColorMode,9+i,12+BASESPRITE_YCOMPENSATION,9+i,12);i++;
            customCostume_MoveCell(sprRockman,autoColorMode,9+i,12+BASESPRITE_YCOMPENSATION,9+i,12);i++;
            customCostume_MoveCell(sprRockman,autoColorMode,9+i,12+BASESPRITE_YCOMPENSATION,9+i,12);i++;
            customCostume_MoveCell(sprRockman,autoColorMode,9+i,12+BASESPRITE_YCOMPENSATION,9+i,12);i++;
            customCostume_MoveCell(sprRockman,autoColorMode,9+i,12+BASESPRITE_YCOMPENSATION,9+i,12);i++;
        }
        //1.13+: Missing break dash frames.
        var i = 0;
        repeat (6 + (gameID == 0)*4)
        {
            //Compensation for Megamix skin.
            var offsetY = 0;
            if (i >= 6)
            {
                offsetY = -4;
            }
            customCostume_MoveCell(sprRockman,autoColorMode,i,8,i,8,0,offsetY);i++;
        }
        
        
        //Pixel importing:
        if (gameID == 0)//48H.
        {
            
            draw_sprite_part_ext(tempSprite,0,766,511,1,1,410,614,1,1,c_white,1);i++;//Primary
            draw_sprite_part_ext(tempSprite,0,766,512,1,1,410,615,1,1,c_white,1);i++;//Secondary
            
            draw_sprite_part_ext(tempSprite,0,766,514,1,1,412,614,1,1,c_white,1);i++;//Coil P
            draw_sprite_part_ext(tempSprite,0,766,515,1,1,412,615,1,1,c_white,1);i++;//Coil S
            
            draw_sprite_part_ext(tempSprite,0,766,517,1,1,414,614,1,1,c_white,1);i++;//Jet P
            draw_sprite_part_ext(tempSprite,0,766,518,1,1,414,615,1,1,c_white,1);i++;//Jet S
            
            //Copy coil for bike
            draw_sprite_part_ext(tempSprite,0,766,514,1,1,416,614,1,1,c_white,1);i++;//Bike P
            draw_sprite_part_ext(tempSprite,0,766,515,1,1,416,615,1,1,c_white,1);i++;//Bike S
            
            draw_sprite_part_ext(tempSprite,0,766,520,1,1,410,618,1,1,c_white,1);i++;//Pronouns.
            draw_sprite_part_ext(tempSprite,0,766,521,1,1,410,621,1,1,c_white,1);i++;//48H eye tracking for Blocky sunglasses. Becomes head tracking for 3.
            
            
            
            draw_sprite_part_ext(tempSprite,0,766,523,1,1,410,617,1,1,c_white,1);i++;//Name Color
            
            
            draw_sprite_part_ext(tempSprite,0,766,523,1,1,410,617,1,1,c_white,1);i++;//1.11 Buster Offset.
            /*
            Restandardize full black to follow the rest of the system compared to 48H, which needed a special exception for pre-1.11.
            
            */
            var col = surface_getpixel(tempSurf,410,617);
            var r = color_get_red(col);
            var g = color_get_blue(col);
            var b = color_get_green(col);
            if (r+b+g == 0)
            {
                draw_set_color(make_color_rgb(129,129,129));
                draw_rectangle(410,617,410,617,false);
                draw_set_color(c_white);
            }
            
            
            //draw_sprite_part_ext(tempSprite,0,766,524,1,1,414,615,1,1,c_white,1);i++;//48H Future 
            draw_set_color(make_color_rgb(48,255,14));//Game Marker.
            draw_rectangle(455,614,455,614,false);
            draw_set_color(c_white);
            
            
        }
        else//1R
        {
            var i = 0;
            draw_sprite_part_ext(tempSprite,0,766,563,1,1,410,614,1,1,c_white,1);i++;//Primary
            draw_sprite_part_ext(tempSprite,0,766,564,1,1,410,615,1,1,c_white,1);i++;//Secondary
            
            draw_sprite_part_ext(tempSprite,0,766,566,1,1,412,614,1,1,c_white,1);i++;//Coil P
            draw_sprite_part_ext(tempSprite,0,766,567,1,1,412,615,1,1,c_white,1);i++;//Coil S
            
            //Note: Modify this if the 1R update adds Rush Jet colors. Until then clone from Coil.
            draw_sprite_part_ext(tempSprite,0,766,566,1,1,414,614,1,1,c_white,1);i++;//Jet P
            draw_sprite_part_ext(tempSprite,0,766,567,1,1,414,615,1,1,c_white,1);i++;//Jet S
            
            //Copy coil for bike
            draw_sprite_part_ext(tempSprite,0,766,566,1,1,416,614,1,1,c_white,1);i++;//Bike P
            draw_sprite_part_ext(tempSprite,0,766,567,1,1,416,615,1,1,c_white,1);i++;//Bike S
            
            //draw_sprite_part_ext(tempSprite,0,766,520,1,1,410,618,1,1,c_white,1);i++;//Pronouns.
            //draw_sprite_part_ext(tempSprite,0,766,521,1,1,410,621,1,1,c_white,1);i++;//48H eye tracking for Blocky sunglasses.
            
            //1R apparently lacked pronouns altogether?? While completely transparent would be the most "appropriate", we need players to know pronouns exist now, so use flat gray.
            draw_set_color(make_color_rgb(128,128,128));//Game Marker.
            draw_rectangle(410,618,410,618,false);
            draw_set_color(c_white);
            
            
            
            draw_sprite_part_ext(tempSprite,0,766,563,1,1,410,617,1,1,c_white,1);i++;//Name Color. Copy from primary palette.
            
            //48H's future use was never used, so ignore it.
            
            //draw_sprite_part_ext(tempSprite,0,766,524,1,1,414,615,1,1,c_white,1);i++;//48H Future 
            draw_set_color(make_color_rgb(1,255,14));//Game Marker.
            draw_rectangle(455,614,455,614,false);
            draw_set_color(c_white);
            
            
        }
        break;
        case 2://MaGMML2: Hell on Earth.
        case 4:
            var CELLMAX_X = 18;
            var CELLMAX_Y = 8;//Only automate this many, as the ones outside the standard are gonna be nightmarish to code in this system.
            var sqS = 48;
            for (var a = 0; a < CELLMAX_X; a++)//Set to the X and Y Cells of the player.
            {
                for (var b = 0; b < CELLMAX_Y; b++)
                {
                    //var mA = a;
                    //var mB = b;
                    if (b == 2)//MaGMML2 lacked throwing frames.
                    {
                        var offsetX = 0;
                        var offsetY = 0;
                        if (inRange(a,7,11))
                        {
                            offsetY = -4;
                        }
                        else if (inRange(a,11,13))
                        {
                            offsetX = 2;
                        }
                        else if (a == 13)
                        {
                            offsetY = -1;
                        }
                        else if (a == 14)
                        {
                            offsetX = -1;
                            offsetY = 4;
                        }
                        else if (inRange(a,15,18))
                        {
                            offsetY = -2;
                        }
                        customCostume_MoveCell(sprRockman,autoColorMode,a,b,a,b, offsetX, offsetY);
                    }
                    else if (b == 6)
                    {
                        continue;//Ignore #6, that's new stuff.
                    }
                    else if (b == 7)//Wire frames.
                    {
                        var oA = a;
                        if (oA > 14)//Skip past ladder sprites.
                        {
                            oA += 3;
                        }
                        customCostume_MoveCell(tempSprite,autoColorMode,oA,15,a,b);
                    }
                    else if (b < 6 && a == 16 && (gameID == 2 || gameID == 4))//Ladder sprites in the 2nd column need an offset fix, but only in MaGMML2 it seems.
                    {//Note: As of writing, the in-game skins are wrong in their offsets for Mega Man specifically on diags and up. This will make it inconsistent with a sample skin and was fixed in 1.9's skin setup.
                    //(We might not have fixed Proto/Roll's offsets on that though, haven't added those as of writing).
                        customCostume_MoveCell(tempSprite,autoColorMode,a,b,a,b,2,0);
                    }
                    else if (inRange(b,3,6) && inRange(a,7,11))
                    {
                        customCostume_MoveCell(tempSprite,autoColorMode,a,b,a,b,0,4);
                    }
                    else if (b == 10)
                    {
                        customCostume_MoveCell(tempSprite,autoColorMode,a,b,a,b,0,inRange(a,4,8)*-4 + inRange(a,8,12)*-2);
                    }
                    else
                    {
                        customCostume_MoveCell(tempSprite,autoColorMode,a,b,a,b);
                    }
                    
                }
                if (a >= 10)//Copy multiple graphics outside b to save on doing it later.
                {
                    customCostume_MoveCell(sprRockman,autoColorMode,a,11+BASESPRITE_YCOMPENSATION,a,11);//Rush bike graphics.
                }
                else if (b == 8)//Else just happens to work for the criteria here lol.
                {
                    customCostume_MoveCell(sprRockman,autoColorMode,a,8,a,8,0, inRange(a,6,10)*-4);//Break Dash & Top Spin
                }
                
            }
            
            var i = 0;//Slash Claw frames (Doing this in case we ever do import MaGMML2 weapons, but also for forward-compatibility).
            customCostume_MoveCell(tempSprite,autoColorMode,26,i,i,9);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,26,i,i,9);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,26,i,i,9);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,26,i,i,9);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,27,i-4,i,9);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,27,i-4,i,9);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,27,i-4,i,9);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,27,i-4,i,9);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,28,i-8,i,9);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,28,i-8,i,9);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,28,i-8,i,9);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,28,i-8,i,9);i++;
            
            i = 0;//SPEEN
            customCostume_MoveCell(tempSprite,autoColorMode,19+i,4,i,11);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,19+i,4,i,11,1,0);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,19+i,4,i,11,1,0);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,19+i,4,i,11,1,0);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,19+i,4,i,11);i++;
            
            customCostume_MoveCell(tempSprite,autoColorMode,19+i-5,5,9,11,1,0);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,19+i-5,5,8,11,1,0);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,19+i-5,5,7,11,1,0);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,19+i-5,5,6,11,1,0);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,19+i-5,5,5,11,1,0);i++;
            
            i = 0;//Nothing personel, kid.
            customCostume_MoveCell(tempSprite,autoColorMode,24+i,5,10+i,8);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,24+i,5,10+i,8);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,24+i,5,10+i,8);i++;
            
            //BOUNCE POGOPOGOPOGOPOGOPOGOPOGOPOGOPOGOPOGO
            customCostume_MoveCell(tempSprite,autoColorMode,27,4,13,8);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,28,4,14,8);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,27,5,13,9);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,28,5,14,9);i++;
            //Wave Bike
            customCostume_MoveCell(tempSprite,autoColorMode,27,6,6,12);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,28,6,7,12);i++;
            
            //Tornado Platform
            i = 0;
            customCostume_MoveCell(tempSprite,autoColorMode,24+i,7,i,12);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,24+i,7,i,12);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,24+i,7,i,12);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,24+i-3,8,i+2,12);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,24+i-3,8,i,12);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,24+i-3,8,i-2,12);i++;
            
            //Rush
            i = 0;
            customCostume_MoveCell(tempSprite,autoColorMode,25+i,12,15+i,8);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,25+i,12,15+i,8);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,25+i,12,15+i,8);i++;
            i = 0;
            customCostume_MoveCell(tempSprite,autoColorMode,25+i,13,15+i,9);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,25+i,13,15+i,9);i++;
            
            //Life.
            customCostume_MoveCell(tempSprite,autoColorMode,25,1,16,12,0,1);i++;
            //Mugshot.
            customCostume_MoveCell(tempSprite,autoColorMode,27,15,17,12);i++;
            
            //Buster graphics.
            var i = 0;
            customCostume_MoveCell(sprRockman,autoColorMode,9+i,12+BASESPRITE_YCOMPENSATION,9+i,12);i++;
            customCostume_MoveCell(sprRockman,autoColorMode,9+i,12+BASESPRITE_YCOMPENSATION,9+i,12);i++;
            customCostume_MoveCell(sprRockman,autoColorMode,9+i,12+BASESPRITE_YCOMPENSATION,9+i,12);i++;
            customCostume_MoveCell(sprRockman,autoColorMode,9+i,12+BASESPRITE_YCOMPENSATION,9+i,12);i++;
            customCostume_MoveCell(sprRockman,autoColorMode,9+i,12+BASESPRITE_YCOMPENSATION,9+i,12);i++;
            customCostume_MoveCell(sprRockman,autoColorMode,9+i,12+BASESPRITE_YCOMPENSATION,9+i,12);i++;
            customCostume_MoveCell(sprRockman,autoColorMode,9+i,12+BASESPRITE_YCOMPENSATION,9+i,12);i++;
            
            
            //Lookup frames: Clone from wire frames.
            customCostume_MoveCell(tempSprite,autoColorMode,0,15,0,6);i++;
            customCostume_MoveCell(tempSprite,autoColorMode,1,15,1,6);i++;
            
            //Door frame: Clone from spin since most sprites should be normal here.
            customCostume_MoveCell(tempSprite,autoColorMode,19+4,4,3,6);i++;
            
            
            //The only sprite outside automation we can't clone: Death
            customCostume_MoveCell(sprRockman,autoColorMode,2,11,2,6);i++;
            
            
            //*Pose*
            customCostume_MoveCell(sprRockman,autoColorMode,12,9,12,9);
            
            var i = 0;
            draw_sprite_part_ext(tempSprite,0,1430,767,1,1,410,614,1,1,c_white,1);i++;//Primary
            draw_sprite_part_ext(tempSprite,0,1430,768,1,1,410,615,1,1,c_white,1);i++;//Secondary
            
            if (gameID == 2)
            {//Just give them rush colors and hope for the best.
                draw_set_color(make_color_rgb(216,40,0));//Rush Red.
                draw_rectangle(412,614,412,614,false);//Red Coil
                draw_rectangle(414,614,414,614,false);//Red Jet
                draw_rectangle(416,614,416,614,false);//Red Bike
                draw_set_color(make_color_rgb(248,248,248));//Rush White.
                draw_rectangle(412,615,412,615,false);//White Coil
                draw_rectangle(414,615,414,615,false);//White Jet
                draw_rectangle(416,615,416,615,false);//White Bike
                draw_set_color(c_white);
            }
            else 
            {//Import the optional parameters.
                var i = 0;
                //Rush Coil.
                draw_sprite_part_ext(tempSprite,0,1430,772,1,1,412,614,1,1,c_white,1);i++;//Coil P
                draw_sprite_part_ext(tempSprite,0,1430,773,1,1,412,615,1,1,c_white,1);i++;//Coil S
                
                //Rush Jet
                draw_sprite_part_ext(tempSprite,0,1430,774,1,1,414,614,1,1,c_white,1);i++;//Jet P
                draw_sprite_part_ext(tempSprite,0,1430,775,1,1,414,615,1,1,c_white,1);i++;//Jet S
                
                //Rush Bike (Pull from Sakugarne).
                draw_sprite_part_ext(tempSprite,0,1430,776,1,1,416,614,1,1,c_white,1);i++;//Bike P
                draw_sprite_part_ext(tempSprite,0,1430,777,1,1,416,615,1,1,c_white,1);i++;//Bike S
            }
            
            
            
            draw_sprite_part_ext(tempSprite,0,1430,769,1,1,410,618,1,1,c_white,1);i++;//Pronouns.
            //Alter weapon compatibility is irrelevant since we don't actually use those frames (but copy them to be safe).
            
            draw_sprite_part_ext(tempSprite,0,1430,767,1,1,410,617,1,1,c_white,1);i++;//Name Color. Copy from Primary
            
            
            
            
            //draw_sprite_part_ext(tempSprite,0,766,524,1,1,414,615,1,1,c_white,1);i++;//48H Future 
            if (gameID == 4)
            {
                draw_set_color(make_color_rgb(gameID_GameMarkers[returnGameID],255,14));//Game Marker.
            }
            else
            {
                draw_set_color(make_color_rgb(gameID_GameMarkers[returnGameID],255,14));//Optional features.
            }
            draw_rectangle(455,614,455,614,false);
            draw_set_color(c_white);
            
            
            
            
        break;
        case 3://MaGMML3
            /*
            
            Super Arm was moved in *place* of cutscene, which was then moved between 11 and 12.
            
            1. Move Y 11 and 12 down by one to 12 and 13.
            2. Move Y 6 down to 11's place.
            3. Move the victory poses at X 3-4, Y 4, to X 9 Y 11
            4. Offset the following airbourne sprites down by 4 pixels:
                X 7 to 10, Y 0 to 7; the whole rectangle.
                X 6 to 9, Y 8
                X 4 to 7, Y 9-10
                NOTE: This applies for Mega Man, the base sample skin. It may cause problems for skins that didn't offset based on that; Adjust your skin as needed.
                For reference, Proto Man and Roll (not the MM11 Roll) were adjusted by 3 pixels instead.
            5. Fill in Y 6 with Super Arm sprites.
            6. Move custom text to new cells.
            
            
            If version 0 and imported from 48H, adjust spin sprites.
            
            */
            var airbourneShifts = makeArray(
                //X Range, *then* Y range
                makeArray(7,10,0,7),
                makeArray(6,9,8,8),
                makeArray(4,7,9,10)

                
                );
            var climbingShifts = makeArray(
                makeArray(15,17,0,6),
                makeArray(8,11,9,10)
                );
            var magmml2_SpaghettiFixup = makeArray(
                makeArray(16,0,2,0),//CellX,CellY,offsetX,offsetY
                makeArray(16,2,2,0),
                /*makeArray(11,3,-2,0),
                makeArray(11,4,-2,0),
                makeArray(11,5,-2,0),
                makeArray(12,3,-2,0),
                makeArray(12,4,-2,0),
                makeArray(12,5,-2,0),
                makeArray(13,3,0,1),
                makeArray(13,4,0,1),
                makeArray(13,5,0,1),
                makeArray(14,3,1,-4),
                makeArray(14,4,1,-4),
                makeArray(14,5,1,-4),*/
                makeArray(15,3,0,2),
                makeArray(15,4,0,2),
                makeArray(15,5,0,2),
                makeArray(16,3,-2,2),
                makeArray(16,4,-2,2),
                makeArray(16,5,-2,2),
                makeArray(15,3,0,2),
                makeArray(15,4,0,2),
                makeArray(15,5,0,2),
                makeArray(17,3,0,2),//CellX,CellY,offsetX,offsetY
                makeArray(17,4,0,2),
                makeArray(17,5,0,2),
                );//Holy crap these are disjointed.
                if (originalImporterVersion < 2)
                {
                    arrayAppend(magmml2_SpaghettiFixup,makeArray(16,1,-1,0));
                }
            var M2_OX = 0;
            var M2_OY = 0;
            for (var i = 0; i < 18; i++)
            {
                //var jOrder = makeArray(11,12,6,0,1,2,3,4,5,6,7,8,9//4,5,6,7,8,9,10,);
                for (var j = 0; j < 16; j++)
                {
                    if (returnGameID == 2)
                    {
                        for (var fix = 0; fix < array_length_1d(magmml2_SpaghettiFixup); fix++)
                        {
                            var ind = magmml2_SpaghettiFixup[fix];
                            if (ind[0] == i && ind[1] == j)
                            {
                                M2_OX = ind[2];
                                M2_OY = ind[3];
                                fix = array_length_1d(magmml2_SpaghettiFixup);
                            }
                        }
                    }
                    var offsetY = 0;
                    var offsetX = 0;
                    if (j < 8)
                    {
                        switch (i)
                        {
                            case 11:
                            case 12:
                                if (j < 8)
                                {
                                    offsetX = -2;
                                }
                            
                            break;
                            case 13:
                                offsetY = 1;
                            break;
                            case 14:
                                offsetX = 1;
                                offsetY = -4;
                            break;
                        }
                    }
                    switch (j)
                    {
                        case 11:
                            if (returnGameID == 3)//Don't do with older games, which may have diag sprites.
                            {
                                customCostume_MoveCell(tempSprite,autoColorMode,i,6,i,j,offsetX+M2_OX,offsetY+M2_OY);
                            }
                        break;
                        case 12:
                            /*if (originalImporterVersion == 0 && (returnGameID == 0 || returnGameID == 1) && inRange(i,1,4))
                            {//Fix bug in Version 0 of MaGMML3 that offset spin bad in 48H/1R.
                                offsetX = 1;
                            }*/
                            customCostume_MoveCell(tempSprite,autoColorMode,i,11,i,j,offsetX+M2_OX,offsetY+M2_OY);
                        break;
                        case 13:
                            customCostume_MoveCell(tempSprite,autoColorMode,i,12,i,j,offsetX+M2_OX,offsetY+M2_OY);
                        break;
                        case 3:
                        case 4:
                        case 5:
                            if (returnGameID != 3)//Inherit diag sprites.
                            {
                                
                                
                                
                                customCostume_MoveCell(tempSprite,autoColorMode,i,j,i,j,offsetX+M2_OX,offsetY+M2_OY);
                            }
                        break;
                        default:
                            
                            var ts = tempSprite;
                            if (j == 6)
                            {
                                ts = sprRockman;
                                offsetX = 0;
                                offsetY = 0;
                                M2_OX = 0;
                                M2_OY = 0;
                            }
                            else
                            {
                                for (var k = 0; k < array_length_1d(airbourneShifts); k++)
                                {
                                    var rect = airbourneShifts[k];
                                    if (inRange(i,rect[0],rect[1]+1) && inRange(j,rect[2],rect[3]+1))
                                    {
                                        offsetY = 4;
                                    }
                                    
                                    
                                }
                                
                                for (var k = 0; k < array_length_1d(climbingShifts); k++)
                                {
                                    rect = climbingShifts[k];
                                    if (inRange(i,rect[0],rect[1]+1) && inRange(j,rect[2],rect[3]+1))
                                    {
                                        offsetY = 2;
                                    }
                                    
                                    
                                }
                                
                                if (i == 16 && j == 15 && MaGMML3_OGameMarker == 0 && originalImporterVersion == 0)
                                {
                                    offsetY = 1;
                                }
                                if (inRange(j,1,3) && i == 16 && MaGMML3_OGameMarker == 1 && originalImporterVersion < 2)
                                {
                                    offsetX = -1;//Shift this back.
                                }
                                if (j == 12 && i == 16 && MaGMML3_OGameMarker == 1 && originalImporterVersion < 2)
                                {
                                    offsetY = -1;//Shift 1up back.
                                }
                                if (i == 16 && inRange(j,0,6) && (MaGMML3_OGameMarker == 2 || MaGMML3_OGameMarker == 202))
                                {//Fix improper offset.
                                    //DUMMY
                                    offsetX = -2;
                                    if (j == 1)
                                    {
                                        offsetX -= 2;
                                    }
                                    
                                }
                                /*if (i == 16 && inRange(j,0,5) && (MaGMML3_OGameMarker == 0) && originalImporterVersion < 2)
                                {
                                    offsetX 
                                }*/
                            }
                            customCostume_MoveCell(ts,autoColorMode,i,j,i,j,offsetX+M2_OX,offsetY+M2_OY);
                        break;
                    }
                }
                
                
            }
            //Move victory poses+text and cutscene row.
            customCostume_MoveCell(tempSprite,autoColorMode,3,4,9,11);
            customCostume_MoveCell(tempSprite,autoColorMode,4,4,10,11);
            customCostume_MoveCell(tempSprite,autoColorMode,11,4,11,11);
            customCostume_MoveCell(tempSprite,autoColorMode,11,5,12,11);
            customCostume_MoveCell(tempSprite,autoColorMode,0,6,0,11);
            customCostume_MoveCell(tempSprite,autoColorMode,1,6,1,11);
            customCostume_MoveCell(tempSprite,autoColorMode,2,6,2,11);
            customCostume_MoveCell(tempSprite,autoColorMode,3,6,3,11);
            
            switch (returnGameID)
            {
                
                case 0:
                case 1:
                case 3:
                    //Diagonal aim sprites.

                    for (var i = 0; i < 18; i++)
                    {
                        
                        customCostume_MoveCell(sprRockman,autoColorMode,i,3,i,3);
                        customCostume_MoveCell(sprRockman,autoColorMode,i,4,i,4);
                        customCostume_MoveCell(sprRockman,autoColorMode,i,5,i,5);
                        customCostume_MoveCell(sprRockman,autoColorMode,i,7,i,7);
                        
                    }
                        
                    
                    /*If people went off the old version they probably already imported this as needed with how gravely obvious it was. Too much of a headache to check only to mess people up.
                    if (returnGameID == 0 || returnGameID == 1)
                    {//Break dash frames.
                        var i = 0;
                        customCostume_MoveCell(sprRockman,autoColorMode,i,8,i,8,0,0);i++;
                        customCostume_MoveCell(sprRockman,autoColorMode,i,8,i,8,0,0);i++;
                        customCostume_MoveCell(sprRockman,autoColorMode,i,8,i,8,0,0);i++;
                        customCostume_MoveCell(sprRockman,autoColorMode,i,8,i,8,0,0);i++;
                        customCostume_MoveCell(sprRockman,autoColorMode,i,8,i,8,0,0);i++;
                        customCostume_MoveCell(sprRockman,autoColorMode,i,8,i,8,0,0);i++;
                    }
                    */
                break;
            }
            draw_set_color(make_color_rgb(gameID_GameMarkers[returnGameID],255,14));//Game Marker.

            draw_rectangle(455,665,455,665,false);//Use this!
            draw_set_color(c_white);
            keepGoing = false;
        break;
    }
    var markerY = 614;
    if (gameID == 3)
    {
        markerY = 665;
    }
    if (originalImporterVersion < 0)
    {
        originalImporterVersion = COSTUME_IMPORTER_VERSION;
    }
    draw_set_color(make_color_rgb(originalImporterVersion,255,14));//MaGMML3 import version marker
    draw_rectangle(456,markerY,456,markerY,false);
    draw_set_color(make_color_rgb(COSTUME_IMPORTER_VERSION,255,15));//Megamix importer version, both used for future compatibility.
    draw_rectangle(456,markerY+2,456,markerY+2,false);
    
    draw_set_color(c_white);
    var index = stringIndexOfReverse(argument[0],"\")+1;
    var fileName = stringSubstring(argument[0],index);
    fileName = stringSubstring(fileName,0,string_length(fileName)-3);//Remove .png.
    
    var newSprite = sprite_create_from_surface(tempSurf,0,0,surface_get_width(tempSurf),surface_get_height(tempSurf),false,false,0,0);
    surface_reset_target();
    /*
    if (DEBUG_ENABLED)
    {
        printErr(gameID);
        sprite_save(newSprite,0,"TRANSITION.PNG");
    }*/
    sprite_delete(tempSprite);
    
    tempSprite = newSprite;
}


//sprite_delete(tempSprite); Handled by deleting newSprite.

mm_surface_free(tempSurf);

var gameImport = makeArray("48H","1R","2","3","2FM");
var newFile = fileName;
var newDir = "Costumes/(" + gameImport[returnGameID] + " Import) " + fileName + "/";
//printErr(newDir + newFile);
if (!directory_exists(working_directory + newDir))
{
    directory_create(working_directory + newDir);
}
else
{
    sprite_delete(newSprite);
    return -2;
}
if (file_exists(working_directory + newDir + newFile + ".png"))
{
    sprite_delete(newSprite);
    return -1;
}
sprite_save(newSprite,0,working_directory + newDir + newFile + ".png");
sprite_delete(newSprite);
if (gameID == 3)
{
    var baseName = string_copy(argument[0],1,string_length(argument[0])-4);
    
    
    var normalAppend = customCostume_GetSoundNames();
    //These hold no purpose for Megamix Engine, but should be copied anyways for authenticity.
    var vaSounds = makeArray("sfxVA_AhMuchBetter","sfxVA_Death","sfxVA_DesperateTimes","sfxVA_FloatLikeAButterfly","sfxVA_Haha","sfxVA_Hit1","sfxVA_Hit2","sfxVA_Hit3","sfxVA_Inhale","sfxVA_Jump1","sfxVA_Jump2","sfxVA_Jump3","sfxVA_KingDedede","sfxVA_Land","sfxVA_LetsDoThis","sfxVA_MetaKnight","sfxVA_OhGoodnessIMightDieSoon","sfxVA_QuitWhileYoureAhead","sfxVA_RunningLowOnHealth","sfxVA_TakeThat","sfxVA_TakeThat2","sfxVA_TakeThis","sfxVA_TakingOffAirborne","sfxVA_ThatsOneDeadBaddie","sfxVA_ThatWasDelicious","sfxVA_TotalAnnihilation","sfxVA_WaddleDee","sfxVA_YesIAmNowReadyToRumble","sfxVA_YouArentGonnaStandAChance","sfxVA_YouReadyForThis","sfxVA_Yummy");
    normalAppend = concatenate(normalAppend,vaSounds);
    var foundSound = false;
    for (var i = 0; i < array_length_1d(normalAppend); i++)
    {
        var input = baseName + "." + normalAppend[i] + ".ogg";
        var output = newDir + newFile + "." + normalAppend[i] + ".ogg";
        if (file_exists(baseName + "." + normalAppend[i] + ".ogg"))
        {
            file_copy(input,working_directory + output);
            foundSound = true;
        }
        
    }
    if (foundSound)
    {
        return 3.5;
    }
}

return returnGameID;
//if (!file_exists(working_directory + "/Costumes/" + ))

