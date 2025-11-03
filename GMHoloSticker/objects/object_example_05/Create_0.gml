/// @desc INHERIT AND DEFINE HOLO.

event_inherited();


holo = new HoloSticker(
  new HoloStickerSprite(sprite_example_01_base, 0),
  new HoloStickerSprite(sprite_example_01_holomask, 0),
  new HoloStickerSprite(sprite_example_01_holospec, 0) 
);


// Create format.
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_colour();
vertex_format_add_texcoord();
vformat = vertex_format_end();

// Create buffer.
vbuffer = vertex_create_buffer();

vertex_begin(vbuffer, vformat);


// Preparations.
var _c = c_white;
var _steps = 1.0 / 32;
var _rate = (pi * 4);
var _umin = self.holo.base.uvs[0];
var _vmin = self.holo.base.uvs[1];
var _umax = self.holo.base.uvs[2];
var _vmax = self.holo.base.uvs[3];

// Generate the vertex buffer.
for(var j = 0.0; j < 1.0; j += _steps) {
for(var i = 0.0; i < 1.0; i += _steps) {
  
  // Iteration.
  var _x0 = i - 0.5;
  var _y0 = j - 0.5;
  var _x1 = _x0 + _steps;
  var _y1 = _y0 + _steps;
  var _u0 = lerp(_umin, _umax, i);
  var _v0 = lerp(_vmin, _vmax, j); 
  var _u1 = lerp(_umin, _umax, i + _steps);
  var _v1 = lerp(_vmin, _vmax, j + _steps); 
  
  var _z00 = cos(_x0 * _rate) * sin(_y0 * _rate); 
  var _z01 = cos(_x0 * _rate) * sin(_y1 * _rate); 
  var _z10 = cos(_x1 * _rate) * sin(_y0 * _rate); 
  var _z11 = cos(_x1 * _rate) * sin(_y1 * _rate); 
  
  // First triangle.
  vertex_position_3d(vbuffer, _x0, _y0, _z00); vertex_color(vbuffer, _c, 1.0); vertex_texcoord(vbuffer, _u0, _v0);
  vertex_position_3d(vbuffer, _x1, _y0, _z10); vertex_color(vbuffer, _c, 1.0); vertex_texcoord(vbuffer, _u1, _v0);
  vertex_position_3d(vbuffer, _x0, _y1, _z01); vertex_color(vbuffer, _c, 1.0); vertex_texcoord(vbuffer, _u0, _v1);
  
  // Second triangle.
  vertex_position_3d(vbuffer, _x1, _y0, _z10); vertex_color(vbuffer, _c, 1.0); vertex_texcoord(vbuffer, _u1, _v0);
  vertex_position_3d(vbuffer, _x1, _y1, _z11); vertex_color(vbuffer, _c, 1.0); vertex_texcoord(vbuffer, _u1, _v1);
  vertex_position_3d(vbuffer, _x0, _y1, _z01); vertex_color(vbuffer, _c, 1.0); vertex_texcoord(vbuffer, _u0, _v1);
}}

// Finalize the buffer.
vertex_end(vbuffer);
vertex_freeze(vbuffer);














