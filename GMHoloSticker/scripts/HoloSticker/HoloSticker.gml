

/**
* A way to draw sprites or textures with holographic effect.
*
* The effect requires three images :
* - Base : the regular color.
* - Mask : the holoeffect mask.
* - Spec : the holospectrum
*
* Base is just regular image, can can be anything.
*
* Mask determines how strong holoeffect is, and what color it takes.
* - Red   : Effect strength, blend factor between base color and spectrum.
* - Green : X-offset where to read from spectrum.
* - Blue  : Y-offset where to read from spectrum.
* - Alpha : Just used as a multiplier for effect strength.
* 
* Spectrum is the holoeffect color.
* - Color can be anything.
* - Mask determines sampling XY-offset.
* - Surface normal and camera position determines "tilt", which adds X-offset.
*
* This asset tries to deal with UV's and asset trimming, so you don't need to use "separate texture page".
*
* -> Note, you might want to add some small zero-holoeffect padding around mask-image
*    as otherwise effect might get stretched over in specific situations.
*
* -> Note you need to supply scaling factor, if mask is not on same scale as base image.
* 
* Alphatest is required for 3D, as transparency can cause issues in general.
* -> You can set specific alphatest per HoloSticker.
* -> Use negative alphatest to disable it.
* 
* @param {Struct.HoloStickerAsset} _base Base color
* @param {Struct.HoloStickerAsset} _mask Holomask, marking the effect.
* @param {Struct.HoloStickerAsset} _spec Holospectrum, effect color.
* @param {Real | Array<Real>} _maskScale If mask is not mapped to base pixel by pixel.
*/
function HoloSticker(_base, _mask, _spec, _maskScale=1.0) constructor
{
  // Initialize the shader uniforms.
  static shader = HoloStickerShader;
  static VSH_remapping    = shader_get_uniform(shader, "VSH_remapping");
  static VSH_rescale      = shader_get_uniform(shader, "VSH_rescale");
  static VSH_maskUV       = shader_get_uniform(shader, "VSH_maskUV");
  static VSH_baseTexels   = shader_get_uniform(shader, "VSH_baseTexels");
  static VSH_maskTexels   = shader_get_uniform(shader, "VSH_maskTexels");
  static VSH_baseOrigin   = shader_get_uniform(shader, "VSH_baseOrigin");
  static VSH_maskOrigin   = shader_get_uniform(shader, "VSH_maskOrigin");
  static FSH_maskSampler  = shader_get_sampler_index(shader, "FSH_maskSampler");
  static FSH_specSampler  = shader_get_sampler_index(shader, "FSH_specSampler");
  static FSH_maskUV       = shader_get_uniform(shader, "FSH_maskUV");
  static FSH_specUV       = shader_get_uniform(shader, "FSH_specUV");
  static FSH_position     = shader_get_uniform(shader, "FSH_position");
  static FSH_holoOffset   = shader_get_uniform(shader, "FSH_holoOffset");
  static FSH_alphaTest    = shader_get_uniform(shader, "FSH_alphaTest");
  
  
  // The base color information.
  self.base = _base;
  
  
  // The holomask strength + offset information.
  self.mask = _mask;
  
  
  //The holospectrum information.
  self.spec = _spec;
  
  
  // The Holospectrum offset
  self.offset = [ 0.0, 0.0 ];
  
  
  // Alphatest - cutoff value.
  // Negative value for disabling the alpha test.
  self.alphaTest = 254.0 / 255.0; 
  
  
  // Check whether remapping is required.
  // -> Remapping is required whenever base coordinates are not 1to1 with mask.
  self.remapping = { };
  self.remapping.required = (array_equals(self.base.uvs, self.mask.uvs) == false);
  self.remapping.scale = [ 
    is_array(_maskScale) ? _maskScale[0] : _maskScale, 
    is_array(_maskScale) ? _maskScale[1] : _maskScale
  ]; 
  
  
  /**
  * Applies holoeffect-shader.
  * Given method parameters is the base-asset, such as sprite (spr, img)
  * 
  * @param {Function} _method
  */
  static Draw = function(_method)
  {
    self.Begin();
    self.base.Draw(_method);
    self.End();
    return self;
  };
  
  
  /**
  * Begin the the holo-effect shader.
  * This will update the uniforms.
  *
  * Uses currently active camera if nothing is provided.
  * Doesn't update camera if -1 is provided.
  * 
  * @param {Id.Camera} _camera
  */
  static Begin = function(_camera=camera_get_active())
  {
    // Set the GPU state.
    gpu_push_state();
    shader_set(self.shader);
    
    // Set the vertex shader uniforms.
    shader_set_uniform_f(self.VSH_remapping, self.remapping.required);
    if (self.remapping.required == true)
    {
      shader_set_uniform_f_array(self.VSH_rescale, self.remapping.scale);
      shader_set_uniform_f_array(self.VSH_maskUV, self.mask.uvs);
      shader_set_uniform_f_array(self.VSH_baseTexels, self.base.texels);
      shader_set_uniform_f_array(self.VSH_maskTexels, self.mask.texels);
      shader_set_uniform_f_array(self.VSH_baseOrigin, self.base.origin);
      shader_set_uniform_f_array(self.VSH_maskOrigin, self.mask.origin);
    }
    
    // Set the fragment shader uniforms.
    texture_set_stage(self.FSH_maskSampler, self.mask.GetTexture());
    texture_set_stage(self.FSH_specSampler, self.spec.GetTexture());
    shader_set_uniform_f_array(self.FSH_maskUV, self.mask.uvs);
    shader_set_uniform_f_array(self.FSH_specUV, self.spec.uvs);
    shader_set_uniform_f_array(self.FSH_holoOffset, self.offset);
	shader_set_uniform_f(self.FSH_alphaTest, self.alphaTest);
    
    // Update position based on the camera.
    if (_camera != -1)
    {
      var _viewMatrix = camera_get_view_mat(_camera);
      var _viewInvMatrix = matrix_inverse(_viewMatrix);
      shader_set_uniform_f(self.FSH_position, 
        _viewInvMatrix[12], 
        _viewInvMatrix[13], 
        _viewInvMatrix[14]
      );
    }
    
    return self;
  };
  
  
  
  /**
  * Update "camera position" in the world.
  * this is in where camera is looking at, affecting tilt calculation.
  *
  * @param {Real} _x
  * @param {Real} _y
  * @param {Real} _z
  */
  static SetPosition = function(_x=0, _y=0, _z=0)
  {
    shader_set_uniform_f(self.FSH_position, _x, _y, _z);
    return self;
  };
  
  
  
  /**
  * Update offset in holospectrum.
  *
  * @param {Real} _x
  * @param {Real} _y
  */
  static SetOffset = function(_x=self.offset[0], _y=self.offset[1])
  {
    self.offset[0] = _x;
    self.offset[1] = _y;
    return self;
  };
  
  
  
  /**
  * Set alpha test, under which value fragment is discard.
  * This uses normalized value.
  * 
  * Setting test value negative basically disables the test.
  * 
  * @param {Real} _alpha
  */ 
  static SetAlphaTest = function(_alphaTest=-1)
  {
    self.alphaTest = _alphaTest;
    return self;
  };
  
  
  
  /**
  * End the shader.
  * Resets shader and returns previous GPU state.
  */
  static End = function()
  {
    shader_reset();
    gpu_pop_state();
    return self;
  };
}



