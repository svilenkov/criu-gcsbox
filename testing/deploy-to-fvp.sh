#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

"$SCRIPT_DIR/recompile-tests.sh" "$@"
"$SCRIPT_DIR/rsync-to-fvp.sh"