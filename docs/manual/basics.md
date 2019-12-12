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





