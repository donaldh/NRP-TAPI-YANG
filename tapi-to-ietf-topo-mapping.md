# Mapping from TAPI Topology to IETF Network Topology

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

## References

https://github.com/OpenNetworkingFoundation/Snowmass-ONFOpenTransport/blob/develop/YANG/TapiTopology.yang

https://datatracker.ietf.org/doc/draft-ietf-i2rs-yang-network-topo/

