/// stringExecutePartial(str)
// executes the given string as code
// global.retval_error contains whether an error occurred
/*
## Overview

Because GMS1.4 lacks anonymous (lambda) functions, it's useful to be able to execute code from a string. This was a feature in
GM8.1, called `string_execute`, but was removed from GMS1.4 because it's too slow and has too many security risks. A similar
function, `stringExecutePartial`, has been created to restore this functionality for the engine. It is definitely very
slow and still has all the same security risks, but at least it's there.

## Usage

This is very straightforward. `stringExecutePartial(str)` will execute the code in the string `str`.

Many gimmicks, such as [custom spawners](../objects/objCustomSpawner), have a creation-code variable for such a string. In the case
of custom spawners, the variable is called `code`. 

## Limitations

Not all game maker syntax is supported, and the parser is incomplete and rather hacky. Currently missing features include
`for` loops (but not `with` loops), **the ability to read variables**, local variables (`var`), and others.

`stringExecutePartial` also requires a list of all variables in the engine to be maintained. If you add a new variable
to any object and you wish to be able to access that variable from within `stringExecutePartial`, you must run the bash
script `meta/update_string_execute.sh` from the working directory `meta/`. This requires
[python3 to be installed](https://www.python.org/downloads/).
*/

var str = argument0;
var full_code = "
```````````
" + str + "
```````````";

