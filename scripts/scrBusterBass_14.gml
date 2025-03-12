var bulletLimit = 4 + (12 * (global.shotUpgrade > 0));;
var weaponCost = 0;
var action = 1; // 0 - no frame; 1 - shoot; 2 - throw; 3 - upwards aim; 4 - upwards diagonal aim; 5 - downwards diagonal aim;
var xOffset = 20;
var yOffset = 0;
var willStop = 0; // If this is 1, the player will halt on shooting ala Metal Blade.

var pCanMove = !playerIsLocked(PL_LOCK_MOVE);

var gDir = sign(grav);
if (gDir == 0)
{
    gDir = 1;
}
var triggerDepthForce = false;
if !(instance_exists(myTrebleBoost))
{
    //setting the actual action here
    if yDir*gDir == -1 && xDir == 0
    {
        action = 3;
        xOffset = 5;
        yOffset = -11;
        //Technically the clibbing variant is a few pixels off from MM10's...*however* it actually looks more like it's coming from the buster with this, and the engine causes the bullet to die anyway so this is the best compromise.
        if (!ground && !climbing)
        {
            xOffset +=1;
        }
        
    }
    else if yDir*gDir == -1 && xDir != 0
    { 
        action = 4;
        xOffset = 18;
        yOffset = -10;
        if (climbing)
        {
            xOffset -= 4;
            yOffset += 1;
        }
        else if (!ground)
        {
            xOffset -= 3;
            yOffset += 2;
        }
    }
    else if yDir*gDir 
    {
        action = 5;
        xOffset = 14+4;
        yOffset = 6+4;
        if (climbing)
        {
            xOffset -= 4;
            yOffset -= 1;
        }
        else if (!ground)
        {
            //yOffset -= 5;
            xOffset -= 3;
            triggerDepthForce = true;
        }
        
    }
}
if (!global.lockBuster)
{
    //printErr(shootTimer);
    if (isSlide)//Failsafe for above to cancel once a slide has started.
    {
        exit;
    }
    if (global.keyShoot[playerID] && (!playerIsLocked(PL_LOCK_SHOOT)))
    {
        if (ground)
        {
            stepTimer = 0;
            dashJumped = false;
        }
        if shootTimer < 8
        {
            shootTimer++
            //shootStandStillLock = lockPoolRelease(shootStandStillLock);
            //shootStandStillLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE]);//lockPoolLock(PL_LOCK_MOVE);
            
            exit;
        }
        i = fireWeapon(xOffset, yOffset, objBusterShot, bulletLimit, weaponCost, action, willStop);
        isShoot = action;
        if ((!place_meeting(x, y + gravDir, objIce)
                    && !(instance_exists(statusObject) && statusObject.statusOnIce)
                    && !(checkCheats(cheatEnums.permaIcePhysics))))
        {
            xspeed = 0;
        }
        
        //printErr(shootTimer);
        if (i)
        {
            //printErr("SHOOT");
            i.sprite_index = sprBassBullet;
            i.dir = 0;
            i.faceDir = image_xscale;
            if (image_xscale < 0)
            {
                i.dir += 180;
            }
        
            if (yDir != 0)
            {
                i.dir -= (yDir*gDir * 90) * image_xscale;
                if (xDir != 0 || yDir*gDir == 1)
                {
                    i.dir += (yDir*gDir * 45) * image_xscale;
                }
            }
            if (triggerDepthForce)
            {
                i.depth = depth+1;
            }
            with (i)
            {
                var bCheck = isBoost;//Fix for despawning before grav lift can take effect.
                isBoost = true;
                scrBusterBass_Step();//Run once to get x and y speeds. Also fixes problems with MM9's gravity lift.
                isBoost = bCheck;
            }
        }
        else
        {
            //shootStandStillLock = lockPoolRelease(shootStandStillLock);
            //shootStandStillLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE]);
            shootTimer = 0;//min(shootTimer,15);
            
        }
        //stepTimer = 0;
    }
    else if (shootTimer >= 16)//If part of this statement and new ending-else below is a fix for Turbo-firing.
    {
        shootTimer = 16;//14;
        
    }
    else
    {
        shootTimer++;
    }
    /*if (!ground)
    {
        stepFrames = 0;
    }*///printErr(xDir);//stepTimer);
    
    //if (!global.keyShoot[playerID] && isShoot && ground)
    //{
        //spriteLoopID = 0;
    //}
}
