#!/bin/bash
source functions.sh

# Ennabling interfaces

enable_interfaces(){
	echo "Habilitando interfaces..."
	cp /etc/sysconfig/network-scripts/ifcfg-eth2 scripts/ifcfg-eth2
	sed 's/ONBOOT=no/ONBOOT=yes/g' ./scripts/ifcfg-eth2
	config_file scripts/ifcfg-eth2 /etc/sysconfig/network-scripts/ifcfg-eth2

	cp /etc/sysconfig/network-scripts/ifcfg-eth0 scripts/ifcfg-eth0
	config_file scripts/ifcfg-eth0 /etc/sysconfig/network-scripts/ifcfg-eth0

	cp /etc/sysconfig/network-scripts/ifcfg-eth1 scripts/ifcfg-eth1
	config_file scripts/ifcfg-eth1 /etc/sysconfig/network-scripts/ifcfg-eth1

}

bonding(){
	echo "Creando interfaz bond0"
	echo "alias	bond0	bonding" > /etc/modprobe.d/bonding.conf
	echo "options	bonding	mode=0	miimon=30" >> /etc/modprobe.d/bonding.conf
	depmod -a

}

# Requirements
	if [ -e "/sys/class/net/eth0" -a -e "/sys/class/net/eth1" -a -e "/sys/class/net/eth2" ]
	then
	enable_interfaces
	#bonding
else
	echo "No se encontraron todas las interfaces de red"
fi
