/// addChoice(_text, _textbox = noone)
// Adds an option for the player to choose at the end of this dialogue box

var _text = argument[0];
var _textbox; if (argument_count > 1) _textbox = argument[1]; else _textbox = noone;

if (!instance_exists(_textbox))
    _textbox = instance_nearest(x, y, objDialogueBox);

with (_textbox)
{
    optionText[optionCount++] = _text;
}
