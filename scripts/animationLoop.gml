/// anim_loop(start, end, speed)
// ensure a local variable called _im exists

var spd, _end, start;

start = min(argument0, image_number - 1);
_end = min(argument1, image_number - 1);
spd = argument2;

_im += spd;
if (_im >= _end + 2)
    _im = _end + 2;
if (_im >= _end + 1)
    _im -= (_end - start + 1);
if (_im < start)
    _im = start;

image_index = max(max(start, 0), floor(_im));
if (image_index > _end)
    image_index = _end;
image_speed = 0;
