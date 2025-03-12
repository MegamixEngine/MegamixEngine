/// conCom(Command file name)
/*
A script for executing A.C.E. code from a text file.
For use with the debug menu's console, in order to allow quick scripts on a per-dev basis.

*/

if (!DEBUG_ENABLED)
{
    exit;
}
if (!directory_exists("ConsoleCommands"))
{
    directory_create("ConsoleCommands");
}
var path = "ConsoleCommands/" + argument[0] + ".txt";
if (!file_exists(path))
{
    var f = file_text_open_write(path);
    file_text_writeln(f);
    file_text_close(f);
    print("ConCom file created. See AppData",WL_SHOW);
    exit;
}
var file = file_text_open_read(path);

var txt = "";
while (!file_text_eof(file)) {
    txt += file_text_readln(file);
}
txt = string_copy(txt,0,string_length(txt));//Get rid of the \n.
file_text_close(file);
print(txt,WL_SHOW,c_white,true);
stringExecutePartial(txt);

    
