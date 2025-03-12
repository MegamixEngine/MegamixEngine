/// mouseGetPosition([isY?])
/*Gets the position of the mouse relative to the screen. Used to fix issues with
drawing the borders.

*/

var ret = 0;
if (argument_count > 0 && argument[0])
{
    ret = ((window_mouse_get_y()-global.mouseStartY)*1/global.screensize)+view_yview;
}
else
{//4:3 only affects the X position.
    ret = ((window_mouse_get_x()-global.mouseStartX)*1/(global.screensize*global.mouseScreenRatio))+view_xview;
}
//printErr(ret);
return ret;
