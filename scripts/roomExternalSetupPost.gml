/// room_external_setup_post()
// sets up the current room from the external room loader map
// should be called after all object create events,
// and only in externally loaded rooms.

var exrm = room;
var exgrid = global.roomExternalSetupMap[? exrm];

assert(ds_exists(exgrid, ds_type_grid), "external room data has been deleted for room no. " + string(room) + ": " + roomExternalGetName(room));
var grid_width = ds_grid_width(exgrid);
var grid_height = ds_grid_height(exgrid);

// second pass -- creation code
for (var i = 1; i < grid_width; i++)
{
    with (exgrid[# i, 0])
    {
        var ccode = xmlStringUnescape(exgrid[# i, 1]);
        if (string_length(ccode) > 0)
            stringExecutePartial(ccode);
    }
}

// room creation code
stringExecutePartial(xmlStringUnescape(exgrid[# 0, 0]));
