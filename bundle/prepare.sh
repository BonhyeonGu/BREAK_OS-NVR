#!/bin/sh

set -e

script_dir=$(dirname "$(readlink -f "$0")")
cd "$script_dir"

# Copy sample Caddyfile
cp ../configs/Caddyfile.conf .
sed 's|:443 {|:2000 {|' -i ./Caddyfile.conf
sed 's|https_port 443|https_port 2000|' -i ./Caddyfile.conf
sed 's|nvr:2020.*$|127.0.0.1:2020 # App|' -i ./Caddyfile.conf
