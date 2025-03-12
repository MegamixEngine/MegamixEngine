/// unitSuiteTick()
// returns non-zero when test complete

while (true)
{
    if (global.unitTestsRun >= ds_list_size(global.unitTestCaseNames))
    {
        return 1;
    }
    
    if (global.unitTestAction == 0)
    {
        // start new test.
        global.unitTestAction = 1;
        global.unitTestCase = ds_list_find_value(global.unitTestCaseNames, global.unitTestsRun);
        global.unitTestCritical = false;
    }
    
    script_execute(global.unitSuiteScript);
    
    if (global.unitTestAction == 1)
    {
        // expected test to update unitTestAction!
        assert(false, "unit test " + unitTestCase + " is missing unitBegin() or unitExecute().");
        break;
    }
    
    if (global.unitTestAction == 1.5)
    {
        // onBegin() ran; wait a frame then do onTick()
        global.unitTestAction = 2;
        break;
    }
    
    // encountered an error -- move to clean up.
    if (global.unitTestAction == 2 && !unitValid())
    {
        global.unitTestAction = 3;
        break;
    }
    
    if (global.unitTestAction == 4)
    {
        // finished tick; clean-up was performed
        global.unitTestAction = 5;
        break;
    }
    
    if (global.unitTestAction == 3)
    {
        // finished tick; no clean-up.
        global.unitTestAction = 5;
    }
    
    if (global.unitTestAction >= 5)
    {
        // finished case
        global.unitTestsRun++;
        if (global.unitTestAbortAll)
        {
            global.unitTestRun = ds_list_size(global.unitTestCaseNames);
        }
        global.unitTestAction = 0;
        var result = makeStruct();
        result.caseName = global.unitTestCase;
        result.warnings = global.unitTestWarns;
        result.errors = global.unitTestErrors;
        ds_list_add(global.unitTestSuiteResults.unitTestCaseResults, result);
        with (result)
        {
            // defer cleanup
            defer(ev_destroy, ev_destroy, 0, dsDestroy, makeArray(global.unitTestWarns, ds_type_list));
            defer(ev_destroy, ev_destroy, 0, dsDestroy, makeArray(global.unitTestErrors, ds_type_list));
        }
        global.unitTestWarns = mm_ds_list_create();
        global.unitTestErrors = mm_ds_list_create();
        continue;
    }
    
    if (global.unitTestAbortAll)
    {
        return false;
    }
    
    break;
}

return false;
