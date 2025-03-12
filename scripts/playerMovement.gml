if (!instance_exists(vehicle))
{
    if (ycoll * gravDir > 0)
    {
        if (playLandSound > 2 && !isHit && !climbing)
        {
            var keepGoing = true;
            with (objTrebleBoost)//Technically not a vehicle.
            {
                if (playerID == other.playerID && isBoosting)
                {
                    keepGoing = false;
                }
            }
            if (keepGoing)
            {
                playSFX(getGenericSFX(SFX_JUMP));
                
                if (global.customCostumeEquipped[playerID] && global.customCostumeLandParticles[playerID])
                {
                    with (instance_create(x - 4, y + (abs(y - bbox_bottom) - 2) * sign(image_yscale), objSlideDust))
                    {
                        image_xscale = 1;
                        hspeed = -1;
                    }
                    with (instance_create(x + 4, y + (abs(y - bbox_bottom) - 2) * sign(image_yscale), objSlideDust))
                    {
                        image_xscale = -1;
                        hspeed = 1;
                    }
                }
            }
        }
    }
}

// Stop movement at section borders (horizontal)
var xdis = x - (view_xview + ((view_wview * 0.5)));
var xpos = (view_wview * 0.5)-6;

if (abs(xdis) > xpos && !global.cameraPanMode)
{
    if ((xdis >= 0 && (!place_meeting(x, y, objSectionArrowRight) || global.lockTransition))
        || (xdis < 0 && (!place_meeting(x, y, objSectionArrowLeft) || global.lockTransition)))
    {
        x = view_xview + (view_wview * 0.5) + xpos * sign(xdis);
        
        if (!isSlide)
            xspeed = 0;
        
        if (position_meeting(x,y,objSolid) && blockCollision)
        {
            event_user(10);
            
            if (checkCheats(cheatEnums.buddha) && canHit && iFrames == 0)
                playerGetHit(28);
        }
    }
}


// stop movement at section borders (vertical)
var ydis = y - (view_yview + (view_hview * 0.5));
var ypos = (view_hview * 0.5) + 32;

if (ydis * gravDir < -ypos && !global.cameraPanMode)
{
    y = view_yview + (view_hview * 0.5) + ypos * sign(ydis);
}
else if (dieToPit && !global.freeMovement && !global.cameraPanMode)
{
    if (ydis * gravDir > ypos - 16)
    {
        if ((gravDir >= 0 && !position_meeting(x, y - 8, objSectionArrowDown))
            || (gravDir < 0 && !place_meeting(x, y + 8, objSectionArrowUp)))
        {
            //in multiplayer, don't kill the player unless this is actually a pit
            //instead, warp to the highest possible player
            var doNotKill = false;
            var isWarping = false;
            
            if (global.playerCount > 1) and (instance_number(objMegaman) > 1) and (global.respawnAllowed)
            {
                if (y < global.sectionBottom)
                {
                    var highestPlayer = instance_nearest(x,view_yview,objMegaman);
                    
                    if (instance_exists(highestPlayer))
                    {
                        coopWarp(highestPlayer.playerID,true,30,true,true,true,true,playerID);
                    }
                    doNotKill = true;
                    isWarping = true;
                }
            }
            
            // Failsafe for invincibility/buddha and bouncy pits cheats simutaniously active
            if (!isWarping && (checkCheats(cheatEnums.invincible) || checkCheats(cheatEnums.buddha)))
            {
                if (gravDir > 0)
                    y = view_yview[0] + view_hview[0] - 6
                else
                    y = view_yview[0] + 6
                
                playerGetHit(28);
                doNotKill = true;
            }
            
            if (!doNotKill)
            {
                event_user(10);
                deathByPit = true;
            }
            //}
        }
    }
}

// Handling of masks to make sure nothing breaks
if (!isSlide && (mask_index == firstSlideMask || mask_index == secondSlideMask))
{
    mask_index = mskMegaman;
}
