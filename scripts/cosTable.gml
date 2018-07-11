/// cosTable(angleInDegrees, [interpolate]);

// This is useful for nes-like movement.

/* NOTES:
    - This is not faster than normal cos calculations. Game Maker Studio calculates
        cos faster than it can run a script. GML just has too much overhead.
    - Table values assume a conversion to radians. So cosTable(15) is the equivalant
        of cos(degtorad(15 ))*/

var _angleInDegrees = argument[0];
var _interpolate = false;

if (argument_count > 1)
{
    _interpolate = argument[1];
}

// restrict angle
_angleInDegrees = modf(_angleInDegrees + 90, 360);

// return value
_tableIndex = round(_angleInDegrees * ds_list_size(global.sinTableID) / 360); // convert into the closest table index
return ds_list_find_value(global.sinTableID, _tableIndex);
