#! /usr/bin/env bash

set -Eeuo pipefail

if [[ $1 == *.go]]
then
    goland $1
fi
