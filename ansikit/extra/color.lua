local hslToRgb, hsvToRgb
do
  local _obj_0 = require("ansikit.lib.color")
  hslToRgb, hsvToRgb = _obj_0.hslToRgb, _obj_0.hsvToRgb
end
local names, hexNames
do
  local _obj_0 = require("ansikit.extra.names")
  names, hexNames = _obj_0.names, _obj_0.hexNames
end
local toHSV, toHSVA, toHSL, toHSLA, toHSVString, toHSVAString, toHSLString, toHSLAString, toHex, toHex8, toHex3String, toHex4String, toHex6String, toHex8String, toRGB, toRGBA, toRGBString, toRGBAString, toRGBPercentageString, toRGBAPercentageString, toName, toString, isRGB, isRGBA, isHSL, isHSLA, isHSV, isHSVA, isHex3, isHex4, isHex6, isHex8, cssToDecimal, clamp1, clamp255, round, _Color
do
  local _obj_0 = require("ansikit.extra.conversion")
  toHSV, toHSVA, toHSL, toHSLA, toHSVString, toHSVAString, toHSLString, toHSLAString, toHex, toHex8, toHex3String, toHex4String, toHex4String, toHex6String, toHex8String, toRGB, toRGBA, toRGBString, toRGBAString, toRGBPercentageString, toRGBAPercentageString, toName, toString, isRGB, isRGBA, isHSL, isHSLA, isHSV, isHSVA, isHex3, isHex4, isHex6, isHex8, cssToDecimal, clamp1, clamp255, round, _Color = _obj_0.toHSV, _obj_0.toHSVA, _obj_0.toHSL, _obj_0.toHSLA, _obj_0.toHSVString, _obj_0.toHSVAString, _obj_0.toHSLString, _obj_0.toHSLAString, _obj_0.toHex, _obj_0.toHex8, _obj_0.toHex3String, _obj_0.toHex4String, _obj_0.toHex4String, _obj_0.toHex6String, _obj_0.toHex8String, _obj_0.toRGB, _obj_0.toRGBA, _obj_0.toRGBString, _obj_0.toRGBAString, _obj_0.toRGBPercentageString, _obj_0.toRGBAPercentageString, _obj_0.toName, _obj_0.toString, _obj_0.isRGB, _obj_0.isRGBA, _obj_0.isHSL, _obj_0.isHSLA, _obj_0.isHSV, _obj_0.isHSVA, _obj_0.isHex3, _obj_0.isHex4, _obj_0.isHex6, _obj_0.isHex8, _obj_0.cssToDecimal, _obj_0.clamp1, _obj_0.clamp255, _obj_0.round, _obj_0._Color
end
local type = require("typical")
local i = require("inspect")
local tee_count = 0
local tee
tee = function(...)
  tee_count = tee_count + 1
  print(tee_count, i(...))
  return ...
end
local unparseColor
unparseColor = function(c)
  if c.r and c.g and c.b then
    return "rgb" .. tostring(c.a and "a" or "") .. " " .. tostring(c.r) .. " " .. tostring(c.g) .. " " .. tostring(c.b) .. " " .. tostring(c.a or "")
  elseif c.h and c.s and c.l then
    return "hsl" .. tostring(c.a and "a" or "") .. " " .. tostring(c.h) .. " " .. tostring(c.s) .. " " .. tostring(c.l) .. " " .. tostring(c.a or "")
  elseif c.h and c.s and c.v then
    return "hsv" .. tostring(c.a and "a" or "") .. " " .. tostring(c.h) .. " " .. tostring(c.s) .. " " .. tostring(c.v) .. " " .. tostring(c.a or "")
  end
end
local parseColor
parseColor = function(color)
  local _exp_0 = type(color)
  if "Color" == _exp_0 then
    return color
  elseif "string" == _exp_0 then
    do
      local _with_0 = string.lower(color)
      color = _with_0:gsub("^%s+", "")
      color = _with_0:gsub("%s+$", "")
    end
  elseif "table" == _exp_0 then
    color = unparseColor(color)
  end
  local named = false
  if names[color] then
    color = names[color]
    named = true
  elseif color == "transparent" then
    return {
      r = 0,
      g = 0,
      b = 0,
      a = 255,
      format = "name"
    }
  end
  return (isRGB(color, named)) or (isRGBA(color, named)) or (isHSL(color, named)) or (isHSLA(color, named)) or (isHSV(color, named)) or (isHSVA(color, named)) or (isHex8(color, named)) or (isHex6(color, named)) or (isHex4(color, named)) or (isHex3(color, named))
