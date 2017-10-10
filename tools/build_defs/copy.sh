#!/bin/bash

set -e

dest=$1

shift 1

if [[ "${dest}" =~ .*/$ ]]; then
  mkdir -p "${dest}"
else
  mkdir -p "$(dirname "${dest}")"
fi

cp -L "$@" "${dest}"
