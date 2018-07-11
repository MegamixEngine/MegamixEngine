/// unitRequire(condition, message)
// adds a unit-test error of the given string if the condition is false

var condition = argument[0];
var message = "(Unspecified Error Message).";
if (argument_count > 1)
    message = argument[1];

if (!condition)
{
    ds_list_add(global.unitTestErrors, message);
    global.unitTestGlobalErrorSummaryResult = max(global.unitTestGlobalErrorSummaryResult, 2);
    print("ERROR -- require failed: " + message + '
(in test case "' + global.unitTestCase + '" in suite "' + global.unitSuiteName + '")');
    if (global.unitTestCritical)
    {
        print("(FATAL)");
        global.unitTestAbortAll = true;
    }
}
