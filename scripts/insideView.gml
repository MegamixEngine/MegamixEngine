/// insideView( | [useRespawnRange] | [x, y])
// Returns true if the object or specified coordinate is inside the view, and false if not.
// if a respawn range is provided, check permit that as margin.
// This script only works for view 0.

if (argument_count == 2)
{
    var _x = argument[0];
    var _y = argument[1];
    return (_x >= view_xview[0] && _y > view_yview[0] && _x <= view_xview[0] + view_wview[0] && _y <= view_yview[0] + view_hview[0]);
}
else
{
    var rr = 0;
    if (argument_count > 0)
    {
        if (argument[0])
            rr = respawnRange;
    }
    
    return (bbox_right + rr >= view_xview[0] && bbox_left - rr <= view_xview[0] + view_wview[0] && bbox_bottom + rr >= view_yview[0] && bbox_top - rr <= view_yview[0] + view_hview[0]);
}
