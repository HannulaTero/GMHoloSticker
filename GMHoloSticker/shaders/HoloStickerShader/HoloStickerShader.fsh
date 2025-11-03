// Derivatives are required, as regular sprites don't have them.
#extension GL_OES_standard_derivatives : enable



// The varying.
varying vec4 vColor;
varying vec3 vPosition;
varying vec2 vBaseCoord;
varying vec2 vMaskCoord;



// Get the uniforms.
uniform sampler2D FSH_maskSampler;
uniform sampler2D FSH_specSampler;
uniform vec4 FSH_maskUV;
uniform vec4 FSH_specUV;
uniform vec3 FSH_position;
uniform vec2 FSH_holoOffset;
uniform float FSH_alphaTest;



// Declare helper functions.
// Some are unnecessary, though I kept them around just in case.
vec2 UVMix(vec2 rate, vec4 dstUV);
vec2 UVMixClamp(vec2 rate, vec4 dstUV);
vec2 UVMixRepeat(vec2 rate, vec4 dstUV);
vec2 UVNormalize(vec2 coord, vec4 srcUV);
vec2 UVRemap(vec2 coord, vec4 srcUV, vec4 dstUV);



// Main function.
void main()
{
  // Get the stickers base color.
  vec4 baseSample = texture2D(gm_BaseTexture, vBaseCoord) * vColor;
  
  // We should check for the alpha.
  if (baseSample.a < FSH_alphaTest)
  {
    discard;
  }
  
  // Get the holomask.
  // Coordinate must be clamped because of possible remapping.
  vec2 maskCoord = clamp(vMaskCoord, FSH_maskUV.xy, FSH_maskUV.zw);
  vec4 maskSample = texture2D(FSH_maskSampler, maskCoord);
  
  // Calculate the normal for the sticker.
  vec3 dx = dFdx(vPosition);
  vec3 dy = dFdy(vPosition);
  vec3 normalSurface = normalize(cross(dx, dy));
  if (gl_FrontFacing == false)
  {
    // Handle winding direction.
    normalSurface = -normalSurface;
  }
  
  // Calculate stickers tilt against the camera.
  vec3 direction = normalize(vPosition - FSH_position);
  float tilt = abs(dot(normalSurface, direction));
  
  // Get the holospectrum offset.
  vec2 offset = maskSample.gb + FSH_holoOffset + vec2(tilt, 0.0);
  
  // Get the holospectrum.
  vec2 specCoord = UVMixRepeat(offset, FSH_specUV);
  vec4 specSample = texture2D(FSH_specSampler, specCoord);
  
  // Get the final output color.
  float effectStrength = maskSample.r * maskSample.a;
  gl_FragColor.rgb = mix(baseSample.rgb, specSample.rgb, effectStrength);
  gl_FragColor.a = baseSample.a;
}



// Define helper functions.
vec2 UVMix(vec2 rate, vec4 dstUV)
{
  return mix(dstUV.xy, dstUV.zw, rate);
}


vec2 UVMixClamp(vec2 rate, vec4 dstUV)
{
  return UVMix(clamp(rate, vec2(0.0), vec2(1.0)), dstUV);
}


vec2 UVMixRepeat(vec2 rate, vec4 dstUV)
{
  return UVMix(fract(rate), dstUV);
}


vec2 UVNormalize(vec2 coord, vec4 srcUV)
{
  return (coord - srcUV.xy) / (srcUV.zw - srcUV.xy);
}


vec2 UVRemap(vec2 coord, vec4 srcUV, vec4 dstUV)
{
  return UVMix(UVNormalize(coord, srcUV), dstUV);
}





