///dispelUtilities()
// kill all utilities so they don't interfere with forced movement

with (objRushCoil)
{
    with (instance_create(x, y, objRushTeleport))
    {
        upordown = 'up';
        parent = parent;
        image_yscale = image_yscale;
    }
    
    canCoil = false;
    instance_destroy();
}

with (objRushJet)
{
    with instance_create(x, y + 8 * image_yscale, objRushTeleport)
    {
        upordown = 'up'
        parent = parent
        image_yscale = image_yscale
    }
    
    instance_destroy();
}

with (objRushCycle)
{
    // Teleport away
    i = instance_create(x, y, objRushTeleport);
    i.upordown = 'up';
    i.parent = parent;
    i.image_yscale = image_yscale;
    
    instance_destroy();
}

with (objTrebleBoost)
{
    if (instance_exists(parent))
    {
        x = parent.x;
        y = parent.y;
        event_perform(ev_alarm,0);
        event_perform(ev_destroy,0);
    }
}

with (objIceWall)
{
    healthpoints = 0;
    event_user(EV_DEATH);
    //instance_create(x, y, objExplosion);
    //instance_destroy();
}
