/// gravityEffect()
// Applies gravity only if we are not on the ground

if (!ground)
{
    var waterGrav;
    waterGrav = grav * waterAccelMod;
    
    if (object_index == objMegaman)
    {
        grav = (gravAccel * gravfactor * gravDir) * !playerIsLocked(PL_LOCK_GRAVITY);
        waterGrav = (gravWater * gravfactor * gravDir) * !playerIsLocked(PL_LOCK_GRAVITY);
        if (checkCheats(cheatEnums.permaLowGravity) || checkCheats(cheatEnums.permaHighGravity))
        {
            if (checkCheats(cheatEnums.permaLowGravity))
            {
                gravfactor = 0.4
            }
            else if (checkCheats(cheatEnums.permaHighGravity))
            {
                gravfactor = 1.9
            }
        }
    }
    
    if (inWater)
    {
        yspeed += waterGrav;
    }
    else
    {
        yspeed += grav;
    }
    
    if (yspeed * sign(grav) > 7)
    {
        yspeed = 7 * sign(grav);
    }
}
