#!/bin/bash
lualatex -shell-escape -output-directory=build thesis.tex
bibtex -output-directory=build paper
lualatex -shell-escape -output-directory=build thesis.tex
lualatex -shell-escape -output-directory=build -synctex=1 thesis.tex
