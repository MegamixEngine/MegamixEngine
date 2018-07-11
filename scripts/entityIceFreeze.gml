/// entityIceFreeze(time, [physics, solid, graphics])
/// freezes this entity (as though by ice)
// time: minimum time to freeze for
// physics [default: true]: true/false -- should object fall while frozen, etc.?
// solid [default: false]: should object be solid while frozen
// graphics [default: 0]: graphics style (currently only 0 -- light blue frozen)

var time = argument[0];
var _physics = true;
var _solid = false;
var _graphics = 0;

if (argument_count > 1)
{
    _physics = argument[1];
    _solid = argument[2];
    _graphics = argument[3];
}

if (time <= 0)
{
    exit;
}

if (!canIce)
{
    exit;
}

// if not currently iced...
if (iceTimer == 0)
{
    yspeedPreIce = yspeed;
    xspeedPreIce = xspeed;
    gravPreIce = grav;
    solidPreIce = isSolid;
    blockCollisionPreIce = blockCollision;
    imageSpeedPreIce = image_speed;
    icePhysics = _physics;
    iceSolid = _solid;
    iceGraphicStyle = _graphics;
    doesTransitionPreIce = doesTransition;
}

// set ice timer
iceTimer = max(iceTimer, time);
