/// playerHandleSprites(Animation Name)
if (playerIsLocked(PL_LOCK_SPRITECHANGE))
{
    exit;
}

// mega man is just a foolish 1-UP in this mode...
if (global.freeMovement)
{
    exit;
}

// setup animation variables
var AnimID;
AnimID = argument0;
lastanimation = AnimID;

animate = 0;
spriteX = 0;
spriteY = 0;

// do animations
switch (AnimID)
{
    case "Normal": // Regular animation stuff 
    case "Proto Shield"://Proto Man variants.
        animNameID = 0; // Standing
        if ((isHit && (!isSlide || (isSlide && !global.blastWind))) || isFrozen)
        {
            // Hurt
            animNameID = 5;
        }
        else if (climbing)
        {
            // Climbing
            animNameID = 4 + (climbing == 2) * 3;
        }
        else if (isSlide)
        {
            // Sliding
            animNameID = 6;
        }
        else if (isShocked)
        {
            // MM1 Stun
            animNameID = 8;
        }
        else if (ground)
        {
            if (!playerIsLocked(PL_LOCK_MOVE) || fanoutDistance != 0)
            {
                if (stepTimer >= stepFrames)
                {
                    // Walking
                    animNameID = 2;
                }
                else if (stepTimer > 0)
                {
                    // Pixel step
                    animNameID = 1;
                }
            }
        }
        else
        {
            // Jumping
            animNameID = 3;
        }
        
        if (animNameID == 0) || (animNameID < 3 && (instance_exists(vehicle)))
        {
            // Stand
            blinkTimer += 1;
            if (global.playerSprite[costumeID] == sprProtoman) || (global.customCostumeEquipped[playerID] && global.customCostumeScarfAnimation[playerID])
            {
                blinkTimerMax = 20;
            }
            else
            {
                blinkTimerMax = 120;
            }
            
            blinkImage = ((blinkTimer mod blinkTimerMax + blinkDuration + 1)
                >= blinkTimerMax);
        }
        else
        {
            blinkTimer = 0;
            blinkImage = 0;
        }
        
        spriteY = isShoot;
        if (animLookUp)
        {
            spriteY = 7;
            animLookUp = false;
        }
        
        if (animNameID != lastAnimNameID)
        {
            // reset the position in the animation so the next one doesn't start partway into it
            spriteLoopID = 0;
            
        }
        
        switch (animNameID)
        {
            // Stand 
            case 0:
                spriteX = blinkImage;
                break;
            
            // Pixel Step 
            case 1:
                spriteX = 2;
                break;
            
            // Walking 
            case 2:
                if (lastAnimNameID == 6)
                {
                    // transition frame from slide (slightly more natural follow-up pose)
                    spriteLoopID = 3;
                }
                
                spriteLoopStart = 0;
                spriteLoopEnd = 3;
                spriteIDX[0] = 3;
                spriteIDX[1] = 4;
                spriteIDX[2] = 5;
                spriteIDX[3] = 6;
                spriteLoopPoint = 0;
                spriteLoopSpeed = 0.15;
                spriteX = spriteIDX[floor(spriteLoopID)];
                animate = 1;
                bassModeHandleSpriteYRewrite(true);
                break;
            
            // Jumping 
            case 3:
                if (AnimID != "Proto Shield" || isShoot)
                {
                    spriteLoopStart = 0;
                    spriteLoopEnd = 3;
                    spriteLoopPoint = 2;
                    spriteIDX[0] = 7;
                    spriteIDX[1] = 8;
                    spriteIDX[2] = 9;
                    spriteIDX[3] = 10;
                    spriteLoopSpeed = 0.3;
                    
                    if ((yspeed < 0 && grav >= 0) || (yspeed > 0 && grav < 0))
                    {
                        // jumping
                        spriteLoopEnd = 1;
                        spriteLoopPoint = 0;
                    }
                    else
                    {
                        // Falling
                        spriteLoopEnd = 3;
                        spriteLoopPoint = 2;
                    }
                    spriteX = spriteIDX[floor(spriteLoopID)];
                    animate = 1;
                }
                else
                {
                    spriteLoopStart = 0;
                    spriteLoopEnd = 3;
                    spriteLoopPoint = 2;
                    spriteIDX[0] = 14;
                    spriteIDX[1] = 15;
                    spriteIDX[2] = 16;
                    spriteIDX[3] = 17;
                    spriteLoopSpeed = 0.3;
                    spriteY = 10;
                    if (yspeed < 0) // jumping
                    {
                        spriteLoopEnd = 1;
                        spriteLoopPoint = 0;
                    }
                    else // Falling
                    {
                        spriteLoopEnd = 3;
                        spriteLoopPoint = 2;
                    }
                    spriteX = spriteIDX[floor(spriteLoopID)];
                    animate = 1;
                }
                break;
            
            // Climbing
            case 4:
                spriteLoopStart = 0;
                spriteLoopEnd = 1;
                spriteIDX[0] = 15;
                spriteIDX[1] = 16;
                
                if (instance_exists(objSectionSwitcher) && !isShoot)
                {
                    // animate automatically while switching sections.
                    // (Mega man is paused and can't animate through the normal means)
                    climbSpriteTimer += 1;
                    climbSpriteTimer = climbSpriteTimer mod 16;
                }
                
                spriteLoopID = !((climbSpriteTimer div 8) mod 2);
                spriteX = spriteIDX[spriteLoopID];
                
                break;
            
            // Hit 
            case 5:
                spriteX = 13 + (!isHit) - (isFrozen > 0);
                bassModeHandleSpriteYRewrite(false);
                break;
            
            // Sliding 
            case 6:
                spriteLoopStart = 0;
                spriteLoopEnd = 1;
                spriteLoopPoint = 0;
                spriteIDX[0] = 11;
                spriteIDX[1] = 12;
                spriteLoopSpeed = 0.3;
                spriteX = spriteIDX[floor(spriteLoopID)];
                animate = 1;
                bassModeHandleSpriteYRewrite(false);
                break;
            
            // Climbing top 
            case 7:
                spriteX = 17;
                
                // shooting (alternate frame to prevent leg switching when shooting)
                if (spriteY > 0)
                {
                    spriteX = 16 - (image_xscale < 0);
                }
                else
                {
                    image_xscale = 1; // redundant code to fix being the wrong xscale for a frame when shooting left
                }
                
                break;
            
            // Stun 
            case 8:
                bassModeHandleSpriteYRewrite(false);
                spriteX = 14;
                break;
                
            // Spin. I don't care anymore
            case 10:
                spriteLoopStart = 0;
                spriteLoopEnd = 3;
                spriteIDX[0] = 6;
                spriteIDX[1] = 7;
                spriteIDX[2] = 8;
                spriteIDX[3] = 9;
                spriteLoopPoint = 0;
                spriteLoopSpeed = 0.25;
                spriteX = spriteIDX[floor(spriteLoopID)];
                spriteY = 8;
                animate = 1;
                break;
        }
        break;
    
    // - E X T R A    A N I M A T I O N    S T U F F - //
    
    // Weapons
    case "Slash":
        spriteY = 9;
        
        var initxoffset;
        
        if (climbing)
        {
            initxoffset = 8;
        }
        else if (ground)
        {
            initxoffset = 0;
        }
        else
        {
            initxoffset = 4;
        }
        
        if (instance_exists(objSlashClaw))
        {
            var sprx;
            sprx = round(instance_nearest(x, y, objSlashClaw).image_index);
            if (sprx > 3)
            {
                sprx = 3;
            }
            spriteX = initxoffset + sprx;
        }
        
        break;
    
    case "Sakugarne0":
        spriteX = 13;
        spriteY = 9;
        break;
    
    case "Sakugarne1":
        spriteX = 14;
        spriteY = 9;
        break;
    
    case "Wire":
        if (!climbing)
        {
            spriteY = 7;
            
            if (instance_exists(objWireAdapter))
            {
                if (ground || other.phase == 1)
                {
                    spriteX = 15;
                }
                else if (other.phase >= 2)
                {
                    spriteX = 16 + isShoot;
                }
            }
            
        }
        
        break;
    
    case "Top":
        spriteY = 8;
        spriteX = 6 + other.animFrame; // anim force
        break;
    
    case "Break":
        spriteY = 8;
        spriteX = other.animFrame + other.flashOffset; // anim force
        break;
    
    case "Cycle":
        spriteX = 10 + other.currentImg;
        spriteY = 12;
        break;
    
    case "Tengu1":
        spriteY = 10;
        
        var initxoffset;
        
        if (climbing)
        {
            initxoffset = 8;
        }
        else if (ground)
        {
            initxoffset = 0;
        }
        else
        {
            initxoffset = 4;
        }
        
        if (instance_exists(objTenguBlade))
        {
            var sprx;
            sprx = round(instance_nearest(x, y, objTenguBlade).image_index);
            if (sprx > 3)
            {
                sprx = 3;
            }
            spriteX = initxoffset + sprx;
        }
        
        break;
    
    case "Tengu2":
        spriteX = 12 + other.animFrame;
        spriteY = 10;
        break;
    
    case "Guts":
        spriteY = 6;
        break;
    
    // Other
    
    case "Talk":
        break;
    
    case "Teleport":
        spriteX = 10 + teleportImg;
        spriteY = 8;
        break;

    case "Spin":
        animSpinOffset += 0.125 * sign(other.image_xscale);
        
        // loop the animation
        if (animSpinOffset >= 10 - !global.costumeExtendedSpin[costumeID])
        {
            animSpinOffset = 0;
        }
        
        if (animSpinOffset < 0)
        {
            animSpinOffset = (10 - !global.costumeExtendedSpin[costumeID]) - 0.125;
        }
        
        if (floor(animSpinOffset) == 4 && !global.costumeExtendedSpin[costumeID])
        {
            if (sign(other.image_xscale) == 1)
                animSpinOffset = 5;
            else
                animSpinOffset = 4 - 0.125;
        }
        
        spriteX = floor(animSpinOffset);
        spriteY = 12;
        
        break;
        
    case "Bike":
        if (animNameID == 5)
            spriteX = 7;
        else
            spriteX = 6 + blinkImage;
        spriteY = 13;
        break;
        
    case "Boost":
     // Treble Boost.
        var startup = -1;
        var aTimer = 0;//Because of how we're not overwriting blinkImage from Normal, we need TrebleBoost to handle this animation.
        var offsetX = 0;//12; Change for 3.
        var offsetY = 0;//12; Change for 3.
        with (objTrebleBoost)
        {
            startup = alarm[1];
            aTimer = animTimer;
        }
        
        //show_debug_message(startup);
        //printErr(startup);
        
        if (startup >= 0)
        {
            animNameID = 1;
            aTimer = 0;
            blinkImage = 0;
        }
        else
        {
            animNameID = 0; // Standing
            
            
            blinkImage = aTimer%2;
            spriteX = offsetX+blinkImage;
            spriteY = offsetY+isShoot;
        }
        
        switch (animNameID)
        {
            case 0: // Stand 
                //spriteX = 19+blinkImage;
                /*if global.cPlayer == 1
                    {
                    if !isShoot
                        spriteY = 7;
                    }*/
                //spriteY = 2;
                break;
                
            case 1:
                spriteX = offsetX;
                spriteY = offsetY+1;
                if (startup >= 9)
                {
                    spriteX += 2;
                    //spriteY++;
                }
                else if (startup >= 6)
                {
                    spriteX += 3;
                    //spriteY++;
                }
                else
                {
                    spriteX += 4;
                    //spriteY++;
                }
                break;
        }
        
        break;
    
    case "Magnet":
        spriteY = other.spry;
        spriteX = other.sprx;
        break;
        
    case "Backturn":
        spriteX = 3;
        spriteY = 13;
        break;        
    case "ProtoMode_Backturn": // ONLY USED IN PROTO MAN MODE
        spriteY = 6;
        spriteX = 4 + blinkImage;
        break;
    case "ProtoMode_Backturn2": // ONLY USED IN PROTO MAN MODE
        spriteY = 6;
        spriteX = 6 + blinkImage;
        break;
        
    case "VictoryPose":
        spriteY = 11;
        if (other.victoryPoseTimer < 15)
        {
            spriteX = 9;
        }
        else
        {
            spriteX = 10;
        }
        break;
}

if (animate) // Animation
{
    if (spriteLoopID < spriteLoopEnd + 1)
    {
        spriteLoopID += spriteLoopSpeed;
    }
    
    if (spriteLoopID >= spriteLoopEnd + 1)
    {
        spriteLoopID = spriteLoopPoint;
    }
}

lastAnimNameID = animNameID;

/*
0 = stand
1 = side step
2 = walk
3 = jump
4 = climb
5 = hurt
6 = slide
7 = climbTop
8 = shocked/mm1 stun
*/
