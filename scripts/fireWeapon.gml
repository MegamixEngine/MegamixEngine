/// fireWeapon(x value,y value,object,limit,energy cost,type (0 none; 1 shoot; 2 throw),stop movement?);
/*
fireWeapon(18,0,objBusterShot,3,0,1,0);

argument0 = x value
argument1 = y value
argument2 = the object to fire
argument3 = bullet limit
argument4 = energycost
argument5 = shoot, throw, etc. (0 = no shoot frame)
argument6 = stop movement
*/

var xs, ys, wobj, limit, cost, frame, _canwalk, i;
xs = argument0;
ys = argument1;
wobj = argument2;
limit = argument3;
cost = argument4;
frame = argument5;
stopit = argument6;

if (limit > 0) // Checks bullet limit
{
    with (prtPlayerProjectile)
    {
        if (parent == other.id)
        {
            limit -= bulletLimitCost;
            if (!limit)
            {
                return noone;
            }
        }
    }
}

// Checks if enough weapon energy
if (cost > 0)
{
    var current = global.weapon[playerID];
    if (global.ammo[playerID, current] <= 0)
    {
        return noone;
    }
    global.ammo[playerID, current] = max(0,
        global.ammo[playerID, current] - cost / (global.energySaver + 1));
}

if (climbing)
{
    image_xscale = climbShootXscale;
}

// Shoot or throw
shootTimer = 0;
isShoot = frame;
shootStandStillLock = lockPoolRelease(shootStandStillLock);
if (stopit)
{
    xspeed = 0;
    shootStandStillLock = lockPoolLock(localPlayerLock[PL_LOCK_MOVE]);
}

if (!ground && (isShoot < 3))
{
    xs -= 5;
}

// Bullet position
ys += 4;
if (climbing)
{
    image_xscale = climbShootXscale;
    ys -= 2;
}
else if (!ground)
{
    ys -= 5;
}

if (instance_exists(vehicle))
{
    ys = vehicle.shootYOffset;
}

// Spawn the bullet
i = instance_create(x + (xs * image_xscale), y + (ys * image_yscale), wobj);

if (instance_exists(i))
{
    i.parent = id;
    i.image_xscale *= image_xscale;
    i.image_yscale *= image_yscale;
    
    return (i);
}

return noone;
