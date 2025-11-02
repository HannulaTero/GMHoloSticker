/// @desc .

image_angle = random(360);

z = 0;


Draw3D = function(_spr, _img)
{
  // Just caching these.
  static identity = matrix_build_identity();
  static transform = matrix_build_identity();
  
  // Move sprite around in 3D.
  matrix_build(
    x, y, z, 
    -70.0, 0.0, 
    image_angle + dsin(current_time / 128) * 48,
    0.25, 0.25, 0.25, 
    transform
  );
  
  // Apply world transformations for the sprite.
  matrix_set(matrix_world, transform);
  draw_sprite(_spr, _img, 0, 0);
  matrix_set(matrix_world, identity);
}