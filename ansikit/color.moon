-- ansikit.color
-- Use colors with ANSI sequences.
-- By daelvn
import SGR from require "ansikit.sequence"

-- reset
reset = SGR 0

-- 4-bit
Bit4  = (index=0) -> SGR index

-- 8-bit
Bit8  = (index=0, bg=false) -> SGR (bg and 48 or 38), 5, index

-- 24-bit
Bit24 = (r=0, g=0, b=0, bg=false) -> SGR (bg and 48 or 38), 2, r, g, b

-- RGB representation
-- print (Color 255, 255, 255) -- white ansi code
Color = (r=0, g=0, b=0, bg=false) -> setmetatable {:r, :g, :b, :bg}, {
  __type:          "Color"
  __tostring:      => Bit24 @r, @g, @b, @bg
  __concat:   (b_) =>
    if "Color" == type b_
      (tostring @) .. (tostring b_)
    elseif "string" == type b_
      (tostring @) .. b_
    else
      return b_
}

-- Turns a color into a background color
background = =>
  @bg = true
  @

-- Turns a color into a foreground color
foreground = =>
  @bg = false
  @

-- Converts a Hex code to RGB. Accepts #rrggbb as a string only, and any hex literal.
-- https://gist.github.com/fernandohenriques/12661bf250c8c2d8047188222cab7e28
hexToRGB = (hex) ->
  switch type hex
    when "string" then hex = tostring hex\gsub "#", ""
    when "number" then hex = "#{string.format "%6.6X", hex}"
  ox  = (str) -> "0x" .. str
  return (tonumber ox hex\sub 1,2), (tonumber ox hex\sub 3,4), (tonumber ox hex\sub 5,6)

{
  :reset, :Bit4, :Bit8, :Bit24
  :Color, :background, :foreground
  :hexToRGB
}