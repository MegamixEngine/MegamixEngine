/// drawEXT(sprite index, image_index, [x], [y], [xscale], [yscale], [image angle], [image blend], [image_alpha])
//shorthand version of draw_sprite_ext that replaces some of the required items with optional ones
var sprI = argument[0];
var imgI = argument[1];
var xOff = 0;
var yOff = 0;
var xS = image_xscale;
var yS = image_yscale;
var rot = image_angle;
var blend = image_blend;
var alpha = image_alpha;

if (argument_count > 2)
    xOff = argument[2];
    
if (argument_count > 3)
    yOff = argument[3];
    
if (argument_count > 4)
    xS = argument[4];
    
if (argument_count > 5)
    yS = argument[5];
    
if (argument_count > 6)
    rot = argument[6];
        

if (argument_count > 7)
    blend = argument[7];
    
if (argument_count > 8)
    alpha = argument[8];
    
    

draw_sprite_ext(sprI, imgI, xOff, yOff, xS,
    yS, rot, blend, alpha);
