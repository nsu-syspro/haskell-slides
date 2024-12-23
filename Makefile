############################
# Usage
# make         # converts all src/*.md files to publish/*.pdf files using pandoc
# make clean   # cleans up publish/*.pdf artifacts
############################

all:

############################
# Common
############################

PANDOC = pandoc

PUBLISH_DIR = publish
SRC_DIR = src
IMAGES_DIR = images
COMMON_DIR = common

############################
# Targets
############################

SRC_MD = $(wildcard $(SRC_DIR)/*.md)
PDF_MD = $(SRC_MD:.md=.pdf)
PDF_MD_DARK = $(PDF_MD:.pdf=-dark.pdf)

SRC_LHS = $(wildcard $(SRC_DIR)/*.lhs)
PDF_LHS = $(SRC_LHS:.lhs=.pdf)
PDF_LHS_DARK = $(PDF_LHS:.pdf=-dark.pdf)

PDF = $(PDF_MD) $(PDF_LHS)
PDF_DARK = $(PDF_MD_DARK) $(PDF_LHS_DARK)

PDF_PUBLISH = $(PDF:$(SRC_DIR)/%=$(PUBLISH_DIR)/%) $(PDF_DARK:$(SRC_DIR)/%=$(PUBLISH_DIR)/%)
PDF_NAMES = $(PDF:$(SRC_DIR)/%.pdf=%)

PNG_ROOT = $(wildcard $(IMAGES_DIR)/*.png)
PNG_TARGET = $(foreach NAME,$(PDF_NAMES),$(wildcard $(IMAGES_DIR)/$(NAME)/*.png))
PNG = $(PNG_ROOT) $(PNG_TARGET)

SVG_ROOT = $(wildcard $(IMAGES_DIR)/*.svg)
SVG_TARGET = $(foreach NAME,$(PDF_NAMES),$(wildcard $(IMAGES_DIR)/$(NAME)/*.svg))
SVG_PDF_ROOT = $(SVG_ROOT:.svg=.pdf)
SVG_PDF_TARGET = $(SVG_TARGET:.svg=.pdf)
SVG_PDF = $(SVG_PDF_ROOT) $(SVG_PDF_TARGET)

DOT_ROOT = $(wildcard $(IMAGES_DIR)/*.gv)
DOT_TARGET = $(foreach NAME,$(PDF_NAMES),$(wildcard $(IMAGES_DIR)/$(NAME)/*.gv))
DOT_PDF_ROOT = $(DOT_ROOT:.gv=.pdf)
DOT_PDF_TARGET = $(DOT_TARGET:.gv=.pdf)
DOT_PDF = $(DOT_PDF_ROOT) $(DOT_PDF_TARGET)

############################
# Goals
############################

.PHONY: all clean pdf
.DEFAULT_GOAL := all

all: pdf

publish: $(PDF_PUBLISH)
pdf:  $(PDF) #$(PDF_DARK)

clean: 
	@echo "Cleaning up..."
	rm -rvf $(PDF) $(PDF_DARK) $(SVG_PDF) $(DOT_PDF)

############################
# Publish patterns
############################

$(PDF_PUBLISH): $(PUBLISH_DIR)/%.pdf: $(SRC_DIR)/%.pdf
	@mkdir -p $(@D)
	cp $< $@

############################
# Pandoc patterns
############################

PANDOC_ARGS :=

$(PDF_MD): %.pdf: %.md
	$(PANDOC) $(PANDOC_ARGS) -t beamer --pdf-engine lualatex $< -o $@

$(PDF_MD_DARK): %-dark.pdf: %.md
	$(PANDOC) $(PANDOC_ARGS) -t beamer --pdf-engine lualatex --variable darkmode=true $< -o $@

$(PDF_LHS): %.pdf: %.lhs
	runhaskell $<
	$(PANDOC) $(PANDOC_ARGS) -f markdown+lhs -t beamer --pdf-engine lualatex $< -o $@

$(PDF_LHS_DARK): %-dark.pdf: %.lhs
	$(PANDOC) $(PANDOC_ARGS) -f markdown+lhs -t beamer --pdf-engine lualatex --variable darkmode=true $< -o $@
	
	
############################
# Image patterns
############################

$(SVG_PDF): %.pdf: %.svg
	@# SELF_CALL is workaround for running inkscape in parallel
	@# See https://gitlab.com/inkscape/inkscape/-/issues/4716
	SELF_CALL=no inkscape -D $< -o $@


$(DOT_PDF): %.pdf: %.gv
	dot -Tpdf $< -o $@

############################
# Custom patterns
############################


TARGET_IMAGE_DEPS = $(filter $(IMAGES_DIR)/$*/%,$(DOT_PDF_TARGET) $(SVG_PDF_TARGET) $(PNG_TARGET))
ROOT_IMAGE_DEPS = $(filter $(IMAGES_DIR)/%,$(DOT_PDF_ROOT) $(SVG_PDF_ROOT) $(PNG_ROOT))

.SECONDEXPANSION:
$(PDF): $(SRC_DIR)/%.pdf: $(ROOT_IMAGE_DEPS) $(COMMON_PNG_IMAGE_DEPS) $$(TARGET_IMAGE_DEPS)
$(PDF_DARK): $(SRC_DIR)/%-dark.pdf: $(ROOT_IMAGE_DEPS) $(COMMON_PNG_IMAGE_DEPS) $$(TARGET_IMAGE_DEPS)

$(PDF) $(PDF_DARK): $(COMMON_DIR)/pres.yaml $(COMMON_DIR)/pres-preamble.tex $(COMMON_DIR)/pres-template.tex
$(PDF) $(PDF_DARK): PANDOC_ARGS = $(COMMON_DIR)/pres.yaml -H $(COMMON_DIR)/pres-preamble.tex --listings --template $(COMMON_DIR)/pres-template.tex --slide-level=1

