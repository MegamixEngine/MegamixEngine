/// circularShineSpread(_x, _y, _type, _number = 8, _start_angle = 0)
// Honestly could not think of a better name for this script.
// It'll spawn a short-lasting shine effect in a circular spread.
//
// Types:
// 0 - Explosion sprite
// 1 - Flash Twinkle sprite
//

var _x = argument[0], _y = argument[1], _type = argument[2];
var _number; if (argument_count > 3) _number = argument[3]; else _number = 8;
var _start_angle; if (argument_count > 4) _start_angle = argument[4]; else _start_angle = 0;

assert(_number > 0, "_number must be a number greater than 0");

var _angle = _start_angle,
    _angle_inc = 360 / _number,
    _vfx_obj = objExplosion;

if (_type == 1)
    _vfx_obj = objSingleLoopEffect;

repeat (_number) {
    with (instance_create(_x, _y, _vfx_obj)) {
        speed = 2.5;
        direction = _angle;
        
        if (_type == 1) {
            sprite_index = sprFlashTwinkle;
            image_speed = 0.3;
        }
    }
    
    _angle = wrapAngle(_angle + _angle_inc);
}
