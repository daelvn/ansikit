-- ansikit.extra.color
-- Color handling library, similar to TinyColor
-- By daelvn
import hexToRGB                               from require "ansikit.color"
import rgbToHsv, rgbToHsl, hslToRgb, hsvToRgb from require "ansikit.lib.color"
i = require "inspect"

-- List of accepted names
-- Exactly as the one in TinyColor
names = {
  aliceblue: "f0f8ff"
  antiquewhite: "faebd7"
  aqua: "0ff"
  aquamarine: "7fffd4"
  azure: "f0ffff"
  beige: "f5f5dc"
  bisque: "ffe4c4"
  black: "000"
  blanchedalmond: "ffebcd"
  blue: "00f"
  blueviolet: "8a2be2"
  brown: "a52a2a"
  burlywood: "deb887"
  burntsienna: "ea7e5d"
  cadetblue: "5f9ea0"
  chartreuse: "7fff00"
  chocolate: "d2691e"
  coral: "ff7f50"
  cornflowerblue: "6495ed"
  cornsilk: "fff8dc"
  crimson: "dc143c"
  cyan: "0ff"
  darkblue: "00008b"
  darkcyan: "008b8b"
  darkgoldenrod: "b8860b"
  darkgray: "a9a9a9"
  darkgreen: "006400"
  darkgrey: "a9a9a9"
  darkkhaki: "bdb76b"
  darkmagenta: "8b008b"
  darkolivegreen: "556b2f"
  darkorange: "ff8c00"
  darkorchid: "9932cc"
  darkred: "8b0000"
  darksalmon: "e9967a"
  darkseagreen: "8fbc8f"
  darkslateblue: "483d8b"
  darkslategray: "2f4f4f"
  darkslategrey: "2f4f4f"
  darkturquoise: "00ced1"
  darkviolet: "9400d3"
  deeppink: "ff1493"
  deepskyblue: "00bfff"
  dimgray: "696969"
  dimgrey: "696969"
  dodgerblue: "1e90ff"
  firebrick: "b22222"
  floralwhite: "fffaf0"
  forestgreen: "228b22"
  fuchsia: "f0f"
  gainsboro: "dcdcdc"
  ghostwhite: "f8f8ff"
  gold: "ffd700"
  goldenrod: "daa520"
  gray: "808080"
  green: "008000"
  greenyellow: "adff2f"
  grey: "808080"
  honeydew: "f0fff0"
  hotpink: "ff69b4"
  indianred: "cd5c5c"
  indigo: "4b0082"
  ivory: "fffff0"
  khaki: "f0e68c"
  lavender: "e6e6fa"
  lavenderblush: "fff0f5"
  lawngreen: "7cfc00"
  lemonchiffon: "fffacd"
  lightblue: "add8e6"
  lightcoral: "f08080"
  lightcyan: "e0ffff"
  lightgoldenrodyellow: "fafad2"
  lightgray: "d3d3d3"
  lightgreen: "90ee90"
  lightgrey: "d3d3d3"
  lightpink: "ffb6c1"
  lightsalmon: "ffa07a"
  lightseagreen: "20b2aa"
  lightskyblue: "87cefa"
  lightslategray: "789"
  lightslategrey: "789"
  lightsteelblue: "b0c4de"
  lightyellow: "ffffe0"
  lime: "0f0"
  limegreen: "32cd32"
  linen: "faf0e6"
  magenta: "f0f"
  maroon: "800000"
  mediumaquamarine: "66cdaa"
  mediumblue: "0000cd"
  mediumorchid: "ba55d3"
  mediumpurple: "9370db"
  mediumseagreen: "3cb371"
  mediumslateblue: "7b68ee"
  mediumspringgreen: "00fa9a"
  mediumturquoise: "48d1cc"
  mediumvioletred: "c71585"
  midnightblue: "191970"
  mintcream: "f5fffa"
  mistyrose: "ffe4e1"
  moccasin: "ffe4b5"
  navajowhite: "ffdead"
  navy: "000080"
  oldlace: "fdf5e6"
  olive: "808000"
  olivedrab: "6b8e23"
  orange: "ffa500"
  orangered: "ff4500"
  orchid: "da70d6"
  palegoldenrod: "eee8aa"
  palegreen: "98fb98"
  paleturquoise: "afeeee"
  palevioletred: "db7093"
  papayawhip: "ffefd5"
  peachpuff: "ffdab9"
  peru: "cd853f"
  pink: "ffc0cb"
  plum: "dda0dd"
  powderblue: "b0e0e6"
  purple: "800080"
  rebeccapurple: "663399"
  red: "f00"
  rosybrown: "bc8f8f"
  royalblue: "4169e1"
  saddlebrown: "8b4513"
  salmon: "fa8072"
  sandybrown: "f4a460"
  seagreen: "2e8b57"
  seashell: "fff5ee"
  sienna: "a0522d"
  silver: "c0c0c0"
  skyblue: "87ceeb"
  slateblue: "6a5acd"
  slategray: "708090"
  slategrey: "708090"
  snow: "fffafa"
  springgreen: "00ff7f"
  steelblue: "4682b4"
  tan: "d2b48c"
  teal: "008080"
  thistle: "d8bfd8"
  tomato: "ff6347"
  turquoise: "40e0d0"
  violet: "ee82ee"
  wheat: "f5deb3"
  white: "fff"
  whitesmoke: "f5f5f5"
  yellow: "ff0"
  yellowgreen: "9acd32"
}

