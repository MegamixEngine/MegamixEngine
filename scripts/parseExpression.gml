/// parseExpression(str)
// reads the expression at the start of the string
// uses global return registers

var str = argument[0];
var inStr = str;

var whitespaceDropped = 0;
global.retval_exprlen = 0;
global.retval_exprval = 0;
global.retval_error = false;

while (stringStartsWith(str, " "))
{
    str = stringSubstring(str, 2);
    whitespaceDropped += 1;
}

var expr = stringPeekToken(str);
str = stringSubstring(str, string_length(expr) + 1);

// not (!)
if (expr == "!")
{
    parseExpression(str);
    if (global.retval_error)
    {
        exit;
    }
    global.retval_exprlen += 1 + whitespaceDropped;
    global.retval_exprval = !global.retval_exprval;
} // strip parentheses
else if (expr == "(")
{
    var paren_match = 1;
    absolve = false;
    for (var i = 1; i <= string_length(str); i++)
    {
        var char = string_char_at(str, i);
        if (char == "(")
            paren_match++;
        if (char == ")")
            paren_match--;
        if (paren_match == 0)
        {
            var aStr = stringSubstring(str, 1, i);
            str = stringSubstring(str, i + 1);
            parseExpression(aStr);
            global.retval_exprlen = string_length(aStr) + 2 + whitespaceDropped;
            absolve = true;
            break;
        }
    }
    if (!absolve)
    {
        // no matching parenthesis found:
        printErr("ERROR unmatched parentheses in: (" + str);
        global.retval_error = true;
        exit;
    }
} // parse function
else if (stringStartsWith(str, "("))
{
    var fn_str = expr;
    
    // gml function
    if (asset_get_type(fn_str) == asset_unknown)
    {
        str = stringSubstring(str, 2);
        var exprlen = string_length(expr) + 1;
        var arg_n = 1;
        arg[0] = fn_str;
        
        // read arguments
        while (true)
        {
            exprlen += string_length(str);
            str = stringTrim(str);
            exprlen -= string_length(str);
            if (string_char_at(str, 1) == ")")
            {
                str = stringSubstring(str, 2);
                break;
            }
            parseExpression(str);
            if (global.retval_error)
            {
                printErr("ERROR parsing function argument in expression:" + str);
                global.retval_error = true;
                exit;
            }
            arg[arg_n++] = global.retval_exprval;
            str = stringSubstring(str, global.retval_exprlen + 1) + whitespaceDropped;
            exprlen += global.retval_exprlen;
            exprlen += string_length(str);
            str = stringTrim(str);
            exprlen -= string_length(str);
            if (string_char_at(str, 1) == ")")
            {
                str = stringSubstring(str, 2);
                exprlen += 1;
                global.retval_exprlen = exprlen + whitespaceDropped;
                break;
            }
            if (string_char_at(str, 1) != ",")
            {
                global.retval_error = true;
                printErr("ERROR parsing function in expression; comma expected: " + str);
                exit;
            }
            str = stringSubstring(str, 2);
            exprlen += 1;
        }
        
        scriptExecuteNargs(executeGMLFunction, arg);
        if (global.execute_gml_function_ERR)
        {
            global.retval_error = true;
            printErr("ERROR GML built-in function not supported: " + fn_str);
            printErr("(Please consider adding the script into the the executeGMLFunction script or filing a bug report!)");
            exit;
        }
        global.retval_exprval = global.gml_fn_retval;
        exit;
    }
}
else
{
    global.retval = 0;
    // direct value or variable
    global.retval_exprlen += string_length(expr) + whitespaceDropped;
    
    // read array
    if (stringStartsWith(str, "["))
    {
        global.retval_exprlen += 1;
        str = stringSubstring(str, 2);
        
        // read value of first index:
        global.retval = 0;
        var stackRetValExprlen = global.retval_exprlen;
        parseExpression(str);
        var indexA = global.retval_exprval;
        str = stringSubstring(str, global.retval_exprlen + 1);
        global.retval_exprlen += stackRetValExprlen;
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
            global.retval_exprlen += stackRetValExprlen;
            if (global.retval_error)
            {
                exit;
            }
            indices = 2;
        }
        if (!stringStartsWith(str, "]"))
        {
            printErr("ERROR expected end-prentheses `]` in: " + str);
            global.retval_error = true;
        }
        else
        {
            global.retval_exprlen += 1;
        }
        if (indices == 1)
        {
            if (!getInstanceVariableArray(expr, 0, indexA))
            {
                global.retval_error = true;
            }
            global.retval_exprval = global.retval;
        }
        else
        {
            if (!getInstanceVariableArray(expr, indexA, indexB))
            {
                global.retval_error = true;
            }
            global.retval_exprval = global.retval;
        }
    }
    else
    {
        // parse expression:
        var expr_value = 0;
        
        // string expression:
        if (expr == '"' || expr == "'")
        {
            var quotchar = expr;
            var endquote_pos = string_pos(quotchar, str);
            expr_value = stringSubstring(str, 0, endquote_pos);
            str = stringSubstring(str, endquote_pos + 1);
            global.retval_exprlen += endquote_pos;
            global.retval_exprval = expr_value;
        } // number expression:
        else if (stringIsNumber(expr))
            global.retval_exprval = real(expr); // keyword expression:
        else if (expr == "other")
            global.retval_exprval = other;
        else if (expr == "self")
            global.retval_exprval = self;
        else if (expr == "noone")
            global.retval_exprval = noone; // check resources
        else if (asset_get_index(expr) != -1)
            global.retval_exprval = asset_get_index(expr); // unknown expression -- throw error
        else
        {
            if (!getInstanceVariable(expr))
            {
                global.retval_error = true;
            }
            global.retval_exprval = global.retval;
        }
    }
}

