/// playerIntro(init)
var init = argument0;

// Set teleport sounds
if (global.teleportSound)
{
    warpInSFX = sfxTeleportInClassic;
}
else
{
    warpInSFX = sfxTeleportIn;
}

// Initialization of the spawning animation (after READY)
if (init)
{
    //if costumeID == 1
        //resumeMusic();
    switch (global.respawnAnimation)
    {
        case 1: // teleport 
            teleportTimer = 0;
            global.lockTransition = true;
            break;
        case 2: // fall in 
            landy = y;
            y = view_yview - 32;
            blockCollision = 0;
            teleportTimer = 0;
            global.lockTransition = true;
            break;
        case 3: // jump in 
            landy = y;
            y = view_yview + view_hview + 32;
            dieToPit = false;
            global.lockTransition = true;
            teleportTimer = 0;
            blockCollision = 0;
            break;
        case 4: // standing (do nothing basically) 
            break;
        case 8: // Come in from skull elevator
        /* goToX = x + (64 * image_xscale);
            getX = x;
            getY = y + 16;
            skullHeight = 0 ;*/ 
            teleportTimer = 0;
            break;
        default:
            landy = y;
            y = view_yview - 32;
            teleportTimer = 0;
            global.lockTransition = true;
            break;
    }
} // Actually perform sequence
else
{
    switch (global.respawnAnimation)
    {
        // 0: teleport (beaming down)
        default:
            canSpriteChange = 1;
            playerHandleSprites("Teleport");
            canSpriteChange = 0;
            if (!global.frozen)
            {
                // If MM has reached the landing position, play his animation
                if (round(y) >= landy)
                {
                    if (teleportTimer == 0)
                    {
                        playSFX(warpInSFX);
                        y = landy;
                        teleportImg = 0;
                    }
                    if (teleportTimer == 3)
                    {
                        teleportImg = 1;
                    }
                    else if (teleportTimer == 6)
                    {
                        teleportImg = 0;
                    }
                    else if (teleportTimer == 9)
                    {
                        teleportImg = 2;
                    }
                    else if (teleportTimer == 13)
                    {
                        // Animation over, let Mega Man move now
                        teleporting = false;
                        teleportTimer = 0;
                        
                        canHit = true;
                        iFrames = 0;
                        
                        teleportLock = lockPoolRelease(teleportLock);
                        ground = true;
                        global.lockTransition = false;
                        exit;
                    }
                    teleportTimer += 1;
                } // Otherwise, beam down
                else
                {
                    y += 8;
                }
            }
            break;
        case 1: // teleport (coming from teleporters, etc) 
            canSpriteChange = 1;
            playerHandleSprites("Teleport");
            canSpriteChange = 0;
            
            // Immediately go into animation since there's no falling down to be done here
            if (teleportTimer == 0)
            {
                playSFX(warpInSFX);
                teleportImg = 0;
            }
            if (teleportTimer == 3)
            {
                teleportImg = 1;
            }
            else if (teleportTimer == 6)
            {
                teleportImg = 0;
            }
            else if (teleportTimer == 9)
            {
                teleportImg = 2;
            }
            else if (teleportTimer == 13)
            {
                // Release after animation is done
                teleporting = false;
                teleportTimer = 0;
                teleportLock = lockPoolRelease(teleportLock);
                
                canHit = true;
                iFrames = 0;
                ground = true;
                global.lockTransition = false;
                exit;
            }
            teleportTimer += 1;
            break;
        case 2: // fall in without teleporting animation
        // don't use teleport sprites, instead do this! 
            canSpriteChange = 1;
            ground = false;
            playerHandleSprites("Normal");
            canSpriteChange = 0;
            
            // start animation if mm has reached the destination
            if (round(y) >= landy)
            {
                if (teleportTimer == 0)
                {
                    playSFX(sfxLand);
                    y = landy;
                }
                else
                {
                    teleporting = false;
                    teleportTimer = 0;
                    teleportLock = lockPoolRelease(teleportLock);
                    
                    canHit = true;
                    iFrames = 0;
                    ground = true;
                    blockCollision = true;
                    global.lockTransition = false;
                    exit;
                }
                teleportTimer += 1;
            }
            else
            {
                y += 8;
            }
            break;
        case 3: // jump in 
            if (teleportTimer == 0)
            {
                // initialization
                introFakeGrav = 0;
                introFakeYspeed = 0;
                
                teleportTimer = 1;
            }
            else
            {
                // apply simulated gravity + yspeed. regular gravity has to stay locked for some reason
                y += introFakeYspeed;
                introFakeYspeed += introFakeGrav;
            }
            
            // set sprites
            canSpriteChange = 1;
            ground = false;
            playerHandleSprites("Normal");
            canSpriteChange = 0;
            
            // Rise if gravity is 0
            if (introFakeGrav == 0)
            {
                y -= 4;
                
                // set gravity if mm is above the starting position
                if (round(y) < landy)
                {
                    introFakeYspeed = -4;
                    introFakeGrav = gravAccel;
                }
            } // if player is falling and is greater than the land y, finish the animation
            else if (introFakeGrav != 0 && round(y) >= landy)
            {
                y = landy; // reset position
                introFakeGrav = 0;
                yspeed = introFakeYspeed;
                
                blockCollision = true;
                checkGround();
                
                if (ground)
                {
                    playSFX(sfxLand);
                    introFakeYspeed = 0;
                }
                
                // cancel animation + release player
                teleporting = false;
                teleportTimer = 0;
                teleportLock = lockPoolRelease(teleportLock);
                
                canHit = true;
                iFrames = 0;
                dieToPit = true;
                
                global.lockTransition = false;
                exit;
            }
            break;
        case 4: // just stand there
        // Immediately cancel the teleporting animation 
            if (teleporting)
            {
                teleporting = false;
                teleportTimer = 0;
                teleportLock = lockPoolRelease(teleportLock);
                canHit = true;
                iFrames = 0;
                ground = true;
                dieToPit = true;
                global.lockTransition = false;
                exit;
            }
            break;
        case 8: // skull entrance
        // Initialize variables 
            if (teleportTimer == 0)
            {
                goToX = x + (32 * image_xscale);
                getX = x;
                getY = y + 16;
                skullHeight = 0;
                teleportTimer = 1;
                
                spriteX = 99;
                spriteY = 99;
            }
            else
            {
                draw_sprite_part_ext(sprSkullElevator, 0, 0, 0, 52,
                    sprite_get_height(sprSkullElevator) * min(skullHeight, 1),
                    round(getX) - sprite_get_xoffset(sprSkullElevator) * -image_xscale,
                    round(getY) - sprite_get_yoffset(sprSkullElevator) + (60 * (1 - min(skullHeight, 1))), // 96
                -image_xscale, image_yscale, image_blend, image_alpha);
                
                // Rising out of the ground
                if (skullHeight < 1
                    && x == getX)
                {
                    spriteX = 99;
                    spriteY = 99;
                    
                    skullHeight += 1 / (60 * 2);
                    if (!instance_exists(objSplash))
                    {
                        instance_create(getX + 16, getY + 2, objSplash);
                        instance_create(getX - 16, getY + 2, objSplash);
                        instance_create(getX, getY, objSplash);
                        
                        with (objSplash)
                        {
                            blockCollision = 0;
                        }
                    }
                } // Push the player outside of the skull if it's rising inwards
                else if (((round(x) <= goToX && image_xscale == 1) || (round(x) >= goToX && image_xscale == -1))
                    && xcoll == 0 && insideSection(x + image_xscale, y))
                {
                    ground = true;
                    xspeed = walkSpeed * image_xscale;
                    canHit = true;
                    
                    teleportLock = lockPoolRelease(teleportLock);
                    playerHandleSprites("Normal");
                    teleportLock = lockPoolLock(
                        localPlayerLock[PL_LOCK_MOVE],
                        localPlayerLock[PL_LOCK_TURN],
                        localPlayerLock[PL_LOCK_SHOOT],
                        localPlayerLock[PL_LOCK_JUMP],
                        localPlayerLock[PL_LOCK_PAUSE],
                        localPlayerLock[PL_LOCK_CHARGE],
                        localPlayerLock[PL_LOCK_SPRITECHANGE],
                        localPlayerLock[PL_LOCK_CLIMB]
                        );
                } // Rising back into the ground
                else if (skullHeight > 0)
                {
                    xspeed = 0;
                    skullHeight -= 1 / (60 * 2);
                    if (!instance_exists(objSplash))
                    {
                        instance_create(getX + 16, getY + 2, objSplash);
                        instance_create(getX - 16, getY + 2, objSplash);
                        instance_create(getX, getY + 2, objSplash);
                        
                        with (objSplash)
                        {
                            blockCollision = 0;
                        }
                    }
                } // End animation
                else
                {
                    teleporting = false;
                    teleportTimer = 0;
                    teleportLock = lockPoolRelease(teleportLock);
                    
                    iFrames = 0;
                    ground = true;
                    dieToPit = true;
                    global.lockTransition = false;
                    
                    exit;
                }
            }
            break;
    }
}
