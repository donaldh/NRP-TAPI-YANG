# NRP-TAPI-YANG

This is a utility project for running the ONF Eagle xmi2yang tool against the MEF-NRP extensions for the T-API model.

# Set Up

This project uses symlinks to both the ONF Eagle xmi2yang tool and the MEF NRP_Interface model.

Check out the three projects in the same directory:

```
% git checkout git@github.com:donaldh/EAGLE-Open-Model-Profile-and-Tools.git
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

Ensure that you have the correct branches checked out:

```
% cd EAGLE-Open-Model-Profile-and-Tools
# git checkout UmlYangTools
% git checkout rfc6087-naming # until PR gets merged
% cd ../MEF-Common-Model
% git checkout CIM_Develop
% cd ..
```

# Usage

Build the YANG modules:

```
% cd NRP-TAPI-YANG
% make
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

```
% make validate
pyang -p project project/*.yang
```

Display a YANG tree view of the generated YANG modules:

```
% make tree
pyang -f tree -p project project/*.yang
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
