/// drawCostume(costume, sheetX, sheetY, x, y, xscale, yscale, colBase, colPrimary, colSecondary, colOutline, [alphaBase = 1, alphaPrimary = 1, alphaSecondary = 1, alphaOutline = 1, image_angle])
// draws the given costume (player skin) at the given coordinates with the given palette.
// costume: sprite index of costume (e.g. objMegaman)
// sheetX, sheetY: coord (in 48x48 units) of the animation frame in the skin sheet.
// colBase: blend mode to use for the base colour (leave as c_white)
// colPrimary, colSecondary, colOutline: palette colours
// [alphaBase, alphaPrimary, alphaSecondary, alphaOutline] (optional): alpha values for palette (0-1)

var costume = argument[0],
    sheetX = argument[1],
    sheetY = argument[2],
    _x = argument[3],
    _y = argument[4],
    _xscale = argument[5],
    _yscale = argument[6],
    col,
    alpha,
    _angle = 0;

// palette
for (var i = 0; i < 4; i++)
{
    col[i] = argument[7 + i];
    if (argument_count > 11 + i)
        alpha[i] = argument[11 + i];
    else
        alpha[i] = 1;
}

// image angle
if (argument_count > 15)
{
    _angle = argument[15];
}

// drawing
var SquareSize = 46;
var _spriteXOff = 23 * _xscale; // normal sprite offsets
var _spriteYOff = 19 * _yscale;


var _surface = noone;
var _left = 2 + (floor(sheetX) * (SquareSize + 5))
var _top  = 2 + (floor(sheetY) * (SquareSize + 5))

if (costume >= sprFINALSPRITE_DONTMOVE)//If greater than this value, assume it is a custom costume, as new sprites come at the end of built-in ones.
{//As in-game, custom costumes only render the inner cells, we don't have to worry about borders, so give them more space to work with!
    SquareSize = 48;
    _spriteXOff = 24 * _xscale; // normal sprite offsets
    _spriteYOff = 20 * _yscale;
    _left = 1 + (floor(sheetX) * (SquareSize + 3))
    _top  = 1 + (floor(sheetY) * (SquareSize + 3))
}
if (_angle == 0)
{
    // draw player sprite
    for (var i = 0; i < 4; i += 1)
    {
        draw_sprite_part_ext(costume, i,
            _left, _top,
            SquareSize, SquareSize,
            (_x - _spriteXOff),
            (_y - _spriteYOff),
            _xscale, _yscale,
            col[i], alpha[i]);
    }
}
else
{
    // draw player sprite on a surface so we can rotate it (draw_sprite_general has glitches when rotating)
    _surface = mm_surface_create(48, 48);
    surface_set_target(_surface);
    draw_clear_alpha(c_white, 0);
    
    // draw player sprite without alterations
    for (var i = 0; i < 4; i += 1)
    {
        draw_sprite_part_ext(costume, i,
            _left, _top,
            SquareSize, SquareSize,
            0, 0, 1, 1,
            col[i], alpha[i]);
    }
    
    surface_reset_target();
    
    // calculate offset when rotating to compensate for only being able to draw from the top-left of the surface
    var _d = sqrt(power(_spriteYOff, 2) + power(_spriteXOff, 2));
    var _rotOff = arctan2(-_spriteYOff, _spriteXOff);
    
    _spriteXOff = round(_d * cos(_rotOff + degtorad(_angle)));
    _spriteYOff = round(_d * -sin(_rotOff + degtorad(_angle)));
    
    // reset target and draw surface rotated
    draw_surface_ext(_surface,
        _x - _spriteXOff,
        _y - _spriteYOff,
        _xscale, _yscale,
        _angle, c_white, 1);
    
    mm_surface_free(_surface);
}
