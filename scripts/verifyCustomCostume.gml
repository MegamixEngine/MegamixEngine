/// verifyCustomCostume(verifyFilename)
// Checks the costume to see if it's usable without actually loading it as the costume. 

var verifyFilename = argument0;

var tempSprite = customCostume_AutogenWhitemasks(verifyFilename);
var error = 0;

if (global.customCostumePixelSurface == noone || 
    !surface_exists(global.customCostumePixelSurface))
{
    global.customCostumePixelSurface = mm_surface_create(1,3);
}

if (is_undefined(tempSprite) || !sprite_exists(tempSprite))
{
    if (sprite_exists(tempSprite))
    {
        sprite_delete(tempSprite);
    }
    error = -1;
    print("invalid sprite");
    return error;
}
if (sprite_get_width(tempSprite) != sprite_get_width(sprRockman) || 
    sprite_get_height(tempSprite) != sprite_get_height(sprRockman))
{
    print("image has different dimensions: " + 
        string(sprite_get_width(tempSprite)) + "," + 
        string(sprite_get_height(tempSprite)));
    print("expected: " + string(sprite_get_width(sprRockman)) + "," + 
        string(sprite_get_height(sprRockman)))
    sprite_delete(tempSprite);
    error = -2;
    return error;
}

sprite_delete(tempSprite);

return error;
