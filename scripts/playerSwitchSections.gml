/// playerSwitchSections()
// Moving from one section to the next, if possible

// newSectionXOffset/newSectionYOffset are used to get the right section borders in the new section
// Taking the normal X/Y coordinate would result in rounding errors in setSection(),
// which could either cause the game to freeze or the wrong section borders to be used
// Using 16 or 32 instead of 64 would also occassionally cause these problems, probably because of the +6/-6

if (global.lockTransition || deathByPit)
{
    exit;
}

// Check for platform
plat = -1;
if (ground)
{
    with (prtEntity)
    {
        if (!dead && isSolid)
        {
            if (doesTransition && (xspeed != 0 || yspeed != 0))
            {
                if (place_meeting(x, y - 2 * other.gravDir, other.id) && !place_meeting(x, y, other.id))
                {
                    other.plat = id;
                    break;
                }
            }
        }
    }
}

if (instance_exists(objSectionSwitcher))
{
    exit;
}

// Right
if (x > (global.sectionRight - 8) && place_meeting(x - xspeed + 6, y, objSectionArrowRight))
{
    if (!place_meeting(global.sectionRight, y, objSolid) || !blockCollision || global.freeMovement)
    {
        x = global.sectionRight - 6;
        setSection(x + 64, (view_yview + view_hview * 0.5), 1);
        with (instance_create(x, y, objSectionSwitcher))
        {
            dir = "x";
            num = 1;
            exit;
        }
    }
}

// Left
if (x < (global.sectionLeft + 8) && place_meeting(x - xspeed - 6, y, objSectionArrowLeft))
{
    if (!place_meeting(global.sectionLeft, y, objSolid) || !blockCollision || global.freeMovement)
    {
        x = global.sectionLeft + 6;
        setSection(x - 64, (view_yview + view_hview * 0.5), 1);
        with (instance_create(x, y, objSectionSwitcher))
        {
            dir = "x";
            num = -1;
            exit;
        }
    }
}

// Down
if (bboxGetYCenter() > (global.sectionBottom - (6 + (plat > 0) * 8)) && position_meeting(x, global.sectionBottom - 8, objSectionArrowDown))
{
    if ((climbing || gravDir == 1 || plat || (playerIsLocked(PL_LOCK_GRAVITY)) || global.freeMovement)
        && (!place_meeting(x, global.sectionBottom, objSolid) || global.freeMovement))
    {
        if (!plat)
        {
            y = global.sectionBottom - 6 + sprite_yoffset - (sprite_height / 2);
        }
        setSection(x, y + 64, 1);
        with (instance_create(x, y, objSectionSwitcher))
        {
            dir = "y";
            num = 1;
            exit;
        }
    }
}

// Up
if (bboxGetYCenter() < (global.sectionTop + (6 + (plat > 0) * 8)) && position_meeting(x, global.sectionTop + 8, objSectionArrowUp))
{
    if ((climbing || gravDir == -1 || plat || (playerIsLocked(PL_LOCK_GRAVITY)) || global.freeMovement)
        && (!place_meeting(x, global.sectionTop, objSolid) || !blockCollision || global.freeMovement))
    {
        if (!plat)
        {
            y = global.sectionTop + 6 + sprite_yoffset - (sprite_height / 2);
        }
        setSection(x, y - 64, 1);
        with (instance_create(x, y, objSectionSwitcher))
        {
            dir = "y";
            num = -1;
            exit;
        }
    }
}
