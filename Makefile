
XMI2YANG=../EAGLE-Open-Model-Profile-and-Tools/xmi2yang\ tool-v2.0/main.js
PANDOC=pandoc -t html5 -f markdown_github-hard_line_breaks -c github-pandoc.css
HTML=$(patsubst %.md, html/%.html, $(wildcard *.md))

all:
	node $(XMI2YANG)

devtool:
	devtool $(XMI2YANG) &

validate:
	pyang -p project project/*.yang

tree:
	pyang -f tree -p project project/*.yang

html:	$(HTML)

html/%.html:	%.md
	$(PANDOC) -o $@ $<

clean:
	rm -f project/*.yang
	rm -f $(HTML)
