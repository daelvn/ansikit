local Sequence
Sequence = require("ansikit.sequence").Sequence
local _fn, _true
do
  local _obj_0 = require("guardia")
  _fn, _true = _obj_0._fn, _obj_0._true
end
local _tostring
_tostring = require("guardia.guards")._tostring
local CSI = Sequence(27)
local _erase = CSI("J")
local eraseFromCursor
eraseFromCursor = function()
  return _erase("0")
end
local eraseToCursor
eraseToCursor = function()
  return _erase("1")
end
local eraseScreen
eraseScreen = function()
  return _erase("2")
end
local eraseFullScreen
eraseFullScreen = function()
  return _erase("3")
end
local eraseAll = eraseFullScreen
local clearFromCursor = eraseFromCursor
local clearToCursor = eraseToCursor
local clearScreen = eraseScreen
local clearFullScreen = eraseFullScreen
local clearAll = clearFullScreen
local erase
erase = function(direction)
  local _exp_0 = direction
  if "screen" == _exp_0 then
    return eraseScreen()
  elseif "all" == _exp_0 then
    return eraseAll()
  elseif "fromcursor" == _exp_0 then
    return eraseFromCursor()
  elseif "tocursor" == _exp_0 then
    return eraseToCursor()
  else
    return eraseScreen()
  end
end
local clear = erase
local _scr
_scr = function(self)
  return function(n)
    if n == nil then
      n = 1
    end
    return self(_fn(_tostring(_true(n))))
  end
end
local scrollUp = _scr(function(n)
  return (CSI("S"))(n)
end)
local scrollDown = _scr(function(n)
  return (CSI("T"))(n)
end)
local scroll
scroll = function(direction, n)
  local _exp_0 = direction
  if "up" == _exp_0 then
    return scrollUp(n)
  elseif "down" == _exp_0 then
    return scrollDown(n)
  else
    return scrollUp(n)
  end
end
return {
  erase = erase,
  clear = clear,
  eraseFromCursor = eraseFromCursor,
  clearFromCursor = clearFromCursor,
  eraseToCursor = eraseToCursor,
  clearToCursor = clearToCursor,
  eraseScreen = eraseScreen,
  clearScreen = clearScreen,
  eraseFullScreen = eraseFullScreen,
  clearFullScreen = clearFullScreen,
  eraseAll = eraseAll,
  clearAll = clearAll,
  scrollUp = scrollUp,
  scrollDown = scrollDown,
  scroll = scroll
}
