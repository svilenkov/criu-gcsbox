#!/bin/bash

mkdir -p deps/fvp
cd deps/fvp
wget https://developer.arm.com/-/cdn-downloads/permalink/FVPs-Architecture/FM-11.29-42/FVP_Base_RevC-2xAEMvA_11.29_42_Linux64_armv8l.tgz
tar zxvf FVP_Base_RevC-2xAEMvA_11.29_42_Linux64_armv8l.tgz
