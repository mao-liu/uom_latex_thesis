.PHONY: all clean manuscript.pdf

all: manuscript.pdf

clean:
	latexmk -CA

manuscript.pdf: manuscript.tex
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make $<
