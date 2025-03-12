/// spawnPassiveTextBoxSingleString(boxPosition, endEvent, name, name color, text, [font]);
// Version of spawnPassiveTextBox that only takes in a single string as the text.
// The text will be split into multiple blocks if very long

// argument0: 0 at the top; 1 in the bottom
// argument1: what event 'event_user(x)' it triggers after closing it. If it's -1, it does nothing
// argument2: name;
// argument3: name color;
// argument4: the text that should be displayed, which will be split into multiple blocks depending on the full length
// argument5: font to use for this textbox. If not defined, defaults to the regular font

assert(argument_count >= 5, "spawnTextBoxSingleString expects 5-6 arguments. Was only given " + string(argument_count));

var _font = global.font;
if (argument_count > 5)
    _font = argument[5];
// Now create the textbox
return spawnPassiveTextBoxUsingArray(argument0, argument1, argument2, argument3, _parseTextIntoBlocks(argument4, view_wview - 43, _font), _font);
