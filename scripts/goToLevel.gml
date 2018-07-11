/// goToLevel(room, [returnHere], [fadeOut])
// begins a new stage and goes to the given room.
// fadeOut (default: true). Camera should fade out and then in. If false, room switch is immediate.
// returnHere (default: true). This is the room that should be returned to when the level is exited. Game mode cannot be in-level.

// Note: do not use this to *return* to a hub. Call returnFromLevel() instead.

var rm = argument[0];
var fadeOut = true;
var returnHere = true;
if (argument_count > 1)
{
    returnHere = argument[1];
}
if (argument_count > 2)
{
    fadeOut = argument[2];
}

global.hasTeleported = false;

global.beginStageOnRoomBegin = true;

if (returnHere)
{
    global.roomReturn = room;
}

// switch rooms
if (fadeOut)
{
    global.nextRoom = rm;
}
else
{
    room_goto(rm);
}
