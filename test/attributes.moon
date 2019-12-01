-- testing several attributes
import reset, Bit4, Bit8, Bit24 from require "ansikit.color"
palette                            = require "ansikit.palette"
text                               = require "ansikit.text"

import color4, Color, background from palette
print (Bit4 91) .. "hey" .. reset
print color4.red .. color4.bright.bg.cyan .. "hewwo" .. reset

white = Color 255, 255, 255
red   = Color 255, 0,   0

print white .. (background red) .. "hewwo" .. reset

import Palette, nameFor, addColor, removeColor from palette

own           = Palette "own"
addToOwn      = addColor own
removeFromOwn = removeColor own

addToOwn "white", white
addToOwn "red",   red

print red .. (background own.white) .. (nameFor own) .. reset