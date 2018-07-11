/// playerHandleHit();
// While being hit
if (isHit)
{
    if (hitTimer >= hitTime)
    {
        isHit = false;
        hitTimer = 0;
        
        hitLock = lockPoolRelease(hitLock);
        
        if (iFrames != 0)
        {
            iFrames = 60 * (1 + (global.sturdyHelmet * 0.5));
        }
    }
}
