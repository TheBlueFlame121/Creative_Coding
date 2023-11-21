FROM ubuntu:jammy

ARG DEBIAN_FRONTEND=noninteractive

ENV TZ="Europe/London"

USER root

SHELL [ "/bin/bash", "-c" ]

RUN apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt update && \
    apt upgrade -y

RUN apt-get update

RUN apt-get install -y wget git vim htop apt-utils \
    software-properties-common unzip build-essential

RUN apt install sudo && groupadd noroot && \
    useradd -s /bin/bash -m -g noroot noroot && \
    usermod -aG sudo noroot && \
    echo "noroot ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

WORKDIR /home/noroot/

RUN wget https://github.com/openframeworks/openFrameworks/releases/download/0.12.0/of_v0.12.0_linux64gcc6_release.tar.gz && \
  tar -xvf of_v0.12.0_linux64gcc6_release.tar.gz && \
  mv of_v0.12.0_linux64gcc6_release openframeworks && \
  rm -rf of_v0.12.0_linux64gcc6_release.tar.gz

RUN cd openframeworks/scripts/linux/ubuntu && \
    ./install_dependencies.sh

USER noroot

RUN sudo chown -R noroot:noroot openframeworks/

RUN cd openframeworks/scripts/linux && \
    ./compileOF.sh -j4