while (string_length(str) > 0)
{
    // skip non-logical tokens:
    str = stringTrim(str);
    var next_char = string_char_at(str, 1);
    if (next_char == " " || next_char == ";" || next_char == "  " || next_char == "
    " || next_char == chr(10) || next_char == "{" || next_char == "}")
    {
        str = stringSubstring(str, 2);
        continue;
    }
    
    // skip comments -- single-line
    if (stringStartsWith(str, "//"))
    {
        var nextline = string_pos(chr(10), str);
        if (nextline == 0)
            exit;
        str = stringSubstring(str, nextline + 1);
    }
    
    // skip comments -- multi-line
    if (stringStartsWith(str, "/*"))
    {
        var nextline = string_pos("*/", str);
        if (nextline == 0)
            break;
        str = stringSubstring(str, nextline + 2);
    }
    
    // keywords
    var token = stringPeekToken(str);
    if (token == "while" || token == "var" || token == "do" || token == "until" || token == "switch" || token == "case")
    {
        printErr("ERROR executing string. Cannot handle token " + token + " in: " + full_code);
        break;
    }
    
    // if statement
    if (token == "if")
    {
        str = stringSubstring(str, string_length("if") + 1);
        parseExpression(str);
        str = stringSubstring(str, global.retval_exprlen + 1);
        if (global.retval_error)
        {
            printErr("ERROR parsing expression while executing string:" + str + " in: " + full_code);
            break;
        }
        var expr = global.retval_exprval;
        var block_string = stringPeekBlock(str);
        if (global.retval_error)
        {
            break;
        }
        
        str = stringSubstring(str, string_length(block_string) + 1);
        if (expr)
        {
            stringExecutePartial(block_string);
        }
        if (global.retval_error)
            break;
        continue;
    }
    
    // with statement
    if (token == "with")
    {
        str = stringSubstring(str, string_length("with") + 2);
        parseExpression(str);
        str = stringSubstring(str, global.retval_exprlen + 1);
        if (global.retval_error)
        {
            printErr("ERROR parsing expression while executing string:" + str + " in: " + full_code);
            break;
        }
        var expr = global.retval_exprval;
        var block_string = stringPeekBlock(str);
        if (global.retval_error)
            break;
        str = stringSubstring(str, string_length(block_string) + 1);
        with (expr)
            stringExecutePartial(block_string);
        if (global.retval_error)
            break;
        continue;
    }
    
    if (token == "exit")
        break;
    
    // function
    if (string_char_at(str, string_length(token) + 1) == "(")
    {
        var fn_id = asset_get_index(token);
        str = stringSubstring(str, string_pos("(", str) + 1);
        var fn_str = token;
        var arg_n = 0;
        var arg;
        global.retval_error = false;
        
        // read arguments
        while (true)
        {
            str = stringTrim(str);
            if (string_char_at(str, 1) == ")")
            {
                str = stringSubstring(str, 2);
                break;
            }
            parseExpression(str);
            if (global.retval_error)
            {
                printErr("ERROR parsing function argument in string execution:" + str + " in: " + full_code);
                break;
            }
            arg[arg_n++] = global.retval_exprval;
            str = stringSubstring(str, global.retval_exprlen + 1);
            str = stringTrim(str);
            if (string_char_at(str, 1) == ")")
            {
                str = stringSubstring(str, 2);
                break;
            }
            if (string_char_at(str, 1) != ",")
            {
                global.retval_error = true;
                printErr("ERROR parsing function in string execution; comma expected: " + str + " in: " + full_code);
                break;
            }
            str = stringSubstring(str, 2);
        }
        if (global.retval_error)
            break;
        if (asset_get_type(fn_str) == asset_script)
        {
            // script
            scriptExecuteNargs(fn_id, arg);
            continue;
        }
        else if (asset_get_type(fn_str) == asset_unknown)
        {
            // built-in gml function
            // shift vars to make room for fn name passed as arg
            for (var i = arg_n; i >= 1; i--)
                arg[i] = arg[i - 1];
            arg[0] = fn_str;
            scriptExecuteNargs(executeGMLFunction, arg);
            if (global.execute_gml_function_ERR)
            {
                global.retval_error = true;
                printErr("ERROR GML built-in function not supported: " + fn_str + ", in: " + full_code);
                printErr("(Please consider adding the script into the the execute_gml_function script or filing a bug report!)");
                break;
            }
            continue;
        }
        else
        {
            global.retval_error = true;
            printErr("ERROR not a script resource: " + fn_str + ", in: " + full_code);
            break;
        }
    }
    
    // assignment -- read expression
    var assign_var = token;
    var indices = 0;
    var indexA, indexB;
    str = stringSubstring(str, string_length(token) + 1);
    str = stringTrim(str);
    if (stringStartsWith(str, "["))
    {
        // array
        str = stringSubstring(str, 2);
        parseExpression(str);
        str = stringSubstring(str, global.retval_exprlen + 1);
        indexA = global.retval_exprval;
        var indices = 1;
        if (global.retval_error)
        {
            exit;
        }
        var indexB = 0;
        if (stringStartsWith(str, ","))
        {
            str = stringSubstring(str, 2);
            stackRetValExprlen = global.retval_exprlen;
            parseExpression(str);
            indexB = global.retval_exprval;
            str = stringSubstring(str, global.retval_exprlen + 1);
            if (global.retval_error)
            {
                printErr("ERROR parsing expression while executing string:" + str + " in: " + full_code);
                exit;
            }
            indices = 2;
        }
        if (!stringStartsWith(str, "]"))
        {
            printErr("ERROR parsing expression while executing string:" + str + " in: " + full_code);
            exit;
        }
        else
        {
            str = stringSubstring(str, 2);
        }
    }
    str = stringSubstring(str, string_pos("=", str) + 1);
    str = stringTrim(str);
    
    parseExpression(str);
    str = stringSubstring(str, global.retval_exprlen + 1);
    
    if (global.retval_error)
    {
        printErr("ERROR parsing expression while executing string:" + str + " in: " + full_code);
        break;
    }
    
    // apply assignment
    switch (indices)
    {
        case 0:
            var success = setInstanceVariable(assign_var, global.retval_exprval);
            break;
        case 1:
            var success = setInstanceVariableArray(assign_var, global.retval_exprval, 0, indexA);
            break;
        case 2:
            var success = setInstanceVariableArray(assign_var, global.retval_exprval, indexA, indexB);
            break;
    }
    
    if (!success)
    {
        printErr("ERROR unkown variable name in execute string: " + assign_var);
        printErr("(Consider adding this variable to the script setInstanceVariable)");
        break;
    }
    
    continue;
}
