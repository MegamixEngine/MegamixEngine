/// returnFromLevel([fadeOut])
// ends the current level and returns to global.roomReturn.
// if already at globl.roomReturn, return to title screen
// fadeOut (default: true): screen should fade out? (if false, room switch is immediate.)

var fadeOut = true;
var myRoom = undefined;

if (argument_count >= 1)
{
    fadeOut = argument[0];
}

// - - - - - - - - - - - - - - - - - - - - - - - -

if (is_undefined(myRoom))
{
    if (global.returnLayers) //There are layers to return to
    {
        var index = (global.returnLayers - 1);
        
        myRoom              = global.returnLayer[index];
        global.teleportX    = global.returnLayerX[index];
        global.teleportY    = global.returnLayerY[index];
        global.teleportDir  = global.returnLayerDir[index];
        global.respawnAnimation = 0;
        global.hasTeleported = 1;
        switch (myRoom)//Treat these as a full exit.
        {
            case rmStageSelect:
            case rmCastleIntro:
                global.teleportX=-1;
                global.teleportY=-1;
                global.teleportDir=1;
                global.hasTeleported = 0;
            break;
            
            
        }
        
    }
    else //There are no layers to return to
    {
        myRoom = rmFileSelect;
        saveLoadGame(true);
    }
}

global.endStageOnRoomEnd = 1;

// weapon get!
if (array_length_1d(global.levelReward) > 1)
{
    myRoom = rmWeaponGet;
}

// - - - - - - - - - - - - - - - - - - - - - - - -

if (fadeOut)
{
    global.nextRoom = myRoom;
}
else
{
    global.previousRoom = room;
    room_goto(myRoom);
}

global.shownCastleIntro = false;
