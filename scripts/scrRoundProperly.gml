/// scrRoundProperly(num)

if (abs(argument0) - floor(abs(argument0)) < 0.5)
{
    return floor(argument0);
}
else
{
    return ceil(argument0);
}
