#!/bin/bash

export PATH_TO_FVP="$PWD/deps/fvp/Base_RevC_AEMvA_pkg/models/Linux64_armv8l_GCC-9.3/"
export PATH="$PATH_TO_FVP:$PATH"

export KERNEL_SRC_PATH="$PWD/deps/kernel-src/linux-6.15-rc7"
export CMDLINE="root=/dev/vda3 rootfstype=btrfs rootwait rootflags=subvol=root console=ttyAMA0,115200 loglevel=8 earlycon=pl011,0x1c090000 selinux=0 audit=0 evm=off security=none hugepagesz=2M default_hugepagesz=2M hugepages=8 nokaslr"

shrinkwrap --runtime null run $@ \
  --rtvar KERNEL=$KERNEL_SRC_PATH/arch/arm64/boot/Image \
  --rtvar CMDLINE="${CMDLINE}" \
  --rtvar ROOTFS=./deps/imgs/Fedora42_converted.raw \
  --rtvar DTB=~/.shrinkwrap/package/ns-edk2/dt_bootargs.dtb \
  --rtvar INITRD=./deps/imgs/initramfs-6.15.0-rc7-yoctodev-standard+.img \
  --overlay ./overlays/params.yaml \
  fedora-ns-edk2.yaml
