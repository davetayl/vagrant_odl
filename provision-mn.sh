#!/usr/bin/env bash

# Configure script
set -e # Stop script execution on any error
echo ""; echo "-----------------------------------------"

# Configure variables
MYHOST=mndev
TESTPOINT=google.com
TOPOLOGY=tree4 # Options tree2, tree4, tree6
echo "- Variables set -"

# Set system name
hostnamectl set-hostname $MYHOST > /dev/null 2>&1
sed -i "s/stretch/$MYHOST/g" /etc/hosts > /dev/null 2>&1
echo "- Name set -"

# Test internet connectivity
ping -q -c5 $TESTPOINT > /dev/null
 
if [ $? -eq 0 ]
then
	echo "- Internet Ok -"	
else
	echo "- Internet failed -"
fi

# Base OS update
apt-get -y update > /dev/null 2>&1
apt-get -y upgrade > /dev/null 2>&1
apt -y autoremove > /dev/null 2>&1
echo "- OS Updated -"

# Install tools
apt-get -y install net-tools git wget vim > /dev/null 2>&1
echo "- Tools installed -"


# Install MN
rm -fR /local/mininet > /dev/null 2>&1
git clone git://github.com/mininet/mininet /local/mininet > /dev/null 2>&1
/local/mininet/util/install.sh -a > /dev/null 2>&1
echo "- Mininet installed -"

# Configure MN
wget https://raw.githubusercontent.com/davetayl/vagrant_odl/master/python-mn.py > /dev/null 2>&1
python ./python-mn.py $TOPOLOGY &
echo "- Mininet $TOPOLOGY topology configured -"

# Test Mininet
#/localmn --test pingall

echo "-----------------------------------------"
echo "With great power comes great opportunity!"
echo "-----------------------------------------"
