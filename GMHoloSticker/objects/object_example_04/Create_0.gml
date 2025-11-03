/// @desc INHERIT AND DEFINE HOLO.

event_inherited();

holo = new HoloSticker(
  new HoloStickerSprite(sprite_example_00_base, 0),
  new HoloStickerSprite(sprite_example_00_holomask, 0),
  new HoloStickerSprite(sprite_example_00_holospec, 0) 
);


Draw3DScale = function(_spr, _img)
{
  // Just caching these.
  static identity = matrix_build_identity();
  static transform = matrix_build_identity();
  
  // Move sprite around in 3D.
  matrix_build(
    x, y, z, 
    -70.0, 0.0, 
    image_angle,
    0.25, 0.25, 0.25, 
    transform
  );
  
  // Apply world transformations for the sprite.
  matrix_set(matrix_world, transform);
  var _xs = 0.75 + 0.25 * dsin(current_time / 64);
  var _ys = 0.75 + 0.25 * dcos(current_time / 64);
  var _color = make_color_hsv(current_time / 255 mod 256, 255, 255);
  var _angle = 90 + current_time / 720.0;
  draw_sprite_ext(_spr, _img, 0, 0, _xs, _ys, _angle, _color, 1.0);
  matrix_set(matrix_world, identity);
}




