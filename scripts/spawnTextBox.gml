// spawnTextBox(screenTop, endEvent, name, name color, text)
// argument0: 0 at the top; 1 in the middel; 2 at the bottom
// argument1: what event 'event_user(x)' it triggers after closing it. If it's -1, it defaults to just freeing MM.
// argument2: name;
// argument3: name color;
// argument4-15: the text that should be displayed, place after the last argument you need a -1

// spawn textbox
var i = instance_create(x, y, objDialogueBox);
if (npcID != 0)
{
    i.parent = npcID;
}
i.pos = argument[0];
i.origin = id;
i.o_event = argument[1];
i.name = argument[2];
i.nameCol = argument[3];

// insert text
for (var ca = 4; ca <= 15; ca += 1)
{
    if (!is_string(argument[ca]))
    {
        exit;
    }
    ds_list_add(i.text, argument[ca]);
}

return(i);
