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
    if (checkCheats(cheatEnums.moonwalk))
    {
        xDir *= -1;
    }
    
    if (ground && !playerIsLocked(PL_LOCK_GROUND))
    {
        if (checkCheats(cheatEnums.airSliding))
        {
            airDashed = false;
        }
        if (xDir == image_xscale || (checkCheats(cheatEnums.moonwalk) && xDir == -image_xscale)) // Walk on the ground
        {
            if (global.manualTippytoe)
            {
                if (global.analogStickTilt[playerID, 0])
                {
                    if (global.analogStickTilt[playerID, 0] < 0.75)
                    {
                        if (stepTimer >= (stepFrames - 1))
                        {
                            stepTimer = -stepFrames;
                        }
                    }
                }
            }
            
            var myWalkSpeed = 0;
            
            if (stepTimer < stepFrames) // Tippy-toe
            {
                if !(checkCheats(cheatEnums.wiiPhysics)) || (stepTimer == 0)
                {
                    myWalkSpeed = stepSpeed;
                }
                stepTimer ++;
            }
            else // Walk
            {
                myWalkSpeed = walkSpeed;
                
                
                if (place_meeting(x, y + gravDir, objOil)) // Oil
                {
                    myWalkSpeed = oilWalk;
                }
            }
            var iceShoot = false;
            
            if (global.characterSelected[playerID] == CHAR_BASS && lastWeapon = objBusterShot && global.weapon[playerID] == 0 && isShoot && ((global.keyShoot[playerID] && shootTimer <= 10) || shootTimer <= 8))// && isShoot)
            {//The Bass Buster works differently from other weapons that ground you on the ground in that it keeps you locked even if you were firing in the air.
            //In previous games, using shootStandStill for this had a side effect of having you "slide" across the ground until your shootTimer hit a certain point.
            //To get around this, I've removed the traditional shootStandStill from Bass Buster in favor of this somewhat hack (that we should maybe look into including in base weapon systems in 2.0).
                if ((!place_meeting(x, y + gravDir, objIce)
                    && !(instance_exists(statusObject) && statusObject.statusOnIce)
                    && !(checkCheats(cheatEnums.permaIcePhysics))))
                    {
                        myWalkSpeed = 0;
                        
                    }
                    else
                    {
                        //myWalkSpeed = walkSpeed;
                        //printErr(xspeed);
                        xspeed -= min(abs(xspeed), iceDec) * sign(xspeed);
                        iceShoot = true;
                    }
                stepTimer = 0;
            }
            if (!iceShoot)
            {
                if (place_meeting(x, y + gravDir, objIce) || (instance_exists(statusObject) && statusObject.statusOnIce) || (checkCheats(cheatEnums.permaIcePhysics))) // Ice
                {
                    if ((xspeed * image_xscale) < myWalkSpeed)
                    {
                        xspeed += (myWalkSpeed * iceDec * xDir);
                    }
                }
                else // Normal
                {
                    xspeed = myWalkSpeed * xDir;
                }
            }
        }
        else
        {
            stepTimer = 0;
            
            if (xspeed != 0)
            {
                if (!place_meeting(x, y + gravDir, objIce)
                    && !(instance_exists(statusObject) && statusObject.statusOnIce)
                    && !(checkCheats(cheatEnums.permaIcePhysics))) // Normal physics
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
                xspeed = (walkSpeed) * xDir;
            }
            else
            {
                xspeed = slideSpeed * xDir;
            }
            stepTimer = stepFrames;
        }
    }
    
    
    if (checkCheats(cheatEnums.moonwalk))
    {
        xDir *= -1;
    }
    //A variable for spreading players out if needed in multiplayer.
    if fanoutDistance != 0
    {
        fanoutDistance -= abs(walkSpeed) * sign(fanoutDistance);
        if fanoutDistance * sign(walkSpeed) < 0
        {
            fanoutDistance = 0;
            xspeed = 0;
        }
    }
}
