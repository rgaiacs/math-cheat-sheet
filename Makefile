## Variables

## - COMMONJS     : implementation of CommonJS to use: slimerjs, phantomjs
##                  or nodejs.
COMMONJS ?= slimerjs
## - TEXZILLAPATH : path to TeXZilla.js
TEXZILLAPATH = .

# Command Options
XARGSOPTIONS ?= --no-run-if-empty

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
	   calculus-derivatives.tex \
	   calculus-special-derivatives.tex \
	   calculus-integrals.tex

CHEATSHEETS = $(subst tex,html,$(TEXFILES))

PACKAGELIST = manifest.webapp \
	      LICENSE \
	      building-blocks \
	      css \
	      icons \
	      img \
	      index.html \
	      locales \
	      webL10n

# main rules

## Commands
## - help         : print this message
help:
	@grep -e '^##' Makefile | sed 's/## //'

## - build        : build some files need for this webapp
build: index.html $(ICONS)

## - beaufify     : beautify files
beautify:
	html-beautify -r template.html
	css-beautify -r css/app.css
	js-beautify -r manifest.webapp
	js-beautify -r js/app.js
	js-beautify -r js/setup.js

## - package      : package the webapp
package: build
	zip -r math-cheat-sheet.zip ${PACKAGELIST}

## - cleanall     : remove the files built previously
cleanall:
	rm -f $(CHEATSHEETS)
	rm -f index.html
	rm -f math-cheat-sheet.zip

# Auxiliar rules

index.html: template.sed template.html
	sed -f $^ > $@

template.sed: $(CHEATSHEETS)
	rm -f $@ && for i in $(CHEATSHEETS); \
	do \
		echo -e /\id=\"$${i/.html/}\"/ {\\nr $${i}\\n} >> $@; \
	done;

%.html: %.tex
	xargs $(XARGSOPTIONS) -a $< -L1 \
	    $(COMMONJS) $(TEXZILLAPATH)/TeXZilla.js parser > $@

icons/%.png: icons/math-cheat-sheet.svg
	convert -density 512 -background none $< -resize $(subst icons/math-cheat-sheet-,,$(basename $@)) $@
