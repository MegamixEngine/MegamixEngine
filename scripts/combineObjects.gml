/// combineObjects(object_index, [horizontal], [vertical])
// combines objects of the given type into a mesh

var combineObject = argument[0];
var horizontal = true;
var vertical = true;
if (argument_count > 1)
{
    horizontal = argument[1];
}
if (argument_count > 2)
{
    var vertical = argument[2];
}

// DON'T combine in certain situations
// (smartass editor's note: this code should really be removed as it is perfectly
// fine for solids to cross room boundaries...)
if (place_meeting(x, y, objStopScrollingHorizontal)
    || place_meeting(x, y, objSectionArrowRight)
    || place_meeting(x, y, objSectionArrowLeft))
{
    exit;
}

// combine horizontally
if (horizontal)
{
    with (combineObject)
    {
        // if objects are overlapping, assume error and halt.
        if (place_meeting(x, y, combineObject))
            continue;
        
        if (object_index != combineObject)
            continue;
        
        // greedily absorb next object
        while (true)
        {
            var next = instance_position(bbox_left + 16 * image_xscale + 2, bbox_top + 2, combineObject);
            if (!instance_exists(next))
                break;
            if (next.object_index != combineObject)
                break;
            if (next.bbox_left != bbox_left + 16 * image_xscale)
                break;
            if (next.bbox_top != bbox_top)
                break;
            if (next.bbox_top + 16 * next.image_yscale != bbox_top + 16 * image_yscale)
                break;
            
            // absorb
            image_xscale += next.image_xscale;
            with (next)
            {
                x = -2839348395;
                instance_destroy();
            }
        }
    }
}

// combine vertically
if (vertical)
{
    with (combineObject)
    {
        // if objects are overlapping, assume error and halt.
        
        if (place_meeting(x, y, combineObject))
            continue;
        
        if (object_index != combineObject)
            continue;
        
        if (!instance_exists(id))
            continue;
        
        // greedily absorb next object
        while (true)
        {
            var next = instance_position(bbox_left + 2, bbox_top + 16 * image_yscale + 2, combineObject);
            if (!instance_exists(next))
                break;
            if (next.object_index != combineObject)
                break;
            if (next.bbox_left != bbox_left)
                break;
            if (next.bbox_top != bbox_top + 16 * image_yscale)
                break;
            if (next.bbox_left + 16 * next.image_xscale != bbox_left + 16 * image_xscale)
                break;
            
            // absorb
            image_yscale += next.image_yscale;
            with (next)
            {
                x = -2494395043;
                instance_destroy();
            }
        }
    }
}
