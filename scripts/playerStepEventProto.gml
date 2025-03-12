var protoShieldCreated = 0;
//DELETE THIS! No longer used.
//THE ACTUAL STEP EVENT
if (!global.frozen && !frozen)
{
    playerStep(); // General step event code
    
    if (!playerIsLocked(PL_LOCK_PHYSICS))
    {
        var iscl = image_xscale;
        image_xscale=1;//Ensure a symmetrical mask
        event_inherited(); // General prtEntity code
        image_xscale=iscl;
        playerMovement();
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
    
    // Quick weapon switching
    playerSwitchWeapons();
    
    // Handle the sprites
    playerHandleSpritesProto('Normal');
    
    // Moving from one section to the next, if possible
    playerSwitchSections();
    
    // Recover from mm1 stun
    playerHandleStun();
    
    if protoShieldCreated == 0
    {
        protoShieldCreate = instance_create(x, y, objProtoShield)
        protoShieldCreate.parent = id;
    }
}
