/*
A shader commonly used by emulators to give games a silkier apperance.
Derived from this code, which was in turn derived from a java implementation: https://github.com/SilentPhil/HQx_GMS_2_3
but some elements such as the 3X LUT were derived otherwise.
The following changes were made:
- Contents of the vertex shader were moved to fragment outside the passthrough (This for some reason is required to work, even in the source code above, at least in Windows).
- A workaround was made for the 3X scale LUT texture to work properly with GMS, due to not supporting textures that are not a power of 2.
*/
attribute vec3 in_Position; // (x, y, z)
attribute vec4 in_Colour; // (r, g, b, a)
attribute vec2 in_TextureCoord; // (u, v)

varying vec2 v_vTexcoord;

precision highp float;

void main() {
	vec4 object_space_pos = vec4(in_Position.x, in_Position.y, in_Position.z, 1.0);
	gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
	
    //   +----+----+----+
    //   |    |    |    |
    //   | w1 | w2 | w3 |
    //   +----+----+----+
    //   |    |    |    |
    //   | w4 | w5 | w6 |
    //   +----+----+----+
    //   |    |    |    |
    //   | w7 | w8 | w9 |
    //   +----+----+----+
	v_vTexcoord = in_TextureCoord;
    
}
//######################_==_YOYO_SHADER_MARKER_==_######################@~//
// Simple passthrough fragment shader
//

// https://gist.github.com/metaphore/b4750be45289109b3d49c97b5c300db6

uniform sampler2D LUT;
uniform float TEXTURE_WIDTH;
uniform float TEXTURE_HEIGHT;
uniform float UPSCALE;
uniform float SURFACE_WIDTH;
uniform float SURFACE_HEIGHT;

vec4 v_texCoord[4];
varying vec2 v_vTexcoord;

const vec3 YUV_THRESHOLD = vec3(48.0/255.0, 7.0/255.0, 6.0/255.0);
const vec3 YUV_OFFSET = vec3(0, 0.5, 0.5);

bool diff(vec3 yuv1, vec3 yuv2) {
    return any(greaterThan(abs((yuv1 + YUV_OFFSET) - (yuv2 + YUV_OFFSET)), YUV_THRESHOLD));
}

vec3 toYUV(vec3 color) {
	vec3 yuv = vec3(0.0);

	yuv.x = color.r * 0.299 + color.g * 0.587 + color.b * 0.114;
	yuv.y = color.r * -0.169 + color.g * -0.331 + color.b * 0.5 + 0.5;
	yuv.z = color.r * 0.5 + color.g * -0.419 + color.b * -0.081 + 0.5;

	return yuv;
}

void main() {
	
	vec2 u_textureSize = vec2(TEXTURE_WIDTH,TEXTURE_HEIGHT);
	vec2 u_surfaceSize = vec2(SURFACE_WIDTH,SURFACE_HEIGHT);
	
	vec2 ps = 1.0 / u_textureSize;
    float dx = ps.x;
    float dy = ps.y;
    
	
	
	v_texCoord[0].xy = v_vTexcoord;//floor(v_vTexcoord.xy*u_textureSize)/u_textureSize;
    v_texCoord[0].zw = ps;
    //A square of the surrounding pixels.
    v_texCoord[1] = v_vTexcoord.xxxy + vec4(-dx, 0, dx, -dy); //  w1 | w2 | w3
    v_texCoord[2] = v_vTexcoord.xxxy + vec4(-dx, 0, dx,   0); //  w4 | w5 | w6
    v_texCoord[3] = v_vTexcoord.xxxy + vec4(-dx, 0, dx,  dy); //  w7 | w8 | w9
	
	
	//fract is x-(floor), gets the decimal.
	//Under this sense, consider fp the fractional pixel for use with the surface.
    vec2 fp = fract(v_texCoord[0].xy * u_textureSize);
    //Effectively, get the surrounding four squares of the current pixel. 
    vec2 quad = sign(-0.5 + fp);
    vec3 p1  = texture2D(gm_BaseTexture, v_texCoord[0].xy).rgb;
    vec3 p2  = texture2D(gm_BaseTexture, v_texCoord[0].xy + vec2(dx, dy) * quad).rgb;
    vec3 p3  = texture2D(gm_BaseTexture, v_texCoord[0].xy + vec2(dx, 0) * quad).rgb;
    vec3 p4  = texture2D(gm_BaseTexture, v_texCoord[0].xy + vec2(0, dy) * quad).rgb;
    
    mat4 pixels = mat4(vec4(p1, 0.0), vec4(p2, 0.0), vec4(p3, 0.0), vec4(p4, 0.0));

    vec3 w1  = toYUV(texture2D(gm_BaseTexture, v_texCoord[1].xw).rgb);
    vec3 w2  = toYUV(texture2D(gm_BaseTexture, v_texCoord[1].yw).rgb);
    vec3 w3  = toYUV(texture2D(gm_BaseTexture, v_texCoord[1].zw).rgb);

    vec3 w4  = toYUV(texture2D(gm_BaseTexture, v_texCoord[2].xw).rgb);
    vec3 w5  = toYUV(p1);
    vec3 w6  = toYUV(texture2D(gm_BaseTexture, v_texCoord[2].zw).rgb);

    vec3 w7  = toYUV(texture2D(gm_BaseTexture, v_texCoord[3].xw).rgb);
    vec3 w8  = toYUV(texture2D(gm_BaseTexture, v_texCoord[3].yw).rgb);
    vec3 w9  = toYUV(texture2D(gm_BaseTexture, v_texCoord[3].zw).rgb);

    bvec3 pattern[3];
    pattern[0] =  bvec3(diff(w5, w1), diff(w5, w2), diff(w5, w3));
    pattern[1] =  bvec3(diff(w5, w4), false       , diff(w5, w6));
    pattern[2] =  bvec3(diff(w5, w7), diff(w5, w8), diff(w5, w9));
    bvec4 _cross = bvec4(diff(w4, w2), diff(w2, w6), diff(w8, w4), diff(w6, w8));

    vec2 index;
    index.x = dot(vec3(pattern[0]), vec3(1, 2, 4)) + dot(vec3(pattern[1]), vec3(8, 0, 16)) + dot(vec3(pattern[2]), vec3(32, 64, 128));
    index.y = dot(vec4(_cross), vec4(1, 2, 4, 8)) * (UPSCALE * UPSCALE) + dot(floor(fp * UPSCALE), vec2(1.0, UPSCALE));

    vec2 _step = vec2(1.0) / vec2(256.0, 16.0 * (UPSCALE * UPSCALE));
    vec2 offset = _step / vec2(2.0);
    
    vec2 scaleFix = vec2(1.0);
    //Fix for 3X scale due to GMS requiring textures be a power of 2.
	//Note: Ideally, for higher non-power-of-2 scales, this should be readjusted for those as well.
    if (UPSCALE == 3.0)
    {
    	scaleFix = vec2(1.0,144./256.);
    }
    
    vec4 weights = texture2D(LUT, (index * _step + offset)*scaleFix);
    float sum = dot(weights, vec4(1));
    vec3 res = (pixels * (weights / sum)).rgb;

    gl_FragColor.rgb = res;
    gl_FragColor.a = 1.0;
}
