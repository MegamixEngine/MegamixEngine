/// spawnPassiveTextBoxUsingArray(boxPosition, endEvent, name, name color, text_array, [font])
// version of spawnPassiveTextBox were the text is gotten from an array,
// rather than a varying argument list

// argument0: 0 at the top; 1 in the bottom
// argument1: what event 'event_user(x)' it triggers after closing it. If it's -1, it does nothing
// argument2: name;
// argument3: name color;
// argument4: array of text that should be displayed, each element representing a new section
// argument5: font to use for this textbox. If not defined, defaults to the regular font

assert(argument_count >= 5, "spawnPassiveTextBoxUsingArray expects 5-6 arguments. Was only given " + string(argument_count));

var _textbox = instance_create(x, y, objPassiveDialogueBox),
    _text = argument[4],
    _text_count = array_length_1d(_text);

var _font = global.font;
if (argument_count > 5)
    _font = argument[5];

with (_textbox) {
    boxPosition = argument[0];
    parent = other.id;
    parentEvent = argument[1];
    name = argument[2];
    nameCol = argument[3];
    textFont = _font;
    for (var ca = 0; ca < _text_count; ca++) {
        
        // If the argument provided was '-1', we will skip this one
        if (_text[ca] == -1)
            continue;
        
        // If the argument provided was any other non-string value,
        // we skip not just this argument, but all arguments that come after this one
        if (!is_string(_text[ca]))
            break;
        _text[ca] = _text[ca];
        ds_list_add(textList, _text[ca]);
    }
}

return _textbox;
