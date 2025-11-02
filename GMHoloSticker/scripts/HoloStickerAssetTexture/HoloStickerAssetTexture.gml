

/**
*
*/ 
function HoloStickerTexture(_texture) : HoloStickerAsset() constructor
{
  self.texture = surface_get_texture(_texture);
  
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
    return self.texture;
  };
  
  
  
  /**
  * Function is called immediately, the texture is passed as arguments.
  * 
  * @param {Function} _method
  */
  static Draw = function(_method=self.MethodTexture)
  {
    _method(self.texture);
    return self;
  };
}