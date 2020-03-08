#!/usr/bin/python3

import sys
import mininet

# Make sure there is only one argument passed
with if len(sys.argv = 1):
    topoSel = sys.argv[0]
    except:
        print("Syntax: python-mn.py <tree2|tree4|tree6>")

# Define available topologies
topoDict = {
    tree2: "depth=1,fanout=2",
    tree4: "depth=2,fanout=2",
    tree6: "depth=2,fanout=2"
    }
print(topoDict)
"""
# Construct net objects
myTopo = mininet.topolib(topoDict[topoSel])
myNet = mininet.net(topo=myTopo)

# Start the mininet
myNet.start()


h1, h4  = myNet.hosts[0], myNet.hosts[3]
print h1.cmd('ping -c1 %s' % h4.IP())
myNet.stop()
"""