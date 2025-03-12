///drawWeaponWheel(player ID, x, y, current slot);

var wpn, index, xx, yy, weaponIcon, col, dir, locked;            

var pID = argument0;
var wDirection = argument3;

var outward  = 32;
var size     = (outward * 2);
var surfSize = (size * 2);

var surf = mm_surface_create(surfSize, surfSize);
var surfx = ((argument1 - 1) - size);
var surfy = ((argument2 - 1) - size);

//Current weapon
var cwpn = global.weapon[playerID];

var pri = global.nesPalette[$0];
var sec = global.nesPalette[$10];

var cwpnpri = pri;
var cwpnsec = sec;

//Get current weapon's color
if (global.weaponLocked[cwpn]%2==0)
{
    cwpnpri = getWeaponPrimaryColor(cwpn, costumeID);
    cwpnsec = getWeaponSecondaryColor(cwpn, costumeID);
}

// - - - - - - -

var dir, index, current, xoffset, yoffset, xx, yy, colType;

for (var i = 0; i < 2; i ++;)
{
    surface_set_target(surf);
    
    draw_clear_alpha(c_white, 0);
    
    for (var ii = 0; ii < 8; ii ++;)
    {
        index = ii;
        current = (wDirection == index);
        
        wpn = global.wheelSetWep[pID, index];
        
        locked = 0;
        if (wpn >= 0)
        {
            locked = global.weaponLocked[wpn]%2;
        }
        
        inColor = ((wpn == cwpn) && (locked == 0));
        
        if (inColor != i)
        {
            continue;
        }
        
        // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        
        dir = (ii * 45);
        
        ioutward = outward;
        radius = 8;
        crop = !current;
        
        if (locked)
        {
            radius -= 2;
            ioutward -= 2;
            crop = 1;
        }
        
        // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        
        if (current) //Current icon
        {
            radius += 2;
        }
        
        if (inColor)
        {
            colType = 1; //Colored
            col = cwpnsec;
        }
        else
        {
            if (current)
            {
                colType = 0; //Grey
                col = global.nesPalette[$10]; //Grey
            }
            else
            {
                colType = 2; //Grey dimmed
                col = global.nesPalette[$0]; //Dark grey
            }
        }
        
        // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
        
        xoffset =  (cos(degtorad(dir)));
        yoffset = -(sin(degtorad(dir)));
        
        xx = (size + (xoffset * ioutward));
        yy = (size + (yoffset * ioutward));
        
        draw_set_color(col);
        
        //Circle
        draw_circle(xx, yy, radius, 0);
        
        var tx = xx - (xoffset * (radius / 2));
        var ty = yy - (yoffset * (radius / 2));
        
        radius *= 0.875;
        
        //Triangle
        draw_triangle(
            (size + (xoffset * 12)),
            (size + (yoffset * 12)),
            
            (tx   + (yoffset * radius)),
            (ty   - (xoffset * radius)), 
            
            (tx   - (yoffset * radius)),
            (ty   + (xoffset * radius)),
            0);
            
        draw_set_color(c_white);
        
        xx -= 7;
        yy -= 7;
        
        drawWeaponIcon(wpn, pID, costumeID, xx, yy, colType, 0, 1, crop);
    }
    
    surface_reset_target();
    
    // - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    //Draw surface
    
    var shader = shAddPartialOutlineSmooth;
    shader_set_safe(shader);
    
    var col = c_black;
    shader_set_uniform_f(shader_get_uniform(shader,"u_color"), colour_get_red(col), colour_get_green(col), colour_get_blue(col));
    
    var col = pri;
    if (i)
    {
        col = cwpnpri;
    }
    shader_set_uniform_f(shader_get_uniform(shader,"u_color2"), colour_get_red(col), colour_get_green(col), colour_get_blue(col));
    
    shader_set_uniform_f(shader_get_uniform(shader,"offsetx"), 1 / surfSize);
    shader_set_uniform_f(shader_get_uniform(shader,"offsety"), 1 / surfSize);
    
    draw_surface(surf, surfx, surfy);
    
    shader_reset();

}

//

mm_surface_free(surf);

draw_set_color(c_white);

