local hexToRGB
hexToRGB = require("ansikit.color").hexToRGB
local rgbToHsv, rgbToHsl
do
  local _obj_0 = require("ansikit.lib.color")
  rgbToHsv, rgbToHsl = _obj_0.rgbToHsv, _obj_0.rgbToHsl
end
local hexNames
hexNames = require("ansikit.extra.names").hexNames
local _fn, _er
do
  local _obj_0 = require("guardia")
  _fn, _er = _obj_0._fn, _obj_0._er
end
local _not_Color
_not_Color = require("guardia.guards")._not_Color
local _Color
_Color = function(self)
  return function(cl)
    return self(_fn((_er("ansikit $ expected type Color"))(_not_Color(cl))))
  end
end
local round
round = function(n)
  if (n % 1) >= 0.5 then
    return math.ceil(n)
  else
    return math.floor(n)
  end
end
local strip
strip = function(str)
  do
    local _with_0 = string.lower(str)
    str = _with_0:gsub(",", " ")
    str = _with_0:gsub("[()]", " ")
    str = _with_0:gsub("%s+", " ")
    return _with_0
  end
end
local words
words = function(str)
  local _accum_0 = { }
  local _len_0 = 1
  for word in str:gmatch("%S+") do
    _accum_0[_len_0] = word
    _len_0 = _len_0 + 1
  end
  return _accum_0
end
local cssToDecimal
cssToDecimal = function(unit)
  if unit == nil then
    unit = ""
  end
  local CSS_INTEGER = "^[+-]?%d+%%?$"
  local CSS_NUMBER = "^[+-]?%d+%.%d+%%?$"
  do
    local u = unit:match(CSS_INTEGER)
    if u then
      local sign = u:match("^[+-]")
      local number = u:match("%d+")
      local perc = u:match("%%") and true or false
      local final = ""
      sign = sign or ""
      if perc then
        final = final .. (sign .. "0." .. number)
      else
        final = final .. (sign .. number)
      end
      return tonumber(final)
    else
      do
        u = unit:match(CSS_NUMBER)
        if u then
          local sign = u:match("^[+-]")
          local number = u:match("%d+%.%d+")
          local perc = u:match("%%") and true or false
          local final = ""
          sign = sign or ""
          if perc then
            if number:match("^%d%d") then
              final = final .. (sign .. "0." .. (number:gsub("%.", "0")))
            else
              final = final .. (sign .. "0.0" .. (number:gsub("%.", "0")))
            end
          else
            final = final .. (sign .. number)
          end
          return tonumber(final)
        else
          return error("cssToDecimal $ could not convert " .. tostring(unit) .. " to decimal")
        end
      end
    end
  end
end
local guard
guard = function(t)
  for _, v in pairs(t) do
    if not (v) then
      return false
    end
  end
  return t
end
local clamp255
clamp255 = function(n)
  if n < 0 then
    return 0
  end
  if n > 255 then
    return 255
  end
  return n
end
local clamp1
clamp1 = function(n)
  if n < 0 then
    return 0
  end
  if n > 1 then
    return 1
  end
  return n
end
local isRGB
isRGB = function(str, named)
  if named == nil then
    named = false
  end
  local parts = words(strip(str))
  if parts[1] ~= "rgb" then
    return false
  end
  return guard({
    r = clamp255(cssToDecimal((parts[2] or error("isRGB $ missing component 'r' for RGB")))),
    g = clamp255(cssToDecimal((parts[3] or error("isRGB $ missing component 'g' for RGB")))),
    b = clamp255(cssToDecimal((parts[4] or error("isRGB $ missing component 'b' for RGB")))),
    format = named and "name" or "rgb"
  })
end
local isRGBA
isRGBA = function(str, named)
  if named == nil then
    named = false
  end
  local parts = words(strip(str))
  if parts[1] ~= "rgba" then
    return false
  end
  return guard({
    r = clamp255(cssToDecimal((parts[2] or error("isRGBA $ missing component 'r' for RGBA")))),
    g = clamp255(cssToDecimal((parts[3] or error("isRGBA $ missing component 'g' for RGBA")))),
    b = clamp255(cssToDecimal((parts[4] or error("isRGBA $ missing component 'b' for RGBA")))),
    a = clamp255(cssToDecimal((parts[5] or error("isRGBA $ missing component 'a' for RGBA")))),
    format = named and "name" or "rgba"
  })
end
local isHSL
isHSL = function(str, named)
  if named == nil then
    named = false
  end
  local parts = words(strip(str))
  if parts[1] ~= "hsl" then
    return false
  end
  return guard({
    h = clamp1((cssToDecimal((parts[2] or error("isHSL $ missing component 'h' for HSL")))) / 360),
    s = clamp1(cssToDecimal((parts[3] or error("isHSL $ missing component 's' for HSL")))),
    l = clamp1(cssToDecimal((parts[4] or error("isHSL $ missing component 'l' for HSL")))),
    format = named and "name" or "hsl"
  })
