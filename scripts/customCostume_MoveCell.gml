/// customCostume_MoveCell(spriteID, autoColorMode, srcCellX,srcCellY,destCellX,destCellY,[offX],[offY])


var sqS = 48;
var autoColorMode = argument[1];
var X1 = 1+argument[2]*sqS+argument[2]*3;
var Y1 = 1+argument[3]*sqS+argument[3]*3;
var X2 = 1+argument[4]*sqS+argument[4]*3;
var Y2 = 1+argument[5]*sqS+argument[5]*3;

var XO = 0;
var YO = 0;
if (argument_count > 6)
{
    XO = argument[6];
    YO = argument[7];
}
for (var i = 0; i < !autoColorMode*4+autoColorMode; i++)//Copy the manual whitemasks.
{
    
    draw_sprite_part_ext(argument[0],0,X1+(sprite_get_width(argument[0])*(.25*!autoColorMode+1*autoColorMode))*i,Y1,sqS,sqS,X2+XO+sprite_get_width(sprRockman)*i,Y2+YO,1,1,c_white,1);

    if (argument[0] == sprRockman)//Ignore whitemasks if we're adding new samples since the sprRockman isn't fit well for simple mode.
    {
        exit;
    }
}
