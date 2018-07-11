/// unitCase(name)

var name = argument0;

if (global.unitTestAction == -1)
{
    ds_list_add(global.unitTestCaseNames, name);
}

return global.unitTestAction > 0 && global.unitTestCase == name;
