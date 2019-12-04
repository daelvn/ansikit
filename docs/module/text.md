---
title: ansikit.text
description: Text styling escape codes.
path: tree/master/ansikit
source: text.moon
---

# ansikit.text

Text styling escape codes.

## reset

Resets all text styling.

## bold

Sets bold text.

## notBold

Removes bold effect ([as well as faint effect](https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters)).

## faint

Sets faint text.

## notFaint

Removes faint effect ([as well as bold effect](https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters)).

## italic

Sets italic text.

## notItalic

Removes italic effect ([as well as Fraktur text](https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters)).

## underline

Sets underlined text.

## doubleUnderline

Sets doubly-underlined text.

## notUnderline

Removes underline effect.

## blink

**Alias →** `slowBlink`<br>

Sets slow blinking text.

## rapidBlink

Sets rapid blinking text.

## notBlink

Removes blinking effect.

## reverse

Reverse video text. Swaps foreground and background colors.

## notReverse

Removes reverse effect.

## conceal

Conceals text.

## notConceal

**Alias →** `reveal`<br>

Reveals text.

## crossed

**Alias →** `strikethrough`<br>

Sets crossed-out text.

## notCrossed

**Alias →** `notStrikethrough`<br>

Removes strikethrough effect.

## resetFont

Sets the primary and default font.

## setFont

**Signature →** `([number]) -> nil`

Sets an alternative font `n`. `n` defaults to 0.

## fraktur

Sets Fraktur text.

## notFraktur

Removes Fraktur effect ([as well as italic text](https://en.wikipedia.org/wiki/ANSI_escape_code#SGR_parameters)).

## framed

Sets framed text.

## encircled

Sets encircled text.

## notFramed

**Alias →** `notEncircled`

Removes framed and encircled effects.

## overline

Sets overlined text.

## notOverline

Removes overline effect.