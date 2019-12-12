local color4
color4 = require("ansikit.palette").color4
local text = require("ansikit.text")
local mapping
do
  local _tbl_0 = { }
  for k, v in pairs(text) do
    _tbl_0[k] = v
  end
  mapping = _tbl_0
end
for k, v in pairs(color4) do
  if k == "bg" then
    for kk, vv in pairs(color4.bg) do
      mapping[kk .. "bg"] = vv
    end
  elseif k == "bright" then
    if k == "bg" then
      for kk, vv in pairs(color4.bright.bg) do
        mapping["bright" .. kk .. "bg"] = vv
      end
    else
      mapping["bright" .. k] = v
    end
  else
    mapping[k] = v
  end
end
local _colorize
_colorize = function(str)
  str = str:gsub("(%%{(.-)})", function(self, codes)
    local final = ""
    for word in codes:gmatch("%S+") do
      if not (mapping[word]) then
        error("unknown code " .. tostring(word) .. " in string")
      end
      final = final .. mapping[word]
    end
    return final
  end)
  return str
end
local colorize = setmetatable({
  noReset = _colorize
}, {
  __call = function(self, str)
    return _colorize("%{reset}" .. tostring(str) .. "%{reset}")
  end
})
local _style
_style = function(str)
  local final = ""
  for word in str:gmatch("%S+") do
    if not (mapping[word]) then
      error("unknown code " .. tostring(word) .. " in string")
    end
    final = final .. mapping[word]
  end
  return function(s)
    return final .. s
  end
end
local stylize
stylize = function(acc)
  if acc == nil then
    acc = ""
  end
  return setmetatable({ }, {
    __index = function(self, word)
      if word == "style" then
        return _style
      elseif word == "__accum" then
        return acc
      elseif mapping[word] == nil then
        return error("unknown code " .. tostring(word) .. " in string")
      else
        return stylize(acc .. mapping[word])
      end
    end,
    __call = function(self, str)
      return acc .. str .. text.reset
    end
  })
end
local style = setmetatable({ }, {
  __call = function(self, str)
    return colorize(str)
  end,
  __index = function(self, idx)
    return stylize()[idx]
  end
})
return {
  colorize = colorize,
  stylize = stylize(),
  style = style
}
