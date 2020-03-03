/// scriptExecuteNargs(script, arg_list, [arg_num])

var fn = argument[0];
var arg = argument[1];
if (argument_count > 2)
{
    // narg set.
    var argn = argument[2];
    if (argn == 0)
    {
        // 0 arguments
        script_execute(fn);
        exit;
    }
    else
    {
        // crop args to arg_num
        var _arg = arg;
        arg = makeArray(0);
        for (var i = 0; i < argn; i++)
        {
            arg[i] = _arg[i];
        }
    }
}

switch (array_length_1d(arg))
{
    case 0:
        script_execute(fn);
        exit;
    case 1:
        script_execute(fn, arg[0]);
        exit;
    case 2:
        script_execute(fn, arg[0], arg[1]);
        exit;
    case 3:
        script_execute(fn, arg[0], arg[1], arg[2]);
        exit;
    case 4:
        script_execute(fn, arg[0], arg[1], arg[2], arg[3]);
        exit;
    case 5:
        script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4]);
        exit;
    case 6:
        script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5]);
        exit;
    case 7:
        script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6]);
        exit;
    case 8:
        script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7]);
        exit;
    case 9:
        script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8]);
        exit;
    case 10:
        script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9]);
        exit;
    case 11:
        script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10]);
        exit;
    case 12:
        script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10], arg[11]);
        exit;
    case 13:
        script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10], arg[11], arg[12]);
        exit;
    case 14:
        script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10], arg[11], arg[12], arg[13]);
        exit;
    case 15:
        script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10], arg[11], arg[12], arg[14]);
        exit;
}

