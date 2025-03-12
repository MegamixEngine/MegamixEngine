/// setCheckpoint(_checkpoint, x, y, dir, animation, doesSav)

var _checkpoint = argument[0];

// - - - - - - - - - - - - - - - - - - - -

//Disable checkpoint
var _c      = 0;
var _cn     = "";

var _x      = 0;
var _y      = 0;
var _dir    = 1;
var _anim   = 0;
var _save   = 1;

var _debug  = "CLEARED CHECKPOINT";

// - - - - - - - - - - - - - - - - - - - -

//Set checkpoint
if (_checkpoint)
{
    _c      = room;
    _cn     = global.roomName;
    
    _x      = argument[1];
    _y      = argument[2];
    _dir    = argument[3];
    _anim   = argument[4];
    _save   = argument[5];

    _debug  = "CHECKPOINT SET - X " + string(_x) + " Y " + string(_y) + " ID " + string(_c) + " LOAD " + _cn;
}

// - - - - - - - - - - - - - - - - - - - -

//Set actual variables
global.checkpoint       = _c;
global.checkpointName   = _cn;

global.checkpointX      = _x;
global.checkpointY      = _y;
global.checkpointDir    = _dir;
global.respawnAnimation = _anim;

show_debug_message(_debug);

// - - - - - - - - - - - - - - - - - - - -

if (_checkpoint && _save)
{
    if (global.roomTimer > 0)
    {
        if (!global.stageIsHub)
        {
            saveLoadCheckpoint(1, global.stage);
        }
    }
}

