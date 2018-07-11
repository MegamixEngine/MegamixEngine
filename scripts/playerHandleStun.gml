if (shockedTime > 1)
{
    shockedTime -= 1;
}
else
{
    mm1Stun = false;
    isShocked = false;
    shockedTime = 0;
    shockLock = lockPoolRelease(shockLock);
}
