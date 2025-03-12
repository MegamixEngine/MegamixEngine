///drawSegmentedLine(x1, y1, x2, y2, sprite, segments, [xscale], [yscale])
var _x1 = argument[0];
var _y1 = argument[1];
var _x2 = argument[2];
var _y2 = argument[3];
var _sprite = argument[4];
var _segments = argument[5];

var _xscale = 1;
var _yscale = 1;
if (argument_count >= 7)
{
  _xscale = argument[6];
}
if (argument_count >= 8)
{
  _yscale = argument[7];
}

var _distanceX = (_x2 - _x1);
var _distanceY = (_y2 - _y1);
    
for (var i = _segments - 1; i >= 0; i--)
{
    draw_sprite_ext(_sprite, 0, (_x1 + (i * (_distanceX / _segments))), (_y1 + (i * (_distanceY / _segments))), _xscale, _yscale, 0, c_white, 1.0);
}
