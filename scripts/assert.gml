/// assert(expression, [error message])
// crashes the game if the given expression evaluates to false
// printing optional error message

if (!argument[0]) {
    // caps makes this easier to spot in the inspector
    var ERROR_MESSAGE = "FATAL ASSERTION FAILURE";
    
    if (argument_count > 1) {
        printErr(ERROR_MESSAGE);
        printErr(argument[1]);
        
        ERROR_MESSAGE += ": " + argument[1];
    }
    
    show_error(ERROR_MESSAGE, true);
}
