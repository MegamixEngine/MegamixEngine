// roomsID();

// If you enter a room that has another room-kind-ID attached to it, your checkpoint, weapon and pickup settings reset
// This allows you to have levels made out of multiple rooms without having to deal with reset shenanigans

// this script may be factored out for a different way to check if a new level is starting.

var val, rm;
val = 0;
rm = argument0;

if (rm == rmInit)
{
    val = 1;
}
if (rm == rmDisclaimer)
{
    val = 1;
}
if (rm == rmStageSelect)
{
    val = 1;
}
if (rm == rmRoomSelect)
{
    val = 1;
}
if (rm == rmOptions)
{
    val = 1;
}
if (rm == rmTitleScreen)
{
    val = 1;
}

if (rm == lvlCastleIntro)
{
    val = 1;
}

return (val);
