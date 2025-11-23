#!/bin/bash
set -euo pipefail

SRC_DIR="/root/criu"
TARGET="root@127.0.0.1"
SSH_PORT="${1:-2222}"

ssh -p $SSH_PORT -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null $TARGET "mkdir -p /root/criu/compel /root/criu/criu/pie"

cd "$SRC_DIR"

rsync -q -v --progress -avz -R -e "ssh -p $SSH_PORT -oStrictHostKeyChecking=no -oUserKnownHostsFile=/dev/null"  \
	compel/compel-host-bin \
	criu/criu \
	criu/pie/parasite.built-in.o \
	criu/pie/restorer.built-in.o \
	criu/pie/restorer.o \
	criu/pie/restorer-blob.h \
	criu/cr-restore.o \
	criu/built-in.o \
	test/zdtm/static/cwd00 \
	compel/test/infect/parasite.po \
	compel/test/infect/parasite.o \
	compel/test/infect/spy \
	compel/test/infect/victim \
	compel/libcompel.a \
	compel/arch/aarch64/src/lib/infect.c \
	compel/src/lib/infect.c \
	compel/test/infect/Makefile \
	compel/test/infect/parasite.c \
	compel/test/infect/spy.c \
	test/zdtm/Makefile.inc \
	test/zdtm/static/Makefile \
	test/zdtm/static/cwd00 \
	test/zdtm/static/env00 \
	test/zdtm/static/env00.out \
	test/zdtm/static/session03 \
	test/zdtm/static/session03.out \
	test/zdtm/static/posix_timers \
	test/zdtm/static/posix_timers.out \
	test/zdtm/static/pthread00 \
	test/zdtm/static/pthread00.out \
	test/zdtm.py \
	images/core-aarch64.proto \
	"$TARGET:/root/criu/"

echo "✅ Sync complete."
