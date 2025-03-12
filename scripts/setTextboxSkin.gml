/// setTextboxSkin(skin_name, _textbox = noone)
// Allows for textboxes to have different appearances
var skin_name = argument[0];
var _textbox; if (argument_count > 1) _textbox = argument[1]; else _textbox = noone;

if (!instance_exists(_textbox))
    _textbox = instance_nearest(x, y, objDialogueBox);

with (_textbox) {
    switch (skin_name) {
        default:
            skinIndex = 0;
            break;
    }
}
