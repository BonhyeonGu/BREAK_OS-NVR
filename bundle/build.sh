#!/bin/sh

set -e

tfcctv_version="r1.4"
caddy_version="2.6.2"
osnvr_version="v0.12.1"

script_dir=$(dirname "$(readlink -f "$0")")
cd "$script_dir"

./prepare.sh

docker image build \
	--build-arg tfcctv_version=$tfcctv_version \
	--build-arg caddy_version=$caddy_version \
	--build-arg osnvr_version=$osnvr_version \
	-t osnvr/os-nvr_bundle:local .
