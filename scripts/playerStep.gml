/// playerStep()
// Handles general step event code for the player

xDir = global.keyRight[playerID] - global.keyLeft[playerID];
yDir = global.keyDown[playerID]  - global.keyUp[playerID];
if (reverseControls)
    xDir = -xDir;
    
if (!playerIsLocked(PL_LOCK_PHYSICS))
{
    playLandSound += 1;
    
    checkGround();
    
    playerHandleMovement();
    
    if (instance_exists(statusObject))
    {
        if (statusObject.statusCanJump)
        {
            playerHandleJumping();
        }
        if (statusObject.statusCanClimb)
        {
            playerHandleClimbing();
        }
    }
    else
    {
        playerHandleJumping();
        playerHandleClimbing();
    }
    
    playerHandleSliding();
}

if (checkCheats(cheatEnums.burstChaser))
{
    walkSpeed = 1.3 * 2;
    slideSpeed = 2.5 * 2;
    climbSpeed = 1.3 * 2;
    
    if (checkCheats(cheatEnums.wiiPhysics))
    {
        walkSpeed = 1.4 * 2;
        stepSpeed = 1 * 2;//Is forced to only run on the first frame.
        slideSpeed = 2.55 * 2;//Closest approximation I could get with side-by-side tests in MM10 Wily 4 LC2.
    }
}

if ((checkCheats(cheatEnums.invincible) && !checkCheats(cheatEnums.buddha)) && dieToSpikes)
    dieToSpikes = false;
    
// I literally don't know where to put this otherwise. Not globalcontrol.
global.maxMTanks = 1 + (2 * (global.mysteryContainer > 0));

playerHandleFrozen();

playerHandleOil();

playerHandleHit();
