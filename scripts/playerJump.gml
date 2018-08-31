/// playerJump()
// causes this player instance to jump

// We can jump-cancel the throwing animation
shootStandStillLock = lockPoolRelease(shootStandStillLock);

yspeed = (jumpSpeed + jumpSpeedWater * (inWater > 0)) * -gravDir;
ground = false;

// change this so that you have to press jump to do a min jump
canMinJump = true;

jumpCounter += 1;

if (jumpCounter > 1 && multiJumpDashCancel == true)
{
    dashJumped = false;
}
