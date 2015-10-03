
ROOT_DIRECTORY := $(shell pwd)

DIRS := $(sort $(dir $(wildcard $(ROOT_DIRECTORY)/*/ \
                                $(ROOT_DIRECTORY)/*/*/ )))

CLEAN_DIRS := $(sort $(dir $(shell find . -name '*.tex')))

TIMESTAMP := $(shell date +'%Y_%m_%d-%H_%M_%S')

ROOT_TEX := $(wildcard *.tex)

CHAPTERS := $(basename $(notdir $(wildcard chapters/*.tex)))

CHAPTER_RELEASE := $(addsuffix -release,$(CHAPTERS))

clean:
	@for d in $(CLEAN_DIRS); do\
		cd $$d; pwd; latexmk -c -silent; cd $(ROOT_DIRECTORY);\
	done

veryclean: clean
	@rm -vf *-view.pdf

all: main

chapters: $(CHAPTERS)

main: main.tex
	cp $@.pdf $@-view.pdf
	@rm $@.pdf

release: main
	cp $<-view.pdf ../out-drafts/all_-_$(TIMESTAMP).pdf

$(ROOT_TEX):
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make -silent $@

$(CHAPTERS): %: chapters/%.tex
	bash minimum.sh chapters/$@.tex

$(CHAPTER_RELEASE): %-release: %
	cp $<-view.pdf ../out-drafts/$<_-_$(TIMESTAMP).pdf

.PHONY: clean veryclean all main chapters release $(ROOT_TEX)

#---
# catch all 
#---
help: 
	@bash -c "echo Available targets:; \
            make -pn | grep -e '^[a-z0-9-]\+:' | sed 's/:.*//g' | \
            sed 's/\(.*\)/  \1/g' | sort"

# run "make help" if no target is supplied
.DEFAULT_GOAL := help

# a catch-all message for any targets that do not exist
%::
	@$(ECHO) Target \`$@\' not found. Use \"make help\" to list all targets.
