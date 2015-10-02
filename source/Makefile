.PHONY: all clean main

#all: main.pdf

clean:
	latexmk -CA

main: main.tex
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make $<
	cp $@.pdf $@-view.pdf
