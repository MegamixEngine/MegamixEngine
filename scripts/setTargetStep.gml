/* if (!faction)
{
    target = noone;
}*/

if (target)
{
    if (!instance_exists(target)) // Previous target died,
    {
        target = noone;
    }
    else
    {
        if (target.dead || !target.canHit || !target.isTargetable || !global.factionStance[faction, target.faction])
        {
            target = noone;
        }
    }
}

var select = 0;

switch (behaviourType)
{
    case 0: // Generic 'smart' / non-obvious AI 
        if (target) // If mega man is very far, and hasn't shot lately, retarget with very low probability
        {
            if (!irandom(500) && hitTimer > 100)
            {
                if (point_distance(x, y, target.x, target.y) > 80)
                {
                    target = noone;
                    select = 1;
                }
            }
        }
        else
        {
            select = 1;
        }
        break;
    case 1: // Pick nearest entity at every step 
        select = 1;
        break;
    case 2: // Switch entity every couple seconds 
        if (hitTimer mod 140 == 90 || !target)
        {
            select = 2;
        }
        break;
    case 3: // Do nothing 
        break;
    case 4: // Pick once, never switch 
        if (!target)
        {
            select = 2;
        }
        break;
}

if (select) // Select a new target
{
    var dist = 1000;
    var pick = 0;
    with (prtEntity)
    {
        if (!dead)
        {
            if (isTargetable && canHit && id != other.id)
            {
                if (global.factionStance[other.faction, faction])
                {
                    if (select == 1) // Select based on the distance
                    {
                        if (other.behaviourType == 0) // Select nearest
                        {
                            pick = point_distance(x, y, other.x, other.y) < dist - 10
                                || (point_distance(x, y, other.x, other.y) < dist && !random(1));
                        }
                        else // Select nearest at every step
                        {
                            pick = point_distance(x, y, other.x, other.y) < dist;
                        }
                        
                        if (pick)
                        {
                            other.target = id;
                            dist = point_distance(x, y, other.x, other.y);
                        }
                    }
                    else // Choose at random
                    {
                        pick = random(999);
                        if (pick < dist)
                        {
                            other.target = id;
                            dist = pick;
                        }
                    }
                }
            }
        }
    }
}
