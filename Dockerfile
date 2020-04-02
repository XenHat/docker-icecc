FROM gentoo/stage3-amd64 as base
MAINTAINER me@xenh.at
USER root
RUN emaint sync -A
RUN eselect profile list
RUN eselect profile set default/linux/amd64/17.1

FROM base as install1
USER root
RUN echo 'MAKEOPTS="--jobs=14"' | tee --append /etc/portage/make.conf
RUN echo 'EMERGE_DEFAULT_OPTS="--quiet --jobs=14 --load-average=14 --ask=n --autounmask --autounmask-write --autounmask-continue"' | tee --append /etc/portage/make.conf
RUN emerge sys-devel/icecream

FROM install1 as install2
USER root
RUN cat /etc/portage/make.conf
RUN emerge app-admin/doas

FROM install2 as useradd
USER root
RUN useradd --create-home -s /bin/bash icecc

FROM useradd as copy
USER root
USER root
COPY scripts/build.sh /tmp/build.sh
COPY scripts/icecc-run.sh /usr/local/bin/icecc-run.sh

FROM copy as prepare
USER root
WORKDIR /home/icecc
RUN chmod +x /usr/local/bin/icecc-run.sh
EXPOSE 10245 8765/TCP 8765/UDP 8766
ENTRYPOINT ["/usr/local/bin/icecc-run.sh"]
