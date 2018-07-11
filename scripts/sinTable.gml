/// sinTable(angleInDegrees);

// This is useful for nes-like movement.

/* NOTES:
    - This is not faster than normal sin calculations. Game Maker Studio calculates
        sin faster than it can run a script. GML just has too much overhead.
    - Table values assume a conversion to radians. So sinTable(15) is the same as
        sin(degtorad(15 ))*/

var _angleInDegrees = argument[0];

// restrict angle
// restrict angle
_angleInDegrees = modf(_angleInDegrees, 360);

// return value
_tableIndex = round(_angleInDegrees * ds_list_size(global.sinTableID) / 360); // convert into the closest table index
return ds_list_find_value(global.sinTableID, _tableIndex);
