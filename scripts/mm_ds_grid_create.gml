/// mm_ds_grid_create(w,h)
var newList = ds_grid_create(argument[0],argument[1]);
mm_registeritem(newList,MEMORYMANAGER_GRID);
return newList;
