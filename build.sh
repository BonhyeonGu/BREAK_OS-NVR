#!/bin/sh

set -e

osnvr_version="v0.12.1"

script_dir=$(dirname "$(readlink -f "$0")")
cd "$script_dir"

docker image build --build-arg osnvr_version=$osnvr_version -t osnvr/os-nvr:local .
