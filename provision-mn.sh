#!/usr/bin/env bash

# Configure script
set -e # Stop script execution on any error

# Configure variables
echo "- Set Variables -"
MYHOST=mndev
TESTPOINT=google.com
TOPOLOGY=tree

# Set system name
echo "- Set Name -"
hostnamectl set-hostname $MYHOST > /dev/null 2>&1
/bin/sed -i "s/debianvb/$MYHOST/g" /etc/hosts > /dev/null 2>&1

# Test internet connectivity
ping -q -c5 $TESTPOINT > /dev/null
 
if [ $? -eq 0 ]
then
	echo "- Internet Ok -"	
else
	echo "- Internet failed -"
fi

# Base OS update
echo "- OS Update -"
/usr/bin/apt-get -y update # > /dev/null 2>&1
/usr/bin/apt-get -y upgrade

# Install tools
echo "- Install tools -"
/usr/bin/apt-get -y install net-tools git wget

# Install MN
echo "- Install MN -"
# /usr/bin/apt-get -y install openvswitch
# /bin/systemctl enable openvswitch
# /bin/systemctl start openvswitch
/bin/rm -fR /usr/local/mininet
/usr/bin/git clone git://github.com/mininet/mininet /usr/local/mininet
/usr/local/mininet/util/install.sh -a

# Configure MN
echo "- Configuring MN -"
/usr/bin/wget https://raw.githubusercontent.com/davetayl/vagrant_odl/master/python-mn.py
/usr/bin/python ./python-mn.py
 
# Test Mininet
/usr/local/bin/mn --test pingall


echo "----------------------------"
echo "Sweet bro, you're up as bro!"
echo "----------------------------"