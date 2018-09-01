/// playerDraw()
var restoreMusic = 0;
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
// Drawing READY text before teleporting in
if (showReady)
{
    depth = -1000000; // make sure the ready text isn't hidden behind stuff
    // Draw the READY text
    if costumeID == 1 && restoreMusic == 0 && !audio_is_playing(sfxWhistle) && readyTimer == 0 && !global.hasTeleported 
    {
        playSFX(sfxWhistle);
        stopMusic();
        restoreMusic = 1;
    }
    
    if (!global.frozen)
    {
        readyTimer += 1;
    }
    
    var readyIndicator;
    readyIndicator = readyTimer mod 12;
    if (readyIndicator >= 6 && readyIndicator
        <= 11) // For the last 7 frames of every 14 frames, show the READY text
    {
        readyText = "READY";
        
        draw_set_halign(fa_center);
        draw_set_valign(fa_middle);
        draw_set_color(c_white);
        
        draw_text(view_xview + view_wview / 2, view_yview + view_hview / 2,
            readyText);
        
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
    }
    if (readyTimer >= 72 && !audio_is_playing(sfxWhistle))
    {
        depth = 0; // restore normal depth.
        
        readyTimer = 0;
        showReady = false;
        // Teleporting sequence
        teleporting = true;
        playerIntro(true);
    }
} // If it's not READY time, just draw the player
else
{
    if restoreMusic == 1
    {
        restoreMusic = -1;
        resumeMusic();
    }
    // main drawing stuff
    col[0] = c_white;
    col[1] = global.primaryCol[playerID];
    col[2] = global.secondaryCol[playerID];
    col[3] = global.outlineCol[playerID];
    
    
    if ((iFrames mod 4) < 2 || iFrames < 0)
    {
        if (isHit && (hitTimer mod 8) <= 3) // Hitspark
        {
            draw_sprite_ext(sprHitspark, 0, spriteGetXCenter(),
                spriteGetYCenter(), image_xscale, image_yscale, 0, c_white,
                1);
        }
        else // Draws the player
        {
            drawPlayer(playerID, costumeID, spriteX, spriteY,
                round(x), round(y), image_xscale, image_yscale);
        }
    }
    
    // Weapon icon
    if (drawWeaponIcon)
    {
        var icon, iconx;
        iconx = 0;
        if (!climbing)
        {
            iconx = image_xscale;
        }
        col[0] = make_color_rgb(255, 228, 164);
        col[3] = c_white;
        
        for (i = 0; i <= 3; i += 1)
        {
            draw_sprite_ext(global.weaponIcon[global.weapon[playerID]],
                i, round(x) - 8 + iconx,
                round(y) - 30 * image_yscale, 1, image_yscale, 0,
                col[i], image_alpha);
        }
    }
}
