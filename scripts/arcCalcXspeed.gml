/// arcCalcXspeed(yspeed, gravity, spawn_x, spawn_y, impact_x, impact_y, [speed_limit])
var t_yspeed;
t_yspeed = argument[0];
var t_grav;
t_grav = argument[1];
var t_spawn_x;
t_spawn_x = argument[2];
var t_spawn_y;
t_spawn_y = argument[3];
var t_impact_x;
t_impact_x = argument[4];
var t_impact_y;
t_impact_y = argument[5];
var t_speed_limit = 8;
if (argument_count > 6)
{
    t_speed_limit = argument[6];
}

var t_y;
t_y = t_spawn_y;
var t_yprev;
t_yprev = t_y;
var time;
time = 0;
do
{
    time += 1;
    t_yprev = t_y;
    t_y += t_yspeed;
    t_yspeed += t_grav;
}
    until ((t_y >= t_impact_y && t_yprev < t_impact_y)
    || (t_yspeed > 0 && t_y > t_impact_y))

t_new_xspeed = (t_impact_x - t_spawn_x) / time;

// enforce speed limit
if (t_speed_limit != -1 && abs(t_new_xspeed) > t_speed_limit)
{
    if (t_new_xspeed > 0)
    {
        t_new_xspeed = t_speed_limit;
    }
    else
    {
        t_new_xspeed = -t_speed_limit;
    }
}

return t_new_xspeed;
