/// unitSuite(name, script)
// begins a new suite of unit tests as defined in the given script

global.unitSuiteName = argument0;
global.unitSuiteScript = argument1;
global.unitTestCaseNames = ds_list_create();
global.unitTestWarns = ds_list_create();
global.unitTestErrors = ds_list_create();
global.unitTestsRun = 0;
global.unitTestCase = "";
global.unitTestAction = -1; // -1: read suite. 0: new test. 1: begin / execute. 2: tick. 3: tick-terminate. 4: terminate. 5: completed

// output data as a struct containing:
// - suiteName: the name of the unit test suite
// - unitTestCaseResults: a ds_list of structs containing info about each case
global.unitTestSuiteResults = makeStruct();
global.unitTestSuiteResults.suiteName = global.unitSuiteName;
global.unitTestSuiteResults.unitTestCaseResults = ds_list_create();
with (global.unitTestSuiteResults)
{
    // defer cleanup
    defer(ev_destroy, ev_destroy, 0, dsDestroy, makeArray(unitTestCaseResults, ds_type_list));
}

script_execute(global.unitSuiteScript);

global.unitTestAction = 0;
