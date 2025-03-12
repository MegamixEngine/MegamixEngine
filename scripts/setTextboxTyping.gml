/// setTextboxTyping(_type_speed, _speed_multiplier = 4, _text_blip = -1, _textbox = noone)
// Configures how settings in a textbox relating to text getting typed out

var _type_speed = argument[0];
var _speed_multiplier; if (argument_count > 1) _speed_multiplier = argument[1]; else _speed_multiplier = 4;
var _text_blip; if (argument_count > 2) _text_blip = argument[2]; else _text_blip = -1;
var _textbox; if (argument_count > 3) _textbox = argument[3]; else _textbox = noone;

if (!instance_exists(_textbox))
{
    _textbox = instance_nearest(x, y, objDialogueBox);
}

with (_textbox)
{
    textSpeed = _type_speed;
    textSpeedMulti = _speed_multiplier;
    
    if (_text_blip != -1)
    {
        textBlip = _text_blip;
    }
}
