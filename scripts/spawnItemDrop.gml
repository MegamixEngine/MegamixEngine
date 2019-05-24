/// spawnItemDrop([myItem], [x], [y])

// returns the object spawned, or returns -1 if no object was spawned.

// if "myItem" ==  0 --> regular drop
// if "myItem" == -1 --> drop nothing
// if "myItem" >   0 --> object_index of the object to spawn

// Use x and y to specify exactly where the item will spawn. If they aren't set then it will
// spawn in the center of the hitbox of the object that called this script.

// arguments

_myItem = 0;
_x = x;
_y = y;

if (argument_count > 0)
{
    _myItem = argument[0];
}

if (argument_count > 1)
{
    _x = argument[1]
}

if (argument_count > 2)
{
    _y = argument[2];
}

// Random drop rates (credit to Blyka)
// randomize();

if (_myItem >= 0)
{
    var item = _myItem;
    
    if (item == 0)
    {
        if (!irandom(4096)) // The shiniest shiny of all shinies
        {
            item = objYashichi;
        }
        else
        {
            var randItem = floor(random(600));
            randItem *= 1 - (global.dropUpgrade * 0.33) - (global.converter * 0.1);
            
            if (randItem < 4)
            {
                item = objLife;
            }
            else if (randItem < 45)
            {
                item = choose(objLifeEnergyBig, objWeaponEnergyBig);
            }
            else if (randItem < 120)
            {
                item = choose(objLifeEnergySmall, objWeaponEnergySmall, objBoltBig);
            }
            else if (randItem < 240)
            {
                item = objBoltSmall;
            }
        }
    }
    
    if (item > 0)
    {
        var i = instance_create(_x, _y, item);
        i.respawn = false;
        
        if (argument_count <= 1)
        {
            i.x += bboxGetXCenter() - bboxGetXCenterObject(i);
        }
        
        if (argument_count <= 2)
        {
            i.y += bboxGetYCenter() - bboxGetYCenterObject(i);
        }
        
        i.disappear = disappearTime;
        
        if (i.grav != 0)
        {
            i.yspeed = -2;
        }
        
        with (i)
        {
            if (other.script != scrNoEffect)
            {
                script_execute(other.script);
            }
            
            if (other.code != "")
            {
                stringExecutePartial(other.code);
            }
        }
        
        return i;
    }
}

return -1;