-- Inverted name list
hexNames = {v, k for k, v in pairs names}

-- Makes string into a parseable bare minumum.
-- "RGB(0, 0, 0)" -> "rgb 0 0 0"
strip = (str) -> return with string.lower str
  str = \gsub ",",    " "
  str = \gsub "[()]", " "
  str = \gsub "%s+",  " "

-- Splits a string into words.
words = (str) -> [word for word in str\gmatch "%S+"]

-- Turns a CSS unit into a decimal number.
cssToDecimal = (unit="") ->
  CSS_INTEGER = "[+-]?%d+%%?"
  CSS_NUMBER  = "[+-]?%d+%.%d+%%?"
  if u = unit\match CSS_INTEGER
    sign   = u\match"^[+-]"
    number = u\match"%d+"
    perc   = u\match"%%" and true or false
    final  = ""
    sign or= ""
    if perc
      final ..= sign.."0."..number
    else
      final ..= sign..number
    return tonumber final
  elseif u = unit\match CSS_NUMBER
    sign   = u\match"^[+-]"
    number = u\match"%d+%.%d+"
    perc   = u\match"%%" and true or false
    final  = ""
    sign or= ""
    if perc
      if number\match "^%d%d"
        final ..= sign.."0."..(number\gsub "%.","0")
      else
        final ..= sign.."0.0"..(number\gsub "%.","0")
    else
      final ..= sign..number
    return tonumber final
  else return false

-- check that none of the values is false
guard = (t) ->
  for k, v in pairs t do return false unless v
  return t

-- checks for several formats using Lua patterns.
isRGB = (str) ->
  parts = words strip str
  return false if parts[1] != "rgb"
  guard {
    r: cssToDecimal parts[2]
    g: cssToDecimal parts[3]
    b: cssToDecimal parts[4]
    format: "rgb"
  }
isRGBA = (str) ->
  parts = words strip str
  return false if parts[1] != "rgba"
  guard {
    r: cssToDecimal parts[2]
    g: cssToDecimal parts[3]
    b: cssToDecimal parts[4]
    a: cssToDecimal parts[5]
    format: "rgba"
  }
isHSL = (str) ->
  parts = words strip str
  return false if parts[1] != "hsl"
  guard {
    h: (cssToDecimal parts[2]) / 360
    s:  cssToDecimal parts[3]
    l:  cssToDecimal parts[4]
    format: "hsl"
  }
isHSLA = (str) ->
  parts = words strip str
  return false if parts[1] != "hsla"
  guard {
    h: (cssToDecimal parts[2]) / 360
    s:  cssToDecimal parts[3]
    l:  cssToDecimal parts[4]
    a:  cssToDecimal parts[5]
    format: "hsla"
  }
isHSV = (str) ->
  parts = words strip str
  return false if parts[1] != "hsv"
  guard {
    h: (cssToDecimal parts[2]) / 360
    s:  cssToDecimal parts[3]
    v:  cssToDecimal parts[4]
    format: "hsv"
  }
