---
title: ansikit.color | ansikit
description: Use colors with ANSI sequences
source: ansikit/color.moon
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