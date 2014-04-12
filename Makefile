# Commands

COMMONJS = slimerjs
XARGSOPTIONS = --no-run-if-empty

# Files
#
TEXFILES = algebra-basics.tex \
	   trigonometry-basics.tex

CHEATSHEETS = $(subst tex,html,$(TEXFILES))

index.html: template.sed template.html
	sed -f $^ > $@

template.sed: $(CHEATSHEETS)
	rm $@ && for i in $(CHEATSHEETS); \
	do \
		echo -e /$${i/.html/}/ {\\nr $${i}\\n} >> $@; \
	done

%.html: %.tex
	xargs $(XARGSOPTIONS) -a $< --verbose -L1 \
	    $(COMMONJS) TeXZilla.js parser > $@

cleanall:
	rm index.html
	rm -f $(CHEATSHEETS)
