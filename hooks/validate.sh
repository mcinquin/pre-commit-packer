#!/usr/bin/env bash

set -o errexit
set -o pipefail

PACKER_BIN=""

if [ -z "$(command -v packer)" ]; then
  echo "packer is required"
  exit 1
else
  PACKER_BIN=$(command -v packer)
fi

ERROR=0

for file in "$@"; do
  if ! $PACKER_BIN validate -syntax-only "$file"; then
    ERROR=1
    echo
    echo "Failed path: $file"
    echo "================================"
  fi
done

if [[ $ERROR -ne 0 ]]; then
  exit 1
fi
