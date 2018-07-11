/// rectangleIntersectionType(xa1, ya1, xa2, ya2, xb1, yb1, xb2, yb2)
// returns any of the following values:
// 1: rectangles are equal
// 2: A contains B
// 3: B contains A
// 4 and up: partial overlap

// meeting at a single line segment does not count as intersection

var ax1 = argument0;
var ay1 = argument1;
var ax2 = argument2;
var ay2 = argument3;
var bx1 = argument4;
var by1 = argument5;
var bx2 = argument6;
var by2 = argument7;

// no overlap
if (ax2 <= bx1 || ax1 >= bx2 || ay2 <= by1 || ay1 >= by2)
    return 0;

// equal
if (ax1 == bx1 && ax2 == bx2 && ay1 == by1 && ay2 == by2)
    return 1;

// A >= B
if (ax1 <= bx1 && ax2 >= bx2 && ay1 <= by1 && ay2 >= by2)
    return 2;

// B >= A
if (ax1 >= bx1 && ax2 <= bx2 && ay1 >= by1 && ay2 <= by2)
    return 3;

// partial overlap
return 4;
