/// unitRequireEquals(a, b, [message])
// adds a unit-test error of the given string if the two values are not equal
// also displays the two values if they differ.

var a = argument[0];
var b = argument[1];
var message = "";
if (argument_count > 2)
{
    message = argument[2] + "
    
    ";
}

var cond;

// arrays are compared differently
if (is_array(a) && is_array(b))
{
    if (array_height_2d(a) != array_height_2d(b))
    {
        cond = false
    }
    else
    {
        cond = true;
        for (var i = 0; i < array_height_2d(a); i++)
        {
            if (array_length_2d(a, i) != array_length_2d(b, i))
            {
                cond = false;
            }
            else 
            {
                for (var j = 0; j < array_length_2d(a, i); j++)
                {
                    if (a[i, j] != b[i, j])
                    {
                        cond = false;
                    }
                }
            }
        }
    }
}
else if (is_array(a) ^^ is_array(b))
{
    cond = false;
}
else
{
    cond = a == b;
}

unitRequire(cond, message + string(a) + " != " + string(b));
