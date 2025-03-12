/// drawWeaponIcon(weaponID, playerID, costumeID, x, y, [color-type], [wheel-signifier], [show status], [crop])

var _col;

var _weaponID   = argument[0];
var _playerID   = argument[1];
var _costumeID  = argument[2];

if (global.customCostumeEquipped[_playerID])
{
    _costumeID  = global.customCostumeIndex+_playerID
}

var _x          = argument[3];
var _y          = argument[4];

_x = round(_x);
_y = round(_y);

var _colorType  = 0; // Which color type (0 = grey / 1 = color / 2&3 = 0&1 but dimmed)
var _wheelShow  = 0; // Show on the icon which weapon-wheel slots the weapon is assigned to
var _showStatus = 0; // Show lock- and infinity-status
var _crop       = 0; // Crop - only needed for weapon-wheel

var _args = argument_count;

if (_args > 5)
{
    _colorType = argument[5];
    
    if (_args > 6)
    {
        _wheelShow = argument[6];
        
        if (_args > 7)
        {
            _showStatus = argument[7];
            
            if (_args > 8)
            {
                _crop = argument[8];
            }
        }
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

// Get sprite
var _spr = sprWeaponIconsBlank;
var _imgs = 4;

if (_weaponID  >= 0) // Get weapon icon if proper weapon assigned
{
    _spr = global.weaponIcon[_weaponID];
}

//Get color
if ((_colorType mod 2) && (_weaponID >= 0)) // 1 - Color
{
    _col[0] = make_color_rgb(255, 228, 164);
    _col[1] = getWeaponPrimaryColor(  _weaponID, _costumeID,_playerID);
    //override above if using multiplayer colors.
    if ((_weaponID == 0 || global.weaponPrimaryColor[global.weapon[_playerID]]) && (global.playerCount > 1 && global.multiplayerColors))
        _col[1] = global.multiplayerPalette[_playerID,global.weapon[_playerID]];
    _col[2] = getWeaponSecondaryColor(_weaponID, _costumeID);
    _col[3] = c_white;
}
else // 0 - Grey
{
    _col[0] = c_white;
    _col[1] = global.nesPalette[$0];  //Dark grey
    _col[2] = global.nesPalette[$10]; //Grey
    _col[3] = c_white;
    
    _imgs = 3;
}

if (_colorType >= 2) // 3 or 4 - Dim color from 1 & 2
{
    _col[0] = _col[2];
    _col[3] = _col[2];
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if (!_crop) // No cropping
{
    for (_i = 0; _i < _imgs; _i ++;) //Draw icon
    {
        draw_sprite_ext(_spr, _i, _x, _y, 1, 1, 0, _col[_i], 1);
    }
    
    if (global.WheelEnabled)
    {
        if (_wheelShow) //Draw weapon wheel signifier
        {
            var _direction = 0;
            
            shaderSetColorreplace(
                make_color_rgb(32, 32, 32), _col[1], 
                make_color_rgb(64, 64, 64), _col[2]);
            
            for (var _ii = 0; _ii < 8; _ii ++;)
            {
                _direction = (_ii * 45);
                
                if (global.wheelSetWep[_playerID, _ii] == _weaponID)
                {
                    draw_sprite_ext(sprWeaponWheelSetIcons, (_ii mod 2), 
                        (_x + 8) + floor(lengthdir_x(8, _direction)),
                        (_y + 8) + floor(lengthdir_y(8, _direction)),
                        1, 1, floorTo(_direction, 90), c_white, 1);
                }
            }
            
            shader_reset();
        }
    }
}
else // Crop-mode (used for the weapon-wheel)
{
    var _surf = mm_surface_create(13, 13);
    
    surface_set_target(_surf);
    
    // - - -
    
    draw_clear_alpha(c_white, 1);
    
    draw_set_blend_mode(bm_subtract);
    draw_point(0 ,  0);
    draw_point(12,  0);
    draw_point(0 , 12);
    draw_point(12, 12);
    draw_set_blend_mode(bm_normal);
    
    draw_set_colour_write_enable(1, 1, 1, 0);
    
    for (var _i = 0; _i < _imgs; _i ++;) //Draw icon
    {
        draw_sprite_ext(_spr, _i, -2, -2, 1, 1, 0, _col[_i], 1);
    }
    
    // - - -
    
    surface_reset_target();
    
    draw_surface(_surf, (_x + 2), (_y + 2));
    
    draw_set_colour_write_enable(1, 1, 1, 1);
    
    mm_surface_free(_surf);
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if (_showStatus) //Draw weapon status
{
    if (_weaponID >= 0)
    {
        var _status = -1;
        if (global.weaponLocked[_weaponID]%2 > 0)
        {
           _status = 1;
           _col[0] = global.nesPalette[$16];
        }
        
        if (global.infiniteEnergy[_weaponID])
        {
            _status = 0;
        }
        
        if (_status >= 0)
        {
            draw_sprite_ext(sprWeaponWheelStatus, _status, (_x + 2), (_y + 2), 1, 1, 0, _col[0], 1);
        }
        
    }
}

