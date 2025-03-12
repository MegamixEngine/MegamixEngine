//THE ACTUAL STEP EVENT
if (!global.frozen && !frozen)
{
    if (xScaleOverride != 0)
    {
        image_xscale = movementXScale;
    }
    playerStep(); // General step event code
    
    if (!playerIsLocked(PL_LOCK_PHYSICS))
    {
        gCollXScale = image_xscale;
        var iscl = image_xscale;
        image_xscale = 1;//Ensure a symmetrical mask
        event_inherited(); // General prtEntity code
        image_xscale = iscl;
        gCollXScale = 0;
        playerMovement();
        
    }
    if (xScaleOverride != 0)
    {
        movementXScale = image_xscale;
    }
    if (xScaleOverride != 0 && !climbing)
    {
        image_xscale = sign(xScaleOverride);
    }
    // Shooting
    if (instance_exists(statusObject))
    {
        if (statusObject.statusCanShoot)
        {
            playerHandleShoot();
        }
    }
    else
    {
        playerHandleShoot();
    }
    
    if (climbing)
    {
        movementXScale = image_xscale;
    }
    
    // Quick weapon switching
    playerSwitchWeapons();
    
    if (global.characterSelected[playerID] == CHAR_PROTOMAN && !instance_exists(myProtoShield))
    {
        myProtoShield = instance_create(x,y,objProtoShield);
        myProtoShield.parent = id;
        myProtoShield.playerID = playerID;
    }
    
    // Handle the sprites
    if (global.characterSelected[playerID] == CHAR_PROTOMAN)
    {
        playerHandleSprites("Proto Shield");
    }
    else
    {
        playerHandleSprites('Normal');
    }
    
    // Moving from one section to the next, if possible
    playerSwitchSections();
    
    // Recover from mm1 stun
    playerHandleStun();
}
