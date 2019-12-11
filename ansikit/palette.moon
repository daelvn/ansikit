-- ansikit.palette
-- Makes palettes out of colors.
-- By daelvn
type                 = require "typical"
import Bit4, Bit8 from require "ansikit.color"

-- Bit4 collection
color4 = {
  black:   Bit4 30
  red:     Bit4 31
  green:   Bit4 32
  yellow:  Bit4 33
  blue:    Bit4 34
  magenta: Bit4 35
  cyan:    Bit4 36
  white:   Bit4 37
  -- background
  bg:
    black:   Bit4 40
    red:     Bit4 41
    green:   Bit4 42
    yellow:  Bit4 43
    blue:    Bit4 44
    magenta: Bit4 45
    cyan:    Bit4 46
    white:   Bit4 47
  -- bright
  bright:
    black:   Bit4 90
    red:     Bit4 91
    green:   Bit4 92
    yellow:  Bit4 93
    blue:    Bit4 94
    magenta: Bit4 95
    cyan:    Bit4 96
    white:   Bit4 97
    bg:
      black:   Bit4 100
      red:     Bit4 101
      green:   Bit4 102
      yellow:  Bit4 103
      blue:    Bit4 104
      magenta: Bit4 105
      cyan:    Bit4 106
      white:   Bit4 107
}

-- Bit8 collection
-- Use as color8._255 or color8.bg._255
color8 = setmetatable {}, __index: (idx) =>
  if idx == "bg"
    return setmetatable {}, __index: (idxx) =>
      if ("string" == type idxx) and idxx\match "^_"
        return Bit8 (idxx\match "_(%d+)"), true
      else
        return nil
  elseif ("string" == type idx) and idx\match "^_"
    return Bit8 (idx\match "_(%d+)"), false
  else
    return nil

-- Creates a named palette
Palette = (name, builder={}) ->
  setmetatable {:name, colors: builder}, {
    __type:  "Palette"
    __index: (idx) =>
      return  rawget @, "name"   if idx == "__name"
      return  rawget @, "colors" if idx == "__colors"
      return (rawget @, "colors")[idx]
  }

-- Gets name of palette
nameFor = => ("Palette" == type @) and @__name or nil

-- Add color to palette
addColor = (pal) -> (name, color) -> pal.__colors[name] = color

-- Remove color from palette
removeColor = (pal) -> (name) -> pal.__colors[name] = nil

{
  :color4, :color8
  :Palette, :nameFor, :addColor, :removeColor
}