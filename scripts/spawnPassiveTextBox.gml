/// spawnPassiveTextBox(boxPosition, endEvent, name, name color, text, ...)
// Spawns a passive textbox for characters to speak
// argument0: 0 at the top; 1 in the bottom
// argument1: what event 'event_user(x)' it triggers after closing it. If it's -1, it does nothing
// argument2: name;
// argument3: name color;
// argument4, 5, 6, ...: the text that should be displayed, each argument representing a block of dialogue

// No way to add in the font argument from the other textbox scripts without affecting all instances of this script call so far,
// due to how varying arguments work.
//
// Instead, just do this:
// var textbox = spawnPassiveTextBox(...);
// textbox.textFont = [font];

//Convert the texts from varying argument list to array
var _text_list = array_create(0);
for (var ca = 4; ca < argument_count; ca++) {
    // If the argument provided was '-1', we will skip this one
    if (argument[ca] == -1)
        continue;
    
    // If the argument provided was any other non-string value,
    // we skip not just this argument, but all arguments that come after this one
    if (!is_string(argument[ca]))
        break;
    arrayAppend(_text_list, argument[ca]);
}

return spawnPassiveTextBoxUsingArray(argument[0], argument[1], argument[2], argument[3], _text_list);
