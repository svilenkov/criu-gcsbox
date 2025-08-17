#!/bin/bash
set -euo pipefail

TAG="v6.15-rc7"
ARCH="arm64"
CONFIG_FILE="../.config"
DST_DIR="kernel-src"

mkdir -p "$PWD/deps/${DST_DIR}"
cd deps

if [ ! -d "$DST_DIR" ]; then
  curl -L "https://github.com/torvalds/linux/archive/refs/tags/${TAG}.tar.gz" -o "${TAG}.tar.gz"
  tar -xf "${TAG}.tar.gz"
  rm "${TAG}.tar.gz"
  mv "linux-${TAG#v}" "${DST_DIR}"
fi

cd "${DST_DIR}"
cp "$CONFIG_FILE" .config
