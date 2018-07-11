/// decreaseMagnitude(x, amount)
// returns x plus-or-minus amount, whichever brings it closer to 0.
// returns 0 if abs(x) < amount

var _x = argument0;
var _a = argument1;

if (abs(_x) < abs(_a))
{
    return 0;
}
else
{
    return _x - sign(_x) * abs(_a);
}
