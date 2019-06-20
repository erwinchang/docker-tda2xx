FROM ubuntu:trusty-20180112

MAINTAINER Erwin "m9207216@gmail.com"

# https://github.com/sameersbn/docker-ubuntu/blob/14.04/Dockerfile
RUN echo 'APT::Install-Recommends 0;' >> /etc/apt/apt.conf.d/01norecommends \
 && echo 'APT::Install-Suggests 0;' >> /etc/apt/apt.conf.d/01norecommends

# fix ia32-libs
# https://stackoverflow.com/questions/23182765/how-to-install-ia32-libs-in-ubuntu-14-04-lts-trusty-tahr
#RUN echo 'deb http://old-releases.ubuntu.com/ubuntu/ raring main restricted universe multiverse' > /etc/apt/sources.list.d/ia32-libs-raring.list
# https://askubuntu.com/questions/578172/cannot-install-ia32-libs-on-ubuntu-14-04-64bit
# lib32z1 lib32ncurses5 lib32bz2-1.0, will fully replace any functionality needed by ia32-libs

# for 32bit
RUN dpkg --add-architecture i386

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y git build-essential \
# && DEBIAN_FRONTEND=noninteractive apt-get install -y ia32-libs
 && DEBIAN_FRONTEND=noninteractive apt-get install -y lib32z1 lib32ncurses5 lib32bz2-1.0
# VisionSDK_Linux_UserGuide.pdf
# PROCESSOR_SDK_VISION_03_06_00_00/vision_sdk/build/hlos/scripts/linux/setup-linux-build-env.sh
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y lib32stdc++6 lib32z1-dev lib32z1 lib32ncurses5 lib32bz2-1.0
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ssh corkscrew gawk sed u-boot-tools dos2unix dtrx git lib32z1
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y lib32ncurses5 lib32bz2-1.0 libc6:i386 libc6-i386 libstdc++6:i386 libncurses5:i386
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libz1:i386 libc6-dev-i386 device-tree-compiler mono-complete lzop
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y locales
## fix build kernel menuconfig
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y lib32ncurses5-dev
## fix build kernel
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y bc
## for https://github.com/GENIVI/vsomeip
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libboost-system1.55-dev libboost-thread1.55-dev libboost-log1.55-dev
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y asciidoc source-highlight doxygen graphviz
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y cmake
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y libbz2-dev
RUN rm -rf /var/lib/apt/lists/*

RUN locale-gen en_US.UTF-8
RUN DEBIAN_FRONTEND=noninteractive dpkg-reconfigure locales

#bash
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

#
COPY gitconfig /root/.gitconfig
COPY ssh_config /root/.ssh/config

WORKDIR /mnt/aosp
COPY utils/docker_entrypoint.sh /root/docker_entrypoint.sh
COPY utils/aosp_bashrc.sh /root/aosp_bashrc.sh
RUN chmod +x /root/docker_entrypoint.sh
ENTRYPOINT ["/root/docker_entrypoint.sh"]
