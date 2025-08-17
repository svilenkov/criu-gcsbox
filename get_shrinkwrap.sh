#!/bin/bash

cd deps
git clone https://git.gitlab.arm.com/tooling/shrinkwrap.git
cd shrinkwrap
git apply ../../patches/INITRD.patch
