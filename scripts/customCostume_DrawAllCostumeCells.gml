/// drawAllCostumeCells(spriteID,XOffset,YOffset)
//Draws all costume cells as they'd be displayed on a surface of 0,0.
//This is used to remove the green square that can appear under rare circumstances
//(Has to do with texture UV coordinates I think?).
var CELLMAX_X = 18;
var CELLMAX_Y = 14;
var XO = 0;//argument[1];
var YO = 0;
if (argument_count > 1)
{
    XO = argument[1];
    YO = argument[2];
}
var sqS = 48;
for (var a = 0; a < CELLMAX_X; a++)//Set to the X and Y Cells of the player.
{
    for (var b = 0; b < CELLMAX_Y; b++)
    {
        var X = 1+a*sqS+a*3;
        var Y = 1+b*sqS+b*3;
        draw_sprite_part_ext(argument[0],0,X+XO,Y+YO,sqS,sqS,X,Y,1,1,c_white,1);
    }
}
