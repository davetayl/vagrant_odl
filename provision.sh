#!/usr/bin/env bash

# Set system name
echo "- Set Name -"
hostnamectl set-hostname odldev > /dev/null 2>&1
/bin/sed -i "s/debianvb/odldev/g" /etc/hosts > /dev/null 2>&1

# Base OS update
echo "- OS Update -"
/bin/yum -y update > /dev/null 2>&1


# Install tools
echo "- Install tools -"
/bin/yum -y install net-tools

# Install ODL
echo "- Install ODL Sodium -"
/bin/yum -y localinstall https://cbs.centos.org/repos/nfv7-opendaylight-112-release/x86_64/os/Packages/opendaylight-11.2.0-1.el7.noarch.rpm
# /bin/yum -y install opendaylight

# Configure ODL
echo "- Configuring ODL -"
/bin/sed -i 's/odl/root/g' /usr/lib/systemd/system/opendaylight.service
/bin/systemctl enable opendaylight
/bin/systemctl start opendaylight

echo "----------------------------"
echo "Sweet bro, you're up as bro!"
echo "----------------------------"