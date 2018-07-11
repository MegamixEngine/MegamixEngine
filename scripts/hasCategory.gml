/// hasCategory(categories, category)
// returns true if `category` is in the given categories list

// check each comma-separated value

// early-out
if (string_pos(argument1, argument0) == 0)
    return false;

// precise check
var catArray = stringSplit(argument0, ",", true);
return (indexOf(catArray, argument1) != -1);
