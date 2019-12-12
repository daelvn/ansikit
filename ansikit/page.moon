-- ansikit.page
-- Page-manipulating functions and escape sequences.
-- By daelvn
import Sequence   from require "ansikit.sequence"
import _fn, _true from require "guardia"
import _tostring  from require "guardia.guards"

CSI = Sequence 27

-- Clearing functions
_erase = CSI "J"

eraseFromCursor = -> _erase "0"
eraseToCursor   = -> _erase "1"
eraseScreen     = -> _erase "2"
eraseFullScreen = -> _erase "3"
eraseAll        = eraseFullScreen

clearFromCursor = eraseFromCursor
clearToCursor   = eraseToCursor
clearScreen     = eraseScreen
clearFullScreen = eraseFullScreen
clearAll        = clearFullScreen

erase = (direction) -> switch direction
  when "screen"     then eraseScreen!
  when "all"        then eraseAll!
  when "fromcursor" then eraseFromCursor!
  when "tocursor"   then eraseToCursor!
  else                   eraseScreen!
clear = erase

-- Scrolling
_scr       = => (n=1) -> @ _fn _tostring _true n
scrollUp   = _scr (n) -> (CSI "S") n
scrollDown = _scr (n) -> (CSI "T") n
scroll     = (direction, n) -> switch direction
  when "up"   then scrollUp n
  when "down" then scrollDown n
  else             scrollUp n

{
  :erase, :clear
  :eraseFromCursor, :clearFromCursor
  :eraseToCursor,   :clearToCursor
  :eraseScreen,     :clearScreen
  :eraseFullScreen, :clearFullScreen
  :eraseAll,        :clearAll

  :scrollUp, :scrollDown, :scroll
}
