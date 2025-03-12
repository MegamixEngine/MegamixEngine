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
// Turns a color gray based on the highest of its RGB values
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float grayLevels[4]; //these are based on the megamix 1.9 palette

void main()
{
    vec4 oldCol = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    float avg = ((oldCol.r + oldCol.g + oldCol.b) / 3.0);
    int index = int((avg + (0.125 * float(avg >= grayLevels[1]))) * 3.0); //a little extra weighting here to increase diversity
    float finalCol = mix(grayLevels[index], oldCol.r, float(oldCol.r == oldCol.g && oldCol.g == oldCol.b)); //don't recolor colors that already match a gray
    gl_FragColor = vec4(vec3(finalCol, finalCol, finalCol), oldCol.a);
}