// TODO: order of operations

// trim
while (stringStartsWith(str, " "))
{
    str = stringSubstring(str, 2);
    global.retval_exprlen += 1;
}

// operand
var operand;
operand[0] = "==";
operand[1] = "<=";
operand[2] = ">=";
operand[3] = ">";
operand[4] = "<";
operand[5] = "+";
operand[6] = "-";
operand[7] = "*";
operand[8] = "/";
operand[9] = "mod ";
operand[10] = "div ";
operand[11] = "and ";
operand[12] = "&&";
operand[13] = "||";
operand[14] = "or ";
operand[15] = "!=";

for (var i = 0; i < array_length_1d(operand); i++)
{
    var op = operand[i];
    if (stringStartsWith(str, op))
    {
        str = stringSubstring(str, string_length(op) + 1);
        global.retval_exprlen += string_length(op);
        var stackRetValExprlen = global.retval_exprlen;
        var stackRetValExprVal = global.retval_exprval;
        parseExpression(str);
        global.retval_exprlen += stackRetValExprlen;
        switch (i)
        {
            case 0:
                global.retval_exprval = stackRetValExprVal == global.retval_exprval;
                break;
            case 1:
                global.retval_exprval = stackRetValExprVal <= global.retval_exprval;
                break;
            case 2:
                global.retval_exprval = stackRetValExprVal >= global.retval_exprval;
                break;
            case 3:
                global.retval_exprval = stackRetValExprVal > global.retval_exprval;
                break;
            case 4:
                global.retval_exprval = stackRetValExprVal < global.retval_exprval;
                break;
            case 5:
                global.retval_exprval = stackRetValExprVal + global.retval_exprval;
                break;
            case 6:
                global.retval_exprval = stackRetValExprVal - global.retval_exprval;
                break;
            case 7:
                global.retval_exprval = stackRetValExprVal * global.retval_exprval;
                break;
            case 8:
                global.retval_exprval = stackRetValExprVal / global.retval_exprval;
                break;
            case 9:
                global.retval_exprval = stackRetValExprVal mod global.retval_exprval;
                break;
            case 10:
                global.retval_exprval = stackRetValExprVal div global.retval_exprval;
            case 11:
            case 12:
                global.retval_exprval = stackRetValExprVal && global.retval_exprval;
                break;
            case 13:
            case 14:
                global.retval_exprval = stackRetValExprVal || global.retval_exprval;
                break;
            case 15:
                global.retval_exprval = stackRetValExprVal != global.retval_exprval;
                break;
        }
        break;
    }
}
