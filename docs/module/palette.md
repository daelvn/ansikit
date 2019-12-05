---
title: ansikit.palette
description: Palettes and color representations for ansikit.
path: tree/master/ansikit
source: palette.moon
---
# ansikit.palettte

Palettes and color representations for ansikit.

## color4

A table that contains a collection of [Bit4](/module/color#bit4) colors.

```markdown
- black
- red
- green
- yellow
- blue
- magenta
- cyan
- white
```

It can be prefixed with modifiers such as `bg` or `bright`, so you can address `color4.white`, `color4.bg.white`, `color4.bright.white` and `color4.bright.bg.white`.

## color8

Table that generates [Bit8](/module/color#bit8) colors based on an index. Accepts a single `bg` modifier. They are accessed with an underscore on front, such as `color8._255` or `color8.bg._48`.

## Palette

**Signature →** `(string, [table]) -> Palette`<br>

Creates a named palette that can contain colors. It takes an optional table that contains a list of `Color`s. You can access its name indexing `__name` and the color list using `__colors`, but you should use the functions for that. You can index colors already added by using a normal index, such as `pal.white`.

## nameFor

**Signature →** `(Palette) -> string|nil`<br>

Returns the name for a `Palette`.

## addColor

**Signature →** `(Palette) -> (string, Color) -> nil`<br>

Takes a `Palette`, then a name and a `Color` and adds it to the palette.

## removeColor

**Signature →** `(Palette) -> (string) -> nil`<br>

Removes a color from a `Palette` by name.