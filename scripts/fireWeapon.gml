/// fireWeapon(x value,y value,object,limit,energy cost,type (0 none; 1 shoot; 2 throw),stop movement? (0 no; 1 non-ice ground; 2 all));
/*
fireWeapon(18,0,objBusterShot,3,0,1,0);

argument0 = x value
argument1 = y value
argument2 = the object to fire
argument3 = bullet limit
argument4 = energycost
argument5 = shoot, throw, etc. (0 = no shoot frame)
argument6 = stop movement (0 = false, 1 = Yes except on non-ice ground, 2 = Yes All)
*/

var xs, ys, wobj, limit, cost, frame, stopit;
xs = argument[0];
ys = argument[1];
wobj = argument[2];
limit = argument[3];
cost = argument[4];
frame = argument[5];
stopit = argument[6];

if (limit > 0 && (checkCheats(cheatEnums.noBulletLimits) <= 0)) // Checks bullet limit
{
    var checkObj = prtPlayerProjectile;
    if (checkCheats(cheatEnums.lingeringWeapons))//ZCombos linger.
    {
        checkObj = wobj;
    }

    with (checkObj)
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

if ((checkCheats(cheatEnums.lingeringWeapons)) && instance_exists(myTrebleBoost))
{
    frame = 1;
}

// Checks if enough weapon energy
if (cost > 0)
{
    var current = global.weapon[playerID];
    
    if (ceil(global.ammo[playerID, current]) <= 0)
    {
        return noone;
    }
    
    ammoDecrease(playerID, cost);
}

if (climbing)
{
    if (image_xscale != climbShootXscale)
    {
        // alternate climbing frame so the player's legs don't switch
        climbSpriteTimer = (climbSpriteTimer + 8) mod 16;
    }
    
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
/*
if (!ground && (isShoot < 3))
{
    xs -= 5;
}*/

//Starting in Megamix 1.9, costumes have been adjusted such that the sprite offsets are accurate to MM6/9/10, as have their busters.
// Bullet position
ys += 4;

// if we're not shooting Ice Wall then increase it (ice wall requires to be at a specific place to work properly)
// also magnet beam
if (wobj != objIceWall && wobj != objMagnetBeam && wobj != objSaltWater && wobj != objConcreteShot && wobj != objWaterWave) 
{
    ys += global.costumeShotOffset[costumeID];
}
if (climbing)
{
    image_xscale = climbShootXscale;
    //ys -= 2;
}
else if (!ground)
{
    //ys -= 1;//5; Previous value.
}

if (instance_exists(vehicle))
{
    if (global.characterSelected[playerID] == CHAR_BASS) && (vehicle.object_index == objMegaman8Sled)
        ys = argument[1] + vehicle.shootYOffset;
    else
        ys = vehicle.shootYOffset;
}

// Spawn the bullet
var i = instance_create(x + (xs * image_xscale), y + (ys * image_yscale), wobj);

if (instance_exists(i))
{
    i.parent = id;
    
    i.image_xscale *= image_xscale;
    i.image_yscale *= image_yscale;
    if (checkCheats(cheatEnums.hugeWeapons)) //Note: A large number of weapons will probably need adjustments on a case-by-case basis for this.
    {
        i.image_xscale *= 4;
        i.image_yscale *= 4;
    }
    
    autoFireDelay = i.autoFireSet;
    lastWeapon = i.object_index;
    return (i);
}

return noone;
