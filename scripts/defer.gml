/// defer(event, subEvent, depth, script, [args], [delay])
// defers the given script to run at the given event / sub-event / depth order
// optionally provide an array of arguments
// optionally provide number of frames to delay action

// special case: if args provided are "ev_destroy, ev_room_end"
// then script will run after the caller is destroyed or the room ends,
// whichever comes first

// special case: if args provided are "ev_destroy, EV_DEATH" then
// the script will run after the caller is destroyed or the caller is
// dead (must be an entity) or the room ends; whichever comes first

with (instance_create(0, 0, objDefer))
{
    event = argument[0];
    subEvent = argument[1];
    
    if (event == ev_destroy)
    {
        caller = other.id;
    }
    
    depth = argument[2];
    script = argument[3];
    
    if (argument_count <= 4)
    {
        argCount = 0;
    }
    else
    {
        args = argument[4];
        argCount = array_length_1d(args);
    }
    
    if (argument_count <= 5)
    {
        timer = 0;
    }
    else
    {
        timer = argument[5];
    }
    
    return id;
}
