
XMI2YANG=../EAGLE-Open-Model-Profile-and-Tools/xmi2yang\ tool-v2.0/main.js
PANDOC=pandoc -t html5 -f markdown_github-hard_line_breaks -c github-pandoc.css
HTML=$(patsubst %.md, html/%.html, $(wildcard *.md))

yang:	## Run xmi2yang to generate YANG files
	node $(XMI2YANG)

devtool:	## Run xmi2yang in chrome devtool for debugging
	devtool $(XMI2YANG) &

validate:	## Run pyang validation
	pyang -p yang yang/*.yang

tree:	## Generate pyang tree view
	pyang -f tree -p yang yang/*.yang

html:	$(HTML)

html/%.html:	%.md
	$(PANDOC) -o $@ $<

clean:	## Clean up
	rm -f project/*.yang
	rm -f $(HTML)

help:	## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: help
.DEFAULT_GOAL := help
