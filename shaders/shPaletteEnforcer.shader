//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)

varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    v_vColour = in_Colour;
    v_vTexcoord = in_TextureCoord;
}

//######################_==_YOYO_SHADER_MARKER_==_######################@~//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D palette; // palette sprites must be 32 in width and have "Used for 3D" checked!!!!!!!!
uniform float paletteLength;

// convert to CIE XYZ colorspace
vec3 rgb2xyz(vec3 c)
{
    return vec3(0.4124 * c.r + 0.3576 * c.g + 0.1805 * c.b
        , 0.2126 * c.r + 0.7152 * c.g + 0.0722 * c.b
        , 0.0193 * c.r + 0.1192 * c.g + 0.9505 * c.b) * 100.0;
}

// convert from CIE XYZ colorspace to CIE*Lab colorspace
const vec3 D65 = vec3(95.047, 100.0, 108.883); // standard 6500K Daylight light source
vec3 xyz2cielab(vec3 c)
{
    c /= D65;

    if (c.x > 0.008856) { c.x = pow(c.x, 1.0/3.0); }
    else                { c.x = (7.787 * c.x) + (16.0/116.0); }
    if (c.y > 0.008856) { c.y = pow(c.y, 1.0/3.0); }
    else                { c.y = (7.787 * c.y) + (16.0/116.0); }
    if (c.z > 0.008856) { c.z = pow(c.z, 1.0/3.0); }
    else                { c.z = (7.787 * c.z) + (16.0/116.0); }
    
    return vec3((116.0 * c.y) - 16.0, 500.0 * (c.x - c.y), 200.0 * (c.y - c.z));
}

// CIE*Lab is based on CIE XYZ, can't convert directly from rbg
vec3 rgb2cielab(vec3 c)
{
    return xyz2cielab(rgb2xyz(c));
}

// distance between two colors
float deltaE(vec3 c1, vec3 c2)
{
    return sqrt(pow(c2.x - c1.x, 2.0) + pow(c2.y - c1.y, 2.0) + pow(c2.z - c1.z, 2.0));
}

// do the thing
void main()
{
    vec4 col = texture2D(gm_BaseTexture, v_vTexcoord);
    vec3 lab = rgb2cielab(col.rgb);
    float paletteHeight = ceil(paletteLength / 32.0);
    
    // find closest value in palette
    vec3 iCol;
    vec3 indexCol = rgb2cielab(texture2D(palette, vec2(0.0, 0.0)).rgb);
    float index = 0.0;
    float i = 1.0;
    while (true)
    {
        iCol = rgb2cielab(texture2D(palette, vec2(mod(i, 32.0) / 32.0, (i / 32.0) / paletteHeight)).rgb);
        if (abs(deltaE(lab, iCol)) < abs(deltaE(lab, indexCol)))
        {
            index = i;
            indexCol = iCol;
        }
        
        i++;
        if (i >= paletteLength)
        {
            break;
        }
    }
    
    // replace
    gl_FragColor = vec4(texture2D(palette, vec2(mod(index, 32.0) / 32.0, (index / 32.0) / paletteHeight)).rgb, col.a);
}
