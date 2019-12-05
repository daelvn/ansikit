---
title: ansikit.color
description: Use colors with ANSI sequences
path: tree/master/ansikit
source: color.moon
---

# ansikit.color

Use colors with ANSI sequences. Refer to [this Wikipedia page](https://en.wikipedia.org/wiki/ANSI_escape_code) for a list of colors or how to use ANSI sequences in general.

## Bit4

**Signature →** `(number) -> string`<br>

Generates a single-number color escape sequence. Equivalent to using `(Sequence 27, "m") n`.

## Bit8

**Signature →** `(number, boolean) -> string`<br>

Chooses a color 0-255 from a predefined palette. The boolean determines whether it is a foreground or background color (`false` for foreground, `true` for background, defaults to `false`).

## Bit24

**Signature →** `(number, number, number, boolean) -> string`<br>

Takes `r`, `g` and `b` parameters and a boolean that determines whether it is a foreground or background color (works as in [Bit8](#Bit8)).

## Color

**Signature →** `(number, number, number, [boolean]) -> Color`<br>

A function that creates a representation of an RGB color, with an optional background flag (if set to false, will be used as foreground, and otherwise as background. Defaults to false). The colors are passed in order `r`, `g`, `b`.

```lua tab="Lua"
white = Color(255,255,255)
```

```moonscript tab="MoonScript"
white = Color 255, 255, 255
```

## background

Takes a `Color` and sets it to a background color.

## foreground

Takes a `Color` and sets it to a foreground color.

## hexToRGB

**Signature →** `(number|string) -> number, number, number`<br>

Taxes a hex number or 6-digit long hex string and turns it into three RGB components.
