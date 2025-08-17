#!/bin/bash

mkdir -p deps/imgs
cd deps/imgs
wget https://download.fedoraproject.org/pub/fedora/linux/releases/42/Cloud/aarch64/images/Fedora-Cloud-Base-Generic-42-1.1.aarch64.qcow2
# next run: qemu-img convert -O raw Fedora-Cloud-Base-Generic-42-1.1.aarch64.qcow2 Fedora42_converted.raw
