/// getRoomInBackground(name, [external location], [hash])
// Starts loading the room of the given name in the background.

if (argument_count == 1)
{
    return getRoom(argument[0], "", "", true)
}

if (argument_count == 2)
{
    return getRoom(argument[0], argument[1], "", true)
}

if (argument_count == 3)
{
    return getRoom(argument[0], argument[1], argument[2], true)
}

assert(false, "Wrong number of arguments provided: " + string(argument_count));
