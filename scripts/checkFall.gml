/// checkFall(xOffset,ignoreSlopes)
// check if an object would fall at a horizontal offset
// Note: checking for slopes with big collision masks might be slow
if (!ground || !blockCollision)
    return true;
var _x = x;
var _y = y;
var _xspeed = xspeed;
var _yspeed = yspeed;
var _xcoll = xcoll;
var _ycoll = ycoll;

// Simple check
xspeed = argument0;
generalCollision(1); // Ignore slopes for now
checkGround(1);
var colX = x;
var result = !ground;

// If a ledge is detected in a world of squares check for slopes
if (result && argument1 == false)
{
    if (checkSolid(-4 * sign(argument0), sign(grav) * 16, 1))
    {
        x = _x;
        repeat (2)
        {
            xspeed = floor(argument0 / 2);
            ground = true;
            generalCollision();
            xspeed += sign(xspeed) * (((bbox_bottom - bbox_top) + (bbox_right - bbox_left)) / 2);
            gound = true;
            checkGround();
            if (ground)
                break;
        }
        result = !ground;
        if (object_index == objSpine)
            print("Slope code for some reason");
    }
    else
    {
        if (object_index == objSpine)
            print("Didn't find a slope");
    }
}

x = _x;
y = _y;
xcoll = _xcoll;
ycoll = _ycoll;
ground = true;
xspeed = _xspeed;
yspeed = _yspeed;
blockCollision = true;
return result;
