/// playerDraw()
// Don't draw if the game is fading in
if (teleporting || showReady)
{
    if (objGlobalControl.fadeAlpha > 0)
    {
        exit;
    }
}

if ((teleporting || showDuringReady) && !instance_exists(objSectionSwitcher))
{
    playerIntro(false);
}

// Handle READY state (drawing happens in objGlobalControl)
if (showReady)
{
    var sfx = sfxWhistle;
    var stopEarly = global.keySlide[playerID] || global.autoCutsceneSkip == 2;
    var canEnd = ((readyTimer >= 80) || stopEarly) || global.stageIsHub;
    
    if (costumeID == 1 || global.customCostumeEquipped[playerID]) // We are Protoman/Break Man. and not in multiplayer
    {
        if (global.playerCount == 1 && !global.protoWhistle)
        {
            if ((readyTimer == 0) && (!global.hasTeleported)) //Stop music
            {
                //playSFX(sfx);
                //stopMusic();
                
            }
            /*if (stopEarly)
            {
                stopSFX(sfx);
                canEnd = 1;
            }*/
            
           
            global.protoWhistle = true;
            var whis = getGenericSFX(SFX_WHISTLE);
            if (whis >= 0)
            {
                playSFX(whis);//sfxProtoWhistleShort);
            }
            /*if (canEnd) //Resume music
            {
                resumeMusic();
                global.protoWhistle = true; //has whistles, now disabled when dying later. its cute but given this game, annoying.
            }*/
        }
    }
    
    if (!global.frozen) //Handle timer
    {
        readyTimer ++;
            
        if (canEnd)
        {
            // Teleporting sequence
            teleporting = true;
            
            readyTimer = 0;
            showReady = false;
            
            playerIntro(true);
        }
    }
} 
else // Out of the READY state
{
    var xx = round(x);
    var yy = round(y);
    // Main drawing stuff
    if ((iFrames mod 4) < 2 || iFrames < 0)
    {
        if (isHit && (hitTimer mod 8) <= 3) // Hitspark
        {
            draw_sprite_ext(sprHitspark, 0, spriteGetXCenter(), spriteGetYCenter(), image_xscale, image_yscale, image_angle, c_white, 1);
        }
        else // Draws the player
        {
            drawPlayer(playerID, costumeID, spriteX, spriteY, xx, yy, image_xscale, image_yscale, image_angle);
        }
    }
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
    // Paralysis. I'm really adding this to playerDraw? Whatever
    if (isFrozen == 2)
    {
        draw_sprite_ext(sprSparkShockParalyze, (global.gameTimer % 15 < 7), xx + 2 * image_xscale, yy + 6 * image_yscale, image_xscale, image_yscale, 0, c_white, 1);
    }
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    
    // Weapon icon
    if (weaponIconDrawing)
    {
        if (!weaponIconMode) // Weapon switch icon
        {
            if (global.wepIconShow)
            {
                var ixx = xx - 8 + (image_xscale * (climbing == 0));
                var iyy = yy - (30 * image_yscale);
                
                if (image_yscale < 0)
                {
                    iyy -= 16;
                }
                
                drawWeaponIcon(global.weapon[playerID], playerID, costumeID, ixx, iyy, 1, 1, 1);
            }
        } 
        else // Weapon wheel
        {
            drawWeaponWheel(playerID, xx, yy, wheelDirection);
         }
    }
}

