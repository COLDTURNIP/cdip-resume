## Pre-requirement ##

These documents are designed to be built with **pandoc**. Please install it
first.

For OSX, I recommand to install them with Haskell cabal:

    brew install haskell-platform
    cabal update
    cabal install pandoc

If you need the PDF format output, pandoc needs **LaTeX** to do this. I
installed [MacTex](http://tug.org/mactex/) on my Mac.


## Editing ##

All the sources in markdown are placed under `/src` folder. If you'd like to
customize the HTML/PDF output format, try to hack the `*.css` and `*.tex` files.


## Build ##

All the build script is placed under `/script` folder.

    ./build

It will build the sources into HTML, TeX, and PDF under `/out`

