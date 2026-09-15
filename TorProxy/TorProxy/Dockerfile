ARG image_debian
FROM ${image_debian}
ARG CodeUnitVersion
ARG DotNetRuntime
ARG tor_version
LABEL version=${CodeUnitVersion}
ENV ISRUNNINGINCONTAINER="true"
#TODO make it possible to have an own apt-server for apt-packages to get rid of rate limits


ARG TorKey=A3C4F0F979CAA22CDBA8F512EE8CBC9E886DDD89
ARG TorURL=https://deb.torproject.org/torproject.org
LABEL maintainer "marius.goecke@gmail.com"
LABEL description="TorProxy is a docker-image for running a hidden service in a docker-container."
LABEL targetEnvironmentType="$TargetEnvironmentType"
LABEL version="$Version"

RUN apt-get -y update && \
    apt-get -y install wget gpg lsb-release && \
    mkdir /Workspace && \
    mkdir /Workspace/Application && \
    mkdir /Workspace/Data && \
    echo "   deb     [signed-by=/usr/share/keyrings/deb.torproject.org-keyring.gpg] $TorURL $(lsb_release -cs) main" | tee -a /etc/apt/sources.list.d/tor.list && \
    wget -qO- https://deb.torproject.org/torproject.org/$TorKey.asc | gpg --dearmor | tee /usr/share/keyrings/deb.torproject.org-keyring.gpg >/dev/null && \
    apt-get update && apt-get install -y tor=${tor_version} deb.torproject.org-keyring && \
    echo "Tor version: $(tor --version)" && \
    apt-get -y purge wget gpg lsb-release apt-transport-https && \
    apt-get -y clean

WORKDIR /Workspace/Data

COPY ./TorProxy/torrc.template /Workspace/Application/torrc
COPY ./TorProxy/EntryPoint.sh /Workspace/Application/EntryPoint.sh

ENTRYPOINT ["/Workspace/Application/EntryPoint.sh"]
