/// reAndDeactivateObjects(reset/deactivate objects, activate objects)

// Argument0: 1 to Deactivate all objects
// Entites that have "shiftVisible > 0" and prtAlwaysActive-objects do not get deactivated
// Argument1: 1 to Reactivate objects in the current section

var deac = argument0;
var reac = argument1;
var sw = global.switchingSections;

if (deac)
{
    if (DEBUG_SPAWN && DEBUG_ENABLED)
    {
        show_debug_message("Instance deactivation");
    }
    
    with (prtEffect)
    {
        if (despawn)
        {
            instance_destroy();
        }
    }
    
    var specialObjects = makeArray(objQuickSand, prtRail); // these objects behave differently, but we still want to deactivate them after a transition
    var n = array_length_1d(specialObjects);
    
    with (all)
    {
        if (object_index == prtEntity || object_is_ancestor(object_index, prtEntity))
        {
            var reset = 1;
            
            if (shiftVisible)
            {
                reset = ((!sw &&(!collision_rectangle(global.sectionLeft, global.sectionTop, global.sectionRight, global.sectionBottom, id, true, false))));
                
                if (!reset)
                {
                    if (faction != 1 && faction != 2)
                    {
                        with (objSpawnCondition)
                        {
                            if (faction == other.faction || faction < 0)
                            {
                                if (place_meeting(x, y, other))
                                {
                                    event_user(0);
                                    reset = !allowSpawn;
                                    break;
                                }
                            }
                        }
                    }
                }
            }
            
            if (reset)
            {
                if (deac < 2)
                {
                    if (shiftVisible < 2 || dead)
                    {
                        if (!respawn)
                        {
                            instance_destroy();
                        }
                        else
                        {
                            dead = true;
                            beenOutsideView = false;
                            spawned = false;
                            
                            event_user(EV_SPAWN); // despawn event
                            event_perform(ev_step, ev_step_normal);
                            
                            beenOutsideView = true;
                        }
                    }
                }
                if (shiftVisible < 3)
                {
                    instance_deactivate_object(id);
                }
            }
            
        }
        else if (object_index != prtAlwaysActive && !object_is_ancestor(object_index, prtAlwaysActive))
        {
            var stay = 0;
            
            for (var i = 0; i < n; i++)
            {
                if (object_index == specialObjects[i] || object_is_ancestor(object_index, specialObjects[i]))
                {
                    stay = (sw || collision_rectangle(global.sectionLeft, global.sectionTop, global.sectionRight, global.sectionBottom, id, true, false));
                    break;
                }
            }
            
            if (!stay)
            {
                instance_deactivate_object(id);
            }
        }
    }
}

if (reac)
{
    instance_activate_region(global.sectionLeft, global.sectionTop,
        abs(global.sectionRight - global.sectionLeft) - 1,
        abs(global.sectionBottom - global.sectionTop) - 1, true);
    
    if (DEBUG_SPAWN && DEBUG_ENABLED)
    {
        show_debug_message("Instance activation");
    }
}
