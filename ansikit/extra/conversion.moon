-- ansikit.extra.conversion
-- Conversions for ansikit.extra.color
-- By daelvn
import hexToRGB           from require "ansikit.color"
import rgbToHsv, rgbToHsl from require "ansikit.lib.color"
import hexNames           from require "ansikit.extra.names"
import _fn, _er           from require "guardia"
import _not_Color         from require "guardia.guards"

-- Color type guard
_Color = => (cl) -> @ _fn (_er "ansikit $ expected type Color") _not_Color cl

-- Round up to the nearest integer
round = (n) -> if (n%1) >= 0.5 then math.ceil n else math.floor n

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
  CSS_INTEGER = "^[+-]?%d+%%?$"
  CSS_NUMBER  = "^[+-]?%d+%.%d+%%?$"
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
  else error "cssToDecimal $ could not convert #{unit} to decimal"

-- check that none of the values is false
guard = (t) ->
  for _, v in pairs t do return false unless v
  return t

-- Clamps from 0 to 255
clamp255 = (n) ->
  return 0   if n < 0
  return 255 if n > 255
  return n

-- Clamps from 0 to 1
clamp1 = (n) ->
  return 0 if n < 0
  return 1 if n > 1
  return n

-- checks for several formats using Lua patterns.
isRGB = (str, named=false) ->
  parts = words strip str
  return false if parts[1] != "rgb"
  guard {
    r: clamp255 cssToDecimal (parts[2] or error "isRGB $ missing component 'r' for RGB")
    g: clamp255 cssToDecimal (parts[3] or error "isRGB $ missing component 'g' for RGB")
    b: clamp255 cssToDecimal (parts[4] or error "isRGB $ missing component 'b' for RGB")
    format: named and "name" or "rgb"
  }
isRGBA = (str, named=false) ->
  parts = words strip str
  return false if parts[1] != "rgba"
  guard {
    r: clamp255 cssToDecimal (parts[2] or error "isRGBA $ missing component 'r' for RGBA")
    g: clamp255 cssToDecimal (parts[3] or error "isRGBA $ missing component 'g' for RGBA")
    b: clamp255 cssToDecimal (parts[4] or error "isRGBA $ missing component 'b' for RGBA")
    a: clamp255 cssToDecimal (parts[5] or error "isRGBA $ missing component 'a' for RGBA")
    format: named and "name" or "rgba"
  }
isHSL = (str, named=false) ->
  parts = words strip str
  return false if parts[1] != "hsl"
  guard {
    h: clamp1 (cssToDecimal (parts[2] or error "isHSL $ missing component 'h' for HSL")) / 360
    s: clamp1  cssToDecimal (parts[3] or error "isHSL $ missing component 's' for HSL")
    l: clamp1  cssToDecimal (parts[4] or error "isHSL $ missing component 'l' for HSL")
    format: named and "name" or "hsl"
  }
isHSLA = (str, named=false) ->
  parts = words strip str
  return false if parts[1] != "hsla"
  guard {
    h: clamp1 (cssToDecimal (parts[2] or error "isHSLA $ missing component 'h' for HSLA")) / 360
    s: clamp1  cssToDecimal (parts[3] or error "isHSLA $ missing component 's' for HSLA")
    l: clamp1  cssToDecimal (parts[4] or error "isHSLA $ missing component 'l' for HSLA")
    a: clamp1  cssToDecimal (parts[5] or error "isHSLA $ missing component 'a' for HSLA")
    format: named and "name" or "hsla"
  }
isHSV = (str, named=false) ->
  parts = words strip str
  return false if parts[1] != "hsv"
  guard {
    h: clamp1 (cssToDecimal (parts[2] or error "isHSV $ missing component 'h' for HSV")) / 360
    s: clamp1  cssToDecimal (parts[3] or error "isHSV $ missing component 's' for HSV")
    v: clamp1  cssToDecimal (parts[4] or error "isHSV $ missing component 'v' for HSV")
    format: named and "name" or "hsv"
  }
isHSVA = (str, named=false) ->
  parts = words strip str
  return false if parts[1] != "hsva"
  guard {
    h: clamp1 (cssToDecimal (parts[2] or error "isHSVA $ missing component 'h' for HSVA")) / 360
    s: clamp1  cssToDecimal (parts[3] or error "isHSVA $ missing component 's' for HSVA")
    v: clamp1  cssToDecimal (parts[4] or error "isHSVA $ missing component 'v' for HSVA")
    a: clamp1  cssToDecimal (parts[5] or error "isHSVA $ missing component 'a' for HSVA")
    format: named and "name" or "hsva"
  }
