# Freego Linux Container

Test Version: Freego_Sep272024_linux_version

Source: https://accessibility.moda.gov.tw/Download/Detail/2763?Category=70

## Pre-build

Download freego from the [MODA website](https://accessibility.moda.gov.tw/Download/Detail/2763?Category=70), extract the .gz archive, and copy its contents to ./driver path.

## Build

```shell
docker build -t {image_name} --build-arg DEFAULT_PWD={YOUR_PASSWORD} .
```

## Run

```shell
docker run -d --name Freego -p 3389:3389 --cap-add=SYS_ADMIN --shm-size=2g {image_name}
```

You can use RDP application access by 3389/tcp, account is __rytass__. There is a Freego application in desktop.
