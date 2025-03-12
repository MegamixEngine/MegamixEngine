///shaderSetColorreplace(old color, new color, [up to 9])

var shader = shReplaceColor;
shader_set_safe(shader);

var _uniformOld = "";
var _uniformNew = "";

var _val = 0;
var _ii = 0;

for (_i = 1; _i <= 9; _i ++;)
{
    var _uniformOld = shader_get_uniform(shader, "u_coloro" + string(_i));
    var _uniformNew = shader_get_uniform(shader, "u_colorn" + string(_i));
    
    if (_ii < argument_count) //Set colors
    {
        _val = argument[_ii ++];
        shader_set_uniform_f(_uniformOld, colour_get_red(_val), colour_get_green(_val), colour_get_blue(_val));
        
        _val = argument[_ii ++];
        shader_set_uniform_f(_uniformNew, colour_get_red(_val), colour_get_green(_val), colour_get_blue(_val));
    }
    else //No argument supplied - Set to unreachable color value
    {
        _val = -1000;
        shader_set_uniform_f(_uniformOld, _val, _val, _val);
        shader_set_uniform_f(_uniformNew, _val, _val, _val);
    }
}
