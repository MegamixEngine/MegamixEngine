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

//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float brightness;
uniform float saturation;

void main()
{
    
    vec4 ogCol = texture2D(gm_BaseTexture, v_vTexcoord);
    
    float colr = ogCol.r * brightness;
    float colg = ogCol.g * brightness;
    float colb = ogCol.b * brightness;
    
    vec3 c = vec3(colr, colg, colb);
    
    // Calculate the luminance of the original color
    float luminance = dot(ogCol.rgb, vec3(0.2126, 0.7152, 0.0722));
    
    // Calculate the desaturated color (grayscale)
    vec3 gray = vec3(luminance);
    
    // Blend between the desaturated color and the original color based on saturation
    vec3 finalColor = mix(gray, c, saturation);
    
    gl_FragColor = vec4(finalColor, ogCol.a);
}
