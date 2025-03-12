/// playerJump()
// causes this player instance to jump
var incrementJumpCounter = 1
if(argument_count>0)
{
    incrementJumpCounter=argument[0];
}
// We can jump-cancel the throwing animation
shootStandStillLock = lockPoolRelease(shootStandStillLock);

yspeed = (jumpSpeed + jumpSpeedWater * (inWater > 0)) * -gravDir;
if ((checkCheats(cheatEnums.doubleJump)) && !ground && !climbing)
{
    if (checkCheats(cheatEnums.doubleJump))
        playSFX(sfxBalladeShoot);
        
    // create slide dust particles
    with (instance_create(x - 4, y + (abs(y - bbox_bottom) - 2) * sign(image_yscale), objSlideDust))
    {
        image_xscale = 1;
        hspeed = -1;
    }
    with (instance_create(x + 4, y + (abs(y - bbox_bottom) - 2) * sign(image_yscale), objSlideDust))
    {
        image_xscale = -1;
        hspeed = 1;
    }
}

if (getGenericSFX(SFX_JUMPMARIO) >= 0)
{
    playSFX(getGenericSFX(SFX_JUMPMARIO));
}
ground = false;

// change this so that you have to press jump to do a min jump
canMinJump = true;

if incrementJumpCounter != 0
{
    jumpCounter += incrementJumpCounter;
}

if (jumpCounter > 1 && multiJumpDashCancel == true)
{
    dashJumped = false;
}
