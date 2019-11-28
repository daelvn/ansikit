-- ansikit.page
-- Page-manipulating functions and escape sequences.
-- By daelvn
import Sequence   from require "ansikit.sequence"
import _fn, _true from require "guardia"
import _tostring  from require "guardia.guards"

CSI = Sequence 27

-- Clearing functions
erase = CSI "J"
clear = erase

eraseFromCursor = -> erase "0"
eraseToCursor   = -> erase "1"
eraseScreen     = -> erase "2"
eraseFullScreen = -> erase "3"

clearFromCursor = eraseFromCursor
clearToCursor   = eraseToCursor
clearScreen     = eraseScreen
clearFullScreen = eraseFullScreen

-- Scrolling
_scr       = => (n=1) -> @ _fn _tostring _true n
scrollUp   = _scr (n) -> (CSI "S") n
scrollDown = _scr (n) -> (CSI "T") n

{
  :eraseFromCursor, :clearFromCursor
  :eraseToCursor,   :clearToCursor
  :eraseScreen,     :clearScreen
  :eraseFullScreen, :clearFullScreen

  :scrollUp, :scrollDown
}
