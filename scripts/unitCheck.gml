/// unitCheck(condition, message)
// adds a unit-test warning of the given string if the condition is false

var condition = argument[0];
var message = "(Unspecified Warning Message)."
    ;
if (argument_count > 1)
{
    message = argument[1];
}

if (!condition)
{
    global.unitTestGlobalErrorSummaryResult = max(global.unitTestGlobalErrorSummaryResult, 1);
    ds_list_add(global.unitTestWarns, message);
    print("Warning -- check failed: " + message + '
 (in test case "' + global.unitTestCase + '" in suite "' + global.unitSuiteName + '")');
}
