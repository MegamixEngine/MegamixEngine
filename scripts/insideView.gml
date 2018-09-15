/// insideView([x],[y],[pointCheck],[range])
// Returns true if the object is inside the view at the specified coordinates, and false if not.
// if pointCheck is true, the given coordinates will be tested instead of the object
// if not doing a point check, if range will be used as a margin
// This script only works for view 0.

var _x = x;
var _y = y;
var _pch = false;
var _rr = 0;

if(argument_count>0)
{
    _x=argument[0];
}
if(argument_count>1)
{
    _y=argument[1];
}
if(argument_count>2)
{
    _pch=argument[2];
}
if(argument_count>3)
{
    _rr=argument[3];
}


if (_pch)
{
    return (_x >= view_xview[0] && _y > view_yview[0] && _x <= view_xview[0] + view_wview[0] && _y <= view_yview[0] + view_hview[0]);
}
else
{
    var __x = x;
    var __y = y;
    x = _x;
    y = _y;
    var result = (bbox_right + _rr >= view_xview[0] && bbox_left - _rr  <= view_xview[0] + view_wview[0] && bbox_bottom + _rr  >= view_yview[0] && bbox_top - _rr <= view_yview[0] + view_hview[0]);
    x = __x;
    y = __y;
    return result;
}
