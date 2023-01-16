#!/bin/sh
# Bump versions in all files.
tfcctv_version="r1.4"
caddy_version="2.6.2"
osnvr_version="v0.12.1"

# Go to home.
script_path=$(readlink -f "$0")
home_dir=$(dirname "$(dirname "$script_path")")
cd "$home_dir" || exit

bump() {
	file=$1
	sed "s|^tfcctv_version=.*$|tfcctv_version=\"$tfcctv_version\"|" -i "$file"
	sed "s|^caddy_version=.*$|caddy_version=\"$caddy_version\"|" -i "$file"
	sed "s|^osnvr_version=.*$|osnvr_version=\"$osnvr_version\"|" -i "$file"
}

bump ./bundle/build.sh
bump ./bundle/release.sh
bump ./utils/release.sh
bump ./build.sh

bump_compose() {
	file=$1
	sed "s|curid/doods2_tf-cctv:.*$|curid/doods2_tf-cctv:$tfcctv_version\"|" -i "$file"
	sed "s|caddy:.*-alpine$|caddy:$caddy_version-alpine|" -i "$file"
	sed "s|osnvr/os-nvr:.*$|osnvr/os-nvr:$osnvr_version|" -i "$file"
}

bump_compose ./compose-samples/default.yml
bump_compose ./compose-samples/no-doods.yml
bump_compose ./compose-samples/no-webserver.yml
