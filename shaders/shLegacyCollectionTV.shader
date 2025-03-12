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
#if __VERSION__ < 130
#define TEXTURE2D texture2D
#else
#define TEXTURE2D texture
#endif

uniform vec4 u_crt_sizes;
uniform float distortion;
uniform bool distort;
uniform bool border;

varying vec4 v_vColour;

uniform vec4 u_settings; //vignette inner circle size, vignette outter circle size, noise strength
uniform vec3 u_vignette_colour; //R,G,B

uniform float uni_seed;//Elapsed time.

//uniform vec4 t_tex;
//uniform vec4 t_prevTex;
//uniform vec4 t_artifactMap;
uniform sampler2D sam_s;
uniform sampler2D prevSam_s;
uniform sampler2D artifactSam_s;
uniform float test;


vec4 Texturize(/*vec4 plane, */sampler2D samp, vec2 vec)
{
    return TEXTURE2D(samp,vec).xyzw;
}

float cmp(bool boo)
{
    if (boo)
        return 1.0;
    else
        return 0.0;
}
vec4 icb(int value)
{
    if (value < 1)
    {
        return vec4( 1.000000, 0, 0, 0);
    }
    else if (value < 2)
    {
        return vec4( -0.316228, 0, 0, 0);
    }
    else
    {
        return vec4( 0.100000, 0, 0, 0);
    }
    
}
vec4 Process()
{
    //texture2D tex = texture2D(sam_s,t_tex);
    //texture2D prevTex = texture2D(sam_s,t_prevTex);
    //texture2D artifactMap = texture2D(artifactSam_s,t_artifactMap);
    vec4 o0;

    vec4 r0,r1,r2,r3,r4,r5,r6,r7;
    vec4 v0 = gl_FragCoord;
    
    vec2 v1 = v_vTexcoord;
    vec4 v2 = v_vColour;
    vec4 fDest;
    
    
    
    
    
    
    r0.xyzw = vec4(0,0.00416666688,-0.00390625,-0) + v1.xyxy;
    r1.xyzw = Texturize(artifactSam_s, r0.xy).xyzw;
    r0.xy = vec2(0.00390625,0) + v1.xy;
    r2.xyzw = Texturize(sam_s, r0.zw);
    r3.xyzw = Texturize(sam_s, v1.xy);
    r4.xyzw = Texturize(sam_s, r0.xy);
    r5.xyzw = vec4(0.200000003,0.200000003,0.200000003,0.200000003) * r1.xyzw;
    r6.xyzw = Texturize(prevSam_s, r0.zw);//PREV!
    r7.xyzw = Texturize(prevSam_s, v1.xy);
    r0.xyzw = Texturize(prevSam_s, r0.xy);
    r2.xyzw = -r3.xyzw + r2.xyzw;
    r4.xyzw = r4.xyzw + -r3.xyzw;
    r2.xyzw = r4.xyzw + r2.xyzw;
    r2.xyzw = clamp(r2.xyzw * r5.xyzw + r3.xyzw,0.0,1.0);
    r3.x = dot(r2.xyz, vec3(0.298999995,0.587000012,0.114));
    r3.yz = vec2(0,0);
    while (true) {
        //r3.w = cmp(int(r3.z) >= 3);
        //if (r3.w != 0) break;
        if (int(r3.z) >= 3) break;
        r3.w = floor(r3.z) + 1.0;
        r4.x = floor(r3.w);
        r4.yz = -r4.xx * vec2(0.00390625,0) + v1.xy;
        r5.xyzw = Texturize(sam_s, r4.yz);
        r4.xy = r4.xx * vec2(0.00390625,0) + v1.xy;
        r4.xyzw = Texturize(sam_s, r4.xy);
        r4.w = dot(r5.xyz, vec3(0.298999995,0.587000012,0.114));
        r4.x = dot(r4.xyz, vec3(0.298999995,0.587000012,0.114));
        r4.xy = -r4.xw + r3.xx;
        r4.x = r4.y + r4.x;
        r3.y = r4.x * icb(int(r3.z)+0).x + r3.y;
        r3.yz = r3.yw;
    }
    
    r3.x = 0.200000003 * r3.y;
    r1.xyzw = vec4(-1,-1,-1,-1) + r1.xyzw;
    r1.xyzw = r1.xyzw * vec4(0.200000003,0.200000003,0.200000003,0.200000003) + vec4(1,1,1,1);
    r1.xyzw = clamp(r3.xxxx * r1.xyzw + r2.xyzw,0.0,1.0);
    r0.xyzw = r6.xyzw + r0.xyzw;
    r0.xyzw = r0.xyzw * vec4(0.400000006,0.400000006,0.400000006,0.400000006) + r7.xyzw;
    r0.xyzw = vec4(0.333333343,0.333333343,0.333333343,0.333333343) * r0.xyzw;
    r0.xyzw = max(r1.xyzw, r0.xyzw);
    //o0.xyzw = vec4(test,0,0,1);
    o0.xyzw = min(vec4(1,1,1,1), r0.xyzw);
    return o0;
}

void main()
{
    gl_FragColor = Process();
}

