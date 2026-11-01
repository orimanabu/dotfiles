#!/bin/bash

if [ x"$#" != x"1" ]; then
	echo "$0 subcmd"
	exit 1
fi
subcmd=$1; shift

casketsdir=${HOME}/Data/caskets
mntdir=/mnt/sources
sudo chown $(whoami):wheel /mnt/sources

case ${subcmd} in
mount|start)
	mkdir -p ${mntdir}/rhel7
	sudo mount -t squashfs ${casketsdir}/casket-20230430-rhel7.sqfs.xz ${mntdir}/rhel7

	mkdir -p ${mntdir}/rhel8
	sudo mount -t squashfs ${casketsdir}/casket-20240524-rhel8-no-dotnet.sqfs.xz ${mntdir}/rhel8

	mkdir -p ${mntdir}/rhel9
	sudo mount -t squashfs ${casketsdir}/casket-20260525-rhel9-no-dotnet.sqfs.xz ${mntdir}/rhel9

	mkdir -p ${mntdir}/rhel10
	sudo mount -t squashfs ${casketsdir}/casket-20260523-rhel10-no-dotnet.sqfs.xz ${mntdir}/rhel10
	;;
unmount|umount|stop)
	sudo umount ${mntdir}/rhel7
	sudo umount ${mntdir}/rhel8
	sudo umount ${mntdir}/rhel9
	sudo umount ${mntdir}/rhel10
	;;
*)
	echo "unknown subcmd: ${subcmd}"
	exit 1
	;;
esac
