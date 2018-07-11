// setTargetHit(projectile id)

var projectile = argument0;

switch (behaviourType)
{
    case 0:
    case 1: // Target agressor 
        if (instance_exists(projectile.parent))
        {
            target = projectile.parent;
        }
    case 2: // Consider targetting aggressor
    // Don't target new aggressor if very near an existing mega man, unless aggressor is also near: 
        if (!target)
        {
            if (instance_exists(projectile.parent))
            {
                target = projectile.parent;
            }
        }
        else if (hitTimer > 120) // Target aggressor, but only if it hasn't been too long since the last switch
        {
            if (distance_to_object(target) < 32)
            {
                if (instance_exists(projectile.parent))
                {
                    if (distance_to_object(projectile.parent) < 40)
                    {
                        target = projectile.parent;
                    }
                }
            }
        }
        break;
    case 3: // Sorry - Nothing 
        break;
}
