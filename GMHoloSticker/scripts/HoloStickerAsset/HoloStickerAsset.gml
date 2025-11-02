

/**
* Contains required information for the shader.
*/ 
function HoloStickerAsset() constructor
{
  self.texture  = undefined;
  self.uvs      = array_create(4, 0.0);
  self.texels   = array_create(2, 0.0);
  self.origin   = array_create(2, 0.0);
  
  
  /**
  * Function is called immediately, specific are passed as argument.
  * 
  * @param {Function} _method
  */
  static Draw = function(_method=self.MethodAsset)
  {
    _method();
    return self;
  };
  
  
  /**
  * Return the asset texture.
  */
  static GetTexture = function()
  {
    return undefined;
  };
  
  
  static MethodAsset = function()
  {
    return self;
  };
  
  
  static MethodSprite = function(_spr, _img)
  {
    return self;
  };
  
  
  static MethodTexture = function(_texture)
  {
    return self;
  };
  
  
  static MethodSurface = function(_surface)
  {
    if (surface_exists(_surface) == false)
    {
      return self;
    }
    return self;
  };
}