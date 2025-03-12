/// split_tile(tile, w=16,h=16)
// splits the given tile into tiles of the given width and height, aligned to a w by h grid

var t, // tile
_w, // grid width
_h, // grid height
_x,
    _y,
    _minx,
    _miny,
    _maxx,
    _maxy;
t = argument[0];
if (argument_count > 1)
{
    _w = argument[1];
    _h = argument[2];
}
else
{
    _w = 16;
    _h = 16;
}

if (t < 0 || _w <= 0 || _h <= 0)
    return false;

if (!tile_exists(t))
    return false;

// tile width
var tw = tile_get_width(t);

// tile height
var th = tile_get_height(t);

// tile x
var tx = tile_get_x(t);

// tile y
var ty = tile_get_y(t);

// tile left
var tl = tile_get_left(t);

// tile top
var tT = tile_get_top(t);
var td = tile_get_depth(t);
var tsrc = tile_get_background(t);

//Flipping
var fX = sign(tile_get_xscale(t));
var fY = sign(tile_get_yscale(t));

if (tw == _w && th == _h && tx mod _w == 0 && ty mod _h == 0)
{
    // tile does not need splitting; already aligned
    return false;
}

var ntl;
for (_x = floor(tx / _w) * _w; _x < ceil((tx + tw) / _w) * _w; _x += _w)
{
    for (_y = floor(ty / _h) * _h; _y < ceil((ty + th) / _h) * _h; _y += _h)
    {
        _minx = max(_x, tx);
        _miny = max(_y, ty);
        _maxx = min(_x + _w, tx + tw);
        _maxy = min(_y + _h, ty + th);
        
        ntl = tile_add(tsrc, _minx - tx + tl, _miny - ty + tT, _maxx - _minx,
            _maxy - _miny, _minx, _miny, td);
        tile_set_scale(ntl,fX,fY);
        
    }
}

tile_delete(t);
return true;
