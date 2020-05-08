# tkz-fct – Tools for drawing graphs of functions

Release 1.3c 2020/04/11

## Description

The `tkz-fct` package is designed to give math teachers (and students) easy access to programming graphs of functions with TikZ and gnuplot.

## Licence
This work may be distributed and/or modified under the
conditions of the LaTeX Project Public License, either version 1.3
of this license or (at your option) any later version.
The latest version of this license is in
[LaTeX Project Public License](https://www.latex-project.org/lppl/)
 and version 1.3 or later is part of all distributions of LaTeX version 2005/12/01 or later.

This work has the LPPL maintenance status “maintained”.

The Current Maintainer of this work is Alain Matthes.

## Requirements

The package compiles with utf8, pdflatex and lualatex, loads and depends on updated versions of:

- [tikz](https://ctan.org/pkg/tikz)
- [gnuplot](http://www.gnuplot.info/)
- [tkz-base](https://ctan.org/pkg/tkz-base)
- [fp](https://ctan.org/pkg/fp)

## Installation

The package `tkz-fct` is present in TeXLive and MiKTeX, use the package manager to install. You can experiment with the `tkz-fct` package by placing all of the distribution files in the directory containing your current tex file.

The different files must be moved into the different directories in your
installation `TDS` tree or in your `TEXMFHOME`:

```
  doc/TKZdoc-fct.pdf   -> TDS:doc/latex/tkz-fct/TKZdoc-fct.pdf
  doc/README.md        -> TDS:doc/latex/tkz-fct/README.md
  doc/latex/*.*        -> TDS:doc/latex/tkz-fct/latex/*.*
  latex/tkz-fct.sty    -> TDS:tex/latex/tkz-fct/tkz-fct.sty
```

## How to use

To use the package `tkz-fct`, place the following line in the preamble of your LaTeX document.

```latex
\usepackage{tkz-fct}
```

If you use the `xcolor` package, load that package before `tkz-fct` to avoid package conflicts.

```latex
\usepackage[usenames,dvipsnames]{xcolor}
\usepackage{tkz-fct}
```

In order to format the numbers correctly, you place the following two lines

```latex
\usepackage[your-language]{babel}
\usepackage[autolanguage]{numprint}
```

## Documentation

Documentation for `tkz-fct` is available on CTAN and in your TeX distribution.

## History

- Version 1.4c
  - Correction of a bug in the macro `\tkzFct`.
  - Correction of the documentation.
- Version 1.3c
  - Correction of a bug (incompatibility between `tkz-fct` and `tkzexample`).
  - Add compatibility between `tkz-fct` and `tkz-base`.
  - Correction of the documentation.
- Version 1.2c
  - Add compatibility with `tkz-base` > 3.01.
- Version 1.16c
  - Correction of bugs.
  - Now default domain is `xmin:xmax` and not `-5:5`.
- Version 1.13
  - First version.
