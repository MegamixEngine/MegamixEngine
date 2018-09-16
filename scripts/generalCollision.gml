/// generalCollision([noSlopeEffect])
// Handles general collision
// isSolid = 0 - no collision, 1 = collision, 2 = topsolid collision, 3 = ignore mega man

xcoll = 0;
ycoll = 0;

var myid = id;
var xprev = x;
var noSlopeEffect = false;

if (argument_count > 0 && argument[0])
{
    noSlopeEffect = true;
}


// Set the direction of gravity
var cgrav = sign(grav);

if (object_index == objMegaman)
{
    cgrav = gravDir;
}
cgrav += (cgrav == 0);

// Set stuff solid according to the isSolid variable
with (objSolid)
{
    solid = (isSolid>0);
}

with (prtEntity)
{
    if (!dead && id != myid)
    {
        if (isSolid == 1)
        {
            if (object_index == objBossDoor || object_index == objBossDoorVertical || !place_meeting(x, y, myid))
            {
                if (!fnsolid)
                {
                    solid = 1;
                }
                else
                {
                    solid = !global.factionStance[faction, other.faction];
                    if (fnsolid == 2)
                    {
                        solid = !solid;
                    }
                }
            }
        }
    }
}

// Stoppers are only solid for the object_index they have stored
with (objGenericStopper)
{
    solid=0;
    if (other.object_index == objectToStop || object_is_ancestor(other.object_index, objectToStop))
    {
        solid = 1;
    }
}

if (dieToSpikes) // Handle dying to spikes
{
    // the solidity of spikes depends on whether or not
    // we are hitstunned.
    var spSolid = (canHit && iFrames != 0);
    with (objSpike)
    {
        solid = spSolid;
    }
}

// Horizontal collision
if (xspeed != 0)
{
    var slp = (ceil(abs(xspeed)) * MAX_SLOPE * cgrav) * (yspeed * cgrav <= 0);

    // make semisolids solid if they can be used as a slope
    if (slp != 0)
    {
        with (objTopSolid)
        {
            solid=0;
            if (place_meeting(x - other.xspeed, y, myid))
            {
                if (!place_meeting(x - other.xspeed, y + slp, myid)
                    && !place_meeting(x, y, myid))
                {
                    solid = 1;
                }
            }
        }

        with (prtEntity)
        {
            if (!dead)
            {
                if (isSolid == 2)
                {
                    if (place_meeting(x - other.xspeed, y, myid))
                    {
                        if (!place_meeting(x - other.xspeed, y + slp, myid)
                            && !place_meeting(x, y, myid))
                        {
                            if (!fnsolid)
                            {
                                solid = 1;
                            }
                            else
                            {
                                solid = !global.factionStance[faction, other.faction];
                                if (fnsolid == 2)
                                {
                                    solid = !solid;
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    x += xspeed;

    // check for collision
    if (!place_free(x, y))
    {
        // horizontal collision clears fractional component of x position
        x = round(x);

        // move back outsie of the object while overlapping.
        xcoll = sign(xspeed) * -0.5;
        repeat (max(32, abs(xspeed) * 4))
        {
            if (!place_free(x, y))
            {
                x += xcoll;
            }
            else
            {
                break;
            }
        }


        // this value can be read by object logic later.
        xcoll = xspeed;

        // cancel x velocity.
        xspeed = 0;

        // Slope code
        if (!noSlopeEffect)
        {
            if (xcoll != 0)
            {
                // slopes only affect entities on the ground
                if (slp != 0)
                {
                    var xsl = xcoll - (x - xprev);
                    if (sign(xcoll) == sign(xsl))
                    {
                        for (var _i = 1; _i <= ceil(abs(xsl)) * MAX_SLOPE; _i += 1)
                        {
                            if (place_free(x + xsl, y - _i))
                            {
                                x += xsl;
                                y -= _i;
                                xspeed = xcoll;
                                xcoll = 0;
                                break;
                            }
                            else if (place_free(x + xsl, y + _i))
                            {
                                x += xsl;
                                y += _i;
                                xspeed = xcoll;
                                xcoll = 0;
                                break;
                            }
                        }
                    }
                }
            }
        }
    }
}

// Vertical collision
if (yspeed != 0)
{
    // jumpthrough objects beneath us are solid
    if (yspeed * cgrav > 0)
    {
        with (objTopSolid)
        {
            solid = 0;
            if (isSolid)
            {
                if (!place_meeting(x, y, myid))
                {
                    solid = 1;
                }
            }
        }
    }

    with (prtEntity)
    {
        if (!dead)
        {
            if (isSolid == 2)
            {
                solid = 0;
                if ((sign(y-other.y) == cgrav) && (place_meeting(x,y-other.yspeed-cgrav,myid) || place_meeting(x,y-2*cgrav,myid))&&(!place_meeting(x,y,myid)))
                {
                    if (!fnsolid)
                    {
                        solid = 1;
                    }
                    else
                    {
                        solid = !global.factionStance[faction, other.faction];
                        if (fnsolid == 2)
                        {
                            solid = !solid;
                        }
                    }
                }
            }
        }
    }

    y += yspeed;

    // check for collision
    if (!place_free(x, y))
    {
        // clear fractional component of y (for floating point stability)
        y = round(y);

        // move back until no longer overlapping with the solid.
        ycoll = sign(yspeed) * -1;
        repeat (max(32, abs(yspeed) * 4))
        {
            if (!place_free(x, y))
            {
                y += ycoll;
            }
            else
            {
                break;
            }
        }

        // these values can be read by object logic later
        ycoll = yspeed;
        if (yspeed * cgrav > 0)
        {
            ground = true;
        }

        // cancel out y-velocity
        yspeed = 0;
    }
}

// solid objects one can stand inside of, like quicksand:
if (!ground && sinkin)
{
    if (place_meeting(x, y + cgrav, objStandSolid))
    {
        if (yspeed * cgrav > 0)
        {
            ground = true;
            ycoll = yspeed;
            yspeed = 0;
        }
    }
}

if (dieToSpikes)
{
    // don't hit MM if he's teleporting in lol
    if (object_index == objMegaman)
    {
        if (teleporting || showReady)
        {
            exit;
        }
    }

    if (!spSolid) // spikes caused death
    {
        spSolid = instance_place(x, y, objSpike);
        if (spSolid)
        {
            global.damage = spSolid.contactDamage;
            healthpoints -= global.damage;

            if (healthpoints <= 0)
            {
                event_user(EV_DEATH);
            }
            else
            {
                x = xprevious;
                y = yprevious;
                event_user(EV_HURT);
            }
        }
    }
}
with(all)
{
    solid=0;
}
