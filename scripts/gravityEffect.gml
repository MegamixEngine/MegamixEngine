/// gravityEffect()
// Applies gravity only if we are not on the ground

if (!ground)
{
    var waterGrav;
    waterGrav = grav * waterAccelMod;
    
    if (object_index == objMegaman)
    {
        grav = (0.25 * gravfactor * gravDir) * !playerIsLocked(PL_LOCK_GRAVITY);
        waterGrav = gravWater;
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
