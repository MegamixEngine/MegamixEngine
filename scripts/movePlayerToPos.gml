///movePlayerToPos(xPos, [endDir], [lenience], [speed])

if (!instance_exists(target))
{
    return false;
    exit;
}

var endDir = 1;
if (argument_count > 1)
    endDir = argument[1];

var lenience = 4;
if (argument_count > 2)
    lenience = argument[2];
    
var spd = target.walkSpeed;
if (argument_count > 3)
    spd = argument[3];
    
if (abs(target.x - argument[0]) >= lenience)
{
    dispelUtilities();
    
    with (target)
    {
        if (x > argument[0])
            image_xscale = -1;
        else
            image_xscale = 1;    
                    
        xspeed = spd * image_xscale;
        stepTimer = stepFrames;
        fanoutDistance = 1;
    }
    
    return false;
}
else
{
    with (target)
    {
        image_xscale = endDir;
        xspeed = 0;
        fanoutDistance = 0;
        x = argument[0];
    }
    
    return true;
}
