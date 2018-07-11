// a suite of tests for string functions

if (unitCase("stringTrim"))
{
    if (unitExecute())
    {
        unitRequireEquals(stringTrim("foo1"), "foo1");
        unitRequireEquals(stringTrim(" foo2"), "foo2");
        unitRequireEquals(stringTrim("foo3    "), "foo3");
    }
}

if (unitCase("stringJoin"))
{
    if (unitExecute())
    {
        var a = makeArray(0, 1, 3, "geh")
            ;
        var b = a;
        unitRequireEquals(stringJoin(a, ", "), "0, 1, 3, geh", "Incorrect return result");
        unitRequireEquals(a, b, "Does not modify array");
    }
}

if (unitCase("string_at"))
{
    if (unitExecute())
    {
        unitRequire(stringAt("test", "est", 1) == false);
        unitRequire(stringAt("test", "est", 2) == true);
        unitRequire(stringAt("test", "est", 3) == false);
    }
}

if (unitCase("stringSplit"))
{
    if (unitExecute())
    {
        var a = stringSplit("aleph, beta , gimmel, hey", ",", true);
        unitRequireEquals(a, makeArray("aleph", "beta", "gimmel", "hey"));
        
        var b = stringSplit(",aleph, beta  , gimmel, hey,", ",");
        unitRequireEquals(b, makeArray("", "aleph", " beta  ", " gimmel", " hey", ""));
        
        var c = stringSplit("aleph, beta  , gimmel,hey", ", ");
        unitRequireEquals(c, makeArray("aleph", "beta  ", "gimmel,hey"));
        
        var d = stringSplit("test", "");
        unitRequireEquals(d, makeArray("t", "e", "s", "t"));
    }
}

if (unitCase("category parsing"))
{
    if (unitExecute())
    {
        unitRequire(hasCategory("a, b,c , ef", "a"), "a");
        unitRequire(hasCategory("a, b,c , ef", "b"), "b");
        unitRequire(hasCategory("a, b,c , ef", "c"), "c");
        unitRequire(hasCategory("a, b,c , ef", "ef"), "ef");
        unitRequire(!hasCategory("a, b,c , ef", "d"), "d");
    }
}
