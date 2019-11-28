-- ansikit.color
-- Use colors with ANSI sequences.
-- By daelvn
unpack or= table.unpack
import Sequence from require "ansikit.sequence"

SGR = Sequence 27, "m"

-- reset
reset = SGR 0

-- 4-bit
Bit4  = (index=0) -> SGR index

-- 8-bit
Bit8  = (index=0, bg=false) -> SGR (bg and 48 or 38), 5, index

-- 24-bit
Bit24 = (r=0, g=0, b=0, bg=false) -> SGR (bg and 48 or 38), 2, r, g, b

{ :reset, :Bit4, :Bit8, :Bit24 }
