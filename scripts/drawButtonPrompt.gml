///drawButtonPrompt(button, x, y, [display press], [playerID])

var _b = argument[0];
var _x = argument[1];
var _y = argument[2];
var _p = 0;

var _drawPress = 0;
if (argument_count > 3)
{
    if (argument[3] > 0)
    {
        _drawPress = 1;
        _y -= 5;
    }
    
    if (argument_count > 4)
    {
        _p = argument[4];
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

var _keyBind, _buttonBind;

switch(_p)
{
    case 0:
        _keyBind = global.keyboardBind0;
        _buttonBind = global.gamepadBind0;
        break;
        
    case 1:
        _keyBind = global.keyboardBind1;
        _buttonBind = global.gamepadBind1;
        break;
        
    case 2:
        _keyBind = global.keyboardBind2;
        _buttonBind = global.gamepadBind2;
        break;
        
    case 3:
        _keyBind = global.keyboardBind3;
        _buttonBind = global.gamepadBind3;
        break;                     
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

var _key = -1;
var _button = -1;
var _raw = -1;

var _spr = sprInputPromptBlank;
var CID = objGlobalControl.controllerID[0];

if (is_real(_b))
{
    _key    = _keyBind[_b];
    _button = _buttonBind[_b];
    _raw = _b;
}
else
{
    switch(argument[0])
    {
        case "left":
        
            _key    = _keyBind[INPUT_LEFT];
            _button = _buttonBind[INPUT_LEFT];
            _raw = INPUT_LEFT;
            if (_button == -1)//General checks to assume D-Pad prompts if the user's controller lacks an actual pad (Some D-Pads act like an axes instead).
            {
                _button = 2;
                while (CID > 3)//Subtract until we reach XInput.
                {
                    CID -= 4;
                }
            }
            break;
            
        case "right":
            
            _key    = _keyBind[INPUT_RIGHT];
            _button = _buttonBind[INPUT_RIGHT];
            _raw = INPUT_RIGHT;
            if (_button == -1)//General checks to assume D-Pad prompts if the user's controller lacks an actual pad (Some D-Pads act like an axes instead).
            {
                _button = 3;
                while (CID > 3)//Subtract until we reach XInput.
                {
                    CID -= 4;
                }
            }
            break;
            
        case "up":
            
            _key    = _keyBind[INPUT_UP];
            _button = _buttonBind[INPUT_UP];
            _raw = INPUT_UP;
            if (_button == -1)//General checks to assume D-Pad prompts if the user's controller lacks an actual pad (Some D-Pads act like an axes instead).
            {
                _button = 0;
                while (CID > 3)//Subtract until we reach XInput.
                {
                    CID -= 4;
                }
            }
            break;
            
        case "down":
            
            _key    = _keyBind[INPUT_DOWN];
            _button = _buttonBind[INPUT_DOWN];
            _raw = INPUT_DOWN;
            if (_button == -1)//General checks to assume D-Pad prompts if the user's controller lacks an actual pad (Some D-Pads act like an axes instead).
            {
                _button = 1;
                while (CID > 3)//Subtract until we reach XInput.
                {
                    CID -= 4;
                }
            }
            break;
            
        case "jump":
            _key    = _keyBind[INPUT_JUMP];
            _button = _buttonBind[INPUT_JUMP];
            _raw = INPUT_JUMP;
            break;
            
        case "shoot":
            
            _key    = _keyBind[INPUT_SHOOT];
            _button = _buttonBind[INPUT_SHOOT];
            _raw = INPUT_SHOOT;
            break;
            
        case "slide":
            
            _key    = _keyBind[INPUT_SLIDE];
            _button = _buttonBind[INPUT_SLIDE];
            _raw = INPUT_SLIDE;
            break;
            
        case "pause":
            
            _key    = _keyBind[INPUT_PAUSE];
            _button = _buttonBind[INPUT_PAUSE];
            _raw = INPUT_PAUSE;
            break;
            
        case "map":
            
            _key    = _keyBind[INPUT_QUICKITEM];
            _button = _buttonBind[INPUT_QUICKITEM];
            _raw = INPUT_QUICKITEM;
            break;
            
        case "switchleft":
            
            _key    = _keyBind[INPUT_WEAPONLEFT];
            _button = _buttonBind[INPUT_WEAPONLEFT];
            _raw = INPUT_WEAPONLEFT;
            break;
            
        case "switchright":
            
            _key    = _keyBind[INPUT_WEAPONRIGHT];
            _button = _buttonBind[INPUT_WEAPONRIGHT];
            _raw = INPUT_WEAPONRIGHT;
            break;
            
        case "wheel":
            
            _key    = _keyBind[INPUT_WEAPONWHEEL];
            _button = _buttonBind[INPUT_WEAPONWHEEL];
            _raw = INPUT_WEAPONWHEEL;
            break;
        
        case "wheel2":
            
            _key    = _keyBind[INPUT_WEAPONWHEEL];
            _button = _buttonBind[INPUT_WEAPONWHEEL2];
            _raw = INPUT_WEAPONWHEEL2;
            break;
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

//Sprite
var _type = global.buttonPromptType;

if (_type) //Gamepad
{
    var convButt = _button;
        
    if (_button != -1)
    {
        switch (_type)
        {
            case BUTTONPROMPT_CONTEXTID:
                _spr = sprInputPromptContext;
            break;
            case 6:
                _spr = sprInputPromptGamecube;
            break;
            case 5:
                _spr = sprInputPromptN64;
            break;
            case 4:
                _spr = sprInputPromptGenesis;
                break;
            case 3:
                _spr = sprInputPromptSwitch;
            break;
            case 2:
                _spr = sprInputPromptPlaystation;
                break;
                
            default:
                _spr = sprInputPromptXbox;
                break;
        }
        
        
        var _sn = floor(sprite_get_number(_spr) / 2);
        var _img = convButt + (_sn * gamepad_button_check_cross(CID, _button));
        if (_type == BUTTONPROMPT_CONTEXTID)
        {
            _img = _raw + (_sn * gamepad_button_check_cross(CID, _button));
        }
        draw_sprite(_spr, _img, _x, _y);
    }
    else
    {
        draw_sprite(_spr, 0, _x, _y);
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

else //Keyboard
{
    if (_key != -1)
    {
        var press = keyboard_check(_key);
        
        draw_sprite(sprInputPromptKey, press, _x, _y);
        
        var _special = -1;
        
        switch(_key)
        {
            case vk_right:
                _special = 0;
                break;
                
            case vk_up:
                _special = 1;
                break;
                
            case vk_left:
                _special = 2;
                break;
                
            case vk_down:
                _special = 3;
                break;
                
            case vk_space:
                _special = 4;
                break;
                
            case vk_enter:
                _special = 5;
                break;
                
            case vk_backspace:
                _special = 6;
                break;
                
            case vk_control:
                _special = 7;
                break;
                
            case vk_tab:
                _special = 8;
                break;
            
            case vk_shift:
                _special = 9;
                break;
            
        }
        
        if (press)
        {
            draw_set_color(c_black);
        }
        else
        {
            draw_set_color(global.nesPalette[$0]);
        }
        
        if (_special >= 0) //Sprite based
        {
            draw_sprite_ext(sprInputPromptKeySpecial, _special, _x, _y, 1, 1, 0, draw_get_color(), 1);
        }
        else //Font based
        {
            draw_set_valign(1);
            draw_set_halign(1);
            draw_set_font(global.fontSmall2);
            
            var _txt = string_upper(chr(_key));

            draw_text((_x + 4), (_y + 4), _txt);
            
            draw_set_valign(0);
            draw_set_halign(0);
            draw_set_font(global.font);
        }
        
        draw_set_color(c_white);
    }
    else
    {
        draw_sprite(_spr, 0, _x, _y);
    }
}

// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if (_drawPress)
{
    draw_sprite(sprInputPromptPress, 0, _x, (_y + 9));
}

