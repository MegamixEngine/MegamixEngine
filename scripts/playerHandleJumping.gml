/// playerHandleJumping();

var jumpMax = jumpCounterMax + (checkCheats(cheatEnums.doubleJump));

if (!playerIsLocked(PL_LOCK_JUMP))
{
    if (ground)
    {
        jumpCounter = 0;
        dashJumped = false;
    }
    if (global.keyJumpPressed[playerID] && (yDir != gravDir || !global.downJumpSlide))
    {
        if (ground || jumpCounter < jumpMax)
        {
            playerJump();
        }
        else if (jumpCounter >= jumpMax && checkCheats(cheatEnums.VVVVV) && !climbing)
        {
            yspeed /= 2;
            y = y-5*-image_yscale;
            image_yscale *= -1;
            //y += sprite_get_yoffset(mask_index);
            
            playSFX(sfxGravityFlip);
            gravDir *= -1;
        }
    }
    else if (!global.keyJump[playerID]) // Minjumping (lowering jump when the jump button is released)
    {
        if (yspeed * gravDir < 0 && canMinJump)
        {
            canMinJump = false;
            yspeed = 0;
        }
    }
}
