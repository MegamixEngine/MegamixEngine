//Same as Chiko's just darker since blends don't work with shaders.
attribute vec3 in_Position;
attribute vec2 in_TextureCoord;
varying vec2 vTc;
void main()
{
gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION]*vec4(in_Position.xyz,1.);
vTc=in_TextureCoord;
}
//######################_==_YOYO_SHADER_MARKER_==_######################@~varying vec2 vTc;
void main()
{
const vec3 ww=vec3(0.2125,0.7154,0.0721);
vec3 irgb=texture2D(gm_BaseTexture,vTc).rgb;
float alpha=texture2D(gm_BaseTexture,vTc).a;
float luminance=dot(irgb,ww);
luminance = pow(abs(luminance),2.23);
gl_FragColor=vec4(luminance,luminance,luminance,alpha);
}
