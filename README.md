# docker-icecc

Distributed compiler

## Usage

Build your local version:

```sh
docker build . -t gentoo-icecc-local
```

To start the icecc daemon, simply run:

```sh
docker run -d --net=host -p ::10245/tcp -p ::8765/tcp -p ::8766/tcp -p ::8765/udp gentoo-icecc-local
```
Windows host version:
```
docker run -p 10245:10245/tcp -p 8765:8765/tcp -p 8766:8766/tcp -p 8765:8765/udp gentoo-icecc-local
```
If want to start the icecc-scheduler together, simply run:

```sh
docker run -d -e ICECC_ENABLE_SCHEDULER=1 --net=host -p ::10245/tcp -p ::8765/tcp -p ::8766/tcp -p ::8765/udp gentoo-icecc-local
```
Windows host version:
```
docker run -e ICECC_ENABLE_SCHEDULER=1 -p 10245:10245/tcp -p 8765:8765/tcp -p 8766:8766/tcp -p 8765:8765/udp gentoo-icecc-local
```
