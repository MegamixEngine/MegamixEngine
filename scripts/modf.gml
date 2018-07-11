/// modf(x, [d])
// computes floating-point modulo
// d: divisor. Default: 1.
// guaranteed to return non-negative number.

var _x = argument[0];
var _d = 1;
if (argument_count > 1)
{
    _d = abs(argument[1]);
}

if (_d == 0)
{
    return 0;
}

return _x - floor(_x / _d) * _d;
