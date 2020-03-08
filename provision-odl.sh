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
/bin/systemctl enable opendaylight > /dev/null 2>&1
/bin/systemctl start opendaylight > /dev/null 2>&1
echo "- OpenDaylight server configured -"

echo "-----------------------------------------"
echo "With great power comes great opportunity!"
echo "-----------------------------------------"
