/// mm_sprite_delete(sprite)
//NOTE: ONLY USE FOR FIRE TOTEMS!


mm_deregisteritem(argument[0],MEMORYMANAGER_SURFACE);

sprite_delete(argument[0]);
