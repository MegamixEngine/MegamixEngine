/// testSuiteBossDoorsHelperMockInput()

var dir = "r";
with (objMegaman)
{
    if (y > 720 && y < 820)
    {
        dir = "l";
    }
}

var jump = "";
if (global.roomTimer mod 100 == 50)
{
    jump += "J";
}
if (global.roomTimer div 50 mod 2 == 1)
{
    jump += "j";
}

return "-0:" + dir + jump + "|-";
