#!/usr/bin/python3

"""
Create a 1024-host network, and run the CLI on it.
If this fails because of kernel limits, you may have
to adjust them, e.g. by adding entries to /etc/sysctl.conf
and running sysctl -p. Check util/sysctl_addon.
"""

from mininet.cli import CLI
from mininet.log import setLogLevel
from mininet.node import OVSSwitch
from mininet.topolib import TreeNet

if __name__ == '__main__':
    setLogLevel( 'info' )
    network = TreeNet( depth=3, fanout=1, switch=OVSSwitch )