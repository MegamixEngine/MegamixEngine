/// playerHandleMovement();

if (!playerIsLocked(PL_LOCK_TURN))
{
    if (xDir != 0)
    {
        image_xscale = sign(xDir);
    }
}

// Movement (includes initializing sidestep while on the ground)
if (!playerIsLocked(PL_LOCK_MOVE))
{
    if (ground && !playerIsLocked(PL_LOCK_GROUND))
    {
        if (xDir == image_xscale) // Walk on the ground
        {
            if (stepTimer < stepFrames)
            {
                if (xspeed == 0)
                {
                    xspeed = stepSpeed * image_xscale;
                }
                stepTimer += 1;
            }
            else
            {
                if (place_meeting(x, y + gravDir, objOil)) // Oil
                {
                    xspeed = oilWalk * xDir;
                }
                else if (place_meeting(x, y + gravDir, objIce)
                    || (instance_exists(statusObject) && statusObject.statusOnIce)) // Ice
                {
                    if (xspeed * image_xscale < walkSpeed)
                    {
                        xspeed += iceDec * xDir;
                    }
                }
                else // Normal
                {
                    xspeed = walkSpeed * xDir;
                }
            }
        }
        else
        {
            stepTimer = 0;
            if (xspeed != 0)
            {
                if (!place_meeting(x, y + gravDir, objIce)
                    && !(instance_exists(statusObject) && statusObject.statusOnIce)) // Normal physics
                {
                    xspeed = 0;
                }
                else // Ice physics
                {
                    xspeed -= min(abs(xspeed), iceDec) * sign(xspeed);
                }
            }
        }
    }
    else // Move in the air
    {
        if (!playerIsLocked(PL_LOCK_AERIAL))
        {
            if (!dashJumped)
            {
                xspeed = walkSpeed * xDir;
            }
            else
            {
                xspeed = slideSpeed * xDir;
            }
            stepTimer = stepFrames;
        }
    }
}
