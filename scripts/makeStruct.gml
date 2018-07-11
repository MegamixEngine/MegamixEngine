/// makeStruct([persistent?])
// returns a blank struct object
// persistence defaults to the creator's persistence

var p = persistent;
if (argument_count > 0)
    p = argument[0];

with (instance_create(0, 0, objStruct))
{
    visible = false;
    persistent = p;
    return id;
}
