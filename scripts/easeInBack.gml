/// easeInBack(t, c = 1.70158)
var t = argument[0];
var c; if (argument_count > 1) c = argument[1]; else c = 1.70158;

return (c + 1) * power(t, 3) - c * power(t, 2);
