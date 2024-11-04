#!/usr/bin/env bash
set -eo pipefail

declare -r testfile="${1}"
declare -r url="${2}"
declare has_errors=0

if [ ! -f "$testfile" ]; then
  echo "error: test_file '$testfile' file does not exist" >&2
  has_errors=1
fi

if [ -z "$url" ]; then
  echo "error: 'url' required" >&2
  has_errors=1
fi

[ "$has_errors" -eq 1 ] && exit 1

export SHAKEDOWN_URL="$url"
bash $testfile
