```Bash
git clone https://github.com/BonhyeonGu/OS-NVR
cd ./OS-NVR
cp ./compose-samples/default.yml ./docker-compose.yml
cp ./configs/samples/* ./configs
docker-compose up --abort-on-container-exit
sudo nano ./configs/env.yaml
```

비밀번호를 입력해야할 수 있으며 #- nvr/addons/auth/none 의 #을 제거하고 저장할 것

```Bash
docker rm os-nvr-nvr-1
cp compose/* ./
```

Dockerfile-cuda 속 image의 cuda 이미지 버전은 장치와 맞게 설정할 것

```Bash
docker-compose up -d
```

## 원본

<img src="https://gitlab.com/osnvr/os-nvr-assets/-/raw/master/screenshots/readme.png">

[Screenshots](https://gitlab.com/osnvr/os-nvr_assets/-/tree/master/screenshots)

## Overview

##### beta release.

OS-NVR is a mobile-friendly extensible CCTV system.

The front-end is written completely from scratch to give the best performance on mobile/low-end devices. The back-end is written in Go using FFmpeg for video processing.


`OS-NVR` is a temporary name. [#2](https://gitlab.com/osnvr/os-nvr/-/issues/2)


Use [Issues](https://gitlab.com/osnvr/os-nvr/-/issues) for bug reports, feature requests and support. [Matrix chat](https://matrix.to/#/#os_nvr:matrix.org)

##### Note: iPhone support is currently limited.

## Documentation

- [Installation](./docs/1_Installation.md)
- [Configuration](./docs/2_Configuration.md)
- [Development](./docs/3_Development.md)
- [API](./docs/4_API.md)
- [Object Detection](./addons/doods2/README.md)
- [Motion Detection](./addons/motion/README.md)
- [Timeline viewer](./addons/timeline/README.md)

<br>

## Similar projects

- [ZoneMinder](https://github.com/ZoneMinder/ZoneMinder)
- [Moonfire](https://github.com/scottlamb/moonfire-nvr)
- [Motion](https://github.com/Motion-Project/motion)[Eye](https://github.com/ccrisan/motioneye/)[OS](https://github.com/ccrisan/motioneyeos)
- [Viseron](https://github.com/roflcoopter/viseron)
- [camera.ui](https://github.com/SeydX/camera.ui)

## Related projects

- [TF-CCTV](https://gitlab.com/Curid/TF-CCTV)
- [OpenIPC](https://openipc.org)
- [PineCube](https://www.pine64.org/cube)


## License
All code is licensed under [GPLv2 or Later](LICENSE)
