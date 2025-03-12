/// findTileWithSplit(depth, x, y, w = 16, h = 16 )
// returns a tile at a position if it exists, splitting it if needed

var _gw = 16;
var _gh = 16;
if(argument_count > 3)
{
    _gw = argument[3];
    if(argument_count > 4)
    {
        _gh = argument[4];
    }
    else
    {
        _gh = _gw;
    }
}

var _findDepth = argument[0];
var _findX = argument[1];
var _findY = argument[2];

var _tile = tile_layer_find(_findDepth, _findX, _findY);
if(_tile)
{
    var _tw = tile_get_width(_tile);
    var _th = tile_get_height(_tile);
    
    if( (_tw mod _gw) == 0 && (_th mod _gh) == 0)
    {
        if(splitTile(_tile, _gw, _gh))
        {
            _tile = tile_layer_find(_findDepth, _findX, _findY);
        }
    }
    else
    {
        _tile = -1;
    }
}

return _tile;
