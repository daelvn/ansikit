---
title: ansikit.sequence
description: Form ANSI sequences easily.
path: tree/master/ansikit
source: sequence.moon
---

# ansikit.sequence

Form ANSI sequences easily.

## Sequence

**Signature →** `(string|number) -> ([string|number]) -> (...) -> string`<br>

Creates and ANSI sequence with start character `sb` and final character `tb`. `tb` is usually ST, but is not always needed.

```moon tab="MoonScript"
color = (Sequence 27) "m"
color 38, 2, 255, 255, 255 -- ^[38;2;255;255;255m
```

```lua tab="Lua"
color = Sequence(27)("m")
color(38, 2, 255, 255, 255) -- ^[38;2;255;255;255m
```

