/// drawControllerOverlay(x,y)
/// shows semi-transparent controller indicating currently pressed buttons

var draw_x, draw_y, active, i, spr;
draw_x = argument0;
draw_y = argument1;

spr = sprControllerOverlay;
if (global.showControllerOverlay == 2)
{
    spr = sprControllerOverlayThin;
}

for (var j = 0; j < global.playerCount; j += 1)
{
    draw_x -= (sprite_get_width(spr) - 28);
    draw_sprite_ext(spr, 0, draw_x, draw_y, 1, 1, 0, c_white, 1 / 1.28);
    draw_set_color(c_white);
    
    // draw red dots
    for (i = 1; i <= 10; i += 1)
    {
        active = false;
        
        // check if key down
        switch (i)
        {
            case 1:
                active = global.keyLeft[j];
                break;
            case 2:
                active = global.keyRight[j];
                break;
            case 3:
                active = global.keyUp[j];
                break;
            case 4:
                active = global.keyDown[j];
                break;
            case 5:
                active = global.keyShoot[j];
                break;
            case 6:
                active = global.keyJump[j];
                break;
            case 7:
                active = global.keySlide[j];
                break;
            case 8:
                active = global.keyWeaponSwitchLeft[j];
                break;
            case 9:
                active = global.keyWeaponSwitchRight[j];
                break;
            case 10:
                active = global.keyPause[j];
                break;
        }
        if (active)
        {
            draw_sprite_ext(spr, i, draw_x, draw_y, 1, 1, 0,
                global.nesPalette[18], 1 / 1.28);
        }
    }
    
    // bevel in between controllers
    draw_x -= 3;
}

draw_set_alpha(1);
draw_set_color(c_white);
