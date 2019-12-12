local type = require("typical")
local Bit4, Bit8
do
  local _obj_0 = require("ansikit.color")
  Bit4, Bit8 = _obj_0.Bit4, _obj_0.Bit8
end
local color4 = {
  black = Bit4(30),
  red = Bit4(31),
  green = Bit4(32),
  yellow = Bit4(33),
  blue = Bit4(34),
  magenta = Bit4(35),
  cyan = Bit4(36),
  white = Bit4(37),
  bg = {
    black = Bit4(40),
    red = Bit4(41),
    green = Bit4(42),
    yellow = Bit4(43),
    blue = Bit4(44),
    magenta = Bit4(45),
    cyan = Bit4(46),
    white = Bit4(47)
  },
  bright = {
    black = Bit4(90),
    red = Bit4(91),
    green = Bit4(92),
    yellow = Bit4(93),
    blue = Bit4(94),
    magenta = Bit4(95),
    cyan = Bit4(96),
    white = Bit4(97),
    bg = {
      black = Bit4(100),
      red = Bit4(101),
      green = Bit4(102),
      yellow = Bit4(103),
      blue = Bit4(104),
      magenta = Bit4(105),
      cyan = Bit4(106),
      white = Bit4(107)
    }
  }
}
local color8 = setmetatable({ }, {
  __index = function(self, idx)
    if idx == "bg" then
      return setmetatable({ }, {
        __index = function(self, idxx)
          if ("string" == type(idxx)) and idxx:match("^_") then
            return Bit8((idxx:match("_(%d+)")), true)
          else
            return nil
          end
        end
      })
    elseif ("string" == type(idx)) and idx:match("^_") then
      return Bit8((idx:match("_(%d+)")), false)
    else
      return nil
    end
  end
})
local Palette
Palette = function(name, builder)
  if builder == nil then
    builder = { }
  end
  return setmetatable({
    name = name,
    colors = builder
  }, {
    __type = "Palette",
    __index = function(self, idx)
      if idx == "__name" then
        return rawget(self, "name")
      end
      if idx == "__colors" then
        return rawget(self, "colors")
      end
      return (rawget(self, "colors"))[idx]
    end
  })
end
local nameFor
nameFor = function(self)
  return ("Palette" == type(self)) and self.__name or nil
end
local addColor
addColor = function(pal)
  return function(name, color)
    pal.__colors[name] = color
  end
end
local removeColor
removeColor = function(pal)
  return function(name)
    pal.__colors[name] = nil
  end
end
return {
  color4 = color4,
  color8 = color8,
  Palette = Palette,
  nameFor = nameFor,
  addColor = addColor,
  removeColor = removeColor
}
