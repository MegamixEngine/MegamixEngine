// easeInOutSine(t, n)
// t represents progress of animations in bounds 0 (start) and 1 (end)

var t = argument[0];

//return function
return (1 - cos(pi*t))/2;
