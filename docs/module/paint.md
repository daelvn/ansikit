---
title: ansikit.paint
description: NFP Paint format support. (CraftOS)
path: tree/master/ansikit
source: paint.moon
---
# ansikit.paint

NFP Paint format support from CraftOS.

## colors

A [Palette](/module/palette/#palette) that mimics the [CraftOS `colors` API](https://wiki.computercraft.cc/Colours_API).

## loadNFP

**Signature →** `(string) -> table`<br>

Gets an NFP-formatted string and creates a table out of the representation. The table contains rows, and each row contains a color per column. No characters are involved.

## loadImage

Equivalent to [loadNFP](#loadNFP), but it takes a filename and loads the image from a file.

## drawImage

**Signature →** `(table) -> nil`<br>

Prints an image that was loaded with [loadImage](#loadImage) or [loadNFP](#loadNFP).