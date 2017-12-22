VALIDATOR_JAR=~/.m2/repository/donaldh/yang-validator/1.0/yang-validator-1.0-executable.jar
XMI2YANG=../EAGLE-Open-Model-Profile-and-Tools/UmlYangTools/xmi2yang/app.js
PANDOC=pandoc -t html5 -f markdown_github-hard_line_breaks -c github-pandoc.css
HTML=$(patsubst %.md, html/%.html, $(wildcard *.md))
SAMPLES=$(wildcard samples/*.xml)

yang::	## Run xmi2yang to generate YANG files
	node $(XMI2YANG)
	perl -pi -e 's/^}/    typedef real { type decimal64 { fraction-digits 2; } }\n}/' project/mef-common.yang
	perl -pi -e 's/l-2cp/l2cp/' project/mef-*.yang project/nrm-connectivity.yang
	perl -pi -e 's/mef-types/mef-common-types/g' project/*.yang
	perl -pi -e 's/nresource/n-resource/' project/nr*.yang
	perl -pi -e 's/(uses|grouping) context/$$1 context-attrs/' project/tapi-common.yang
	perl -pi -e 's/min-elements 2;//' project/tapi-common.yang
	perl -pi -e 's/LayerProtocolName/layer-protocol-name/' project/tapi-common.yang
	perl -pi -e 's/CapacityUnit/capacity-unit/' project/tapi-common.yang
	mv project/mef-types.yang project/mef-common-types.yang

devtool:	## Run xmi2yang in chrome devtool for debugging
	node-inspect $(XMI2YANG) &

pyang:	## Run pyang validation
	pyang -p yang yang/*.yang

tree:	## Generate pyang tree view
	pyang -f tree -p yang yang/*.yang

test:	$(SAMPLES) ## Validate JSON instance docs against YANG schema

samples/*.xml::
	java -jar $(VALIDATOR_JAR) yang $@

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
