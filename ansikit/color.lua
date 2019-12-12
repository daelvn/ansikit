local SGR
SGR = require("ansikit.sequence").SGR
local reset = SGR(0)
local Bit4
Bit4 = function(index)
  if index == nil then
    index = 0
  end
  return SGR(index)
end
local Bit8
Bit8 = function(index, bg)
  if index == nil then
    index = 0
  end
  if bg == nil then
    bg = false
  end
  return SGR((bg and 48 or 38), 5, index)
end
local Bit24
Bit24 = function(r, g, b, bg)
  if r == nil then
    r = 0
  end
  if g == nil then
    g = 0
  end
  if b == nil then
    b = 0
  end
  if bg == nil then
    bg = false
  end
  return SGR((bg and 48 or 38), 2, r, g, b)
end
local Color
Color = function(r, g, b, bg)
  if r == nil then
    r = 0
  end
  if g == nil then
    g = 0
  end
  if b == nil then
    b = 0
  end
  if bg == nil then
    bg = false
  end
  return setmetatable({
    r = r,
    g = g,
    b = b,
    bg = bg
  }, {
    __type = "Color",
    __tostring = function(self)
      return Bit24(self.r, self.g, self.b, self.bg)
    end,
    __concat = function(self, b_)
      if "Color" == type(b_) then
        return (tostring(self)) .. (tostring(b_))
      elseif "string" == type(b_) then
        return (tostring(self)) .. b_
      else
        return b_
      end
    end
  })
end
local background
background = function(self)
  self.bg = true
  return self
end
local foreground
foreground = function(self)
  self.bg = false
  return self
end
local hexToRGB
hexToRGB = function(hex)
  local _exp_0 = type(hex)
  if "string" == _exp_0 then
    hex = tostring(hex:gsub("#", ""))
  elseif "number" == _exp_0 then
    hex = tostring(string.format("%6.6X", hex))
  end
  local ox
  ox = function(str)
    return "0x" .. str
  end
  return (tonumber(ox(hex:sub(1, 2)))), (tonumber(ox(hex:sub(3, 4)))), (tonumber(ox(hex:sub(5, 6))))
end
return {
  reset = reset,
  Bit4 = Bit4,
  Bit8 = Bit8,
  Bit24 = Bit24,
  Color = Color,
  background = background,
  foreground = foreground,
  hexToRGB = hexToRGB
}
