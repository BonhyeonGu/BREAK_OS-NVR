#!/bin/sh

set -e

count="37"
osnvr_version="prune"
repo="https://gitlab.com/curid/os-nvr.git"

script_dir=$(dirname "$(readlink -f "$0")")
home_dir=$(dirname "$script_dir")
cd "$home_dir"

docker buildx build \
	--pull --push \
	--build-arg osnvr_version="$osnvr_version" \
	--build-arg repo="$repo" \
	-t osnvr/os-nvr:dev"$count" \
	--platform linux/amd64 .
