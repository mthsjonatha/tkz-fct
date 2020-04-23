# tkz-fct – Tools for drawing graphs of functions

Release 1.3c 2020/04/11

## Description

The tkz-fct package is designed to give math teachers (and students) easy access to programming graphs of functions with TikZ and gnuplot.


## Licence

The packages may be modified and distributed under the terms and
conditions of the [LaTeX Project Public
License](https://www.latex-project.org/lppl/), version 1.3 or greater.

## Installation

You can experiment with the tkz-fct package by placing all of the distribution
 files in the directory containing your current tex file.

You can also place all of the distribution files in the directory : 
/texmf/tex/latex/tkz.

## Features

- needs  tkz-base, fp.sty and gnuplot;
- automatically loads the package TikZ; 
- compiles with utf8, pdflatex, lualatex.

## How to use it

To use the package tkz-fct, place the following line in the preamble of your
 LaTeX document.

\usepackage{tkz-fct}

If you use the xcolor package, load that package before tkz-fct to avoid
 package conflicts.

\usepackage[usenames,dvipsnames]{xcolor}

\usepackage{tkz-fct}

In order to format the numbers correctly, you place the following two lines 

\usepackage[your-language]{babel} 

\usepackage[autolanguage]{numprint} 

## Documentation

Documentation for `tkz-fct`   is available on CTAN and in your TeX distribution.

## History

- 1.3c Correction of a bug ( incompatibility between tkz-fct and tkzexample).
      Add compatibility between t tkz-fct and tkz-base.
      Correction of the documentation.

- 1.2c  Add compatibility   with tkz-base > 3.01.

- 1.16c correction of bugs 
          now default domain is xmin:xmax and not -5:5.  
- 1.13 first version   