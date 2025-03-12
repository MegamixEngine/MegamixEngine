///entityCreateChild(x, y, obj)

// x - spawn-offset from the parent's x-value
// y - spawn-offset from the parent's y-value
// obj - object-index of the child

var _x = argument[0];
var _y = argument[1];
var _obj = argument[2];

//if (argument_count > 3)
//{
//}

// - - - - - - - - - - - - - - - - - - - - - - - -

//Get position
_x = x + (_x * image_xscale);
_y = y + (_y * image_yscale);

//Create child
var _i = instance_create(_x, _y, _obj);

// - - - - - - - - - - - - - - - - - - - - - - - -

//Set/copy some variables
if (instance_exists(_i))
{
    with(_i)
    {
        respawn = false;
        
        parent = other;
        faction = other.faction;
        target = other.target;
        
        image_xscale = other.image_xscale;
        image_yscale = other.image_yscale;
        image_angle = other.image_angle;
        
        inWater = other.inWater;
        stopOnFlash = other.stopOnFlash;
    }
    
    return(_i);
}
else
{
    return(-1);
}

