printf "\\nStarting...\\n"

set -e

bundle_dir=$(dirname "$(readlink -f "$0")")
cd "$bundle_dir" || exit 1

docker run -it \
	--env TZ=America/New_York \
	--shm-size=500m \
	-p 2000:2000 \
	-v "$bundle_dir"/configs:/home/_nvr/os-nvr/configs \
	-v "$bundle_dir"/storage:/home/_nvr/os-nvr/storage \
	-v "$bundle_dir"/.cache/GOPATH:/home/_nvr/go \
	-v "$bundle_dir"/.cache/GOCACHE:/home/_nvr/.cache \
	osnvr/os-nvr_bundle:local
