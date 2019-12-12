---
title: ansikit.page
description: Page-manipulating functions and escape sequences.
path: tree/master/ansikit
source: page.moon
---

# ansikit.page

Page-manipulating functions and escape sequences.

## eraseFromCursor

**Signature →** `nil`<br>
**Alias →** `clearFromCursor`<br>

Clears everything from the cursor position.

## eraseToCursor

**Signature →** `nil`<br>
**Alias →** `clearToCursor`<br>

Clears everything until the cursor position.

## eraseScreen

**Signature →** `nil`<br>
**Alias →** `clearScreen`<br>

Clears everything currently displayed.

## eraseFullScreen

**Signature →** `nil`<br>
**Alias →** `clearFullScreen`, `eraseAll`, `clearAll`<br>

Clears everything currently displayed and in the scrollback buffer.

## erase

**Signature →** `(string) -> nil`<br>
**Alias →** `clear`<br>

Takes a direction between `screen`, `all`, `fromcursor` and `tocursor` and erases it.

## scrollUp

**Signature →** `([number]) -> nil`<br>

Scrolls up page by `n` lines. `n` defaults to 1.

## scrollDown

**Signature →** `([number]) -> nil`<br>

Scrolls down page by `n` lines. `n` defaults to 1.

## scroll

**Signature →** `(string, [number]) -> nil`<br>

Scrolls page in direction `up` or `down` by `n` lines. `n` defaults to 1.