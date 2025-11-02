

/**
*
* @param {Asset.GMSprite} _spr
* @param {Real} _img
*/ 
function HoloStickerSprite(_spr, _img) : HoloStickerAsset() constructor
{
  self.spr = _spr;
  self.img = _img;
  self.texture = sprite_get_texture(_spr, _img);
  
  // Preparations.
  var _uvs = sprite_get_uvs(_spr, _img);
  var _xoffset = sprite_get_xoffset(_spr);
  var _yoffset = sprite_get_yoffset(_spr);
  
  // Get the UV coordinates.
  self.uvs[0] = _uvs[0];
  self.uvs[1] = _uvs[1];
  self.uvs[2] = _uvs[2];
  self.uvs[3] = _uvs[3];
  
  // Get the texels.
  self.texels[0] = texture_get_texel_width(self.texture);
  self.texels[1] = texture_get_texel_height(self.texture);
  
  // Calculate the origin in UV coordinates.
  self.origin[0] = _uvs[0] + (_xoffset - _uvs[4]) * self.texels[0];
  self.origin[1] = _uvs[1] + (_yoffset - _uvs[5]) * self.texels[1];
  
  
  
  /**
  * Return the asset texture.
  */
  static GetTexture = function()
  {
    return self.texture;
  };
  
  
  /**
  * Function is called immediately, the sprite and image are passed as arguments.
  * 
  * @param {Function} _method
  */
  static Draw = function(_method=self.MethodSprite)
  {
    _method(self.spr, self.img);
    return self;
  };
}




