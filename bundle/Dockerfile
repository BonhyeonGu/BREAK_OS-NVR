ARG tfcctv_version
FROM curid/doods2_tf-cctv:$tfcctv_version


# Install dependencies.
RUN apt update && \
	apt install -y sudo git ffmpeg libnss3-tools && \
	rm -rf /var/lib/apt/lists/*


# Install GO1.16 and use it to build GO1.18
RUN apt update && \
	apt install -y golang-1.16 && \
	rm -rf /var/lib/apt/lists/* && \
	cd /usr/lib && \
	git clone --branch go1.18 --depth 1 https://go.googlesource.com/go go && \
	cd /usr/lib/go/src && \
	GOROOT_BOOTSTRAP=/usr/lib/go-1.16 ./make.bash && \
	apt purge -y golang-1.16 --autoremove


# Install Caddy. Build from source to get
# multi-arch support and a specified version.
ARG caddy_version
RUN cd / && \
	git clone --branch v$caddy_version --depth 1 https://github.com/caddyserver/caddy.git && \
	cd /caddy/cmd/caddy/ && \
	/usr/lib/go/bin/go build -v && \
	mv caddy /usr/local/bin/ && \
	rm -r /caddy && \
	rm -r /root/go
RUN groupadd --system caddy
RUN useradd --system \
    --gid caddy \
    --create-home \
    --home-dir /var/lib/caddy \
    --shell /usr/sbin/nologin \
    --comment "Caddy web server" \
    caddy

RUN sudo -u caddy caddy start && HOME=/var/lib/caddy caddy trust
RUN chown caddy:caddy -R /var/lib/caddy/.local


# Install OS-NVR.
ARG osnvr_version
RUN useradd -m -s /sbin/nologin _nvr
RUN cd /home/_nvr/ && \
	sudo -u _nvr git clone --branch $osnvr_version --depth 1 https://gitlab.com/osnvr/os-nvr.git
RUN cd /home/_nvr/os-nvr && \
	sudo -u _nvr /lib/go/bin/go mod vendor

# Create cache directory.
RUN sudo -u _nvr mkdir "/home/_nvr/os-nvr/.cache"

# Set environment variables.
RUN sudo -u _nvr /lib/go/bin/go env -w "GOPATH=/home/_nvr/os-nvr/.cache/GOPATH"
RUN sudo -u _nvr /lib/go/bin/go env -w "GOCACHE=/home/_nvr/os-nvr/.cache/GOCACHE"


# Add files.
ADD ./init.sh /init.sh
ADD ./Caddyfile.conf /Caddyfile.conf
ADD ./demo.json /demo.json


USER root:root
ENTRYPOINT /init.sh
