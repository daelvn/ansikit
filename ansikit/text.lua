local SGR
SGR = require("ansikit.sequence").SGR
local reset = SGR(0)
local bold = SGR(1)
local notBold = SGR(22)
local faint = SGR(2)
local notFaint = SGR(22)
local italic = SGR(3)
local notItalic = SGR(23)
local underline = SGR(4)
local doubleUnderline = SGR(21)
local notUnderline = SGR(24)
local slowBlink = SGR(5)
local rapidBlink = SGR(6)
local notBlink = SGR(25)
local blink = slowBlink
local reverse = SGR(7)
local notReverse = SGR(27)
local conceal = SGR(8)
local notConceal = SGR(28)
local reveal = notConceal
local crossed = SGR(9)
local notCrossed = SGR(29)
local strikethrough = crossed
local notStrikethrough = notCrossed
local setFont
setFont = function(n)
  if n == nil then
    n = 0
  end
  return SGR(10 + n)
end
local resetFont = setFont(0)
local fraktur = SGR(20)
local notFraktur = SGR(23)
local framed = SGR(51)
local encircled = SGR(52)
local notFramed = SGR(54)
local notEncircled = notFramed
local overline = SGR(53)
local notOverline = SGR(55)
return {
  reset = reset,
  bold = bold,
  notBold = notBold,
  faint = faint,
  notFaint = notFaint,
  italic = italic,
  notItalic = notItalic,
  underline = underline,
  doubleUnderline = doubleUnderline,
  notUnderline = notUnderline,
  blink = blink,
  rapidBlink = rapidBlink,
  slowBlink = slowBlink,
  notBlink = notBlink,
  reverse = reverse,
  notReverse = notReverse,
  conceal = conceal,
  notConceal = notConceal,
  reveal = reveal,
  crossed = crossed,
  notCrossed = notCrossed,
  strikethrough = strikethrough,
  notStrikethrough = notStrikethrough,
  resetFont = resetFont,
  setFont = setFont,
  fraktur = fraktur,
  notFraktur = notFraktur,
  framed = framed,
  notFramed = notFramed,
  encircled = encircled,
  notEncircled = notEncircled,
  overline = overline,
  notOverline = notOverline
}
