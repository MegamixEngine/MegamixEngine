/// mm_surface_destroy(surf)
var surf = argument0;

mm_deregisteritem(surf,MEMORYMANAGER_SURFACE);

surface_free(surf);