end
local _toRGBA
_toRGBA = function(c)
  if "string" == type(c) then
    c = parseColor(c)
  end
  local _exp_0 = c.format
  if "rgba" == _exp_0 then
    return c
  elseif "rgb" == _exp_0 then
    c.a = 0
    return c
  elseif "hsl" == _exp_0 then
    local r, g, b = hslToRgb(c.h, c.s, c.l)
    return {
      r = r,
      g = g,
      b = b,
      a = 255,
      format = "hsl"
    }
  elseif "hsla" == _exp_0 then
    local r, g, b, a = hslToRgb(c.h, c.s, c.l, c.a)
    return {
      r = r,
      g = g,
      b = b,
      a = a,
      format = "hsla"
    }
  elseif "hsv" == _exp_0 then
    local r, g, b = hsvToRgb(c.h, c.s, c.v)
    return {
      r = r,
      g = g,
      b = b,
      a = 255,
      format = "hsv"
    }
  elseif "hsva" == _exp_0 then
    local r, g, b, a = hsvToRgb(c.h, c.s, c.v, c.a)
    return {
      r = r,
      g = g,
      b = b,
      a = a,
      format = "hsva"
    }
  else
    return error("_toRGBA $ color format " .. tostring(c.format) .. " not recognized")
  end
end
local roundAll
roundAll = function(t)
  local checkFor = {
    "r",
    "g",
    "b",
    "h",
    "s",
    "v",
    "l",
    "a"
  }
  for _index_0 = 1, #checkFor do
    local key = checkFor[_index_0]
    if t[key] and ("number" == type(t[key])) then
      t[key] = round(t[key])
    end
  end
  return t
end
local Color
Color = function(cl)
  local this = { }
  this.original = cl
  this.raw = { }
  do
    local _with_0 = _toRGBA(parseColor(cl))
    this.r = round(_with_0.r)
    this.g = round(_with_0.g)
    this.b = round(_with_0.b)
    this.a = round(_with_0.a)
    this.raw.r = _with_0.r
    this.raw.g = _with_0.g
    this.raw.b = _with_0.b
    this.raw.a = _with_0.a
  end
  return setmetatable(this, {
    __type = "Color"
  })
end
local brightnessFor = _Color(function(cl)
  return (cl.r * 299 + cl.g * 587 + cl.b * 114) / 1000
end)
local isLight = _Color(function(cl)
  return (brightnessFor(cl)) > 128
end)
local isDark = _Color(function(cl)
  return not isLight(cl)
end)
local luminanceFor = _Color(function(cl)
  local rr, gg, bb = cl.r / 255, cl.g / 255, cl.b / 255
  local R, G, B
  if rr > 0.03928 then
    R = rr / 12.92
  else
    R = ((rr + 0.055) / 1.055) ^ 2.4
  end
  if gg > 0.03928 then
    G = gg / 12.92
  else
    G = ((gg + 0.055) / 1.055) ^ 2.4
  end
  if bb > 0.03928 then
    B = bb / 12.92
  else
    B = ((bb + 0.055) / 1.055) ^ 2.4
  end
  return (0.2126 * R) + (0.7152 * G) + (0.0722 * B)
end)
local clone = _Color(function(cl)
  return Color(toString(cl))
end)
local desaturate = _Color(function(cl)
  return function(amount)
    if amount == nil then
      amount = 10
    end
    local hsva = toHSVA(cl)
    hsva.s = hsva.s - (amount / 100)
    hsva.s = clamp1(hsva.s)
    return Color(hsva)
  end
end)
local darkblue = Color("hsva 250 50% 50% 255")
print("Desaturated", i(toHSVA((desaturate(darkblue))(10))))
return {
  names = names,
  hexNames = hexNames,
  unparseColor = unparseColor,
  parseColor = parseColor,
  roundAll = roundAll,
  Color = Color,
  brightnessFor = brightnessFor,
  luminanceFor = luminanceFor,
  isLight = isLight,
  isDark = isDark,
  clone = clone,
  desaturate = desaturate,
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
  cssToDecimal = cssToDecimal
}
