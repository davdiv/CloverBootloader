#!/bin/bash

qemu-system-x86_64 \
		-enable-kvm \
		-cpu host \
		-smp cores=2,threads=1 \
		-m 4G \
		-machine q35,smm=on \
		-hda disk.img
