

/**
*
*/ 
function HoloStickerSurface(_surface) : HoloStickerAsset() constructor
{
  self.surface = _surface;
  self.texture = surface_get_texture(_surface);
  
  var _uvs = texture_get_uvs(self.texture);
  self.uvs[0] = _uvs[0];
  self.uvs[1] = _uvs[1];
  self.uvs[2] = _uvs[2];
  self.uvs[3] = _uvs[3];
    
  self.texels[0] = texture_get_texel_width(self.texture);
  self.texels[1] = texture_get_texel_height(self.texture);
  
  
  
  /**
  * Return the asset texture.
  */
  static GetTexture = function()
  {
    return (surface_exists(surface) == true)
      ? self.surface
      : undefined;
  };
  
  
  
  /**
  * Function is called immediately, the surface is passed as arguments.
  * 
  * @param {Function} _method
  */
  static Draw = function(_method=self.MethodSurface)
  {
    _method(self.surface);
    return self;
  };
}