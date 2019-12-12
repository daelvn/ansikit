-- ansikit.cursor
-- Cursor ANSI sequences
-- By daelvn
import Sequence   from require "ansikit.sequence"
import _fn, _true from require "guardia"
import _tostring  from require "guardia.guards"

-- CSI sequence
CSI = Sequence 27

-- Cursor movement
_curmov          = => (n=1) -> @ _fn _tostring _true n
cursorUp         = _curmov (n) -> (CSI "A") n
cursorDown       = _curmov (n) -> (CSI "B") n
cursorForward    = _curmov (n) -> (CSI "C") n
cursorBack       = _curmov (n) -> (CSI "D") n
cursorNextLn     = _curmov (n) -> (CSI "E") n
cursorPreviousLn = _curmov (n) -> (CSI "F") n
cursorSetColumn  = _curmov (n) -> (CSI "G") n

cursorMove = (direction, n) -> switch direction
  when "up"           then cursorUp n
  when "down"         then cursorDown n
  when "forward"      then cursorForward n
  when "back"         then cursorBack n
  when "nextline"     then cursorNextLn n
  when "previousline" then cursorPreviousLn n
  when "column"       then cursorSetColumn n
  else                     cursorForward n

-- Cursor position
_curpos             = => (x=1, y=1) -> @ (tostring x), (tostring y)
cursorSetPosition   = _curpos (x, y) -> (CSI "H") x, y
cursorSetPosition1  = (x) -> (y) -> cursorSetPosition x, y

cursorSave    = -> (CSI "s")!
cursorRestore = -> (CSI "u")!

{
  :cursorUp
  :cursorDown
  :cursorForward
  :cursorBack
  :cursorNextLn
  :cursorPreviousLn
  :cursorSetColumn
  :cursorSetPosition
  :cursorSetPosition1
  :cursorSave
  :cursorRestore

  :cursorMove
}
