-- ansikit.paint
-- NFP Paint format handler (CraftOS)
-- By daelvn
import Palette                     from require "ansikit.palette"
import Color, hexToRGB, background from require "ansikit.color"
hex = hexToRGB

i = require "inspect"

colors = Palette "CraftOS", {k, background v for k, v in pairs {
  white:     Color hex 0xF0F0F0
  orange:    Color hex 0xF2B233
  magenta:   Color hex 0xE57FD8
  lightBlue: Color hex 0x99B2F2
  yellow:    Color hex 0xDEDE6C
  lime:      Color hex 0x7FCC19
  pink:      Color hex 0xF2B2CC
  gray:      Color hex 0x4C4C4C
  lightGray: Color hex 0x999999
  cyan:      Color hex 0x4C99B2
  purple:    Color hex 0xB266E5
  blue:      Color hex 0x3366CC
  brown:     Color hex 0x7F664C
  green:     Color hex 0x57A64E
  red:       Color hex 0xCC4C4C
  black:     Color hex 0x191919
}}

colorMap = {
  colors.white
  colors.orange
  colors.magenta
  colors.lightBlue
  colors.yellow
  colors.lime
  colors.pink
  colors.gray
  colors.lightGray
  colors.cyan
  colors.purple
  colors.blue
  colors.brown
  colors.green
  colors.red
  colors.black
}

loadNFP = (text) ->
  image, row = {}, {}
  for line in text\gmatch "[^\r\n]+"
    for char in line\gmatch "."
      table.insert row, colorMap[tonumber "0x#{char}"]
    table.insert image, row
    row = {}
  image

safeOpen = (path, mode) ->
  a, b = io.open path, mode
  return a and a or {error: b}

loadImage = (file) ->
  ret = {}
  with safeOpen file, "r"
    error "ansikit.paint: Could not load image #{file}" if .error
    ret = loadNFP \read"*a"
    \close!
  ret

drawImage = (img) ->
  for row in *img
    for color in *row
      io.write color.." "
    io.write "\n"

{
  :colors
  :loadNFP
  :loadImage, :drawImage
}