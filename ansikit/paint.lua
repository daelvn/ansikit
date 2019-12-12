local Palette
Palette = require("ansikit.palette").Palette
local Color, hexToRGB, background
do
  local _obj_0 = require("ansikit.color")
  Color, hexToRGB, background = _obj_0.Color, _obj_0.hexToRGB, _obj_0.background
end
local hex = hexToRGB
local colors = Palette("CraftOS", (function()
  local _tbl_0 = { }
  for k, v in pairs({
    white = Color(hex(0xF0F0F0)),
    orange = Color(hex(0xF2B233)),
    magenta = Color(hex(0xE57FD8)),
    lightBlue = Color(hex(0x99B2F2)),
    yellow = Color(hex(0xDEDE6C)),
    lime = Color(hex(0x7FCC19)),
    pink = Color(hex(0xF2B2CC)),
    gray = Color(hex(0x4C4C4C)),
    lightGray = Color(hex(0x999999)),
    cyan = Color(hex(0x4C99B2)),
    purple = Color(hex(0xB266E5)),
    blue = Color(hex(0x3366CC)),
    brown = Color(hex(0x7F664C)),
    green = Color(hex(0x57A64E)),
    red = Color(hex(0xCC4C4C)),
    black = Color(hex(0x191919))
  }) do
    _tbl_0[k] = background(v)
  end
  return _tbl_0
end)())
local colorMap = {
  colors.white,
  colors.orange,
  colors.magenta,
  colors.lightBlue,
  colors.yellow,
  colors.lime,
  colors.pink,
  colors.gray,
  colors.lightGray,
  colors.cyan,
  colors.purple,
  colors.blue,
  colors.brown,
  colors.green,
  colors.red,
  colors.black
}
local loadNFP
loadNFP = function(text)
  local image, row = { }, { }
  for line in text:gmatch("[^\r\n]+") do
    for char in line:gmatch(".") do
      table.insert(row, colorMap[tonumber("0x" .. tostring(char))])
    end
    table.insert(image, row)
    row = { }
  end
  return image
end
local safeOpen
safeOpen = function(path, mode)
  local a, b = io.open(path, mode)
  return a and a or {
    error = b
  }
end
local loadImage
loadImage = function(file)
  local ret = { }
  do
    local _with_0 = safeOpen(file, "r")
    if _with_0.error then
      error("ansikit.paint: Could not load image " .. tostring(file))
    end
    ret = loadNFP(_with_0:read("*a"))
    _with_0:close()
  end
  return ret
end
local drawImage
drawImage = function(img)
  for _index_0 = 1, #img do
    local row = img[_index_0]
    for _index_1 = 1, #row do
      local color = row[_index_1]
      io.write(color .. " ")
    end
    io.write("\n")
  end
end
return {
  colors = colors,
  loadNFP = loadNFP,
  loadImage = loadImage,
  drawImage = drawImage
}
