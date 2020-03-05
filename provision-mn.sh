#!/usr/bin/env bash

# Set system name
echo "- Set Name -"
hostnamectl set-hostname mndev > /dev/null 2>&1
/usr/bin/sed -i "s/debianvb/mndev/g" /etc/hosts > /dev/null 2>&1

# Base OS update
echo "- OS Update -"
# /usr/bin/yum -y update > /dev/null 2>&1


# Install tools
echo "- Install tools -"
/usr/bin/yum -y install net-tools git
/sbin/setenforce 0

# Install MN
echo "- Install MN -"
/usr/bin/yum -y install openvswitch
/usr/bin/systemctl enable openvswitch
/usr/bin/systemctl start openvswitch
/bin/git clone git://github.com/mininet/mininet /usr/local/mininet
/usr/local/mininet/util/install.sh -fnpvw

# Configure MN
echo "- Configuring MN -"
# /usr/local/bin/mn -c
# /usr/local/bin/mn --controller=remote,ip=10.0.0.17,port=6633
 
# Test Mininet
# /usr/local/bin/mn --test pingall


echo "----------------------------"
echo "Sweet bro, you're up as bro!"
echo "----------------------------"