/// parallaxObjectAddLayer(bgfile, parallaxX, parallaxY, xspd, yspd, wrapX, wrapY, [offXAbs], [offYAbs], [offXRel], [offYRel], [animspd], [bgX], [bgY], [bgW], [bgH], [bgResourceType])

//adds a layer of parallax to objCompoundParallax
//use only in the cc of an objCompoundParallax

/*
argument definitions:
bgfile: 
    the resource index of the file you want the layer to use 
    (e.g. bgStarFieldBackground, sprPooker)

parallaxX, parallaxY: 
    how fast the layer moves horizontally compared to the foreground. 
    1 is the same as the foreground, 1/2 is half the speed of the foreground, 
    2 is twice the speed of the foreground

xspd, yspd: 
    how fast the layer moves horizontally per frame, independent of the parallax motion.

wrapX, wrapY: 
    if set to true, the provided resource wil be repeated infinitely along this axis
    otherwise, it will only be drawn once

offXAbs, offYAbs:
    moves the position of the resource by this amount
    absolute offset means it is unaffected by the parallax value.

offXRel, offYRel:
    moves the position of the resource by this amount
    relative offset means this value is affected by the parallax value, 
    so a relative offset of 10 and a parallax of 0.5 would be 5 pixels of offset
    
animspd:
    the image_speed applied to the provided resource
    only works if the layer's resourceType is a sprite

bgX, bgY, bgW, bgH:
    allows you to specify that only part of the provided resource file be used for the layer
    the x and y are for the top-left corner of the area
    if not set, defaults to the full frame of the resource

bgResourceType:
    the type of resource the provided resource index is.
    1 = background, 2 = sprite, 3 = surface.
    usually automatically determined, but you can set it yourself if you want
*/


//code starts here

//make sure we're being called from the correct place
assert(object_index == objCompoundParallax && event_type == 14, //i checked event_type from within cc and it returned 14. who knows what the proper macro for that is
    "addLayer script called in an inappropriate way");

var i = layersIndex;

//add relative values to the absolute ones
if (argument_count > 11)
{
    argument[7] += argument[9] * argument[1];
    argument[8] += argument[10] * argument[2];
}

//plug variables from the 1d array 'arguments' into a row of 2d array 'layers',
//omitting the relative offsets
var args = argument_count - ((argument_count > 7) * 2);
for (var a = 0; a < args; a++;)
{
    var add = ((a > 8) * 2);
    layers[i, a] = argument[a + add];
}

//autofill optional arguments, if needed
var myBG = argument[0];
if argument_count < 17 //unspecified bgfiletype: same autodetect as original objParallax
{                      //the auto bg size detect relies on the filetype, so this has to run first
    if (background_exists(myBG))
        layers[i, 14] = 1;
    else if (sprite_exists(myBG))
        layers[i, 14] = 2;
    else if (surface_exists(myBG))
        layers[i, 14] = 3;
}
switch argument_count
{
    case 7:     //unspecified offsets: default 0
    case 8:
    case 9:
    case 10:
        layers[i, 7] = 0;
        layers[i, 8] = 0;
    //since there are no 'break;' commands, the code will continue to all cases below
    
    case 11:    //unspecified animspd: defualt 0
        layers[i, 9] = 0;
    
    case 12:    //unspecified bg size: default full resource
    case 13:
    case 14:
    case 15:
    layers[i, 10] = 0;
    layers[i, 11] = 0;
    switch (layers[i, 14])
    {
        case 1: // background: 
            layers[i, 12] = background_get_width(myBG);
            layers[i, 13] = background_get_height(myBG);
            break;
        case 2: // sprite: 
            layers[i, 12] = sprite_get_width(myBG);
            layers[i, 13] = sprite_get_height(myBG);
            break;
        case 3: // surface 
            layers[i, 12] = surface_get_width(myBG);
            layers[i, 13] = surface_get_height(myBG);
            break;
    }
}

//other per-layer variables:
layers[i, 15] = 0;  //image_index for sprite layers

//next time this is called, it should add to the next layer over
layersIndex++;

/*
final result:
0   bgfile
1   parallaxX
2   parallaxY
3   xspd
4   yspd
5   wrapx
6   wrapy
7   offsetX
8   offsetY
9   animspd
10  bgX
11  bgY
12  bgW
13  bgH
14  bgfiletype
15  image_index
*/
