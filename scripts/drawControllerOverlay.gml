/// drawControllerOverlay(x,y)
/// shows semi-transparent controller indicating currently pressed buttons

var draw_x, draw_y, active, i, spr;

var spr = sprControllerOverlay;
var sprw = sprite_get_width(spr);// + 16;
var sprh = sprite_get_height(spr);

var xx = argument0;
var yy = argument1;

var alpha = 1 / 1.28;
var col = global.nesPalette[$15];

var active = 0;
var j = 0;

var weaponWheelUsed = (global.analogStickTilt[j, 1] > 0);
var weaponWheelDir = (round(global.analogStickDirection[j, 1] / 45) mod 8);

//Draw
draw_sprite_ext(spr, 0, xx, yy, 1, 1, 0, c_white, image_alpha);

// draw red dots
for (i = 1; i <= 17; i ++;)
{
    active = false;
    
    // check if key down
    switch (i)
    {
        case 1: //Left
            bx = 1;
            by = 7;
            bw = 2;
            bh = 2;
            active = global.keyLeft[j];
            break;
        case 2: //Right
            bx = 5;
            by = 7;
            bw = 2;
            bh = 2;
            active = global.keyRight[j];
            break;
        case 3:
            bx = 3;
            by = 5;
            bw = 2;
            bh = 2;
            active = global.keyUp[j];
            break;
        case 4:
            bx = 3;
            by = 9;
            bw = 2;
            bh = 2;
            active = global.keyDown[j];
            break;
            
        case 5:
            bx = 9;
            by = 7;
            bw = 4;
            bh = 4;
            active = global.keyShoot[j];
            break;
        case 6:
            bx = 19;
            by = 7;
            bw = 4;
            bh = 4;
            active = global.keyJump[j];
            break;
        case 7:
            bx = 14;
            by = 5;
            bw = 4;
            bh = 4;
            active = global.keySlide[j];
            break;
        case 8:
            bx = 1;
            by = 1;
            bw = 7;
            bh = 2;
            active = global.keyWeaponSwitchLeft[j];
            break;
        case 9:
            bx = 24;
            by = 1;
            bw = 7;
            bh = 2;
            active = global.keyWeaponSwitchRight[j];
            break;
        case 10:
            bx = 18;
            by = 2;
            bw = 4;
            bh = 2;
            active = global.keyPause[j];
            break;
        case 11:
            bx = 10;
            by = 2;
            bw = 4;
            bh = 2;
            active = global.keyMap[j];
            break;
            
        case 12: //Weapon wheel center left
            bx = 3;
            by = 7;
            bw = 2;
            bh = 2;
            active = global.keyWheelSwitch[j];
            break;
        case 13: //Weapon wheel center right
            bx = 27;
            by = 7;
            bw = 2;
            bh = 2;
            active = global.keyWheelSwitch[j];
            break;
            
        case 14: //Weapon wheel left
            bx = 25;
            by = 7;
            bw = 2;
            bh = 2;
            if (weaponWheelUsed)
            {
                active = ((weaponWheelDir >= 3) && (weaponWheelDir <= 5));
            }
            break;
        case 15: //Weapon wheel right
            bx = 29;
            by = 7;
            bw = 2;
            bh = 2;
            if (weaponWheelUsed)
            {
                active = ((weaponWheelDir <= 1) || (weaponWheelDir == 7));
            }
            break;
        case 16: //Weapon wheel up
            bx = 27;
            by = 5;
            bw = 2;
            bh = 2;
            if (weaponWheelUsed)
            {
                active = ((weaponWheelDir >= 1) && (weaponWheelDir <= 3));
            }
            break;
        case 17: //Weapon wheel down
            bx = 27;
            by = 9;
            bw = 2;
            bh = 2;
            if (weaponWheelUsed)
            {
                active = ((weaponWheelDir >= 5) && (weaponWheelDir <= 7));
            }
            break; 
    }
    
    if (active)
    {
        draw_sprite_part_ext(spr, i, bx, by, bw, bh, (xx + bx), (yy + by), 1, 1, col, image_alpha);
    }
}

//for (var j = 0; j < global.playerCount; j ++;)
//{
    //yy += 12;
//}

draw_set_alpha(1);
draw_set_color(c_white);
