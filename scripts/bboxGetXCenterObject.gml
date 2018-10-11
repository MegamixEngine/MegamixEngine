///bboxGetXCenterObject(obj)

var v;
v = argument0;
return round(v.bbox_left + (v.bbox_right - v.bbox_left) * 0.5);
