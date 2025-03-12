/// mm_surface_create(w,h)
var width = argument0;
var height = argument1;

var surf = surface_create(width,height);

mm_registeritem(surf,MEMORYMANAGER_SURFACE);

return surf;