isHex3 = (str, named=false) ->
  ox = (s) -> "0x" .. s
  return hexToRGB str if "number" == type str
  r, g, b = str\match "#?(%x)(%x)(%x)"
  if r and g and b
    return {
      r: clamp255 tonumber ox (r or error "isHex3 $ missing component 'r' for Hex3")
      g: clamp255 tonumber ox (g or error "isHex3 $ missing component 'g' for Hex3")
      b: clamp255 tonumber ox (b or error "isHex3 $ missing component 'b' for Hex3")
      format: named and "name" or "hex3"
    }
  else false
isHex4 = (str, named=false) ->
  ox = (s) -> "0x" .. s
  return hexToRGB str if "number" == type str
  r, g, b, a = str\match "#?(%x)(%x)(%x)(%x)"
  if r and g and b and a
    return {
      r: clamp255 tonumber ox (r or error "isHex4 $ missing component 'r' for Hex4")
      g: clamp255 tonumber ox (g or error "isHex4 $ missing component 'g' for Hex4")
      b: clamp255 tonumber ox (b or error "isHex4 $ missing component 'b' for Hex4")
      a: clamp255 tonumber ox (a or error "isHex4 $ missing component 'a' for Hex4")
      format: named and "name" or "hex4"
    }
  else false
isHex6 = (str, named=false) ->
  ox = (s) -> "0x" .. s
  return hexToRGB str if "number" == type str
  r, g, b = str\match "#?(%x%x)(%x%x)(%x%x)"
  if r and g and b
    return {
      r: clamp255 tonumber ox (r or error "isHex6 $ missing component 'r' for Hex6")
      g: clamp255 tonumber ox (g or error "isHex6 $ missing component 'g' for Hex6")
      b: clamp255 tonumber ox (b or error "isHex6 $ missing component 'b' for Hex6")
      format: named and "name" or "hex6"
    }
  else false
isHex8 = (str, named=false) ->
  ox = (s) -> "0x" .. s
  return hexToRGB str if "number" == type str
  r, g, b, a = str\match "#?(%x%x)(%x%x)(%x%x)(%x%x)"
  if r and g and b and a
    return {
      r: clamp255 tonumber ox (r or error "isHex8 $ missing component 'r' for Hex8")
      g: clamp255 tonumber ox (g or error "isHex8 $ missing component 'g' for Hex8")
      b: clamp255 tonumber ox (b or error "isHex8 $ missing component 'b' for Hex8")
      a: clamp255 tonumber ox (a or error "isHex8 $ missing component 'a' for Hex8")
      format: named and "name" or "hex8"
    }
  else false

-- Returns a HSV color table with h between [0,360] and s,v values between [0,1]
toHSV = _Color (cl) ->
  h, s, v = rgbToHsv cl.raw.r, cl.raw.g, cl.raw.b
  h *= 360
  { :h, :s, :v }

-- Returns a HSV color string with h between [0, 360] and s,v values between [0,100]%
toHSVString = _Color (cl) ->
  h, s, v = rgbToHsv cl.raw.r, cl.raw.g, cl.raw.b
  h *= 360
  "hsv(#{h}, #{s}%, #{v}%)"

-- Returns a HSVA color table with h and a between [0,360] and s,v values between [0,1]
toHSVA = _Color (cl) ->
  h, s, v = rgbToHsv cl.raw.raw.r, cl.raw.raw.g, cl.raw.raw.b
  h *= 360
  { :h, :s, :v, a: cl.raw.raw.a }

-- Returns a HSVA color string with h and a between [0, 360] and s,v values between [0,100]%
toHSVAString = _Color (cl) ->
  h, s, v = rgbToHsv cl.raw.r, cl.raw.g, cl.raw.b
  h *= 360
  "hsva(#{h}, #{s}%, #{v}%, #{cl.raw.a})"

-- Returns a HSL color table with h between [0,360] and s,l values between [0,1]
toHSL = _Color (cl) ->
  h, s, l = rgbToHsv cl.raw.r, cl.raw.g, cl.raw.b
  h *= 360
  { :h, :s, :l }

-- Returns a HSV color string with h between [0, 360] and s,v values between [0,100]%
toHSLString = _Color (cl) ->
  h, s, l = rgbToHsv cl.raw.r, cl.raw.g, cl.raw.b
  h *= 360
  "hsl(#{h}, #{s}%, #{l}%)"

-- Returns a HSLA color table with h and a between [0,360] and s,l values between [0,1]
toHSLA = _Color (cl) ->
  h, s, l = rgbToHsl cl.raw.r, cl.raw.g, cl.raw.b
  h *= 360
  { :h, :s, :l, a: cl.raw.a }

-- Returns a HSVA color string with h and a between [0, 360] and s,v values between [0,100]%
toHSLAString = _Color (cl) ->
  h, s, l = rgbToHsv cl.raw.r, cl.raw.g, cl.raw.b
  h *= 360
  "hsla(#{h}, #{s}%, #{l}%, #{cl.raw.a})"

