/// @desc CHANGE OFFSET.


if (device_mouse_check_button(0, mb_right) == true)
{
  var _dx = device_mouse_x_to_gui(0) / display_get_gui_width();
  var _dy = device_mouse_y_to_gui(0) / display_get_gui_height();
  
  with(object_example_parent)
  {
    holo.SetOffset(_dx, _dy);
  }
}

