# Mapping from TAPI to IETF Network Topology

## TAPI Topology

There is a simple, direct mapping from TAPI Topology to the IETF I2RS Network Topology. The most
notable difference between the two is that TAPI topology supports bi-directional links whereas
IETF topology only has unidirectional links.

| Tapi-topology                       | ietf-network-topology          |
| -------------                       | ------------                   |
| topology                            | network                        |
| topology/node                       | network/node                   |
| topology/node/owned-node-edge-point | network/node/termination-point |
| topology/link                       | network/link                   |
| topology/link/link-port             | network/link/source            |
| - and                               | network/link/destination       |

The majority of the remainder of TAPI Topology can be implemented using augmentation of node, termination-point and link.

### TAPI Topology Node

Augment IETF Network Node

* state
* transfer-capacity
* transfer-cost
* transfer-integrity
* transfer-timing
* layer-protocol-name

### TAPI Topology Link

Augment IETF Network Topology Link

* state
* transfer-capacity
* transfer-cost
* transfer-integrity
* transfer-timing
* risk-parameter
* validation
* lp-transition
* layer-protocol-name
* direction - how should we handle bi-directional links?

## TAPI Connectivity

It is a little more difficult to identify an appropriate mapping for TAPI Connectivity because
there are no obvious candidates for nodes under which the ConnectionEndPoint and ServiceEndPoint
could be put. It also contains Connection and ConnectivityService, both of which could be mapped
to network/link - does that mean two layered topologies?

| tapi-connectivity                              | ietf-network-topology          |
| -----------------                              | ------------                   |
| connection                                     | network/link                   |
| connection/connection-port                     | network/link/source            |
| - and                                          | network/link/destination       |
| ????                                           | network/node                   |
| connection-end-point                           | network/node/termination-point |
|                                                |                                |
| connectivity-service                           | network/link                   |
| connectivity-service/connectivity-service-port | network/link/source            |
| - and                                          | network/link/destination       |
| ????                                           | network/node                   |
| service-end-point                              | network/node/termination-point |

## References

https://github.com/OpenNetworkingFoundation/Snowmass-ONFOpenTransport/blob/develop/YANG/TapiTopology.yang

https://datatracker.ietf.org/doc/draft-ietf-i2rs-yang-network-topo/

