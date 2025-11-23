#!/bin/bash

GCS_ENABLE=0
CRIU_DIR='/root/criu'

case "$1" in
	--gcs=enabled)
		GCS_ENABLE=1
		;;
	--gcs=disabled|"")
		GCS_ENABLE=0
		;;
	*)
		echo "Unknown option: $1"
		echo "Usage: $0 [--gcs=enabled|--gcs=disabled]"
		exit 1
		;;
esac

echo "GCS_ENABLE=${GCS_ENABLE}"
echo

make -C compel/test/infect clean
make -C test/zdtm/static clean
make dist clean
make clean
make

rebuild_test() {
	local T="$1"
	touch "/root/criu/test/zdtm/static/${T}.c"
	make -C /root/criu/test/zdtm/static "GCS_ENABLE=${GCS_ENABLE}" "$T"
}

rebuild_test env00
rebuild_test pthread00
rebuild_test posix_timers