###############################################################################
## Makefile for Spanish--Galician
###############################################################################

LANG1=spa
LANG2=glg


PREFIX1=$(LANG1)-$(LANG2)

PREFIX2=$(LANG2)-$(LANG1)

BASENAME=apertium-$(PREFIX1)

TARGETS_COMMON =			\
	$(PREFIX1).automorf.bin 	\
	$(PREFIX1).prob			\
	$(PREFIX1).autobil.bin		\
	$(PREFIX1).t1x.bin 		\
	$(PREFIX1).autogen.bin 		\
	$(PREFIX1).autopgen.bin 	\
	$(PREFIX2).automorf.bin		\
	$(PREFIX2).prob			\
	$(PREFIX2).autobil.bin		\
	$(PREFIX2).autogen.bin 		\
	$(PREFIX2).autopgen.bin 	\
	$(PREFIX1).rlx.bin	\
	$(PREFIX2).rlx.bin	\
	$(PREFIX2).t1x.bin

# This include defines goals for install-modes, .deps/.d, autobil.prefixes and .mode files:
@ap_include@


###############################################################################
## Monolingual transducers
###############################################################################

# -------------------
# Spanish analysis:
# -------------------

$(PREFIX1).automorf.bin: $(AP_SRC1)/$(LANG1).automorf.bin $(PREFIX1).autobil.bin
	lt-trim $^ $@

# -------------------
# Spanish generation:
# ---------------------

$(PREFIX2).autogen.bin: $(AP_SRC1)/$(LANG1).autogen.bin
	cp $< $@

$(PREFIX2).autopgen.bin: $(AP_SRC1)/$(LANG1).autopgen.bin
	cp $< $@

# -------------------
# Galician analysis:
# -------------------

$(PREFIX2).automorf.bin: $(AP_SRC2)/$(LANG2).automorf.bin $(PREFIX2).autobil.bin
	lt-trim $^ $@

# -------------------
# Galician generation:
# ---------------------

$(PREFIX1).autogen.bin: $(AP_SRC2)/$(LANG2).autogen.bin
	cp $< $@

$(PREFIX1).autopgen.bin: $(AP_SRC2)/$(LANG2).autopgen.bin
	cp $< $@

###############################################################################
## Disambiguation models
###############################################################################

$(PREFIX1).prob: $(AP_SRC1)/$(LANG1).prob
	cp $< $@

$(PREFIX1).rlx.bin: $(AP_SRC1)/apertium-$(LANG1).$(LANG1).rlx
	cg-comp $< $@

$(PREFIX2).prob: $(AP_SRC2)/$(LANG2).prob
	cp $< $@

$(PREFIX2).rlx.bin: $(AP_SRC2)/apertium-$(LANG2).$(LANG2).rlx
	cg-comp $< $@


###############################################################################
## Bilingual dictionaries
###############################################################################

#.deps/$(PREFIX1).dix: $(BASENAME).$(PREFIX1).dix .deps/.d
#	xsltproc translate-to-default-equivalent.xsl $< > $@

$(PREFIX1).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $<
	lt-comp lr $< $@

$(PREFIX2).autobil.bin: $(BASENAME).$(PREFIX1).dix
	apertium-validate-dictionary $<
	lt-comp rl $< $@

###############################################################################
## Lexical selection rules
###############################################################################

#.deps/%.metalrx: %.metalrx
#	python3 metalrx.py $< $@

#.deps/%.lrx: metalrx-to-lrx.xslt .deps/%.metalrx
#	xsltproc $^ > $@.tmp
#	@xmllint --format $@.tmp > $@
#	@rm $@.tmp

#$(PREFIX1).autolex.bin: .deps/$(BASENAME).$(PREFIX1).lrx
#	lrx-comp $< $@

#$(PREFIX2).autolex.bin: .deps/$(BASENAME).$(PREFIX2).lrx
#	lrx-comp $< $@


###############################################################################
## Structural transfer rules
###############################################################################
$(PREFIX1).t1x.bin: $(BASENAME).$(PREFIX1).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@


$(PREFIX2).t1x.bin: $(BASENAME).$(PREFIX2).t1x
	apertium-validate-transfer $<
	apertium-preprocess-transfer $< $@

###############################################################################
## Distribution
###############################################################################

EXTRA_DIST=									\
		.deps/$(BASENAME).$(PREFIX1).lrx	\
		.deps/$(BASENAME).$(PREFIX2).lrx	\
		$(BASENAME).$(PREFIX1).dix 			\
		$(BASENAME).$(PREFIX1).dix 			\
		$(BASENAME).$(PREFIX1).t1x 	\
		$(BASENAME).$(PREFIX2).t1x 			\
		modes.xml 							\
		alt.xsl


###############################################################################
## Installation
###############################################################################

apertium_spa_glgdir=$(prefix)/share/apertium/$(BASENAME)/

# Files which should be installed to $(prefix)/share/apertium/$(BASENAME)/:
apertium_spa_glg_DATA=				\
	$(TARGETS_COMMON)				\
	$(BASENAME).$(PREFIX1).t1x			\
	$(BASENAME).$(PREFIX2).t1x

# All modes are created by the same goal, listing several will just give problems with make -j2
noinst_DATA=modes/$(PREFIX1).mode

install-data-local: install-modes


###############################################################################
## Cleanup
###############################################################################

CLEANFILES = $(TARGETS_COMMON)
clean-local:
	-rm -rf .deps modes


###############################################################################
## Test
###############################################################################

test: all
	apertium-regtest test
