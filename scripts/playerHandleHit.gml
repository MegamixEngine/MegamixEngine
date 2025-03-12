/// playerHandleHit();
// While being hit
if (isHit)
{
    // dumb place to update but literally who cares. No one will ever know
    if (global.sturdyHelmet)
    {
        hitTime = 16;
    }
    
    if (hitTimer >= hitTime || (checkCheats(cheatEnums.noIFrames)))
    {
        isHit = false;
        hitTimer = 0;
        
        hitLock = lockPoolRelease(hitLock);
        
        if (iFrames != 0)
        {
            hitRecover = 2;
            if (!checkCheats(cheatEnums.noIFrames) || (checkCheats(cheatEnums.noIFrames)))
            {
                iFrames = 60 * (1 + ((global.sturdyHelmet > 0) * 0.5));
            }
            else
            {   
                iFrames = 0;
            }
        }
    }
}