-- Returns a hex number (represented as decimal)
toHex = _Color (cl) ->
  rr = string.format "%2.2X", cl.raw.r
  gg = string.format "%2.2X", cl.raw.g
  bb = string.format "%2.2X", cl.raw.b
  tonumber "0x"..rr..gg..bb

-- Returns a hex number with alpha (represented as decimal)
toHex8 = _Color (cl) ->
  rr = string.format "%2.2X", cl.raw.r
  gg = string.format "%2.2X", cl.raw.g
  bb = string.format "%2.2X", cl.raw.b
  aa = string.format "%2.2X", cl.raw.a
  tonumber "0x"..rr..gg..bb..aa

-- Returns a 3 digit hex string
toHex3String = _Color (cl) ->
  rr = (string.format "%X", cl.raw.r)\sub 1,1
  gg = (string.format "%X", cl.raw.g)\sub 1,1
  bb = (string.format "%X", cl.raw.b)\sub 1,1
  "#"..rr..gg..bb

-- Returns a 4 digit hex string
toHex4String = _Color (cl) ->
  rr = (string.format "%X", cl.raw.r)\sub 1,1
  gg = (string.format "%X", cl.raw.g)\sub 1,1
  bb = (string.format "%X", cl.raw.b)\sub 1,1
  aa = (string.format "%X", cl.raw.a)\sub 1,1
  "#"..rr..gg..bb..aa

-- Returns a 6 digit hex string
toHex6String = _Color (cl) ->
  rr = string.format "%2.2X", cl.raw.r
  gg = string.format "%2.2X", cl.raw.g
  bb = string.format "%2.2X", cl.raw.b
  "#"..rr..gg..bb

-- Returns a 8 digit hex string
toHex8String = _Color (cl) ->
  rr = string.format "%2.2X", cl.raw.r
  gg = string.format "%2.2X", cl.raw.g
  bb = string.format "%2.2X", cl.raw.b
  aa = string.format "%2.2X", cl.raw.a
  "#"..rr..gg..bb..aa

-- Returns a RGB color table
toRGB = _Color (cl) -> { r: cl.raw.r, g: cl.raw.g, b: cl.raw.b }

-- Returns a RGB color string
toRGBString = _Color (cl) -> "rgb(#{cl.raw.r}, #{cl.raw.g}, #{cl.raw.b})"

-- Returns a RGBA color table
toRGBA = _Color (cl) -> { r: cl.raw.r, g: cl.raw.g, b: cl.raw.b, a: cl.raw.a }

-- Returns a RGBA color string
toRGBAString = _Color (cl) -> "rgba(#{cl.raw.r}, #{cl.raw.g}, #{cl.raw.b}, #{cl.raw.a})"

-- Returns a RGB color string in percentages
toRGBPercentageString = _Color (cl) -> "rgb(#{round cl.raw.r/255*100}%, #{round cl.raw.g/255*100}%, #{round cl.raw.b/255*100}%)"

-- Returns a RGBA color string in percentages
toRGBAPercentageString = _Color (cl) -> "rgba(#{round cl.raw.r/255*100}%, #{round cl.raw.g/255*100}%, #{round cl.raw.b/255*100}%, #{round cl.raw.a/255*100}%)"

-- Returns a name for the color, if it can be named
toName = _Color (cl) -> hexNames[toHex6String cl] or false

-- Turns a color into a string with a format.
toString = (fmt="hex") -> _Color (cl) ->
  return switch fmt
    when "rgb"         then toRGBString            cl
    when "rgba"        then toRGBAString           cl
    when "prgb"        then toRGBPercentageString  cl
    when "prgba"       then toRGBAPercentageString cl
    when "hsl"         then toHSLString            cl
    when "hsla"        then toHSLAString           cl
    when "hsv"         then toHSVString            cl
    when "hsva"        then toHSVAString           cl
    when "hex3"        then toHex3String           cl
    when "hex4"        then toHex4String           cl
    when "hex", "hex6" then toHex6String           cl
    when "hex8"        then toHex8String           cl
    when "name"        then toName                 cl
    else                    error "toString $ format is invalid"

{
  :_Color
  :toHSV,        :toHSVA,       :toHSL,                 :toHSLA
  :toHSVString,  :toHSVAString, :toHSLString,           :toHSLAString
  :toHex,        :toHex8
  :toHex3String, :toHex4String, :toHex6String,          :toHex8String
  :toRGB,        :toRGBA
  :toRGBString,  :toRGBAString, :toRGBPercentageString, :toRGBAPercentageString
  :toName,       :toString
  :isRGB,        :isRGBA,       :isHSL,                 :isHSLA, :isHSV, :isHSVA
  :isHex3,       :isHex4,       :isHex6,                :isHex8
  :cssToDecimal
  :clamp1,       :clamp255
  :round
}