FROM resin/armhf-alpine:3.4
MAINTAINER Sylvain Desbureaux <sylvain@desbureaux.fr> #Original creator of this Dockerfile
MAINTAINER Cedric Gatay <c.gatay@code-troopers.com>
MAINTAINER Jean-Claude Computing <jeanclaude.computing@gmail.com>

# install packages &
## OpenZwave installation &
# grep git version of openzwave &
# untar the files &
# compile &
# "install" in order to be found by domoticz &
## Domoticz installation &
# clone git source in src &
# Domoticz needs the full history to be able to calculate the version string &
# prepare makefile &
# compile &
# remove git and tmp dirs

ARG VCS_REF
ARG BUILD_DATE

ARG BRANCH_NAME

LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/domoticz/domoticz" \
      org.label-schema.url="https://domoticz.com/" \
      org.label-schema.name="Domoticz" \
      org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.license="GPLv3" \
      org.label-schema.build-date=$BUILD_DATE

RUN apk add --no-cache --virtual build-dependencies \
	 git \
	 tzdata \
	 cmake \
	 linux-headers \
	 libusb-dev \
	 zlib-dev \
	 openssl-dev \
	 boost-dev \
	 sqlite-dev \
	 build-base \
	 eudev-dev \
	 coreutils \
	 curl-dev \
	 python3-dev && \
	 apk add --no-cache \
	 libssl1.0 \
	 boost-thread \
	 boost-system \
	 boost-date_time \
	 sqlite \
	 curl libcurl \
	 libusb \
	 zlib \
	 udev \
	 python3 && \
	 cp /usr/share/zoneinfo/Europe/Paris /etc/localtime && \
	 git clone --depth 2 https://github.com/OpenZWave/open-zwave.git /src/open-zwave && \
	 cd /src/open-zwave && \
	 make -j$(nproc) && \
	 ln -s /src/open-zwave /src/open-zwave-read-only && \
	 git clone -b ${BRANCH_NAME:-master} --depth 2 https://github.com/domoticz/domoticz.git /src/domoticz && \
	 cd /src/domoticz && \
	 git fetch --unshallow && \
	 cmake -DCMAKE_BUILD_TYPE=Release . && \
	 make -j$(nproc) && \
	 rm -rf /src/domoticz/.git && \
	 rm -rf /src/open-zwave/.git && \
	 apk del build-dependencies

VOLUME /config

EXPOSE 8080

ENTRYPOINT ["/src/domoticz/domoticz", "-dbase", "/config/domoticz.db", "-log", "/config/domoticz.log"]
CMD ["-www", "8080"]