end
local isHSLA
isHSLA = function(str, named)
  if named == nil then
    named = false
  end
  local parts = words(strip(str))
  if parts[1] ~= "hsla" then
    return false
  end
  return guard({
    h = clamp1((cssToDecimal((parts[2] or error("isHSLA $ missing component 'h' for HSLA")))) / 360),
    s = clamp1(cssToDecimal((parts[3] or error("isHSLA $ missing component 's' for HSLA")))),
    l = clamp1(cssToDecimal((parts[4] or error("isHSLA $ missing component 'l' for HSLA")))),
    a = clamp1(cssToDecimal((parts[5] or error("isHSLA $ missing component 'a' for HSLA")))),
    format = named and "name" or "hsla"
  })
end
local isHSV
isHSV = function(str, named)
  if named == nil then
    named = false
  end
  local parts = words(strip(str))
  if parts[1] ~= "hsv" then
    return false
  end
  return guard({
    h = clamp1((cssToDecimal((parts[2] or error("isHSV $ missing component 'h' for HSV")))) / 360),
    s = clamp1(cssToDecimal((parts[3] or error("isHSV $ missing component 's' for HSV")))),
    v = clamp1(cssToDecimal((parts[4] or error("isHSV $ missing component 'v' for HSV")))),
    format = named and "name" or "hsv"
  })
end
local isHSVA
isHSVA = function(str, named)
  if named == nil then
    named = false
  end
  local parts = words(strip(str))
  if parts[1] ~= "hsva" then
    return false
  end
  return guard({
    h = clamp1((cssToDecimal((parts[2] or error("isHSVA $ missing component 'h' for HSVA")))) / 360),
    s = clamp1(cssToDecimal((parts[3] or error("isHSVA $ missing component 's' for HSVA")))),
    v = clamp1(cssToDecimal((parts[4] or error("isHSVA $ missing component 'v' for HSVA")))),
    a = clamp1(cssToDecimal((parts[5] or error("isHSVA $ missing component 'a' for HSVA")))),
    format = named and "name" or "hsva"
  })
end
local isHex3
isHex3 = function(str, named)
  if named == nil then
    named = false
  end
  local ox
  ox = function(s)
    return "0x" .. s
  end
  if "number" == type(str) then
    return hexToRGB(str)
  end
  local r, g, b = str:match("#?(%x)(%x)(%x)")
  if r and g and b then
    return {
      r = clamp255(tonumber(ox((r or error("isHex3 $ missing component 'r' for Hex3"))))),
      g = clamp255(tonumber(ox((g or error("isHex3 $ missing component 'g' for Hex3"))))),
      b = clamp255(tonumber(ox((b or error("isHex3 $ missing component 'b' for Hex3"))))),
      format = named and "name" or "hex3"
    }
  else
    return false
  end
end
local isHex4
isHex4 = function(str, named)
  if named == nil then
    named = false
  end
  local ox
  ox = function(s)
    return "0x" .. s
  end
  if "number" == type(str) then
    return hexToRGB(str)
  end
  local r, g, b, a = str:match("#?(%x)(%x)(%x)(%x)")
  if r and g and b and a then
    return {
      r = clamp255(tonumber(ox((r or error("isHex4 $ missing component 'r' for Hex4"))))),
      g = clamp255(tonumber(ox((g or error("isHex4 $ missing component 'g' for Hex4"))))),
      b = clamp255(tonumber(ox((b or error("isHex4 $ missing component 'b' for Hex4"))))),
      a = clamp255(tonumber(ox((a or error("isHex4 $ missing component 'a' for Hex4"))))),
      format = named and "name" or "hex4"
    }
  else
    return false
  end
end
local isHex6
isHex6 = function(str, named)
  if named == nil then
    named = false
  end
  local ox
  ox = function(s)
    return "0x" .. s
  end
  if "number" == type(str) then
    return hexToRGB(str)
  end
  local r, g, b = str:match("#?(%x%x)(%x%x)(%x%x)")
  if r and g and b then
    return {
      r = clamp255(tonumber(ox((r or error("isHex6 $ missing component 'r' for Hex6"))))),
      g = clamp255(tonumber(ox((g or error("isHex6 $ missing component 'g' for Hex6"))))),
      b = clamp255(tonumber(ox((b or error("isHex6 $ missing component 'b' for Hex6"))))),
      format = named and "name" or "hex6"
    }
  else
    return false
  end
