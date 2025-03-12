/// mathTableSetup(); (Only run once at the start of the game)

// trig tables ( value of the table at index 45 for instance gives cos(degtorad(45)) )
global.sinTableID = mm_ds_list_create();

for (var i = 0; i < 24; i++)
{
    var line = sin(degtorad(i * 15));
    ds_list_add(global.sinTableID, line);
}
