
XMI2YANG=../EAGLE-Open-Model-Profile-and-Tools/xmi2yang\ tool-v2.0/main.js

all:
	node $(XMI2YANG)

devtool:
	devtool $(XMI2YANG) &

validate:
	pyang -p project project/*.yang

tree:
	pyang -f tree -p project project/*.yang

clean:
	rm project/*.yang
