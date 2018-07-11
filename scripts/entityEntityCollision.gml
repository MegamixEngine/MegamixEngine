/// entityEntityCollision()
// invoked when two entities collide.

guardCancel = 0; // the way the bullet is ignored.

// optional specification of damage for manual hitting
if (argument_count > 0)
{
    global.damage = argument[0];
}
else
{
    global.damage = contactDamage;
}

// Ignore this bullet if the enemy is choosing to
if (other.ignoreBullet == id)
{
    exit;
}

// now set the damage

// Set proper damage values from the hitter's end
if (faction == 2)
    event_user(EV_WEAPON_SETDAMAGE);

with (other) // damage table stuff goes here
{
    event_user(EV_WEAPON_SETDAMAGE);
}

// 0 = hits.
// 1 = ricochet / can be pierced
// 2 = simply passes through the enemy.
// 3 = ricochet for non-piercing / pass through for piercing
// 4 = ricochet no matter what

with (other) // trigger on hit event. guardCancel set here!
{
    event_user(EV_GUARD);
}

if (global.damage == 0)
{
    guardCancel = max(1, guardCancel);
}

switch (guardCancel)
{
    case 0:
        break;
    case 1: // Regular reflecting 
        if (penetrate == 0) // Reflected by shield
        {
            event_user(EV_REFLECTED);
            exit;
        }
        if (penetrate == 1) // Not getting reflected (no damage)
        {
            exit;
        }
        if (penetrate == 2) // Not getting reflected (no damage) on top of disabling collision with that enemy
        {
            other.ignoreBullet = id;
            playSFX(sfxReflect);
            exit;
        }
        
        // Set penetrate to 3 to completely bypass shields
        break;
    case 2: // Ignore collision 
        exit;
        break;
    case 3: // Reflect non-piercing entities / Ignore piercing entities 
        if (penetrate == 0)
        {
            event_user(EV_REFLECTED);
        }
        exit;
        break;
    case 4: // Reflect regardless of the "penetrate" variable 
        event_user(EV_REFLECTED);
        exit;
        break;
}

event_user(EV_ATTACK); // Effect of the weapon

if (global.damage != 0)
{
    with (other)
    {
        if (contactDamage != 0)
        {
            if (hitTimer >= other.attackDelay)
            {
                if (other.iFrames == 0)
                {
                    if (global.factionStance[faction, other.faction])
                    {
                        event_perform(ev_collision, prtEntity);
                    }
                }
            }
        }
        
        healthpoints -= global.damage;
        
        hitterID = other.id;
        event_user(EV_HURT);
        hitTimer = 0;
        if (healthpoints <= 0)
        {
            // if killOverride is set, only call the base prtPlayerProjectile death
            // (for stuff like tornado blow)
            if (other.killOverride && killOverride)
            {
                var parent = prtEntity;
                if (object_is_ancestor(object_index, prtEnemyProjectile))
                {
                    parent = prtEnemyProjectile;
                }
                else if (object_is_ancestor(object_index, prtBoss))
                {
                    parent = prtBoss;
                }
                else if (object_is_ancestor(object_index, prtMiniBoss))
                {
                    parent = prtMiniBoss;
                }
                else if (object_is_ancestor(object_index, prtPlayerProjectile))
                {
                    parent = prtPlayerProjectile;
                }
                
                event_perform_object(parent, ev_other, ev_user10);
                itemDrop = -1;
            }
            else
            {
                event_user(EV_DEATH);
            }
        }
        
        if (global.damagePopup) // Damagepopup
        {
            instance_create(bboxGetXCenter(), bbox_top + 4, objDamagePopup);
        }
    }
}

if (pierces == 0 || (!other.dead && pierces == 1)) // Take damage if pierces = 0 or pierces = 1 and the target isn't dead
{
    event_user(EV_DEATH);
}
