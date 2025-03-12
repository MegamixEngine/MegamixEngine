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
//######################_==_YOYO_SHADER_MARKER_==_######################@~
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
#if __VERSION__ < 130
#define TEXTURE2D texture2D
#else
#define TEXTURE2D texture
#endif
uniform sampler2D sam_s;
uniform sampler2D maskSam_s;
//Texture2D<vec4> tex : register(t0);
//Texture2D<vec4> mask : register(t1);

vec4 Texturize(/*vec4 plane, */sampler2D samp, vec2 vec)
{
    return TEXTURE2D(samp,vec);
}

//float icb[12] = float[12](0.000412,-0.000630,-0.001747,0.000988,0.003091,0.001904,-0.001583,0.001242,0.003291,-0.000105,-0.003552,-0.003361 );

float icb(int value)
{
    if (value < 1)
    {
        return 0.000412;
    }
    else if (value < 2)
    {
        return -0.000630;
    }
    else if (value < 3)
    {
        return -0.001747;
    }else if (value < 4)
    {
        return 0.000988;
    }else if (value < 5)
    {
        return 0.003091;
    }else if (value < 6)
    {
        return 0.001904;
    }else if (value < 7)
    {
        return -0.001583;
    }else if (value < 8)
    {
        return 0.001242;
    }else if (value < 9)
    {
        return 0.003291;
    }else if (value < 10)
    {
        return -0.000105;
    }else if (value < 11)
    {
        return -0.003552;
    }else// if (value < 12)
    {
        return -0.003361;
    }
    
    
}


/*vec4 icb[12] = vec4[]( vec4( 0.000412, 0, 0, 0),
                              vec4( -0.000630, 0, 0, 0),
                              vec4( -0.001747, 0, 0, 0),
                              vec4( 0.000988, 0, 0, 0),
                              vec4( 0.003091, 0, 0, 0),
                              vec4( 0.001904, 0, 0, 0),
                              vec4( -0.001583, 0, 0, 0),
                              vec4( 0.001242, 0, 0, 0),
                              vec4( 0.003291, 0, 0, 0),
                              vec4( -0.000105, 0, 0, 0),
                              vec4( -0.003552, 0, 0, 0),
                              vec4( -0.003361, 0, 0, 0) );*/

vec4 Process()
{
   
    vec2 v1 = v_vTexcoord;
    vec4 v2 = v_vColour;
    vec4 fDest;

  vec4 r0,r1,r2,r3;
  
  vec4 o0;
  r0.xyzw = vec4(0.0,0.0,0.0,0.0);
  while (true) {
    if (int(r0.w) >= 12) break;
    r1.xy = vec2(icb(int(r0.w)+0),0.0).xy + v1.xy;
    r2.xy = vec2(128.0,240.0) * r1.xy;
    r3.xyzw = Texturize(maskSam_s, fract(r2.xy)).xyzw;
    r1.xyzw = Texturize(sam_s, r1.xy).xyzw;
    r0.xyz = r3.xyz * r1.xyz + r0.xyz;
    r0.w = floor(r0.w) + 1.0;
  }
  r0.xyz = vec3(0.0833333358,0.0833333358,0.0833333358) * r0.xyz;
  r1.xy = vec2(128.0,240.0) * v1.xy;
  r1.xyzw = Texturize(maskSam_s, fract(r1.xy)).xyzw;
  r2.xyzw = Texturize(sam_s, v1.xy).xyzw;
  r0.xyz = r0.xyz * r0.xyz;
  r0.xyz = vec3(0.25,0.25,0.25) * r0.xyz;
  r0.xyz = r1.xyz * r2.xyz + r0.xyz;
  r0.w = 1.25;
  o0.xyzw = v2.xyzw * r0.xyzw;
  return o0;
}
void main()
{
    gl_FragColor = Process();
}
