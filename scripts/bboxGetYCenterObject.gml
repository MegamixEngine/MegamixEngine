/// bboxGetXCenterObject(obj)

var v;
v = argument0;
return round(v.bbox_top + (v.bbox_bottom - v.bbox_top) * 0.5);
