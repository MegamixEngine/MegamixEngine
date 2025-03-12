/// room_external_setup_post()
// sets up the current room from the external room loader map
// should be called after all object create events,
// and only in externally loaded rooms.

var exrm = room;
var exgrid = global.roomExternalSetupMap[? exrm];

assert(ds_exists(exgrid, ds_type_grid), "external room data has been deleted for room no. " + string(room) + ": " + roomExternalGetName(room));
var firstInst = exgrid[# global.erlSetupFirstInst, 0];
var instEnd = exgrid[# global.erlSetupInstCount, 0] + firstInst;
var firstTile = exgrid[# global.erlSetupFirstTile, 0];
var tileEnd = exgrid[# global.erlSetupTileCount, 0] + firstTile;

// second pass -- creation code
for (var i = firstInst; i < instEnd; ++i)
{ 
    iid = exgrid[# i, 0];
    with (iid)
    {
        var ccode = xmlStringUnescape(exgrid[# i, 1]);
        if (string_length(ccode) > 0)
            stringExecutePartial(ccode);
    }
}

// room creation code
stringExecutePartial(xmlStringUnescape(exgrid[# 0, 0]));
