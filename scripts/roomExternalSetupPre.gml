/// roomExternalSetupPre()
// sets up the current room from the external room loader map
// should be called before all object create events,
// and only in externally loaded rooms.

var exrm = room;
var exgrid = global.roomExternalSetupMap[? exrm];

assert(ds_exists(exgrid, ds_type_grid), "external room data has been deleted for room no. " + string(room) + ": " + roomExternalGetName(room));
var firstInst = exgrid[# global.erlSetupFirstInst, 0];
var instEnd = exgrid[# global.erlSetupInstCount, 0] + firstInst;
var firstTile = exgrid[# global.erlSetupFirstTile, 0];
var tileEnd = exgrid[# global.erlSetupTileCount, 0] + firstTile;

// first pass -- attributes
for (var i = firstInst; i < instEnd ; i++)
{
    var iid = exgrid[# i, 0];

    with (iid)
    {
        image_xscale = real(exgrid[# i, 2]);
        image_yscale = real(exgrid[# i, 3]);
        
        var encoded = real(exgrid[# i, 4]);
        var b = encoded mod 256
        var g = (encoded div 256) mod 256;
        var r = (encoded div 65536 ) mod 256;
        var alpha = (encoded div 16777216)  mod 256;
        alpha = alpha / 255;
        image_blend = make_color_rgb(r, g, b);
        image_alpha = alpha;
        image_angle = real(exgrid[# i, 5]);
    }
}

for(var i = firstTile; i < tileEnd; ++i)
{
    var tileId = exgrid[# i, 0];
    if(tile_exists(tileId))
    {
        tile_set_blend(tileId, exgrid[# i, 1]);
    }
}
