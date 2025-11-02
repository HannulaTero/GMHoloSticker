


// Attribyes.
attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_TextureCoord;



// Varyings.
varying vec4 vColor;
varying vec3 vPosition;
varying vec2 vBaseCoord;
varying vec2 vMaskCoord;



// Uniforms.
uniform float VSH_remapping;  // Whether coordinate needs to be remapped.
uniform vec2 VSH_rescale;     // Mask relative scale compared to the base.
uniform vec4 VSH_maskUV;      // UV coordinates for the quad.
uniform vec2 VSH_baseTexels;  // Texel size
uniform vec2 VSH_maskTexels;  // -...-
uniform vec2 VSH_baseOrigin;  // Quad origin as UV coordinate.
uniform vec2 VSH_maskOrigin;  // -...-



// Main function.
void main()
{
  // Make position vec4 for matrix multiplication.
  vec4 position = vec4(in_Position, 1.0);
  
  // Set the clip-space position.
  gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * position;
  
  // Get the vertex color.
  vColor = in_Colour;
  
  // Get the transformed world position for normal calculations.
  vPosition = (gm_Matrices[MATRIX_WORLD] * position).xyz;
  
  // Get the texture coordinates. 
  vBaseCoord = in_TextureCoord;
  vMaskCoord = in_TextureCoord;
  
  // Remap the mask coordinate.
  // If it is a quad, and both assets been trimmed or otherwise have different sizes.
  // The range might be outside the actual image, so the coordinate must be clamped inside fragment shader.
  if (VSH_remapping > 0.5)
  {
    vec2 offset = (vBaseCoord - VSH_baseOrigin) / VSH_baseTexels;
    
    vMaskCoord = VSH_maskOrigin + offset * VSH_maskTexels * VSH_rescale;
  }
}




