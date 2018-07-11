/// setSection(new_section_x,new_section_y,global)
// Sets the section border to be in the section located at the given (x,y) coords

// new_section_x - x coordinate at which to set the section
// new_section_y - y coordinate at which to set the section
// global - do we want to set the global section variables or only local ones

var _global = argument2;

var _x = argument0;
var _y = argument1;
var _i = 0;
var _size = ds_list_size(global.borderlist);


var _str = "";
var _s = 0;
var _e = 0;

var _st = 0;
var _sb = room_height;
var _sl = 0;
var _sr = room_width;

for (_i = 0; _i < _size; _i++)
{
    _str = ds_list_find_value(global.borderlist, _i);
    
    _s = string_pos("s", _str) + 1;
    _e = string_pos("e", _str) + 1;
    
    if (string_count("h", _str)) // Horizontal
    {
        if (_y > real(string_copy(_str, _s, (_e - 1) - _s))
            && _y < real(string_copy(_str, _e, (string_length(_str) + 1) - _e)))
        {
            _str = real(string_copy(_str, 2, _s - 3));
            
            if (_x < _str)
            {
                _sr = min(_str, _sr);
            }
            else
            {
                _sl = max(_str, _sl);
            }
        }
    }
    else // Vertical
    {
        if (_x > real(string_copy(_str, _s, (_e - 1) - _s))
            && _x < real(string_copy(_str, _e, (string_length(_str) + 1) - _e)))
        {
            _str = real(string_copy(_str, 2, _s - 3));
            
            if (_y < _str)
            {
                _sb = min(_str, _sb);
            }
            else
            {
                _st = max(_str, _st);
            }
        }
    }
}

if (_global)
{
    // Set soft borders
    global.borderLockLeft = 0;
    global.borderLockRight = room_width;
    global.borderLockTop = 0;
    global.borderLockBottom = room_height;
    
    global.sectionLeft = _sl;
    global.sectionRight = _sr;
    global.sectionTop = _st;
    global.sectionBottom = _sb;
}
else
{
    sectionLeft = _sl;
    sectionRight = _sr;
    sectionTop = _st;
    sectionBottom = _sb;
}
