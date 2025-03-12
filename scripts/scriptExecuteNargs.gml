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
        return script_execute(fn);
        
    }
    else
    {
        // crop args to arg_num
        var _arg = arg;
        arg = -1;
        arg[0] = 0;
        for (var i = 0; i < argn; i++)
        {
            arg[i] = _arg[i];
        }
    }
}

switch (array_length_1d(arg))
{
    case 0:
        return script_execute(fn);
        
    case 1:
        return script_execute(fn, arg[0]);
        
    case 2:
        return script_execute(fn, arg[0], arg[1]);
        
    case 3:
        return script_execute(fn, arg[0], arg[1], arg[2]);
        
    case 4:
        return script_execute(fn, arg[0], arg[1], arg[2], arg[3]);
        
    case 5:
        return script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4]);
        
    case 6:
        return script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5]);
        
    case 7:
        return script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6]);
        
    case 8:
        return script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7]);
        
    case 9:
        return script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8]);
        
    case 10:
        return script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9]);
        
    case 11:
        return script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10]);
        
    case 12:
        return script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10], arg[11]);
    case 13:
        return script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10], arg[11], arg[12]);
        
    case 14:
        return script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10], arg[11], arg[12], arg[13]);
        
    case 15:
        return script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10], arg[11], arg[12], arg[13], arg[14]);
        
    case 16:
        return script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10], arg[11], arg[12], arg[13], arg[14], arg[15]);
        
    case 17:
        return script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10], arg[11], arg[12], arg[13], arg[14], arg[15], arg[16]);
        
    case 18:
        return script_execute(fn, arg[0], arg[1], arg[2], arg[3], arg[4], arg[5], arg[6], arg[7], arg[8], arg[9], arg[10], arg[11], arg[12], arg[13], arg[14], arg[15], arg[16], arg[17]);
        
    default:
        show_error("Not configured for NArgs of size "  + array_length_1d(arg),true);
        return noone;
}
