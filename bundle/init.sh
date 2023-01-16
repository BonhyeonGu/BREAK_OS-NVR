#!/bin/sh

set -e

GOBIN="/lib/go/bin/go"

cd /home/_nvr/os-nvr || exit

# If env.yaml doesn't exist.
if [ ! -f ./configs/env.yaml ]; then
	printf "Generating configs/env.yaml and demo monitor.\\n"

	# Generate env.yaml
	sudo -u _nvr ./start/start.sh --goBin $GOBIN --env ./configs/env.yaml >/dev/null

	# Enable addons.
	sed 's|#- nvr/addons/auth/none|- nvr/addons/auth/none|' -i ./configs/env.yaml
	sed 's|#- nvr/addons/doods2|- nvr/addons/doods2|' -i ./configs/env.yaml
	sed 's|#- nvr/addons/motion|- nvr/addons/motion|' -i ./configs/env.yaml
	sed 's|#- nvr/addons/watchdog|- nvr/addons/watchdog|' -i ./configs/env.yaml
	sed 's|#- nvr/addons/timeline|- nvr/addons/timeline|' -i ./configs/env.yaml

	mkdir ./configs/monitors
	cp /demo.json ./configs/monitors/
fi

# if Caddyfile.conf doesn't exist.
if [ ! -f ./configs/Caddyfile.conf ]; then
	printf "Generating configs/Caddyfile.conf\\n"
	cp /Caddyfile.conf /home/_nvr/os-nvr/configs/
fi

# Fix permissions.
chown -R _nvr:_nvr /home/_nvr
chown root:root /home/_nvr/os-nvr/configs/env.yaml
chown root:root /home/_nvr/os-nvr/configs/Caddyfile.conf
chmod 744 /home/_nvr/os-nvr/configs/env.yaml
chmod 744 /home/_nvr/os-nvr/configs/Caddyfile.conf

# Set goBin and ffmpegBin.
sed -i "s|goBin:.*|goBin: $GOBIN|" /home/_nvr/os-nvr/configs/env.yaml
sed -i "s|ffmpegBin:.*|ffmpegBin: /usr/bin/ffmpeg|" /home/_nvr/os-nvr/configs/env.yaml


# Start DOODS.
cd /opt/doods/ || exit
python3 /opt/doods/main.py &

# Start Caddy.
sudo -u caddy caddy start --config /home/_nvr/os-nvr/configs/Caddyfile.conf

# Start OS-NVR.
cd /home/_nvr/os-nvr || exit
sudo -u _nvr $GOBIN run ./start/start.go -env ./configs/env.yaml
