# Colors in ansikit

This is a very basic tutorial for color management using `ansikit`. It doesn't cover what is already covered in the [Basics tutorial](/manual/basics/).

## Color objects

You can create tables of type `Color` (using [typical](https://github.com/hoelzro/lua-typical)/typekit) that can be transformed and concatenated.

### Properties

You can index `r`, `g` and `b` values in the table (0-255), as well as a `bg` boolean value, which is true if the color is a background color.

### Metamethofs

#### __type

It has a `__type` metamethod, set to `Color`.

#### __tostring

If `__tostring` is used, it is converted into a true color escape sequence (using [Bit24](/module/color/#Bit24)).

#### __concat

It allows the color to be concatenated to strings or to other Colors.

### Functions

You can switch the `bg` flag in the table by using the functions `background` and `foreground`, which do exactly what you think. They return the object as well.

 ## Palettes

ansikit includes Palettes both as color collections and as a type that you can create.

### color4

This is a named collection of all [Bit4](/module/color/#Bit4) colors. See the [documentation](/module/palette/#color4) for reference on how to access it.

### color8

This is a named collection of all [Bit8](/module/color/#Bit8) colors. See the [documentation](/module/palette/#color8) for reference on how to access it.

### Palette

This lets you create your own palette with a name, and optionally a list of `Color`s.

#### Managing the palette

You can add colors to it with the function [`addColor`](/module/palette/#addColor) or remove from it with [`removeColor`](/module/palette/#removeColor). You can also get its name with the function [`nameFor`](/module/palette/#nameFor).

#### Metamethods

##### __type

`__type` is set to `Palette`.

##### __index

Allows for custom indexing. Will generally allow you to get a color by its name, but you can also index `__name` to get the name of the palette or `__colors` to get the internal list of colorss for the palette.

#### Example

```lua tab="Lua"
mypal = Palette "mypal"
addColor(mypal) ("white", Color(255, 255, 255))
mypal.white -- Color(255, 255, 255)
```

```moonscript tab="MoonScript"
mypal = Palette "mypal"
(addColor mypal) "white", Color 255, 255, 255
mypal.white -- Color 255, 255, 255
```

## Paint

Purely for compatibility with CraftOS, `ansikit.paint` will let you load and draw NFP formatted images.

### NFP format

The NFP formats simply consists of text where a whitespace means "empty", a newline means "next row", and a hex character is a color.

In this library, when an image is loaded, each item in a row is a background `Color` object, which, at drawing time, is prepended to a single space (` `).

### colors

`colors` is a `Palette` named `CraftOS` with the default CraftOS colors.

| Color            | Paint | Display |
| ---------------- | ----- | ------- |
| colors.white     | 0     | #F0F0F0 |
| colors.orange    | 1     | #F2B233 |
| colors.magenta   | 2     | #E57FD8 |
| colors.lightBlue | 3     | #99B2F2 |
| colors.yellow    | 4     | #DEDE6C |
| colors.lime      | 5     | #7FCC19 |
| colors.pink      | 6     | #F2B2CC |
| colors.gray      | 7     | #4C4C4C |
| colors.lightGray | 8     | #999999 |
| colors.cyan      | 9     | #4C99B2 |
| colors.purple    | a     | #B266E5 |
| colors.blue      | b     | #3366CC |
| colors.brown     | c     | #7F664C |
| colors.green     | d     | #57A64E |
| colors.red       | e     | #CC4C4C |
| colors.black     | f     | #191919 |

### Loading and drawing

You can load an image from a text file using [`loadImage`](/module/paint/#loadImage) or from a Lua string using [`loadNFP`](/module/paint/#loadNFP). `loadImage` uses `loadNFP` underneath.

After you have your table, you can blit it into the terminal using the function [`drawImage`](/module/paint/#drawImage).