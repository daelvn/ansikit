---
title: ansikit.style
description: ansicolors/chalk replacement for ansikit
path: tree/master/ansikit
source: style.moon
---

# ansikit.style

[ansicolors.lua](https://github.com/kikito/ansicolors.lua) and [chalk](https://github.com/Desvelao/chalk) drop-in replacement that uses ansikit as a backend. It is worth noting that it also supports all extra ansikit styles and modifiers, such as `fraktur`.

## colorize

[ansicolors.lua](https://github.com/kikito/ansicolors.lua) clone, works roughly the same way. Taken from the ansicolors documentation, and adapted for ansikit:

```lua tab="Lua"
  print(colorize('%{red}hello'))
  print(colorize('%{redbg}hello%{reset}'))
  print(colorize('%{bold red underline}hello'))
```

```moon tab="MoonScript"
  print colorize "%{red}hello"
  print colorize "%{redbg}hello%{reset}"
  print colorize "%{bold red underline}hello"
```

The `colorize` function makes sure that color attributes are reset at each end of the generated string. If you want to generate  complex strings piece-by-piece, use `colorize.noReset`, which works exactly the same, but without adding the reset codes at each end of the string.

### Differences

- ansicolors names the code for bold "bright". ansikit differences between bold and bright colors, so to use the bright version of a color you should use `bright<color>`, and to use bold, simply use the `bold` attribute.
- Some attributes are different between ansicolors and ansikit. ansicolor uses "hidden" whereas ansikit uses "conceal". ansicolor uses "dim" whereas ansikit uses "faint". Refer to the [ansikit.text documentation](/module/text/) to see valid attributes.
- ansicolors detects if it's running on Windows, and if it is, then does not print ANSI codes. This library was half-developed on Windows (eugh, I know), and it Works On My Machine™, so that is not a thing on ansikit.

## stylize

[chalk](https://github.com/Desvelao/chalk) clone, works roughly the same way. Refer to the chalk documentation to see how to use it, but it does include indexing and the `stylize.style` (`chalk.style`) function. 

### Differences

- chalk uses the modifier "reversed", whereas ansikit uses "reverse" (as in [ansikit.text](/module/text/#reverse)). This also reflects in the stylize function.
- To avoid duplicates, the order of some attribute names have been reversed to match with those on `colorize`, so instead of `bgblue`, it's `bluebg` and so on.

## style

A mix of [colorize](#colorize) and [stylize](#stylize). If called with a string, it will use the `colorize` function, and if indexed, will use `stylize` to build the styles, so you have the best of both worlds!