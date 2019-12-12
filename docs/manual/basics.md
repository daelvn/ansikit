# Basics in ansikit

This tutorial covers the basics of ansikit. Just enough to get you started with the library.

## Installation

You can install the library with [LuaRocks](https://luarocks.org/).

```
$ luarocks install ansikit
```

This will make all modules available to you.

## Usage

ansikit is split in several modules that provide grouped functionality, letting you import only what you need. All modules return a table with the named exported values, as is conventional.

```lua tab="Lua"
text = require "ansikit.text"
print text.bold .. "hello" .. text.reset
```

```moonscript tab="MoonScript"
import bold, reset from require "ansikit.text"
print "#{bold}hello#{reset}"
```



## Basic sequences

You can form basic escape sequences using the [Sequence](/module/sequence/#Sequence) function in `ansikit.sequence`. It takes a start character `sb` and a trailing character `tb` that defaults to an empty string.  Passing those will produce a function that takes arguments and returns an escape sequence.

### Example

```lua tab="Lua'
SGR   = Sequence(27, "m")
reset = SGR(0, 1) -- string.char(27) .. "[0;1" .. "m"
```

```moonscript tab="MoonScript"
SGR   = Sequence 27, "m"
reset = SGR 0, 1 -- (string.char 27) .. "[0;1" .. "m"
```

The [SGR](/module/sequence/#SGR) function is already provided as a part of `ansikit.sequence`.

## Cursor and page manipulation

You can use predefined ANSI escape sequences that will let you clear your screen, scroll up/down, change cursor position, etc. All the functions are documented in the [`ansikit.page` module page](/module/page/), and here we will only cover what you might use the most.

To clear a part of the screen, or the whole thing, you might want to use the [`clear`](/module/page/#erase) function. It takes a direction between `screen` (all that is displayed), `all` (includes buffer), `fromcursor` (all from cursor), and `tocursor` (all until cursor).

To scroll, you can use the [`scroll`](/module/page/#scroll) function, which takes a direction from `up` and `down` and a number of lines to scroll, which defaults to 1.

To move the cursor, you would use two methods, [`cursorMove`](/module/cursor/#cursorMove) to move relatively and [`cursorSetPosition`](/module/cursor/#cursorSetPosition) to move absolutely.

```lua tab="Lua"
cursorMove("down", 5)
cursorSetPosition(0,0)
```

```moonscript tab="MoonScript'
cursorMove "down", 5
cursorSetPosition 0,0
```

You can also save and restore a cursor position with [`cursorSave`](/module/cursor/#cursorSave) and [`cursorRestore`](/module/cursor/#cursorRestore).

## Text styles

You can use text styles directly from [`ansikit.text`](/module/text/), and you can find the full list of styles in there.

To use them, you just concatenate them to your string. Remember to use `text.reset` at the end so it doesn't overflow into other text!

```lua tab="Lua"
text = require "ansikit.text"
print text.bold .. "hello" .. text.reset
```

```moonscript tab="MoonScript"
import bold, reset from require "ansikit.text"
print "#{bold}hello#{reset}"
```

## Color basics

To use traditional ANSI escape codes, instead of boilerplate added by `ansikit` for color management, you can use the functions [`Bit4`](/module/color/#Bit4) for traditional ANSI escape sequences, [`Bit8`](/module/color/#Bit8) for 255-indexed and [`Bit24`](/module/color/#Bit24) for true color. These will generate strings you can concatenate to your strings to color them.

```lua tab="Lua'
print Bit4(91, 46) .. "bright red text and cyan bg" .. reset
print Bit8(226, true) .. "yellow background" .. reset
print Bit24(255,255,255,true) .. "rgb white background" .. reset
```

```moonscript tab="MoonScript"
print "#{Bit4 91, 46}bright red text and cyan bg#{reset}"
print "#{Bit8 226, true}yellow background#{reset}"
print "#{Bit24 255,255,255, true}rgb white background#{reset}"
```

But often, you will want to use something simpler, in which case, [`ansikit.style`](/module/style/) implements [ansicolors.lua](https://github.com/kikito/ansicolors.lua) and [`Chalk`](https://github.com/Desvelao/chalk) clones. You can read more about them in the link to `ansikit.style`.

## Conclusion

All of this pretty much covers the basics of ansikit, and the next tutorial covers more on managing colors.