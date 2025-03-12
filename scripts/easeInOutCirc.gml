/// easeInOutCirc(t)
var t = argument0;
if (t < 0.5)
    return (1 - sqrt(1 - power(2 * t, 2))) / 2;
else
    return (sqrt(1 - power(-2 * t + 2, 2)) + 1) / 2;
