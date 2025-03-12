/// print([message], [warningLevel], [color], [noconsole], [debugDumpFile])
/// shows the given debug message on-screen and in the console

// message: the message to print
//   default: ""
// warning level: whether or not to display to user on-screen (depends on config)
//                Note that the output will always be cloned to the console.
//   default: WL_SHOW
// colour: the message colour :)
//   default: c_white
// noconsole: if set to true, will not print in the stdout console
//   default: false
// debugDumpFile: If defined, will print the output to the specified string. Only occurs with debug enabled.
var msg = "";
var warningLevel = WL_VERBOSE;
var col = c_white;
var noConsole = false;
if (argument_count > 0)
    msg = string(argument[0]);
if (argument_count > 1)
    warningLevel = argument[1];
if (argument_count > 2)
    col = argument[2];
if (argument_count > 3)
    noConsole = argument[3];
if (DEBUG_ENABLED)
{
    if (argument_count > 4)
    {
        var file = file_text_open_append(argument[4]);
        file_text_write_string(file,msg);
        file_text_writeln(file);
        file_text_close(file);
        
    }
}
if (!noConsole)
    show_debug_message(msg);
    


// split lines:
var MAX_LINE_WIDTH = 32;
var MIN_LINE_WIDTH = 16;
if (string_length(msg) > MAX_LINE_WIDTH)
{
    // finds last space:
    var last_space = min(string_length(msg), MAX_LINE_WIDTH) - stringIndexOf(stringReverse(stringSubstring(msg, 0, MAX_LINE_WIDTH)), " ") + 1;
    if (last_space <= 4)
        last_space = MAX_LINE_WIDTH;
    var newline = stringIndexOf(msg, "
    ");
    if (newline < last_space)
        last_space = newline;
    last_space = max(last_space, MIN_LINE_WIDTH);
    print(stringSubstring(msg, 0, last_space), warningLevel, col, true);
    print(stringSubstring(msg, last_space), warningLevel, col, true);
    exit;
}

if (global.warningLevel <= warningLevel)
{
    if (global.consoleN >= CONSOLE_MAX)
    {
        for (var i = 1; i < global.consoleN; i++)
        {
            global.consoleTimer[i-1] = global.consoleTimer[i];
            global.consoleColour[i-1] = global.consoleColour[i];
            global.consoleMessage[i-1] = global.consoleMessage[i];
        }
        global.consoleN--;
    }
    global.consoleTimer[global.consoleN] = 0;
    global.consoleColour[global.consoleN] = col;
    global.consoleMessage[global.consoleN] = msg;
    global.consoleN++;
}
