-- ansikit.palette
-- Makes palettes out of colors.
-- By daelvn
type                               = require "typical"
import reset, Bit4, Bit8, Bit24 from require "ansikit.color"

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
    return setmetatable {}, __index (idx) =>
      if ("string" == type idx) and idx\match "^_"
        return Bit8 (idx\match "_(%d+)"), true
      else
        return nil
  elseif ("string" == type idx) and idx\match "^_"
    return Bit8 (idx\match "_(%d+)"), false
  else
    return nil

-- RGB representation
-- print (Color 255, 255, 255) -- white ansi code
Color = (r=0, g=0, b=0, bg=false) -> setmetatable {:r, :g, :b, :bg}, {
  __type:     "Color"
  __tostring:     => Bit24 @r, @g, @b, @bg
  __concat:   (b) =>
    if "Color" == type b
      (tostring @) .. (tostring b)
    elseif "string" == type b
      (tostring @) .. b
    else
      return b
}

-- Turns a color into a background color
background = =>
  @bg = true
  @

-- Turns a color into a foreground color
foreground = =>
  @bg = false
  @

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

-- Converts a Hex code to RGB. Accepts #rrggbb as a string only, and any hex literal.
-- https://gist.github.com/fernandohenriques/12661bf250c8c2d8047188222cab7e28
hexToRGB = (hex) ->
  switch type hex
    when "string" then hex = tostring hex\gsub "#", ""
    when "number" then hex = "#{string.format "%6.6X", hex}"
  ox  = (str) -> "0x" .. str
  return (tonumber ox hex\sub 1,2), (tonumber ox hex\sub 3,4), (tonumber ox hex\sub 5,6)

{
  :color4, :color8
  :Color, :background, :foreground
  :Palette
  :nameFor, :addColor, :removeColor
  :hexToRGB
}