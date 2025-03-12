///drawDebugText(x,y,string,[alpha], [scale x], [scale y], [angle]);
//quick script to bodge out on-screen debugging text without having to re-set drawing every single time
var al = 1;
var xs = 1;
var ys = 1;
var ang = 0;

if (argument_count > 3)
    al = argument[3];
if (argument_count > 4)
    xs = argument[4];
if (argument_count > 5)
    ys = argument[5];
if (argument_count > 6)
    ang = argument[6];


draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_set_colour(c_white);
draw_set_alpha(al);


draw_text_transformed(argument[0],argument[1],argument[2],xs,ys,ang);
