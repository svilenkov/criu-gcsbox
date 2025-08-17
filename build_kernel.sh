#!/bin/bash
set -euo pipefail

CONFIG_PATH="$PWD/.config"
TAG="6.15-rc7"
KERNEL_SRC_DIR="$PWD/deps/kernel-src/linux-${TAG}"

cd "$KERNEL_SRC_DIR"
ls

echo "[*] Cleaning up old build..."
make mrproper

echo "[*] Copying .config..."
cp "$CONFIG_PATH" .config

echo "[*] Building kernel with threads..."
make -j$(nproc) Image

echo "[✓] Kernel build completed."
echo "Image: $KERNEL_SRC_DIR/arch/arm64/boot/Image"