# criu-gcsbox
Minimal environment for testing CRIU with Guarded Control Stack (GCS) on Arm64 via FVP

## Steps:

### Download Fedora Image
```bash
./get_fedora.sh
```

#### Convert to raw
```bash
qemu-img convert -O raw Fedora-Cloud-Base-Generic-42-1.1.aarch64.qcow2 Fedora42_converted.raw
```

#### Remove unnecessary partitions
```bash
sudo sfdisk --delete Fedora42_converted.raw 1
sudo sfdisk --delete Fedora42_converted.raw 2
```

#### Remove invaluid /etc/fstab entries
```bash
sudo losetup --show -Pf deps/imgs/Fedora42_converted.raw
sudo mount /dev/loop0p3 deps/mnt/fedora42
sudo systemd-nspawn -D deps/mnt/fedora42/root
vi /etc/fstab
```

Then remove the /boot and /boot/efi, and type exit in terminal to leave
the systemd-nspawn session

### Clone Shrinkwrap
```bash
./get_shrinkwrap.sh
```

### Download FVP
```bash
./get_fvp.sh
```

### Download INITRD
```bash
./get_initrd.sh
```

### Download Kernel Source
```bash
./get_kernel_src.h
```

### Build Kernel
```bash
./build_kernel.h
```

### Run
```bash
./run_fvp.h
```
