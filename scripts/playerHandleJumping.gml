/// playerHandleJumping();

if (!playerIsLocked(PL_LOCK_JUMP))
{
    if (ground)
    {
        jumpCounter = 0;
        dashJumped = false;
    }
    if (global.keyJumpPressed[playerID] && yDir != gravDir)
    {
        if (ground || jumpCounter < jumpCounterMax)
        {
                playerJump();
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
