//
// A shader for MM2-Style hitflash. Is sligthly inaccurate on human faces, but other parts of the body should be either flush with MM2 or at least better than pure white.
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
uniform vec4 flashcol;

void main()
{
    //gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
    
    float oneOver255 = 1.0/255.0;
    vec4 factor = abs((texture2D(gm_BaseTexture,v_vTexcoord).rgba*255.0) - vec4(255.0,255.0,255.0,255.0));
    
    if (factor.r < 8.0 && factor.g < 8.0 && factor.b < 8.0 && factor.a < 8.0)
    {//If white, turn peach (Below is based on Megamix 1.0 NES Palette.)
        gl_FragColor = vec4(252.0/255.0,224.0/255.0,168.0/255.0,1.0);//vec4(1.0,1.0,1.0,texture2D(gm_BaseTexture,v_vTexcoord).a);

    }
    else
    {
        factor = abs((texture2D(gm_BaseTexture,v_vTexcoord).rgba*255.0) - vec4(0.0,0.0,0.0,255.0));
        if (factor.r < 8.0 && factor.g < 8.0 && factor.b < 8.0 && factor.a < 8.0)
        {//If black, stay whatever black you were.
            gl_FragColor = texture2D(gm_BaseTexture,v_vTexcoord).rgba;
        }
        else
        {//Everything else should be white. This is theoretically *slightly* inaccurate with those that don't use white as a color,
        //But it's still closer to the games than pure white flashing.
            gl_FragColor = vec4(flashcol.r/255.0,flashcol.g/255.0,flashcol.b/255.0,texture2D(gm_BaseTexture,v_vTexcoord).a);//vec4(1.0,1.0,1.0,texture2D(gm_BaseTexture,v_vTexcoord).a);//v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
        }
    }
    
    
}

