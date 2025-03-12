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

uniform vec3 u_color;

void main()     //  Where the magic happens
{
    float margin = 0.25;
    
    //  Normalising the colours.  //
    vec3 col = u_color/255.0; 
    
    //  Storing color. //
    vec4 tempCol = texture2D( gm_BaseTexture, v_vTexcoord );
    
    vec3 black = vec3( 0.0, 0.0, 0.0);
    
    //Comparing to the old colors
    float val = 0.0;
    val = max(val, float(1.0 * float((
        abs(float(tempCol.r - black.r)) +
        abs(float(tempCol.g - black.g)) +
        abs(float(tempCol.b - black.b))) < margin)));
    
    vec3 finalCol =                 col * float(val == 0.0);
         finalCol = max(finalCol, black * float(val == 1.0));
    
    //  Setting our output color.  //
    gl_FragColor = vec4(finalCol, tempCol.a);
}

