local reset, Bit4, Bit8, Bit24
do
  local _obj_0 = require("ansikit.color")
  reset, Bit4, Bit8, Bit24 = _obj_0.reset, _obj_0.Bit4, _obj_0.Bit8, _obj_0.Bit24
end
local palette = require("ansikit.palette")
local text = require("ansikit.text")
local color4, Color, background
color4, Color, background = palette.color4, palette.Color, palette.background
print((Bit4(91)) .. "hey" .. reset)
print(color4.red .. color4.bright.bg.cyan .. "hewwo" .. reset)
local white = Color(255, 255, 255)
local red = Color(255, 0, 0)
print(white .. (background(red)) .. "hewwo" .. reset)
local Palette, nameFor, addColor, removeColor
Palette, nameFor, addColor, removeColor = palette.Palette, palette.nameFor, palette.addColor, palette.removeColor
local own = Palette("own")
local addToOwn = addColor(own)
local removeFromOwn = removeColor(own)
addToOwn("white", white)
addToOwn("red", red)
return print(red .. (background(own.white)) .. (nameFor(own)) .. reset)
