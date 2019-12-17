-- ansikit.sequence
-- Form ANSI sequences
-- By daelvn
unpack or= table.unpack
import _fn, _tr     from require "guardia"
import _not_string  from require "guardia.guards"

char      =    (...) -> unpack [((x) -> ("number" == type x) and (string.char x) or x) v for v in *{...}]
_Sequence = => (...) -> @ _fn (_tr char) _not_string ...
Sequence  = _Sequence (sb, tb="") -> (...) -> sb .. "[" .. (table.concat {...}, ";") .. tb

SGR   = Sequence 27, "m"
reSGR = "#{string.char 27}%[(%d+);?(%d-);?(%d-)m"

unparseSGR = (sequence) -> sequence\match reSGR

{ :Sequence, :SGR, :reSGR, :unparseSGR }
