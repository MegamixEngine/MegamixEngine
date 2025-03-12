/// checkGround([noSlopeEffect])
var noSlopeEffect = false;
if (argument_count > 0 && argument[0])
    noSlopeEffect = true;

/// Checks for ground
if (!ground)
{
    exit;
}

// free-floating entities are never grounded
if (!blockCollision)
{
    ground = 0;
    exit;
}

var myid = id;

// Determine gravity direction
var cgrav = sign(grav);
if (object_index == objMegaman)
{
    cgrav = gravDir;
}
cgrav += (cgrav == 0);

var slp = ceil(abs(xspeed) + 1 + (object_index == objMegaman));

// Enable the solid flag in all solid objects to exploit
// game maker's built-in collision detection.
with (objSolid)
{
    solid = (isSolid == 1);
}

// Stoppers are only solid for the object_index they have stored
with (objGenericStopper)
{
    solid=0;
    if(isGround)
    {
        if (other.object_index == objectToStop || object_is_ancestor(other.object_index, objectToStop))
        {
            solid = 1;
        }
    }
}
if (dieToSpikes) // entities with this variable set to "true" die when coming in contact with spikes
{
    // spikes become solid when hitstunned
    var spSolid = (canHit && iFrames != 0);
    with (objSpike)
    {
        solid = spSolid;
    }
}

// topsolids are only solid if they are beneath us
with (objTopSolid)
{
    solid=0;
    if (isSolid == 1)
    {
        if (!place_meeting(x, y + cgrav, myid))
        {
            if (place_meeting(x, y - cgrav * slp, myid))
            {
                solid = 1;
            }
        }
    }
}

// standsolids are solids one can stand inside of (e.g. quicksand)
// for the purposes of detecting ground, there is
// no difference between these and other solids.
with (objStandSolid)
{
    solid = 1;
}

// some entites act as solids themselves.
with (prtEntity)
{
    solid=0;
    if (!dead && id != myid)
    {
        if (isSolid)
        {
            if (!place_meeting(x, y + cgrav, myid))
            {
                if (isSolid != 2 || place_meeting(x, y - cgrav*slp, myid))
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

// Check for solid objects / slope effect
if (place_free(x, y))
{
    var _i;
    for (_i = 1; _i <= slp; _i += 1)
    {
        if (place_free(x, y + cgrav * _i)) // There is nothing solid below us?
        {
            ground = false;
            if object_index == (objMegaman)
            {
                if jumpCounter == 0
                {
                    jumpCounter += 1;
                    if (global.characterSelected[playerID] == CHAR_BASS && isSlide)
                    {
                        dashJumped = true;
                    }
                }
            }
        }
        else if (yspeed * cgrav >= 0) // There is something solid below us! Lower position to stay grounded if necessary
        {
            ground = true;
            y += cgrav * (_i - 1);
            break;
        }
        if (noSlopeEffect)
        {
            break;
        }
    }
}

with(all)
{
    solid=0;
}
