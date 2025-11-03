/// @desc MOUSE CONTROL.

// Change projection
if (keyboard_check_pressed(vk_tab) == true)
{
  orthographic = orthographic ? false : true;
}


// Move the camera around in XY-plane.
{
  var _dx = real(keyboard_check(ord("W"))) - real(keyboard_check(ord("S")));
  var _dy = real(keyboard_check(ord("D"))) - real(keyboard_check(ord("A")));
  var _dir = point_direction(0, 0, _dx, _dy);
  var _len = point_distance(0, 0, _dx, _dy);
  var _spd = (keyboard_check(vk_shift) == false) ? 6.0 : 16.0;
  
  if (_len > 0.0)
  {
    xat += lengthdir_x(_spd, _dir + dir);
    yat += lengthdir_y(_spd, _dir + dir);
  }
}

// Move the camera around in Z-axis.
if (keyboard_check(ord("Q")) == true)
{
  zat += 4.0;
}

if (keyboard_check(ord("E")) == true)
{
  zat -= 4.0;
}


// Rotate the camera.
if (device_mouse_check_button(0, mb_left) == true)
{
  var _dx = window_mouse_get_delta_x() * 0.15;
  var _dy = window_mouse_get_delta_y() * 0.15;
  window_mouse_set_locked(true);
  
  dir -= _dx;
  rot -= _dy;
  rot = clamp(rot, -80, +80);
}
else
{
  window_mouse_set_locked(false);
}


// Zooming.
if (mouse_wheel_down() == true)
{
  fov *= 1.125;
}

if (mouse_wheel_up() == true)
{
  fov /= 1.125;
}

fov = clamp(fov, 10, 90);


// Update target position and lookat.
xto = xat + lengthdir_x(len, dir) * lengthdir_x(1, rot);
yto = yat + lengthdir_y(len, dir) * lengthdir_x(1, rot);
zto = zat + lengthdir_y(len, rot);


