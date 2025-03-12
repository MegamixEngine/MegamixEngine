/// easeInOutBack(t, c = 1.70158)
var t = argument[0];
var c; if (argument_count > 1) c = argument[1]; else c = 1.70158;

c *= 1.525;

if (t < 0.5)
    return (power(2 * t, 2) * ((c + 1) * 2 * t - c)) / 2;
else
    return (power(2 * t - 2, 2) * ((c + 1) * (t * 2 - 2) + c) + 2) / 2;
