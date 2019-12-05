-- ansikit.style
-- ansicolors/chalk replacement for ansikit
-- https://github.com/kikito/ansicolors.lua
-- https://github.com/Desvelao/chalk
-- By daelvn
import color4 from require "ansikit.palette"
text             = require "ansikit.text"

-- mappings
mapping = {k, v for k, v in pairs text}
for k, v in pairs color4
  if k == "bg"
    for kk, vv in pairs color4.bg
      mapping[kk.."bg"] = vv
  elseif k == "bright"
    if k == "bg"
      for kk, vv in pairs color4.bright.bg
        mapping["bright"..kk.."bg"] = vv
    else
      mapping["bright"..k] = v
  else
    mapping[k] = v

-- ansicolors, but in ansikit
_colorize = (str) ->
  str = str\gsub "(%%{(.-)})", (codes) =>
    final = ""
    for word in codes\gmatch "%S+"
      error "unknown code #{word} in string" unless mapping[word]
      final ..= mapping[word]
    final
  str
colorize = setmetatable {noReset: _colorize}, __call: (str) => _colorize "%{reset}#{str}%{reset}"

-- chalk, but in ansikit
_style = (str) ->
  final = ""
  for word in str\gmatch "%S+"
    error "unknown code #{word} in string" unless mapping[word]
    final ..= mapping[word]
  (s) -> final .. s

stylize = (acc="") -> setmetatable {}, {
  __index: (word) =>
    if     word == "style"      then return _style
    elseif word == "__accum"    then return acc
    elseif mapping[word] == nil then error "unknown code #{word} in string"
    else                             return stylize acc..mapping[word]
  __call: (str) => acc .. str .. text.reset
}

-- Main function
-- When used as a table, creates a function with those styles.
-- When used as a function, takes a string and works as ansicolors.
style = setmetatable {}, {
  __call:  (str) => colorize str
  __index: (idx) => stylize![idx]
}

{
  :colorize
  stylize: stylize!
  :style
}