#!/bin/bash

CRIU_DIR='/root/criu'
OUTDIR="logs"

default_test="env00"

if [ $# -eq 0 ]; then
	TESTS=("$default_test")
else
	TESTS=("$@")
fi

ssh_exec() {
	ssh root@127.0.0.1 -q -p 2222 \
		-oStrictHostKeyChecking=no \
		-oUserKnownHostsFile=/dev/null \
		"$@"
}

test_cmd() {
	local TEST="$1"
	local GCS_FLAG="$2"   # 0 or 1

    cat <<EOF
cd ${CRIU_DIR}/test &&
rm -rf dump/zdtm/static/${TEST}/* &&
GCS_ENABLE=${GCS_FLAG} ./zdtm.py run --keep-img=always -f h -t zdtm/static/${TEST}
EOF
}

run_test() {
	local TEST="$1"
	local MODE="$2"
	local LOG="${TEST}_${MODE}.log"

    local SUFFIX

    if [ "$MODE" -eq 1 ]; then
        SUFFIX="gcs"
    else
        SUFFIX="no-gcs"
    fi

	> "$LOG"   # truncate before run

	CMD="$(test_cmd ${TEST} ${MODE})"
	echo "About to run ($SUFFIX):"
	echo "${CMD}"

	{
		ssh_exec "${CMD}"
		echo ">>> DONE SSH RUN (${SUFFIX})"
		date
	} >"$LOG" 2>&1

	# Looks for: "Test zdtm/static/env00 PASS"
	PASS_LINE=$(grep -E "Test zdtm/static/${TEST}.*PASS" "$LOG")
	echo "$PASS_LINE"

	DUMP_PATH=$(grep -o "dump/zdtm/static/${TEST}/[0-9]\+/[0-9]\+/dump.log" "$LOG")

	LOCAL_DUMP="${OUTDIR}/${TEST}_$(echo "$DUMP_PATH" | sed 's#dump/zdtm/static/'${TEST}'/##;s#/dump.log##;s#/#_#g')_dump_${SUFFIX}.log"
	echo "Saving ${DUMP_PATH} to ${LOCAL_DUMP}"

	ssh_exec "cat ${CRIU_DIR}/test/${DUMP_PATH}" > "$LOCAL_DUMP"

	grep -i gcs "$LOCAL_DUMP"
}

for T in "${TESTS[@]}"; do
	echo '[CONFIG] randomize_va_space = ON'
	ssh_exec 'echo 1 > /proc/sys/kernel/randomize_va_space'
	run_test "$T" 0
	run_test "$T" 1

	echo '[CONFIG] randomize_va_space= OFF'
	ssh_exec 'echo 0 > /proc/sys/kernel/randomize_va_space'
	run_test "$T" 1
done
