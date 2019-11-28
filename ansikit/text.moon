-- ansikit.text
-- Text styling escape codes.
-- By daelvn
import Sequence from require "ansikit.sequence"

SGR = Sequence 27, "m"

-- reset
reset = SGR 0

-- bold
bold    = SGR 1
notBold = SGR 22

-- faint
faint    = SGR 2
notFaint = SGR 22

-- italic
italic    = SGR 3
notItalic = SGR 23

-- underline
underline       = SGR 4
doubleUnderline = SGR 21
notUnderline    = SGR 24

-- blink
slowBlink  = SGR 5
rapidBlink = SGR 6
notBlink   = SGR 25
blink      = slowBlink

-- reverse
reverse    = SGR 7
notReverse = SGR 27

-- conceal
conceal    = SGR 8
notConceal = SGR 28
reveal     = notConceal

-- strikethrough
crossed          = SGR 9
notCrossed       = SGR 29
strikethrough    = crossed
notStrikethrough = notCrossed

-- font
setFont   = (n=0) -> SGR 10+n
resetFont = setFont 0

-- fraktur
fraktur    = SGR 20
notFraktur = SGR 23

-- framing
framed       = SGR 51
encircled    = SGR 52
notFramed    = SGR 54
notEncircled = notFramed

-- overline
overline    = SGR 53
notOverline = SGR 55

{
  :reset
  :bold,      :notBold
  :faint,     :notFaint
  :italic,    :notItalic
  :underline, :doubleUnderline, :notUnderline
  :blink,     :rapidBlink,      :slowBlink,     :notBlink
  :reverse,   :notReverse
  :conceal,   :notConceal,      :reveal
  :crossed,   :notCrossed,      :strikethrough, :notStrikethrough
  :resetFont, :setFont
  :fraktur,   :notFraktur
  :framed,    :notFramed
  :encircled, :notEncircled
  :overlined, :notOverlined
}
