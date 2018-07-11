/// carve_solid(x1, y1, x2, y2)
// carves objSolids so that the boundaries of the given rectangle
// are guaranteed not to be overlapped by any solid.
// returns true if any solids were found in the given region.

var x1 = argument[0];
var y1 = argument[1];
var x2 = argument[2];
var y2 = argument[3];

var any = false;

// negative dimensions are invalid
if (x2 <= x1 || y2 <= y1)
{
    exit;
}

// repeatedly attempt to split until no attempt succeeds
while (true)
{
    var split = false;
    with (objSolid)
    {
        if (instance_exists(id))
        {
            var w = image_xscale * sprite_get_width(sprite_index);
            var h = image_yscale * sprite_get_height(sprite_index);
            
            if (rectangleIntersectionType(x1, y1, x2, y2, x, y, x + w, y + h) >= 3)
            {
                any = true;
                var grid_x, grid_y;
                grid_x[0] = max(x, x1);
                grid_x[1] = x;
                grid_x[2] = min(x + w, x2);
                grid_x[3] = x + w;
                quickSort(grid_x);
                
                grid_y[0] = max(y, y1);
                grid_y[1] = y;
                grid_y[2] = min(y + h, y2);
                grid_y[3] = y + h;
                quickSort(grid_y);
                
                for (var i = 0; i < 3; i++)
                {
                    for (var j = 0; j < 3; j++)
                    {
                        var lx = grid_x[i];
                        var ly = grid_y[j];
                        var rx = grid_x[i + 1];
                        var ry = grid_y[j + 1];
                        if ((rx - lx) > 0 && (ry - ly) > 0)
                        {
                            if (lx != x || ly != y || rx != x + w || ry != y + h)
                            {
                                split = true;
                            }
                            if (rectangleIntersectionType(x, y, x + w, y + h, lx, ly, rx, ry) > 0)
                            {
                                with (instance_create(lx, ly, object_index))
                                {
                                    image_xscale = (rx - lx) / sprite_get_width(sprite_index);
                                    image_yscale = (ry - ly) / sprite_get_height(sprite_index);
                                }
                            }
                        }
                    }
                }
                
                instance_destroy();
                break;
            }
        }
    }
    if (!split)
    {
        return any;
    }
}

return any;
