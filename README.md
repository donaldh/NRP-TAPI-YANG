# NRP-TAPI-YANG

This is a utility project for running the ONF Eagle xmi2yang tool against the MEF-NRP extensions for the T-API model.

# Prerequisites

You'll need nodejs installed to be able to run the xmi2yang tool. If you want to validate the
output then you'll also need to install pyang.

## nodejs

If you are using macOS and have homebrew installed then installing nodejs is as simple as:

```sh
brew install nodejs
```
Alternatively, you can download it from https://nodejs.org/en/download/

## pyang

pyang is a python script that can be installed from PyPy using pip

```sh
pip install pyang
```

Note that you will need pip installed first. On macOS you may want to start by installing Python
virtualenv and then setting up a virtualenv for pyang.

# Set Up

This project uses symlinks to both the ONF Eagle xmi2yang tool and the MEF/TAPI models.

Check out the three projects in the same directory:

```sh
# git checkout git@github.com:OpenNetworkingFoundation/EAGLE-Open-Model-Profile-and-Tools.git
% git checkout git@github.com:donaldh/EAGLE-Open-Model-Profile-and-Tools.git # until PR gets merged
...
% git checkout git@github.com:MEF-GIT/MEF-Common-Model.git
...
% git checkout git@github.com:donaldh/NRP-TAPI-YANG.git
...
% ls -1
EAGLE-Open-Model-Profile-and-Tools/
MEF-Common-Model/
NRP-TAPI-YANG/
```

Ensure that you have the correct git branches checked out:

```sh
% cd EAGLE-Open-Model-Profile-and-Tools
% git checkout refactor_umlyangtools
% cd ../MEF-Common-Model
% git checkout CIM_Develop
% cd ../NRP-TAPI-YANG
% git checkout refactor
% cd ..
```

# Usage

Everything in hte NRP-TAPI-YANG project is automated using Make:

```sh
% make
yang                 Run xmi2yang to generate YANG files
devtool              Run xmi2yang in chrome devtool for debugging
pyang                Run pyang validation
tree                 Generate pyang tree view
test                 Validate JSON instance docs against YANG schema
clean                Clean up
help                 This help
```

# How to Build the YANG

Build the YANG modules:

```sh
% cd NRP-TAPI-YANG
% make yang
node ../EAGLE-Open-Model-Profile-and-Tools/xmi2yang\ tool-v2.0/main.js
NRP_Interface.uml read success!
Tapi.uml read success!
TapiConnectivity.uml read success!
TapiTopology.uml read success!
xmi translate to yang successfully!
write nrp-interface.yang successfully!
write tapi.yang successfully!
write tapi-connectivity.yang successfully!
write tapi-topology.yang successfully!
```

Validate the YANG modules with pyang:

```sh
% make validate
pyang -p yang yang/*.yang
```

Display a YANG tree view of the generated YANG modules:

```sh
% make tree
pyang -f tree -p yang yang/*.yang
module: nrp-interface
   +--rw uni
   +--rw evc-per-uni
   +--rw evc
   +--rw service-endpoint
   +--rw mef-route
module: tapi-connectivity
   +--rw connection* [uuid]
   |  +--ro connection-port* [local-id]
   |  |  +--ro connection-end-point?   -> /service-end-point/connection-end-point/uuid
...
```
