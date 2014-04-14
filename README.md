# Math Cheat Sheet

This is a math cheat sheet using MathML for Firefox OS.

## License

See [License](LICENSE).

## Dependencies

### Included

- [webL10n](https://github.com/fabi1cazenave/webL10n)
  - Directory: `webL10n`
  - License: BSD/MIT/WTFPL license
- [Building Blocks](https://github.com/buildingfirefoxos/Building-Blocks)
  - Directory: `building-blocks`
  - License: Apache License, Version 2.0

### Not Included

- [TeXZilla](https://github.com/fred-wang/TeXZilla)
- [ImageMagick](http://www.imagemagick.org/)

### Optional

- [js-beautify](https://github.com/einars/js-beautify)

## Build

~~~
$ make build
~~~

To view the webapp open the file `index.html`.

## Package

~~~
# make package
~~~

The file `math-cheat-sheet.zip` is your package app.
