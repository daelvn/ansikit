---
title: ansikit.cursor | Lua ansikit
description: Cursor-manipulating functions and escape sequences.
source: ansikit/cursor.moon
---

# ansikit.cursor

Cursor-manipulating functions and escape sequences.

## cursorUp

**Signature →** `([number]) -> nil`<br>

Moves the cursor up `n` characters. `n` defaults to 1.

## cursorDown

**Signature →** `([number]) -> nil`<br>

Moves the cursor down `n` characters. `n` defaults to 1.

## cursorForward

**Signature →** `([number]) -> nil`<br>

Moves the cursor forward `n` characters. `n` defaults to 1.

## cursorBack

**Signature →** `([number]) -> nil`<br>

Moves the cursor back `n` characters. `n` defaults to 1.

## cursorNextLn

**Signature →** `([number]) -> nil`<br>

Moves the cursor to the next `n` lines. `n` defaults to 1.

## cursorPreviousLn

**Signature →** `([number]) -> nil`<br>

Moves the cursor to the previous `n` lines. `n` defaults to 1.

## cursorSetColumn

**Signature →** `([number]) -> nil`<br>

Moves the cursor to column `n`. `n` defaults to 1.

## cursorSetPosition

**Signature →** `(number, number) -> nil`<br>

Sets the cursor position to `x` and `y`.

## cursorSetPosition1

**Signature →** `(number) -> (number) -> nil`<br>

Curried version of [cursorPosition](#cursorPosition).

## cursorSave

**Signature →** `nil`<br>

Saves the current cursor position.

## cursorRestore

**Signature →** `nil`<br>

Restores the previously saved cursor position.