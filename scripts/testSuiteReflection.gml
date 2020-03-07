// a suite of tests for string execute partial

if (unitCase("set"))
{
    if (unitExecute())
    {
        test = 0;
        var err = stringExecutePartial("test = 1");
        if (is_string(err)) show_debug_message(err);
        unitRequireEquals(test, 1, "failed to set instance variable");
    }
}

if (unitCase("set global"))
{
    if (unitExecute())
    {
        global.flag = 9;
        stringExecutePartial("global.flag = 12");
        unitRequireEquals(global.flag, 12, "failed to set global variable");
    }
}

if (unitCase("get"))
{
    if (unitExecute())
    {
        test = 5;
        value = 0;
        stringExecutePartial("value = test");
        unitRequireEquals(test, 5, "set instead of get instance variable by accident");
        unitRequireEquals(value, 5, "failed to get instance variable or assign afterward");
    }
}

if (unitCase("get global"))
{
    if (unitExecute())
    {
        test = 7;
        global.flag = 3;
        stringExecutePartial("test = global.flag");
        unitRequireEquals(test, 3, "set instead of get global variable by accident");
        unitRequireEquals(global.flag, 3, "failed to get global variable or assign it");
    }
}

if (unitCase("set array"))
{
    if (unitExecute())
    {
        test[0] = -5;
        test[1] = -6;
        test[2] = -7;
        stringExecutePartial("test[1] = 14");
        unitRequireEquals(test[1], 14, "failed to set array");
    }
}

if (unitCase("get array"))
{
    if (unitExecute())
    {
        test[0] = 25;
        test[1] = 26;
        test[2] = 27;
        value = 5;
        stringExecutePartial("value = test[1]");
        unitRequireEquals(value, 26, "failed to get array or assign afterward");
        unitRequireEquals(test[1], 26, "array was modified erroneously while setting");
    }
}

if (unitCase("set global array"))
{
    if (unitExecute())
    {
        global.flag[0] = -9;
        global.flag[1] = -15;
        global.flag[2] = -29;
        stringExecutePartial("global.flag[1] = 67");
        unitRequireEquals(global.flag[1], 67, "failed to set global array");
    }
}

if (unitCase("get global array"))
{
    if (unitExecute())
    {
        global.flag[0] = 44;
        global.flag[1] = 45;
        global.flag[2] = 46;
        value = 5;
        stringExecutePartial("value = global.flag[2]");
        unitRequireEquals(value, 46, "failed to get array or assign afterward");
        unitRequireEquals(global.flag[2], 46, "array was modified erroneously while setting");
    }
}

if (unitCase("arithmetic"))
{
    if (unitExecute())
    {
        value = 5;
        stringExecutePartial("value = ((7 * 13) - (5)) mod 6");
        unitRequireEquals(value, 2, "incorrectly computed arithmetic");
        stringExecutePartial("value = -9");
        unitRequireEquals(value, -9, "cannot handle negative numbers (-9)");
    }
}

if (unitCase("if statements"))
{
    if (unitExecute())
    {
        value = 5;
        stringExecutePartial("if (3 < 5) {value = 6} ");
        unitRequireEquals(value, 6, "if statement did not trigger");
        stringExecutePartial("value = 9; if (5 < 3) {value = 7} ");
        unitRequireEquals(value, 9, "if statement triggered when it should not have");
    }
}

if (unitCase("else-if statements"))
{
    if (unitExecute())
    {
        value = 5;
        stringExecutePartial("if (3 < 5) {value = 6} else {value = 7}");
        unitRequire(value != 7, "else block triggered when it should not have");
        stringExecutePartial("value = 8; if (5 < 3) {value = 7} else {value = 9}");
        unitRequireEquals(value, 9, "else block failed to trigger");
    }
}

if (unitCase("functions"))
{
    if (unitExecute())
    {
        value = 5;
        stringExecutePartial("value = sin(3)");
        unitRequire(value == sin(3), "couldn't call 1-arg function.");
    }
}
