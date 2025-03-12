/// drawPlayerInk(playerID, sheetX, sheetY, x, y, xscale, yscale, [image_angle])
// draws the given player at the given position under the octone ink effect
// that is, all black except for the eyes (white) and outline (39)
// sheetX, sheetY: coord (in 48x48 units) of the animation frame in the skin sheet.

var cid = argument[0],
    sheetX = argument[1],
    sheetY = argument[2],
    _x = argument[3],
    _y = argument[4],
    _xscale = argument[5],
    _yscale = argument[6];
    _angle = 0;

if (argument_count > 7)
{
    _angle = argument[7];
}

if (global.inkSurface[0] == -1 || !surface_exists(global.inkSurface[0]))
{
    global.inkSurface[0] = mm_surface_create(48, 48);
    global.inkSurface[1] = mm_surface_create(48, 48);
}
var v = 0;
if (global.inkSurface[0])
{
    surface_set_target(global.inkSurface[1]);
    draw_clear_alpha(c_black, 0);
    surface_reset_target();
    surface_set_target(global.inkSurface[0]);
    draw_clear_alpha(c_black, 0);
    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_set_blend_mode(bm_normal);
    d3d_set_fog(true, c_white, 0, 0);
    drawCostume(global.playerSprite[cid], sheetX, sheetY, 24, 20, 1, 1,
        c_white, c_white, c_white, c_white, 1, 1, 1, 1, _angle);
    d3d_set_fog(false, 0, 0, 0);
    draw_set_blend_mode(bm_subtract);
    drawCostume(global.playerSprite[cid], sheetX, sheetY, 24, 20, 1, 1,
        c_white, c_black, c_black, c_black, 0, 0, 0, 0, _angle);
    
    // saturate RGB values greater the 0xfc, set all others to 0.
    draw_set_alpha(0);
    draw_set_blend_mode(bm_add);
    draw_set_color(c_white);
    draw_set_alpha(1);
    for (var i = 0; i <= 10; i++)
    {
        v = !v;
        surface_reset_target();
        surface_set_target(global.inkSurface[v]);
        draw_surface(global.inkSurface[1 - v], 0, 0);
    }
    
    surface_reset_target();
    draw_set_alpha(1);
    surface_set_target(global.inkSurface[0]);
    d3d_set_fog(true, c_white, 0, 0);
    drawCostume(global.playerSprite[cid], sheetX, sheetY, 24, 20, 1, 1,
        c_white, c_white, c_white, c_white, 1, 1, 1, 1, _angle);
    d3d_set_fog(false, 0, 0, 0);
    draw_set_blend_mode(bm_subtract);
    draw_set_alpha(0);
    draw_surface(global.inkSurface[1], 0, 0);
    surface_reset_target();
    draw_set_blend_mode(bm_normal);
    draw_surface_ext(global.inkSurface[0], _x - 24 * _xscale, _y - 20 * _yscale, _xscale, _yscale, 0, c_white, 1);
    draw_set_alpha(1);
    var mB = c_black;
    if (global.playerCount > 1 && global.multiplayerColors)
        mB = global.multiplayerPalette[playerID,MULTPAL_INKED];
                
    drawCostume(global.playerSprite[cid], sheetX, sheetY, _x, _y, _xscale, _yscale,
        c_white, c_black, mB, global.nesPalette[$2D], 0, 0, 0, 1, _angle);
}
