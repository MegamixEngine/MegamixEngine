/// assert(expression, [error message])
// crashes the game if the given expression evaluates to false
// printing optional error message

if (!argument[0])
{
    if (argument_count > 1)
    {
        // caps makes this easier to spot in the inspector
        var ERROR_MESSAGE = argument[1];
        printErr(ERROR_MESSAGE);
        printErr("FATAL ASSERTION FAILURE");
    }
    
    // intentionally invoke crash:
    var a = 0; // ASSERTION FAILED -- SEE CONSOLE
    a = 1 / a; // ASSERTION FAILED -- SEE CONSOLE
    var b; // ASSERTION FAILED -- SEE CONSOLE
    b[3] = 0; // ASSERTION FAILED -- SEE CONSOLE
    b[4] = b[a]; // ASSERTION FAILED -- SEE CONSOLE
    b[5] = b[10]; // ASSERTION FAILED -- SEE CONSOLE
    assert(false); // ASSERTION FAILED -- SEE CONSOLE
    return a; // ASSERTION FAILED -- SEE CONSOLE
}
