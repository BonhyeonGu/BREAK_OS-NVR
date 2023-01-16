#!/bin/sh

set -e

osnvr_version="v0.12.1"

# Go to home.
script_path=$(readlink -f "$0")
home_dir=$(dirname "$(dirname "$script_path")")
cd "$home_dir" || exit

docker buildx build \
	--pull --push \
	--build-arg osnvr_version="$osnvr_version" \
	-t osnvr/os-nvr:"$osnvr_version" \
	--platform linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64/v8 .

docker buildx build \
	--pull --push \
	--build-arg osnvr_version="$osnvr_version" \
	-t osnvr/os-nvr:latest \
	--platform linux/amd64,linux/arm/v6,linux/arm/v7,linux/arm64/v8 .
