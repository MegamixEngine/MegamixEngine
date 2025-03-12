/// repeatExplosion(xDelta, yDelta, [timer], [frequency], [itemDrop], [width], [height], [explosionObject], [enemySprite], [set enemy frame], [soundEffect], [expldsprite_index], [item time], [primary pal], [blend? minus = nespalette], [secondary pal])
//creates a repeating explosion effect
var inst = instance_create(x+argument[0], y+argument[1], objRepeatExplosion);

with inst
{
    
    xOffset = argument[0];
    yOffset = argument[1]; 
    if (object_get_parent(other) == prtEntity)
        parentHealthPointsStart = other.healthpointsStart;
    
    image_xscale = other.image_xscale;
    image_yscale = other.image_yscale;
    
    if (argument_count > 2)
    {
        deathTimer = argument[2];
    }
    if (argument_count > 3)
    {
        frequency  = argument[3];
    }
    if (argument_count > 4)
    {
        itemDrop = argument[4];
    }
    if (argument_count > 5)
    {
        width = argument[5];
    }
    if (argument_count > 6)
    {
        height = argument[6]; 
    } 
    if (argument_count > 7)
    {
        explosionObject = argument[7];
    }    
    if (argument_count > 8)
    {
        if (argument[8] != 0)
            enemySprite = argument[8];
        else
            enemySprite = other.sprite_index;
    }
    else
    {
        enemySprite = other.sprite_index;
    }
    if (argument_count > 9)
    {
        currentFrame = argument[9];
    }
    else
    {
        currentFrame = other.image_index;
    }
    if (argument_count > 10)
    {
        soundEffect = argument[10];
    }
    if (argument_count > 11)
    {
        explosionSprite = argument[11];
    }
    if (argument_count > 12)
    {
        disappearTime = argument[12];
    }
    
    //if sprite index = sprExplosionClassic, then use palette. This variable also doubles up as img_blend below
    if (argument_count > 13)
        myPal[0] = argument[13];
        
    if (argument_count > 14) // if minus, pull from imgblend. use -55 for colour 0.
    {
        if (argument[13] >= 1)
            image_blend = argument[14];
        else if (argument[14] <= -55)
            image_blend = global.nesPalette[abs(argument[0])]
        else if (argument[14] <= -1)
            image_blend = global.nesPalette[abs(argument[14])]
        else
            image_blend = c_white;
    }

    if (argument_count > 15) 
        myPal[1] = argument[15];

}

return inst;
