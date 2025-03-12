/// getNameOfColor(color)
//Returns a the simplest form of a color's name. Contains the color wheel, monochrome colors, and 5 extra.
//Note: Uses American spelling system. Replace gray as necessary.
var red = color_get_red(argument[0]);
var green = color_get_green(argument[0]);
var blue = color_get_blue(argument[0]);
var colorName;
var closestDistance = 195075;//Max distance (255^2 + 255^2 + 255^2) for comparison.

//List of predefined colors and their RGB values.
var colorList = makeArray(
    //Color wheel.
    makeArray("red", 255, 0, 0),
    makeArray("blue", 0, 0, 255),
    makeArray("yellow", 255, 255, 0),
    makeArray("green", 0, 255, 0),
    makeArray("orange", 255, 128, 0),
    makeArray("purple", 128, 0, 128),
    
    //Extra colors. Not part of the normal color wheel but weird if only ID'd by above.
    makeArray("pink",255,0,255),//RGB Extreme.
    makeArray("cyan",0,255,255),//RGB Extreme.
    makeArray("brown",128,64,0),//Mixture of all colors in paint.
    makeArray("teal",0,128,128),//Not truly cyan but not any other color really.
    makeArray("indigo",64,0,128),//Somewhat rare and could easily be called blue, but Sunstar is using it anyhow.
    makeArray("maroon",128,0,0),//Last color I can think of that'd stand out.
    
    //Uniform colors (RGB should typically be all the same or close).
    makeArray("gray", 128, 128, 128),
    makeArray("white", 255, 255, 255),
    makeArray("black", 0, 0, 0)
    
);

//Loop through the predefined colors and find the closest match.
for (var i = 0; i < array_length_1d(colorList); i++)
{
    var colorData = colorList[i];
    var r = colorData[1];
    var g = colorData[2];
    var b = colorData[3];

    var distance = (r - red) * (r - red) + (g - green) * (g - green) + (b - blue) * (b - blue);
    
    //If the distance is smaller than the previous closest, update the color name.
    if (distance < closestDistance)
    {
        closestDistance = distance;
        colorName = colorData[0];
    }
}

return colorName;
