/// teleportOutEffect(_x, _y, _p_col = -1, _s_col = -1, _dir = image_xscale, _depth = depth)
// This script spawns a teleport out VFX
// Its colour can be configured

var _x = argument[0], _y = argument[1];
var _p_col; if (argument_count > 2) _p_col = argument[2]; else _p_col = -1;
var _s_col; if (argument_count > 3) _s_col = argument[3]; else _s_col = -1;
var _dir; if (argument_count > 4) _dir = argument[4]; else _dir = image_xscale;
var _depth; if (argument_count > 5) _depth = argument[5]; else _depth = depth;

var _tele = instance_create(_x, _y, objEddieTeleport);
_tele.image_xscale = _dir;
_tele.depth = _depth;
_tele.upordown = 'up';
_tele.parent = -1;
_tele.playerID = -1;
_tele.col[1] = _p_col;
_tele.col[2] = _s_col;
