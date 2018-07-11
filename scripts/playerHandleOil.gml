/// playerHandleOil();
// Oil
if (!teleporting && !showReady)
{
    if ((place_meeting(x, y, objOil) && !place_meeting(x, y - yspeed, objOil))
        || (!place_meeting(x, y, objOil) && place_meeting(x, y - yspeed, objOil)))
    {
        var wtr;
        if (place_meeting(x, y, objOil))
        {
            wtr = instance_place(x, y, objOil);
        }
        else
        {
            wtr = instance_place(x, y - yspeed, objOil);
        }
        if (!wtr.fire)
        {
            with (wtr)
            {
                event_user(1);
            }
        }
    }
}
