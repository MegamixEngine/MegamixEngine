/// room_external_setup_pre()
// sets up the current room from the external room loader map
// should be called before all object create events,
// and only in externally loaded rooms.

var exrm = room;
var exgrid = global.roomExternalSetupMap[? exrm];

assert(ds_exists(exgrid, ds_type_grid), "external room data has been deleted for room no. " + string(room) + ": " + roomExternalGetName(room));
var grid_width = ds_grid_width(exgrid);
var grid_height = ds_grid_height(exgrid);

// first pass -- attributes
for (var i = 1; i < grid_width; i++)
{
    var iid = exgrid[# i, 0];
    with (iid)
    {
        image_xscale = real(exgrid[# i, 2]);
        image_yscale = real(exgrid[# i, 3]);
        
        // image_blend = real(exgrid[# i, 4]);
        image_angle = real(exgrid[# i, 5]);
    }
}
