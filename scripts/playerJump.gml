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
