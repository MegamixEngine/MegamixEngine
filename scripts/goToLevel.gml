/// goToLevel(rm, [return here], [fadeOut])
// begins a new stage and goes to the given room.
// fadeOut (default: true). Camera should fade out and then in. If false, room switch is immediate.
// returnHere (default: true). This is the room that should be returned to when the level is exited. Game mode cannot be in-level.

// Note: do not use this to *return* to a hub. Call returnFromLevel() instead.

var rm = argument[0];

var returnHere = true;
if (argument_count > 1)
{
    returnHere = argument[1];
}

var fadeOut = true;
if (argument_count > 2)
{
    fadeOut = argument[2];
}

global.hasTeleported = false;

global.endStageOnRoomEnd = 1;

// - - - - - - - - - - - - - - - - - - - - - - - -

// Switch Rooms
if (fadeOut)
{
    global.nextRoom = rm;
}
else
{
    room_goto(rm);
}
