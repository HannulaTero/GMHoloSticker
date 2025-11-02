/// @desc INHERIT AND DEFINE HOLO.

event_inherited();

holo = new HoloSticker(
  new HoloStickerSprite(sprite_example_02_base, 0),
  new HoloStickerSprite(sprite_example_02_holomask, 0),
  new HoloStickerSprite(sprite_example_02_holospec, 0),
  0.25 // The holomask is 1/4 of base image.
);


