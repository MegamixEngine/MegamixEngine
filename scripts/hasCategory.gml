///hasCategory(categories, category)
// returns true if `category` is in the given categories list

// check each comma-separated value

var _toCheck = argument[0];
var _checkFor = argument[1];

// early-out
if (string_pos(_checkFor, _toCheck) == 0)
{
    return false;
}

// precise check
var _array = stringSplit_Proper(_toCheck, ",", true);

return (indexOf(_array, _checkFor) != -1);

