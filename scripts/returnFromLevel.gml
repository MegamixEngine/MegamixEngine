/// returnFromLevel([fadeOut])
// ends the current level and returns to global.roomReturn.
// if already at globl.roomReturn, return to title screen
// fadeOut (default: true): screen should fade out? (if false, room switch is immediate.)

var fadeOut = true;
if (argument_count > 0)
{
    fadeOut = argument[0];
}

// return to title if already at roomReturn
if (global.roomReturn == room)
{
    global.roomReturn = rmTitleScreen;
}

global.endStageOnRoomEnd = global.inGame;

global.checkpoint = false;

var rm = global.roomReturn;

// weapon get!
if (array_length_1d(global.levelReward) > 1)
{
    rm = rmWeaponGet;
}

if (fadeOut)
{
    global.nextRoom = rm;
}
else
{
    room_goto(rm);
}
