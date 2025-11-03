**GMHoloSticker**

_CS2 style holographic sticker effect for GameMaker._

The shader allows to draw sprites or textures with holographic effect. The effect requires three images :
- Base : the regular color.
- Mask : the holoeffect mask.
- Spec : the holospectrum

Base is just regular image, can can be anything.

Mask determines how strong holoeffect is, and what color it takes.
- Red   : Effect strength, blend factor between base color and spectrum.
- Green : X-offset where to read from spectrum.
- Blue  : Y-offset where to read from spectrum.
- Alpha : Just used as a multiplier for effect strength.

Spectrum is the holoeffect color.
- Color can be anything.
- Mask determines sampling XY-offset.
- Surface normal and camera position determines "tilt", which adds X-offset.

This asset tries to deal with UV's and asset trimming, so you don't need to use "separate texture page".

-> Note, you might want to add some small zero-holoeffect padding around mask-image
   as otherwise effect might get stretched over in specific situations.

-> Note you need to supply scaling factor, if mask is not on same scale as base image.
 
Alphatest is required for 3D, as transparency can cause issues in general.
-> You can set specific alphatest per HoloSticker.
-> Use negative alphatest to disable it.
