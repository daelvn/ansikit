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
local _curmov
_curmov = function(self)
  return function(n)
    if n == nil then
      n = 1
    end
    return self(_fn(_tostring(_true(n))))
  end
end
local cursorUp = _curmov(function(n)
  return (CSI("A"))(n)
end)
local cursorDown = _curmov(function(n)
  return (CSI("B"))(n)
end)
local cursorForward = _curmov(function(n)
  return (CSI("C"))(n)
end)
local cursorBack = _curmov(function(n)
  return (CSI("D"))(n)
end)
local cursorNextLn = _curmov(function(n)
  return (CSI("E"))(n)
end)
local cursorPreviousLn = _curmov(function(n)
  return (CSI("F"))(n)
end)
local cursorSetColumn = _curmov(function(n)
  return (CSI("G"))(n)
end)
local cursorMove
cursorMove = function(direction, n)
  local _exp_0 = direction
  if "up" == _exp_0 then
    return cursorUp(n)
  elseif "down" == _exp_0 then
    return cursorDown(n)
  elseif "forward" == _exp_0 then
    return cursorForward(n)
  elseif "back" == _exp_0 then
    return cursorBack(n)
  elseif "nextline" == _exp_0 then
    return cursorNextLn(n)
  elseif "previousline" == _exp_0 then
    return cursorPreviousLn(n)
  elseif "column" == _exp_0 then
    return cursorSetColumn(n)
  else
    return cursorForward(n)
  end
end
local _curpos
_curpos = function(self)
  return function(x, y)
    if x == nil then
      x = 1
    end
    if y == nil then
      y = 1
    end
    return self((tostring(x)), (tostring(y)))
  end
end
local cursorSetPosition = _curpos(function(x, y)
  return (CSI("H"))(x, y)
end)
local cursorSetPosition1
cursorSetPosition1 = function(x)
  return function(y)
    return cursorSetPosition(x, y)
  end
end
local cursorSave
cursorSave = function()
  return (CSI("s"))()
end
local cursorRestore
cursorRestore = function()
  return (CSI("u"))()
end
return {
  cursorUp = cursorUp,
  cursorDown = cursorDown,
  cursorForward = cursorForward,
  cursorBack = cursorBack,
  cursorNextLn = cursorNextLn,
  cursorPreviousLn = cursorPreviousLn,
  cursorSetColumn = cursorSetColumn,
  cursorSetPosition = cursorSetPosition,
  cursorSetPosition1 = cursorSetPosition1,
  cursorSave = cursorSave,
  cursorRestore = cursorRestore,
  cursorMove = cursorMove
}
