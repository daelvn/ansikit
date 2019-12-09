-- ansikit.extra.color
-- Color handling library, similar to TinyColor
-- By daelvn
import hslToRgb, hsvToRgb from require "ansikit.lib.color"
import names, hexNames    from require "ansikit.extra.names"
import
  toHSV, toHSVA, toHSL, toHSLA, toHSVString, toHSVAString, toHSLString, toHSLAString,
  toHex, toHex8, toHex3String, toHex4String, toHex4String, toHex6String, toHex8String,
  toRGB, toRGBA, toRGBString, toRGBAString, toRGBPercentageString, toRGBAPercentageString,
  toName, toString,
  isRGB, isRGBA, isHSL, isHSLA, isHSV, isHSVA,
  isHex3, isHex4, isHex6, isHex8,
  cssToDecimal, clamp1, clamp255, round
  _Color
from require "ansikit.extra.conversion"
io.stdin\setvbuf "no"
print "toRGBA", toRGBA
print "isHSL",  isHSL
type                                             = require "typical"
i                                                = require "inspect"
tee_count                                        = 0
tee                                              = (...) ->
  tee_count += 1
  print tee_count, i ...
  ...

-- Turns a color table into a string
unparseColor = (c) ->
  if c.r and c.g and c.b
    return "rgb#{c.a and "a" or ""} #{c.r} #{c.g} #{c.b} #{c.a or ""}"
  elseif c.h and c.s and c.l
    return "hsl#{c.a and "a" or ""} #{c.h} #{c.s} #{c.l} #{c.a or ""}"
  elseif c.h and c.s and c.v
    return "hsv#{c.a and "a" or ""} #{c.h} #{c.s} #{c.v} #{c.a or ""}"

-- Turns a string into a color table.
parseColor = (color) ->
  switch type color
    when "Color"
      return color
    when "string"
      with string.lower color -- trim spaces & turn into lowercase
        color = \gsub "^%s+", ""
        color = \gsub "%s+$", ""
    when "table", "Color"
      color = unparseColor color

  -- check if a name was used
  named = false
  if names[color]
    color = names[color]
    named = true
  elseif color == "transparent"
    return {r:0, g:0, b:0, a:255, format: "name"}

  -- return
  return (isRGB color, named) or
    (isRGBA color, named) or
    (isHSL  color, named) or
    (isHSLA color, named) or
    (isHSV  color, named) or
    (isHSVA color, named) or
    (isHex8 color, named) or
    (isHex6 color, named) or
    (isHex4 color, named) or
    (isHex3 color, named)

-- Converts any color table to RGBA
_toRGBA = (c) ->
  c = parseColor c if "string" == type c
  switch c.format
    when "rgba" then return c
    when "rgb"
      c.a = 0
      return c
    when "hsl"
      r, g, b = hslToRgb c.h, c.s, c.l
      { :r, :g, :b, a: 255, format: "hsl" }
    when "hsla"
      r, g, b, a = hslToRgb c.h, c.s, c.l, c.a
      { :r, :g, :b, :a, format: "hsla" }
    when "hsv"
      r, g, b = hsvToRgb c.h, c.s, c.v
      { :r, :g, :b, a: 255, format: "hsv" }
    when "hsva"
      r, g, b, a = hsvToRgb c.h, c.s, c.v, c.a
      { :r, :g, :b, :a, format: "hsva" }
    else error "_toRGBA $ color format #{c.format} not recognized"

-- Rounds all r, g, b, h, s, v, l, a keys in a table.
roundAll = (t) ->
  checkFor = {"r", "g", "b", "h", "s", "v", "l", "a"}
  for key in *checkFor
    if t[key] and ("number" == type t[key])
      t[key] = round t[key]
  t

-- Creates a new Color object
Color = (cl) ->
  this = {}
  --
  this.original = cl
  --this.color    = parseColor cl
  this.raw      = {}
  with _toRGBA parseColor cl
    this.r = round .r
    this.g = round .g
    this.b = round .b
    this.a = round .a
    this.raw.r = .r
    this.raw.g = .g
    this.raw.b = .b
    this.raw.a = .a
  --
  setmetatable this, __type: "Color"

-- Gets the brightness of a color
brightnessFor = _Color (cl) -> (cl.r * 299 + cl.g * 587 + cl.b * 114) / 1000

-- Checks if the color is light or dark
isLight = _Color (cl) -> (brightnessFor cl) > 128
isDark  = _Color (cl) -> not isLight cl

-- Gets the luminance of a color
luminanceFor = _Color (cl) ->
  rr, gg, bb = cl.r/255, cl.g/255, cl.b/255
  local R, G, B
  if rr > 0.03928 then R = rr / 12.92 else R = ((rr + 0.055) / 1.055) ^ 2.4
  if gg > 0.03928 then G = gg / 12.92 else G = ((gg + 0.055) / 1.055) ^ 2.4
  if bb > 0.03928 then B = bb / 12.92 else B = ((bb + 0.055) / 1.055) ^ 2.4
  return (0.2126 * R) + (0.7152 * G) + (0.0722 * B)

-- Clones a color
clone = _Color (cl) -> Color toString cl

-- Desaturate
desaturate = _Color (cl) -> (amount=10) ->
  hsva    = tee toHSVA cl
  hsva.s -= amount / 100
  hsva.s  = clamp1 hsva.s
  Color hsva

darkblue = Color "hsva 250 50% 50% 255"
--print "Color",       i darkblue
print "_RGBA",       i _toRGBA tee unparseColor darkblue
print "RGBA",        i toRGBA darkblue
print "HSVA",        i toHSVA darkblue
print "Desaturated", i (desaturate darkblue) 10

{
  :names, :hexNames
  :unparseColor, :parseColor
  :roundAll
  :Color
  :brightnessFor, :luminanceFor
  :isLight, :isDark
  :clone
  :desaturate
  -- from ansikit.extra.conversion
  :toHSV, :toHSVA, :toHSL, :toHSLA
  :toHSVString, :toHSVAString, :toHSLString, :toHSLAString
  :toHex, :toHex8
  :toHex3String, :toHex4String, :toHex6String, :toHex8String
  :toRGB, :toRGBA
  :toRGBString, :toRGBAString, :toRGBPercentageString, :toRGBAPercentageString
  :toName, :toString
  :isRGB, :isRGBA, :isHSL, :isHSLA, :isHSV, :isHSVA
  :isHex3, :isHex4, :isHex6, :isHex8
  :cssToDecimal
}