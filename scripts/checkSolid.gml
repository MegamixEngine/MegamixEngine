/// checkSolid(deltaX, deltaY,[noSlopeConditions],[alwaysCheckSolids])
// Check for solid if placed at the given offset from the current (x,y) coords
// noSlopeConditions: default false
// alwaysCheckSolids: defaul false, if true, solid entities will be detected even if the object calling the script is already colliding with it

var _xs = argument[0];
var _ys = argument[1];
var noSlopeConditions = false;
var alwaysCheckSolids = false;
if (argument_count > 2)
    noSlopeConditions = argument[2];
if (argument_count > 3)
    alwaysCheckSolids = argument[3];
var myid = id;

// Set the direction of gravity
var cgrav = sign(grav);
if (object_index == objMegaman)
{
    cgrav = gravDir;
}
cgrav += (cgrav == 0);

with (objSolid)
{
    solid = (isSolid == 1);
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

if (dieToSpikes)
{
    if(!alwaysCheckSolids)
    {
        var spSolid = (canHit && iFrames != 0);
        with (objSpike)
        {
            solid = spSolid;
        }
    }
} 

// jumpthrough objects
with (objTopSolid)
{
    if (isSolid)
    {
        if (!place_meeting(x, y + cgrav, myid))
        {
            if (place_meeting(x - _xs, y - cgrav * abs(_ys), myid))
            {
                solid = 1;
            }
        }
    }
}

with (prtEntity)
{
    if (!dead && id != myid)
    {
        if (isSolid)
        {
            if (alwaysCheckSolids || object_index == objBossDoor || object_index == objBossDoorVertical || !place_meeting(x, y + cgrav, myid))
            {
                if (isSolid != 2 || place_meeting(x - _xs, y - cgrav * abs(_ys), myid))
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

// If you don't know, place_free checks for if you're touching an object flagged with the default
// 'solid' variable. That's why everything is set as solid here and then set back to 0 afterwards.
var ret = 1;
if (place_free(x + _xs, y + _ys))
{
    ret = 0;
}
else if (!noSlopeConditions && _xs != 0 && _ys == 0)
{
    if (place_free(x + _xs, y + min(4, ceil(abs(_xs)) * MAX_SLOPE))
        || place_free(x + _xs, y - max(-4, ceil(abs(_xs)) * MAX_SLOPE)))
    {
        ret = 0;
    }
}
with(all)
{
    solid=0;
}

return (ret);
