/// @desc INHERIT AND DEFINE HOLO.

event_inherited();


// Create a group of assets and handle,
// which can be used for drawing sprite with holographic effect.
holo = new HoloSticker(
  new HoloStickerSprite(sprite_example_00_base, 0),
  new HoloStickerSprite(sprite_example_00_holomask, 0),
  new HoloStickerSprite(sprite_example_00_holospec, 0) 
);


