/// @desc DRAW INFORMATION.

var _text = string(@"
HOLOEFFECT
  rotate images : Space
  rotate camera : Mouse left
  zoom camera   : Mouse wheel
  spec offset   : Mouse right
  XY move       : WASD -keys
  Z move        : QE -keys
  Run           : Shift
  orthographic  : TAB
")

draw_set_font(ft1);
draw_set_color(c_black);
draw_text(16, 18, _text);
draw_set_color(c_white);
draw_text(16, 16, _text);