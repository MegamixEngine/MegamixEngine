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
varying vec4 v_vColour;

//Color palettes
uniform vec3 u_coloro1;
uniform vec3 u_coloro2;
uniform vec3 u_coloro3;
uniform vec3 u_coloro4;
uniform vec3 u_coloro5;
uniform vec3 u_coloro6;
uniform vec3 u_coloro7;
uniform vec3 u_coloro8;
uniform vec3 u_coloro9;

uniform vec3 u_colorn1;
uniform vec3 u_colorn2;
uniform vec3 u_colorn3;
uniform vec3 u_colorn4;
uniform vec3 u_colorn5;
uniform vec3 u_colorn6;
uniform vec3 u_colorn7;
uniform vec3 u_colorn8;
uniform vec3 u_colorn9;

void main()
{
    //The original color
    vec4 ogCol = texture2D( gm_BaseTexture, v_vTexcoord);
    
    //Comparing to the old colors
    vec3 col = vec3(0.0, 0.0, 0.0);
    float val = 0.0;
    float margin = 0.01; //Margin for error
    float div = 255.0;
    
    //Color 1
    col = u_coloro1 / div;
    
    val = max(val, float(1.0 * float((
        abs(float(ogCol.r - col.r)) +
        abs(float(ogCol.g - col.g)) +
        abs(float(ogCol.b - col.b))) < margin)));
    
    //Color 2
    col = u_coloro2 / div;
    
    val = max(val, float(2.0 * float((
        abs(float(ogCol.r - col.r)) +
        abs(float(ogCol.g - col.g)) +
        abs(float(ogCol.b - col.b))) < margin)));
    
    //Color 3
    col = u_coloro3 / div;
    
    val = max(val, float(3.0 * float((
        abs(float(ogCol.r - col.r)) +
        abs(float(ogCol.g - col.g)) +
        abs(float(ogCol.b - col.b))) < margin)));
    
    //Color 4
    col = u_coloro4 / div;
    
    val = max(val, float(4.0 * float((
        abs(float(ogCol.r - col.r)) +
        abs(float(ogCol.g - col.g)) +
        abs(float(ogCol.b - col.b))) < margin)));
        
    //Color 5
    col = u_coloro5 / div;
    
    val = max(val, float(5.0 * float((
        abs(float(ogCol.r - col.r)) +
        abs(float(ogCol.g - col.g)) +
        abs(float(ogCol.b - col.b))) < margin)));
    
    //Color 6
    col = u_coloro6 / div;
    
    val = max(val, float(6.0 * float((
        abs(float(ogCol.r - col.r)) +
        abs(float(ogCol.g - col.g)) +
        abs(float(ogCol.b - col.b))) < margin)));
        
    //Color 7
    col = u_coloro7 / div;
    
    val = max(val, float(7.0 * float((
        abs(float(ogCol.r - col.r)) +
        abs(float(ogCol.g - col.g)) +
        abs(float(ogCol.b - col.b))) < margin)));
        
    //Color 8
    col = u_coloro8 / div;
    
    val = max(val, float(8.0 * float((
        abs(float(ogCol.r - col.r)) +
        abs(float(ogCol.g - col.g)) +
        abs(float(ogCol.b - col.b))) < margin)));
        
    //Color 9
    col = u_coloro9 / div;
    
    val = max(val, float(9.0 * float((
        abs(float(ogCol.r - col.r)) +
        abs(float(ogCol.g - col.g)) +
        abs(float(ogCol.b - col.b))) < margin)));
        
    
    //Set to the new colors
    vec3 finalCol = vec3(ogCol.r, ogCol.g, ogCol.b) * float(val == 0.0);
         finalCol = max(finalCol, (u_colorn1 / div) * float(val == 1.0));
         finalCol = max(finalCol, (u_colorn2 / div) * float(val == 2.0));
         finalCol = max(finalCol, (u_colorn3 / div) * float(val == 3.0));
         finalCol = max(finalCol, (u_colorn4 / div) * float(val == 4.0));
         finalCol = max(finalCol, (u_colorn5 / div) * float(val == 5.0));
         finalCol = max(finalCol, (u_colorn6 / div) * float(val == 6.0));
         finalCol = max(finalCol, (u_colorn7 / div) * float(val == 7.0));
         finalCol = max(finalCol, (u_colorn8 / div) * float(val == 8.0));
         finalCol = max(finalCol, (u_colorn9 / div) * float(val == 9.0));
    
    //  Setting our output color.  //
    gl_FragColor = vec4(finalCol, ogCol.a);     
}

