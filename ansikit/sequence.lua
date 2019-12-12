local unpack = unpack or table.unpack
local _fn, _tr
do
  local _obj_0 = require("guardia")
  _fn, _tr = _obj_0._fn, _obj_0._tr
end
local _not_string
_not_string = require("guardia.guards")._not_string
local char
char = function(...)
  return unpack((function(...)
    local _accum_0 = { }
    local _len_0 = 1
    local _list_0 = {
      ...
    }
    for _index_0 = 1, #_list_0 do
      local v = _list_0[_index_0]
      _accum_0[_len_0] = (function(x)
        return ("number" == type(x)) and (string.char(x)) or x
      end)(v)
      _len_0 = _len_0 + 1
    end
    return _accum_0
  end)(...))
end
local _Sequence
_Sequence = function(self)
  return function(...)
    return self(_fn((_tr(char))(_not_string(...))))
  end
end
local Sequence = _Sequence(function(sb, tb)
  if tb == nil then
    tb = ""
  end
  return function(...)
    return sb .. "[" .. (table.concat({
      ...
    }, ";")) .. tb
  end
end)
local SGR = Sequence(27, "m")
return {
  Sequence = Sequence,
  SGR = SGR
}
