///drawPlayerMugshot(playerID,costumeID,x,y,[primaryCol],[secondaryCol],[outlineCol]);
var playerSprite = argument[1];
var pid = argument[0];
var _x = argument[2];
var _y = argument[3];
//drawPlayer(argument0, argument1, 17, 12, argument2, argument3, 1, 1);
var pC = global.primaryCol[pid];
var sC = global.secondaryCol[pid];
var oC = global.outlineCol[pid];

if (argument_count > 4)
    pC = argument[4];
if (argument_count > 5)
    sC = argument[5];
if (argument_count > 6)
    oC = argument[6];



var iA = 1;
if (argument_count < 5 && ((global.weapon[pid] == 0))
    && (!global.multiplayerColors || global.playerCount == 1))
    iA = 0;

drawCostume(global.playerSprite[playerSprite], 17, 13, _x, _y, 1, 1,
    c_white, pC,
    sC, oC,
    1, iA, iA, 1,
    0);
