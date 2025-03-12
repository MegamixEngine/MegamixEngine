//###########################################
//###########################################
//EVERYTHING IMPORTANT IS IN FRAGMENT FOR THIS
//###########################################
//###########################################

attribute vec3 in_Position;                  // (x,y,z)
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

uniform float offsetx;
uniform float offsety;

uniform vec3 u_color;

void main()
{
    float margin = 0.1;
    
    vec3 col =  u_color/255.0;
    
    vec4 tempCol = texture2D( gm_BaseTexture, v_vTexcoord );
    
    vec3 subcol = vec3(tempCol.r, tempCol.g, tempCol.b);
    
    float alpha = tempCol.a;
    float aa =  max(texture2D(gm_BaseTexture, vec2( v_vTexcoord.x - offsetx, v_vTexcoord.y          )).a,
                max(texture2D(gm_BaseTexture, vec2( v_vTexcoord.x,           v_vTexcoord.y - offsety)).a,
                max(texture2D(gm_BaseTexture, vec2( v_vTexcoord.x - offsetx, v_vTexcoord.y - offsety)).a,
                max(texture2D(gm_BaseTexture, vec2( v_vTexcoord.x + offsetx, v_vTexcoord.y          )).a,
                max(texture2D(gm_BaseTexture, vec2( v_vTexcoord.x,           v_vTexcoord.y + offsety)).a,
                max(texture2D(gm_BaseTexture, vec2( v_vTexcoord.x + offsetx, v_vTexcoord.y + offsety)).a,
                max(texture2D(gm_BaseTexture, vec2( v_vTexcoord.x + offsetx, v_vTexcoord.y - offsety)).a,
                    texture2D(gm_BaseTexture, vec2( v_vTexcoord.x - offsetx, v_vTexcoord.y + offsety)).a)))))));
    
    aa = min(float(aa > 0.0), float(alpha < 1.0));
    
    vec3 finalCol =               subcol * float(aa == 0.0);
         finalCol = max(finalCol,    col * float(aa == 1.0));
    
    alpha = max(aa, alpha);
    
    gl_FragColor = vec4(finalCol, alpha);
}

