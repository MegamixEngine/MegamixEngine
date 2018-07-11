// a suite of tests for a few useful functions

if (unitCase("roundTo"))
{
    if (unitExecute())
    {
        unitRequire(roundTo(17, 5) == 15, "incorrect arithmetic");
    }
}


if (unitCase("modf"))
{
    if (unitExecute())
    {
        unitRequire(roundTo(17, 5) == 15, "incorrect arithmetic");
        
        for (var i = -3; i < 7; i++)
        {
            for (var j = -2; j < 5; j++)
            {
                unitRequire(modf(i * j, i) == 0, "incorrect arithmetic");
                if (!unitValid())
                {
                    exit;
                }
            }
        }
    }
}

if (unitCase("makeArray"))
{
    if (unitExecute())
    {
        unitRequire(array_length_1d(makeArray(1, 2, 5, 8)) == 4, "incorrect size");
        
        var a = makeArray("a", "bc", "def");
        unitRequire(a[1] == "bc", "incorrect data in array");
        unitRequireEquals(array_length_1d(makeArray()), 0, "0-length array malformed");
    }
}

if (unitCase("quicksort"))
{
    if (unitExecute())
    {
        repeat (3)
        {
            for (var j = 1; j < 100; j += 7)
            {
                var arr = makeArray(0);
                var m = 0.2 + random(100);
                for (var i = 0; i < j; i++)
                {
                    arr[i] = random(m) - random(0.1);
                    
                    // put some integers in too
                    if (random(1) < 0.1)
                        arr[i] = floor(arr[i]);
                }
                
                quickSort(arr);
                unitRequire(array_length_1d(arr) == j, "quicksort changed length of array");
                
                for (var i = 0; i < array_length_1d(arr) - 1; i++)
                {
                    unitRequire(arr[i] <= arr[i + 1], "quicksort put array out of order.");
                }
            }
        }
    }
}
