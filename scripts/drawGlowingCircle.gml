/// drawGlowingCircle(_x, _y, _radius, _glow, _inner_col, _outer_col, _inner_alpha, _outer_alpha)
// Draws a circle with a glow around it

var _x = argument0, _y = argument1, _radius = argument2, _glow = argument3, _inner_col = argument4, _outer_col = argument5, _inner_alpha = argument6, _outer_alpha = argument7;

var _precision = 32,
    _turn = 360 / _precision,
    _dir = 0;

// Inner Circle
draw_primitive_begin(pr_trianglefan);
draw_vertex_color(_x, _y, _inner_col, _inner_alpha);
repeat (_precision + 1) {
	draw_vertex_color(_x + lengthdir_x(_radius, _dir), _y + lengthdir_y(_radius, _dir), _inner_col, _inner_alpha);
	_dir += _turn;
}
draw_primitive_end();

// Outer Circle
draw_primitive_begin(pr_trianglestrip);
repeat (_precision + 1) {
    draw_vertex_color(_x + lengthdir_x(_radius, _dir), _y + lengthdir_y(_radius, _dir), _inner_col, _inner_alpha);
    draw_vertex_color(_x + lengthdir_x(_radius + _glow, _dir), _y + lengthdir_y(_radius + _glow, _dir), _outer_col, _outer_alpha);
    _dir += _turn;
}
draw_primitive_end();
