/// drawPlayer(playerID, costumeID, sheetX, sheetY, x, y, xscale, yscale, [image_angle])
// draws the given player at the given position
// invokes drawCostume with the correct values
// sheetX, sheetY: coord (in 48x48 units) of the animation frame in the skin sheet.

var pid = argument[0],
    cid = argument[1],
    sheetX = argument[2],
    sheetY = argument[3],
    _x = argument[4],
    _y = argument[5],
    _xscale = argument[6],
    _yscale = argument[7],
    _angle = 0;

if (argument_count > 8)
{
    _angle = argument[8];
}

var _inked = false;
var baseCol = c_white;
if (instance_exists(objMegaman))
{
    with (objMegaman)
    {
        if (inked && playerID == pid)
        {
            _inked = true;
            baseCol = c_ltgray;
        }
    }
}

var playerSprite = global.playerSprite[cid];//Hacky solution to get Treble Boost to work with this small sheet.
// Buster shots aren't meant to be affected by this
switch(object_index)
{
    case objBusterShot:
    case objBusterShotHalfCharged:
    case objBusterShotCharged:
    case objLife:
    case objCamouflametall:
        _inked = false;
        baseCol = c_white;
        break;
    case objMegaman://
        if (lastanimation == "Boost")
        {
            playerSprite = sprBass_TrebleBoostSheet;
            if (sheetY > 1 || sheetX > 4) || (sheetY == 0 && sheetX > 1)
            {//Hacky fix for multiple gimmicks that are poorly coded for visuals.
                sheetY = min(1,sheetY);
                sheetX = 0+floor(global.roomTimer/4)%2;
            }
        }
        break;
    default:
        break;
}

if (checkCheats(cheatEnums.invisiblePlayer))
    exit;

if (!_inked)
{
    drawCostume(playerSprite, sheetX, sheetY, _x, _y, _xscale, _yscale, baseCol,
        global.primaryCol[pid],global.secondaryCol[pid], global.outlineCol[pid],
        image_alpha, image_alpha, image_alpha, image_alpha, _angle);
}
// octone ink handling:

if (_inked)//Since ink is covering the player, don't include in the invisible cheat.
{
    drawPlayerInk(cid, sheetX, sheetY, _x, _y, _xscale, _yscale, _angle);
}

