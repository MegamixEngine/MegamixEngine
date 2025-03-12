var t, n;
t = argument[0]
n = argument[1]
if (t < 0.5)
    return (power(2, max(0, (n - 1))) * power(t, max(0, n)));
else
    return (1 - (power(((-2 * t) + 2), n) / 2));
