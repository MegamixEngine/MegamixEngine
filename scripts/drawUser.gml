/// drawUser(myEvent, ...)
///drawUser(user event number, [hitspark_sprite index], [spark x], [spark y]);
/*
draws to a particular user event. useful if you want to maintain the primary megamix drawing
code but build a sprite out of parts, say.
*/
var myEvent = argument[0];
var hitSpark = sprHitspark;
var mX = 0;
var mY = 0;
if (argument_count >= 2)
{
    if (argument[1] != true)
        hitSpark = argument[1];
}

if (argument_count >= 3)
{
    mX = argument[2];
}

if (argument_count >= 4)
{
    mY = argument[3];
}

if (!dead)
{
    // this debug message should be left in until
    // the spawn system stops breaking every week.
    if (spawned == -1)
    {
        show_debug_message(object_get_name(object_index) + " drawn without having ever spawned!");
    }
    
    if ((ceil(iFrames / 2) mod 4) || !iFrames)
    {
        var iceBlinkTime = 42;
        if ((ceil(iFrames / 2) mod 2) || (iceTimer > 0 && (iceTimer > iceBlinkTime || (iceTimer <= iceBlinkTime && iceTimer mod 4 == 0))))
        {
            if (argument_count == 1)
            {
                var flashcol = c_white;
                if (iceTimer > 0 && (iceTimer > iceBlinkTime || (iceTimer <= iceBlinkTime && iceTimer mod 4 == 0)))
                {
                    switch (iceGraphicStyle)
                    {
                        case 2:
                            flashcol = make_color_rgb(252,216,132);
                            break;
                        case 1:
                            flashcol = 0;
                            break;
                        default:
                            flashcol = make_color_rgb(0, 120, 255);
                            break;
                    }
                }
                
                hitFlashEffect(true,flashcol);
                event_user(myEvent);
                hitFlashEffect(false);
                
                if (iceTimer > 0 && (iceTimer > iceBlinkTime || (iceTimer <= iceBlinkTime && iceTimer mod 4 == 0)))
                {
                    draw_set_blend_mode(bm_add);
                    event_user(myEvent);
                    draw_set_blend_mode(bm_normal);
                }
            }
            else
            {                
                draw_sprite_ext(sprHitspark, 0, spriteGetXCenter() + (mX * sign(image_xscale)), spriteGetYCenter() + (mY * sign(image_yscale)), 1, 1, 0, c_white, 1);                
            }
        }
        else
        {
            // Special effect when invincibile
            if (invincible)
            {
                var _xscale = image_xscale,
                    _yscale = image_yscale,
                    _sin_factor = sin(sparkleTimer * 0.15) * 0.08;
                image_xscale *= 1.075 + (_sin_factor * sign(image_xscale));
                image_yscale *= 1.025 + (_sin_factor * sign(image_yscale));
                
                d3d_set_fog(true, c_white, 0, 0);
                event_user(myEvent);
                d3d_set_fog(false, 0, 0, 0);
                
                image_xscale = _xscale;
                image_yscale = _yscale;
            }
            
            event_user(myEvent);
        }
    }
}
