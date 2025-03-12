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
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform vec4 isolation;
uniform vec4 replacement;
//uniform float doWhitemask; To achieve the same effect, set isolation and replacement to the same value above.

void main()
{
    /*Doing *255 prevents inaccuracies if we divided by 255 in GMS as:
    1: Division is slower than multiplication, though we need to do it for replacement at least.
    2: GMS can't do triple precision anyways which would make things slightly inaccurate.
    3: GMS overhead is inherently slower. Using shaders wherever possible is drastically faster.
    */
    float oneOver255 = 1.0/255.0;
    vec4 factor = abs((texture2D(gm_BaseTexture,v_vTexcoord).rgba*255.0) - isolation.rgba);
    if (factor.r < 1.0 && factor.g < 1.0 && factor.b < 1.0 && factor.a < 1.0)
    {
        gl_FragColor = replacement.rgba*oneOver255;//vec4(1.0,1.0,1.0,texture2D(gm_BaseTexture,v_vTexcoord).a);

    }
    else
    {
        gl_FragColor = vec4(0,0,0,0);//v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    }
}

