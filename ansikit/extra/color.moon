-- ansikit.extra.color
-- Color handling library, similar to TinyColor
-- By daelvn
import hslToRgb, hsvToRgb from require "ansikit.lib.color"
import _Color             from require "ansikit.extra.conversion"
import
  toHSV, toHSVA, toHSL, toHSLA, toHSVString, toHSVAString, toHSLString, toHSLAString,
  toHex, toHex8, toHex3String, toHex4String, toHex4String, toHex6String, toHex8String,
  toRGB, toRGBA, toRGBString, toRGBAString, toRGBPercentageString, toRGBAPercentageString,
  toName, toString,
  isRGB, isRGBA, isHSL, isHSLA, isHSV, isHSVA,
  isHex3, isHex4, isHex6, isHex8,
  cssToDecimal, clamp1, clamp255
from require "ansikit.extra.conversion"
type                                             = require "typical"
i                                                = require "inspect"
tee_count                                        = 0
tee                                              = (...) ->
  tee_count += 1
  print tee_count, i ...
  ...

-- List of accepted names
-- Exactly as the one in TinyColor
names = {
  aliceblue:            "#F0F8FF"
  antiquewhite:         "#FAEBD7"
  aqua:                 "#00FFFF"
  aquamarine:           "#7FFFD4"
  azure:                "#F0FFFF"
  beige:                "#F5F5DC"
  bisque:               "#FFE4C4"
  black:                "#000000"
  blanchedalmond:       "#FFEBCD"
  blue:                 "#0000FF"
  blueviolet:           "#8A2BE2"
  brown:                "#A52A2A"
  burlywood:            "#DEB887"
  burntsienna:          "#EA7E5D"
  cadetblue:            "#5F9EA0"
  chartreuse:           "#7FFF00"
  chocolate:            "#D2691E"
  coral:                "#FF7F50"
  cornflowerblue:       "#6495ED"
  cornsilk:             "#FFF8DC"
  crimson:              "#DC143C"
  cyan:                 "#00FFFF"
  darkblue:             "#00008B"
  darkcyan:             "#008B8B"
  darkgoldenrod:        "#B8860B"
  darkgray:             "#A9A9A9"
  darkgreen:            "#006400"
  darkgrey:             "#A9A9A9"
  darkkhaki:            "#BDB76B"
  darkmagenta:          "#8B008B"
  darkolivegreen:       "#556B2F"
  darkorange:           "#FF8C00"
  darkorchid:           "#9932CC"
  darkred:              "#8B0000"
  darksalmon:           "#E9967A"
  darkseagreen:         "#8FBC8F"
  darkslateblue:        "#483D8B"
  darkslategray:        "#2F4F4F"
  darkslategrey:        "#2F4F4F"
  darkturquoise:        "#00CED1"
  darkviolet:           "#9400D3"
  deeppink:             "#FF1493"
  deepskyblue:          "#00BFFF"
  dimgray:              "#696969"
  dimgrey:              "#696969"
  dodgerblue:           "#1E90FF"
  firebrick:            "#B22222"
  floralwhite:          "#FFFAF0"
  forestgreen:          "#228B22"
  fuchsia:              "#FF00FF"
  gainsboro:            "#DCDCDC"
  ghostwhite:           "#F8F8FF"
  gold:                 "#FFD700"
  goldenrod:            "#DAA520"
  gray:                 "#808080"
  green:                "#008000"
  greenyellow:          "#ADFF2F"
  grey:                 "#808080"
  honeydew:             "#F0FFF0"
  hotpink:              "#FF69B4"
  indianred:            "#CD5C5C"
  indigo:               "#4B0082"
  ivory:                "#FFFFF0"
  khaki:                "#F0E68C"
  lavender:             "#E6E6FA"
  lavenderblush:        "#FFF0F5"
  lawngreen:            "#7CFC00"
  lemonchiffon:         "#FFFACD"
  lightblue:            "#ADD8E6"
  lightcoral:           "#F08080"
  lightcyan:            "#E0FFFF"
  lightgoldenrodyellow: "#FAFAD2"
  lightgray:            "#D3D3D3"
  lightgreen:           "#90EE90"
  lightgrey:            "#D3D3D3"
  lightpink:            "#FFB6C1"
  lightsalmon:          "#FFA07A"
  lightseagreen:        "#20B2AA"
  lightskyblue:         "#87CEFA"
  lightslategray:       "#778899"
  lightslategrey:       "#778899"
  lightsteelblue:       "#B0C4DE"
  lightyellow:          "#FFFFE0"
  lime:                 "#00FF00"
  limegreen:            "#32CD32"
  linen:                "#FAF0E6"
  magenta:              "#FF00FF"
  maroon:               "#800000"
  mediumaquamarine:     "#66CDAA"
  mediumblue:           "#0000CD"
  mediumorchid:         "#BA55D3"
  mediumpurple:         "#9370DB"
  mediumseagreen:       "#3CB371"
  mediumslateblue:      "#7B68EE"
  mediumspringgreen:    "#00FA9A"
  mediumturquoise:      "#48D1CC"
  mediumvioletred:      "#C71585"
  midnightblue:         "#191970"
  mintcream:            "#F5FFFA"
  mistyrose:            "#FFE4E1"
  moccasin:             "#FFE4B5"
  navajowhite:          "#FFDEAD"
  navy:                 "#000080"
  oldlace:              "#FDF5E6"
  olive:                "#808000"
  olivedrab:            "#6B8E23"
  orange:               "#FFA500"
  orangered:            "#FF4500"
  orchid:               "#DA70D6"
  palegoldenrod:        "#EEE8AA"
  palegreen:            "#98FB98"
  paleturquoise:        "#AFEEEE"
  palevioletred:        "#DB7093"
  papayawhip:           "#FFEFD5"
  peachpuff:            "#FFDAB9"
  peru:                 "#CD853F"
  pink:                 "#FFC0CB"
  plum:                 "#DDA0DD"
  powderblue:           "#B0E0E6"
  purple:               "#800080"
  rebeccapurple:        "#663399"
  red:                  "#FF0000"
  rosybrown:            "#BC8F8F"
  royalblue:            "#4169E1"
  saddlebrown:          "#8B4513"
  salmon:               "#FA8072"
  sandybrown:           "#F4A460"
  seagreen:             "#2E8B57"
  seashell:             "#FFF5EE"
  sienna:               "#A0522D"
  silver:               "#C0C0C0"
  skyblue:              "#87CEEB"
  slateblue:            "#6A5ACD"
  slategray:            "#708090"
  slategrey:            "#708090"
  snow:                 "#FFFAFA"
  springgreen:          "#00FF7F"
  steelblue:            "#4682B4"
  tan:                  "#D2B48C"
  teal:                 "#008080"
  thistle:              "#D8BFD8"
  tomato:               "#FF6347"
  turquoise:            "#40E0D0"
  violet:               "#EE82EE"
  wheat:                "#F5DEB3"
  white:                "#FFFFFF"
  whitesmoke:           "#F5F5F5"
  yellow:               "#FFFF00"
  yellowgreen:          "#9ACD32"
}

-- Inverted name list
hexNames = {v, k for k, v in pairs names}

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
    when "table"
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

-- Round up to the nearest integer
round = (n) -> if (n%1) >= 0.5 then math.ceil n else math.floor n

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
print "Color",       i darkblue
print "_RGBA",       i _toRGBA parseColor darkblue
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
  :_Color
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