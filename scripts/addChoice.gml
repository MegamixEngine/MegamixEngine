/// addChoice(number, text)
var i = instance_nearest(x, y, objDialogueBox);

_on = argument0; // on = option_number
_option = argument1;

i.optionText[_on] = _option;
i.optionCount += 1;
