/// mm_sprite_create_from_surface(id,x,y,w,h,removeback,smooth,xorig,yorig)
//NOTE: ONLY USE FOR FIRE TOTEMS!
var sprite = sprite_create_from_surface(argument[0],
argument[1],argument[2],argument[3],argument[4],argument[5],argument[6],argument[7],argument[8]);

mm_registeritem(sprite,MEMORYMANAGER_SPRITE);

return sprite;
