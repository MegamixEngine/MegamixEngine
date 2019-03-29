

var px = argument0;
var py = argument1;
var color1 = argument2;
var color2 = argument3;
var fill = argument4;
var full = argument5;


if (fill < 0) {
  fill = 0;
}
else if (full < fill) {
  fill = full;
}


var skip = full - fill;
py += skip * 2;


var size = 16;
var frame = 0;


while (0 < fill) {
  if (size <= fill) {
    draw_sprite_ext(sprHudBarP, frame, px, py, 1, 1, 0, color1, 1);
    draw_sprite_ext(sprHudBarS, frame, px, py, 1, 1, 0, color2, 1);
    
    py += size * 2;
    fill -= size;
  }
  else {
    size = size / 2;
    frame += 1;
    assert(1 <= size);
  }
}


