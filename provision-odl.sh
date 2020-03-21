#!/usr/bin/env bash

# Configure script
set -e # Stop script execution on any error
echo ""; echo "-----------------------------------------"

# Configure variables
MYHOST=odldev
TESTPOINT=google.com
echo "- Variables set -"

# Test internet connectivity
ping -q -c5 $TESTPOINT > /dev/null 2>&1
 
if [ $? -eq 0 ]
then
	echo "- Internet Ok -"	
else
	echo "- Internet failed -"
fi

# Set system name
hostnamectl set-hostname $MYHOST > /dev/null 2>&1
/bin/sed -i "s/debianvb/$MYHOST/g" /etc/hosts > /dev/null 2>&1
echo "- Name set -"

# Base OS update
/bin/yum -y update > /dev/null 2>&1
echo "- OS Updated -"


# Install tools
/bin/yum -y install net-tools > /dev/null 2>&1
echo "- Tools installed -"

# Install ODL
/bin/yum -y localinstall https://cbs.centos.org/repos/nfv7-opendaylight-112-release/x86_64/os/Packages/opendaylight-11.2.0-1.el7.noarch.rpm > /dev/null 2>&1
echo "- OpenDaylight (Sodium) installed -"

# Configure ODL
/sbin/setenforce 0 > /dev/null 2>&1
/bin/sed -i 's/odl/root/g' /usr/lib/systemd/system/opendaylight.service > /dev/null 2>&1
/bin/sed -i 's/a126e2e0-3c77-4543-be57-883c02d3759e/a126e2e0-3c77-4543-be57-883c02d3759e,odl-controller-model-topology,odl-netconf-api,odl-openflowjava-protocol,odl-openflowplugin-app-arbitratorreconciliation,odl-openflowplugin-app-config-pusher,odl-openflowplugin-app-forwardingrules-manager,odl-openflowplugin-app-reconciliation-framework,odl-openflowplugin-app-topology,odl-openflowplugin-app-topology-manager,odl-openflowplugin-flow-services,odl-openflowplugin-flow-services-rest,odl-openflowplugin-libraries,odl-openflowplugin-nsf-model,odl-openflowplugin-southbound,odl-restconf/g' /opt/opendaylight/etc/org.apache.karaf.features.cfg > /dev/null 2>&1
/bin/systemctl enable opendaylight > /dev/null 2>&1
/bin/systemctl start opendaylight > /dev/null 2>&1
echo "- OpenDaylight server configured -"
echo ""
echo "Log in with \"ssh -p 8101 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no karaf@localhost\""
echo "Pasword: karaf"
echo ""

echo "-----------------------------------------"
echo "With great power comes great opportunity!"
echo "-----------------------------------------"
