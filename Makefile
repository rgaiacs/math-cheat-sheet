# Commands

COMMONJS = slimerjs
XARGSOPTIONS = --no-run-if-empty

# Files

ICONS = $(foreach size, 32 60 90 120 128 256, icons/math-cheat-sheet-$(size).png)

TEXFILES = algebra-basics.tex \
	   algebra-exponents.tex \
	   algebra-quadratic.tex \
	   algebra-polynomials.tex \
	   algebra-zero.tex \
	   trigonometry-basics.tex \
	   trigonometry-addition.tex \
	   trigonometry-half.tex \
	   trigonometry-double.tex \
	   trigonometry-sines.tex \
	   trigonometry-cosines.tex \
	   calculus-derivatives.tex

CHEATSHEETS = $(subst tex,html,$(TEXFILES))

PACKAGELIST = building-blocks \
	      index.html \
	      LICENSE \
	      manifest.webapp \
	      README.md \
	      css \
	      icons

# main rules

help:
	@grep -e '^##' Makefile | sed 's/## //'

## build    : build some files need for this webapp
build: index.html $(ICONS)

## package  : package the webapp
package: build
	zip -r math-cheat-sheet.zip ${PACKAGELIST}

## cleanall : remove the files built previously
cleanall:
	rm -f $(CHEATSHEETS)
	rm -f index.html
	rm -f math-cheat-sheet.zip

# Auxiliar rules

index.html: template.sed template.html
	sed -f $^ > $@

template.sed: $(CHEATSHEETS)
	rm $@ && for i in $(CHEATSHEETS); \
	do \
		echo -e /\id=\"$${i/.html/}\"/ {\\nr $${i}\\n} >> $@; \
	done;

%.html: %.tex
	xargs $(XARGSOPTIONS) -a $< -L1 \
	    $(COMMONJS) TeXZilla.js parser > $@

icons/%.png: icons/math-cheat-sheet.svg
	convert -background none $< -resize $(subst icons/math-cheat-sheet-,,$(basename $@)) $@
