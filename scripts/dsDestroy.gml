/// dsDestroy(id, type)
/// frees the given data structure

var dsID = argument0;
var dsType = argument1;

if (dsID < 0)
    exit;

if (ds_exists(dsID, ds_type_map) && dsType == ds_type_map)
    ds_map_destroy(dsID);
if (ds_exists(dsID, ds_type_list) && dsType == ds_type_list)
    ds_list_destroy(dsID);
if (ds_exists(dsID, ds_type_stack) && dsType == ds_type_stack)
    ds_stack_destroy(dsID);
if (ds_exists(dsID, ds_type_queue) && dsType == ds_type_queue)
    ds_queue_destroy(dsID);
if (ds_exists(dsID, ds_type_grid) && dsType == ds_type_grid)
    ds_grid_destroy(dsID);
if (ds_exists(dsID, ds_type_priority) && dsType == ds_type_priority)
    ds_priority_destroy(dsID);
