/// @desc UPDATE CAMERA MATRIXES.


// Update where camera is and where pointing at.
matrix_build_lookat(
  xat, yat, zat,
  xto, yto, zto,
  xup, yup, zup,
  viewMatrix
);


// Select projection type.
if (orthographic == true)
{
  matrix_build_projection_ortho(
    display_get_gui_width(),
    display_get_gui_height(),
    znear, zfar,
    projMatrix
  );
}
else
{
  matrix_build_projection_perspective_fov(
    fov,
    display_get_gui_width() / display_get_gui_height(),
    znear, zfar,
    projMatrix
  );
}


// Update the matrixes.
camera_set_view_mat(camera, viewMatrix);
camera_set_proj_mat(camera, projMatrix);
view_camera[0] = camera;