end
local isHex8
isHex8 = function(str, named)
  if named == nil then
    named = false
  end
  local ox
  ox = function(s)
    return "0x" .. s
  end
  if "number" == type(str) then
    return hexToRGB(str)
  end
  local r, g, b, a = str:match("#?(%x%x)(%x%x)(%x%x)(%x%x)")
  if r and g and b and a then
    return {
      r = clamp255(tonumber(ox((r or error("isHex8 $ missing component 'r' for Hex8"))))),
      g = clamp255(tonumber(ox((g or error("isHex8 $ missing component 'g' for Hex8"))))),
      b = clamp255(tonumber(ox((b or error("isHex8 $ missing component 'b' for Hex8"))))),
      a = clamp255(tonumber(ox((a or error("isHex8 $ missing component 'a' for Hex8"))))),
      format = named and "name" or "hex8"
    }
  else
    return false
  end
end
local toHSV = _Color(function(cl)
  local h, s, v = rgbToHsv(cl.raw.r, cl.raw.g, cl.raw.b)
  h = h * 360
  return {
    h = h,
    s = s,
    v = v
  }
end)
local toHSVString = _Color(function(cl)
  local h, s, v = rgbToHsv(cl.raw.r, cl.raw.g, cl.raw.b)
  h = h * 360
  return "hsv(" .. tostring(h) .. ", " .. tostring(s) .. "%, " .. tostring(v) .. "%)"
end)
local toHSVA = _Color(function(cl)
  local h, s, v = rgbToHsv(cl.raw.raw.r, cl.raw.raw.g, cl.raw.raw.b)
  h = h * 360
  return {
    h = h,
    s = s,
    v = v,
    a = cl.raw.raw.a
  }
end)
local toHSVAString = _Color(function(cl)
  local h, s, v = rgbToHsv(cl.raw.r, cl.raw.g, cl.raw.b)
  h = h * 360
  return "hsva(" .. tostring(h) .. ", " .. tostring(s) .. "%, " .. tostring(v) .. "%, " .. tostring(cl.raw.a) .. ")"
end)
local toHSL = _Color(function(cl)
  local h, s, l = rgbToHsv(cl.raw.r, cl.raw.g, cl.raw.b)
  h = h * 360
  return {
    h = h,
    s = s,
    l = l
  }
end)
local toHSLString = _Color(function(cl)
  local h, s, l = rgbToHsv(cl.raw.r, cl.raw.g, cl.raw.b)
  h = h * 360
  return "hsl(" .. tostring(h) .. ", " .. tostring(s) .. "%, " .. tostring(l) .. "%)"
end)
local toHSLA = _Color(function(cl)
  local h, s, l = rgbToHsl(cl.raw.r, cl.raw.g, cl.raw.b)
  h = h * 360
  return {
    h = h,
    s = s,
    l = l,
    a = cl.raw.a
  }
end)
local toHSLAString = _Color(function(cl)
  local h, s, l = rgbToHsv(cl.raw.r, cl.raw.g, cl.raw.b)
  h = h * 360
  return "hsla(" .. tostring(h) .. ", " .. tostring(s) .. "%, " .. tostring(l) .. "%, " .. tostring(cl.raw.a) .. ")"
end)
local toHex = _Color(function(cl)
  local rr = string.format("%2.2X", cl.raw.r)
  local gg = string.format("%2.2X", cl.raw.g)
  local bb = string.format("%2.2X", cl.raw.b)
  return tonumber("0x" .. rr .. gg .. bb)
end)
local toHex8 = _Color(function(cl)
  local rr = string.format("%2.2X", cl.raw.r)
  local gg = string.format("%2.2X", cl.raw.g)
  local bb = string.format("%2.2X", cl.raw.b)
  local aa = string.format("%2.2X", cl.raw.a)
  return tonumber("0x" .. rr .. gg .. bb .. aa)
end)
local toHex3String = _Color(function(cl)
  local rr = (string.format("%X", cl.raw.r)):sub(1, 1)
  local gg = (string.format("%X", cl.raw.g)):sub(1, 1)
  local bb = (string.format("%X", cl.raw.b)):sub(1, 1)
  return "#" .. rr .. gg .. bb
end)
local toHex4String = _Color(function(cl)
  local rr = (string.format("%X", cl.raw.r)):sub(1, 1)
  local gg = (string.format("%X", cl.raw.g)):sub(1, 1)
  local bb = (string.format("%X", cl.raw.b)):sub(1, 1)
  local aa = (string.format("%X", cl.raw.a)):sub(1, 1)
  return "#" .. rr .. gg .. bb .. aa
end)
local toHex6String = _Color(function(cl)
  local rr = string.format("%2.2X", cl.raw.r)
  local gg = string.format("%2.2X", cl.raw.g)
  local bb = string.format("%2.2X", cl.raw.b)
  return "#" .. rr .. gg .. bb
end)
local toHex8String = _Color(function(cl)
  local rr = string.format("%2.2X", cl.raw.r)
  local gg = string.format("%2.2X", cl.raw.g)
  local bb = string.format("%2.2X", cl.raw.b)
  local aa = string.format("%2.2X", cl.raw.a)
  return "#" .. rr .. gg .. bb .. aa
end)
local toRGB = _Color(function(cl)
  return {
    r = cl.raw.r,
    g = cl.raw.g,
    b = cl.raw.b
  }
end)
local toRGBString = _Color(function(cl)
  return "rgb(" .. tostring(cl.raw.r) .. ", " .. tostring(cl.raw.g) .. ", " .. tostring(cl.raw.b) .. ")"
end)
local toRGBA = _Color(function(cl)
  return {
    r = cl.raw.r,
    g = cl.raw.g,
    b = cl.raw.b,
    a = cl.raw.a
  }
end)
local toRGBAString = _Color(function(cl)
  return "rgba(" .. tostring(cl.raw.r) .. ", " .. tostring(cl.raw.g) .. ", " .. tostring(cl.raw.b) .. ", " .. tostring(cl.raw.a) .. ")"
end)
local toRGBPercentageString = _Color(function(cl)
  return "rgb(" .. tostring(round(cl.raw.r / 255 * 100)) .. "%, " .. tostring(round(cl.raw.g / 255 * 100)) .. "%, " .. tostring(round(cl.raw.b / 255 * 100)) .. "%)"
end)
local toRGBAPercentageString = _Color(function(cl)
  return "rgba(" .. tostring(round(cl.raw.r / 255 * 100)) .. "%, " .. tostring(round(cl.raw.g / 255 * 100)) .. "%, " .. tostring(round(cl.raw.b / 255 * 100)) .. "%, " .. tostring(round(cl.raw.a / 255 * 100)) .. "%)"
end)
local toName = _Color(function(cl)
  return hexNames[toHex6String(cl)] or false
end)
local toString
toString = function(fmt)
  if fmt == nil then
    fmt = "hex"
  end
  return _Color(function(cl)
    local _exp_0 = fmt
    if "rgb" == _exp_0 then
      return toRGBString(cl)
    elseif "rgba" == _exp_0 then
      return toRGBAString(cl)
    elseif "prgb" == _exp_0 then
      return toRGBPercentageString(cl)
    elseif "prgba" == _exp_0 then
      return toRGBAPercentageString(cl)
    elseif "hsl" == _exp_0 then
      return toHSLString(cl)
    elseif "hsla" == _exp_0 then
      return toHSLAString(cl)
    elseif "hsv" == _exp_0 then
      return toHSVString(cl)
    elseif "hsva" == _exp_0 then
      return toHSVAString(cl)
    elseif "hex3" == _exp_0 then
      return toHex3String(cl)
    elseif "hex4" == _exp_0 then
      return toHex4String(cl)
    elseif "hex" == _exp_0 or "hex6" == _exp_0 then
      return toHex6String(cl)
    elseif "hex8" == _exp_0 then
      return toHex8String(cl)
    elseif "name" == _exp_0 then
      return toName(cl)
    else
      return error("toString $ format is invalid")
    end
  end)
end
return {
  _Color = _Color,
  toHSV = toHSV,
  toHSVA = toHSVA,
  toHSL = toHSL,
  toHSLA = toHSLA,
  toHSVString = toHSVString,
  toHSVAString = toHSVAString,
  toHSLString = toHSLString,
  toHSLAString = toHSLAString,
  toHex = toHex,
  toHex8 = toHex8,
  toHex3String = toHex3String,
  toHex4String = toHex4String,
  toHex6String = toHex6String,
  toHex8String = toHex8String,
  toRGB = toRGB,
  toRGBA = toRGBA,
  toRGBString = toRGBString,
  toRGBAString = toRGBAString,
  toRGBPercentageString = toRGBPercentageString,
  toRGBAPercentageString = toRGBAPercentageString,
  toName = toName,
  toString = toString,
  isRGB = isRGB,
  isRGBA = isRGBA,
  isHSL = isHSL,
  isHSLA = isHSLA,
  isHSV = isHSV,
  isHSVA = isHSVA,
  isHex3 = isHex3,
  isHex4 = isHex4,
  isHex6 = isHex6,
  isHex8 = isHex8,
  cssToDecimal = cssToDecimal,
  clamp1 = clamp1,
  clamp255 = clamp255,
  round = round
}
