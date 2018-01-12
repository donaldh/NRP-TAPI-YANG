
XMI2YANG=../xmi2yang/app.js

yang::	## Run xmi2yang to generate YANG files
	node $(XMI2YANG)
	perl -pi -e 's/l-2cp/l2cp/' project/sonata-order-interface.yang
	perl -pi -e 's/L2cpAddressSet/l2cp-address-set/' project/sonata-order-interface.yang

debug:	## Run xmi2yang for debugging
	node --inspect-brk $(XMI2YANG)

pyang:	## Run pyang validation
	pyang -p yang yang/*.yang

tree:	## Generate pyang tree view
	pyang -f tree -p yang yang/*.yang

clean:	## Clean up
	rm -f project/*.yang

help:	## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: help
.DEFAULT_GOAL := help
