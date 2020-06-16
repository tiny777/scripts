#!/bin/bash
# Determine  whether executor is root or not
if [ $(whoami) != "root" ]; then
    echo "please exec this shell script with sudo or in root mode"
    exit 1
fi

# Determine if there is a new hostname
if [ -z "$1" ]; then
    echo "please input the new hostname"
    exit 1
fi

# get the release version
version=$(cat /etc/redhat-release | awk -F 'release' '{print $2}' | cut -c -2)

if [ $version -ne 6 ] && [ $version -ne 7 ] && [ $version -ne 8 ]; then
    echo "This script do not suit your system, Bye!"
    exit 1
fi

echo "your hostname will be change to $1"

if [ $version == 6 ]; then
    # get hostname from /etc/sysconfig/network
    hostnameCurrent=$(cat /etc/sysconfig/network | grep HOSTNAME | awk -F '=' '{ print $NF }')
    # echo "your hostname now is $hostnameCurrent"
    # modify the tmp hostname
    hostname $1
    # Determine if there is a field about $hostnameCurrent in /etc/hosts
    # if yes, use awk to replace it
    # if no, echo a new line aboout new hostname
    cat /etc/hosts | grep $hostnameCurrent
    if [ $? -ne 0 ]; then
        echo "127.0.0.1     $1" >>/etc/hosts
    else
        sed -i "s/$hostnameCurrent/$1/g" /etc/hosts
    fi
    # modify the hostname in /etc/sysconfig/network
    sed -i "s/$hostnameCurrent/$1/g" /etc/sysconfig/network
else
    if [ $version == 7 ] || [ $version == 8 ]; then
        hostnamectl set-hostname $1
    fi
fi

echo "Hostname modification is done !"
echo "A restart might be better for apply the change"