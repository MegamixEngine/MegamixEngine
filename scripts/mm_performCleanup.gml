/// mm_performCleanup

//mm_printManager();
if (ds_map_size(global.memoryManager) == 0)
{
    exit;
}
var entry = ds_map_find_first(global.memoryManager);
//var data =
while (true)//entry != last)//var i = 0; i < ds_map_size(global.memoryManager); i++)
{
    var data = ds_map_find_value(global.memoryManager,entry);
    var next = ds_map_find_next(global.memoryManager,entry);
    //show_message(data);
    assert(is_array(data),"MEM MANAGER DATA IS NOT ARRAY");
    var obj = asset_get_index(data[2]);
    switch (obj)
    {
        
        case objGlobalControl:
        case objMusicControl:
        case objMobileControl:
        
        
        break;
        case -1://Global variables. If they fail this test, they are instead room CC.
            if (data[2] == "!")
            {
                break;
            }
        default:
            if (!(object_get_persistent(obj) && object_is_ancestor(obj,prtAlwaysActive)))
            {
                ds_map_delete(global.memoryManager,entry);
                switch (data[1])
                {
                    case MEMORYMANAGER_LIST:
                        if (ds_exists(data[0],ds_type_list))
                            ds_list_destroy(data[0]);
                    break;
                    case MEMORYMANAGER_MAP:
                        if (ds_exists(data[0],ds_type_map))
                            ds_map_destroy(data[0]);
                    break;
                    case MEMORYMANAGER_GRID:
                        if (ds_exists(data[0],ds_type_grid))
                            ds_grid_destroy(data[0]);
                    break;
                    case MEMORYMANAGER_SURFACE:
                        if (surface_exists(data[0]))
                            surface_free(data[0]);
                    break;
                    case MEMORYMANAGER_STACK:
                        if (ds_exists(data[0],ds_type_stack))
                            ds_stack_destroy(data[0]);
                    break;
                    case MEMORYMANAGER_QUEUE:
                        if (ds_exists(data[0],ds_type_queue))
                            ds_queue_destroy(data[0]);
                    break;
                    case MEMORYMANAGER_PRIORITY:
                        if (ds_exists(data[0],ds_type_priority))
                            ds_priority_destroy(data[0]);
                    break;
                    case MEMORYMANAGER_SPRITE:
                        if (sprite_exists(data[0]))
                        {
                            sprite_delete(data[0]);
                        }
                    break;
                }
                
            }
            //i--;
        break;
    }
    
    
    if (!is_undefined(next))
    {
        entry = next;
    }
    else
    {
        break;
    }
}
customCostume_ClearDisplay();
