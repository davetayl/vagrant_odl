#!/usr/bin/python
# Mininet currently only works with python 2

import sys
from mininet.net import Mininet
from mininet.topolib import TreeTopo
from mininet.cli import CLI
from mininet.node import Controller, OVSKernelSwitch, RemoteController

# Configure constants
ctrIp = "10.0.0.17"
ctrPort = 6633
ctrName = "odl01"

# Make sure there is only one argument passed
if len(sys.argv) == 2:
    topoSel = sys.argv[1]
else:
    sys.exit("Syntax: python-mn.py <tree2|tree4|tree6>")

# Define available topologies
topoDict = {
    "tree2": [1,2],
    "tree4": [2,2],
    "tree6": [3,2]
    }

# Construct net objects
myTopo = TreeTopo(depth=topoDict[topoSel][0],fanout=topoDict[topoSel][1])
myNet = Mininet(controller=RemoteController, switch=OVSKernelSwitch, topo=myTopo)
myNet.addController(ctrName, controller=RemoteController, ip=ctrIp, port=ctrPort)

# Start the mininet
myNet.start()

# Enable CLI for degugging
# CLI(myNet)