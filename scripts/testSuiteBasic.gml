// a basic suite of tests

if (unitCase("Very basic test"))
{
    // if this case fails, no more unit tests will run.
    unitCritical();
    
    // single-execution
    if (unitExecute())
    {
        // will fail if this is false (but will not exit test):
        unitRequire(1 + 1 == 2, "summation must not fail");
        
        // will be flagged if this is false (but will not exit test):
        unitCheck("a" + "b" == "ab", "string concatenation would be nice, too.");
    }
}

// for another educational unit test see testSuiteBasicExternalLoad
