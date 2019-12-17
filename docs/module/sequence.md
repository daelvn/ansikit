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

## SGR

[`Sequence`](#Sequence) with the arguments `27` and `"m"` passed in.

## reSGR

**Pattern →** `string.char(27).."%[(%d+)<<m`

A string that holds a pattern to match a `SGR` sequence of up to 3 parameters.

## unparseSGR

**Signature →** `(string) -> ...`<br>

Takes an ANSI sequence and uses [`reSGR`](#reSGR) to return up to 3 digit matches in the sequence.