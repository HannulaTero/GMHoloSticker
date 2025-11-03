/// @desc DRAW HOLO.

holo.Draw(function(_spr, _img)
{
  // Just caching these.
  static identity   = matrix_build_identity();
  static scaling    = matrix_build_identity();
  static transform  = matrix_build_identity();
  
  image_angle += 1;
  
  // Move vertex buffer around in 3D.
  matrix_build(
    0, 0, 0, 
    0, 0, 0, 
    256, 256, 32,
    scaling
  );
  
  matrix_build(
    x, y, z, 
    -70.0, 0.0, 
    image_angle + dsin(current_time / 128) * 48,
    1.0, 1.0, 1.0, 
    transform
  );
  
  matrix_multiply(scaling, transform, transform);
  
  // Apply world transformations for the vertex buffer.
  var _texture = sprite_get_texture(_spr, _img); 
  matrix_set(matrix_world, transform);
  vertex_submit(vbuffer, pr_trianglelist, _texture);
  matrix_set(matrix_world, identity);
});


DrawShadow();