isHSVA = (str) ->
  parts = words strip str
  return false if parts[1] != "hsva"
  guard {
    h: (cssToDecimal parts[2]) / 360
    s:  cssToDecimal parts[3]
    v:  cssToDecimal parts[4]
    a:  cssToDecimal parts[5]
    format: "hsva"
  }
isHex3 = (str) ->
  ox = (s) -> "0x" .. s
  return hexToRgb str if "number" == type str
  r, g, b = str\match "#?(%x)(%x)(%x)"
  if r and g and b
    return {
      r: tonumber ox r
      g: tonumber ox g
      b: tonumber ox b
      format: "hex3"
    }
  else false
isHex4 = (str) ->
  ox = (s) -> "0x" .. s
  return hexToRgb str if "number" == type str
  r, g, b, a = str\match "#?(%x)(%x)(%x)(%x)"
  if r and g and b and a
    return {
      r: tonumber ox r
      g: tonumber ox g
      b: tonumber ox b
      a: tonumber ox a
      format: "hex4"
    }
  else false
isHex6 = (str) ->
  ox = (s) -> "0x" .. s
  return hexToRgb str if "number" == type str
  r, g, b = str\match "#?(%x%x)(%x%x)(%x%x)"
  if r and g and b
    return {
      r: tonumber ox r
      g: tonumber ox g
      b: tonumber ox b
      format: "hex6"
    }
  else false
isHex8 = (str) ->
  ox = (s) -> "0x" .. s
  return hexToRgb str if "number" == type str
  r, g, b, a = str\match "#?(%x%x)(%x%x)(%x%x)(%x%x)"
  if r and g and b and a
    return {
      r: tonumber ox r
      g: tonumber ox g
      b: tonumber ox b
      a: tonumber ox a
      format: "hex8"
    }
  else false
  
-- Turns a string into a color table.
parseColor = (color) ->
  if "string" == type color
    with string.lower color -- trim spaces & turn into lowercase
      color = \gsub "^%s+", ""
      color = \gsub "%s+$", ""

  -- check if a name was used
  named = false
  if names[color]
    color = names[color]
    named = true
  elseif color == "transparent"
    return {r:0, g:0, b:0, a:255, format: "name"}

  -- return
  return (isRGB color) or
    (isRGBA color) or
    (isHSL  color) or
    (isHSLA color) or
    (isHSV  color) or
    (isHSVA color) or
    (isHex8 color) or
    (isHex6 color) or
    (isHex4 color) or
    (isHex3 color)

-- Round up to the nearest integer
round = (n) -> if (n%1) > 0.5 then math.ceil n else math.floor n

-- Converts any color table to RGBA
toRGBA = (c) ->
  c = parseColor c if "string" == type c
  switch c.format
    when "rgba" then return c
    when "rgb"
      c.a = 0
      return c
    when "hsl"
      r, g, b = hslToRgb c.h, c.s, c.l
      { :r, :g, :b, a: 255, format: "rgba" }
    when "hsla"
      r, g, b, a = hslToRgb c.h, c.s, c.l, c.a
      { :r, :g, :b, :a, format: "rgba" }
    when "hsv"
      r, g, b = hsvToRgb c.h, c.s, c.v
      { :r, :g, :b, a: 255, format: "rgba" }
    when "hsva"
      r, g, b, a = hsvToRgb c.h, c.s, c.v, c.a
      { :r, :g, :b, :a, format: "rgba" }
    else error "ansikit.extra.color/toRGBA $ color format #{c.format} not recognized"

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
  this.color    = parseColor cl
  this.round    = {}
  with toRGBA cl
    this.r       = .r
    this.g       = .g
    this.b       = .b
    this.a       = .a
    this.round.r = round .r
    this.round.g = round .g
    this.round.b = round .b
    this.round.a = round .a
  --
  setmetatable this, __type: "Color"

-- Checks the brightness of a color
brightnessFor = (cl) -> (cl.r * 299 + cl.g * 587 + cl.b * 114) / 1000

-- Checks if the color is light or dark
isLight = (cl) -> (brightnessFor cl) > 128
isDark  = (cl) -> not isLight cl

print i Color "hsl 260 66% 80%"