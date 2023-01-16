#!/bin/sh

set -e

tfcctv_version="r1.4"
caddy_version="2.6.2"
osnvr_version="v0.12.1"

script_dir=$(dirname "$(readlink -f "$0")")
cd "$script_dir"

./prepare.sh

docker buildx build \
	--pull --push \
	--build-arg tfcctv_version=$tfcctv_version \
	--build-arg caddy_version=$caddy_version \
	--build-arg osnvr_version=$osnvr_version \
	-t osnvr/os-nvr_bundle:"$osnvr_version" \
	--platform linux/amd64,linux/arm/v7,linux/arm64/v8 .

docker buildx build \
	--pull --push \
	--build-arg tfcctv_version=$tfcctv_version \
	--build-arg caddy_version=$caddy_version \
	--build-arg osnvr_version=$osnvr_version \
	-t osnvr/os-nvr_bundle:latest \
	--platform linux/amd64,linux/arm/v7,linux/arm64/v8 .
