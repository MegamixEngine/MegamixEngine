/// collisionRectangleList(x1, y1, x2, y2, obj, prec, notme);

/*  Arguments:
**      x1, y1       first corner of the collision rectangle (filled)
**      x2, y2       opposite corner of the collision rectangle (filled)
**      obj         object to check for collision
**      prec        set to true for precise collision checking
**      notme       set to true to ignore the calling instance
**
**  Returns:
**      a ds_list id, or keyword noone if no instances are found
**
**  GMLscripts.com
*/

var x1, y1, x2, y2, obj, prec, notme, dsid, i;

x1 = argument0;
y1 = argument1;
x2 = argument2;
y2 = argument3;
obj = argument4;
prec = argument5;
notme = argument6;
dsid = ds_list_create();

with (obj)
{
    if (!notme || id != other.id)
    {
        i = collision_rectangle(x1, y1, x2, y2, id, prec, false);
        if (i != noone)
            ds_list_add(dsid, i);
    }
}
if (ds_list_empty(dsid))
{
    ds_list_destroy(dsid);
    dsid = noone;
}

return dsid;
