FROM ubuntu:16.10

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/main$/main universe/' /etc/apt/sources.list
RUN apt-get -qq update
RUN apt-get -qqy upgrade
RUN apt-get install -qy git git-core gnupg flex bison gperf libsdl1.2-dev libesd0-dev libwxgtk3.0-dev squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev openjdk-8-jre-headless openjdk-8-jdk-headless pngcrush schedtool libxml2 libxml2-utils xsltproc lzop libc6-dev schedtool g++-multilib lib32z1-dev lib32ncurses5-dev libreadline-gplv2-dev gcc-multilib python
RUN apt-get install -qy vim wget bash-completion unzip
#RUN apt-get -qy android-tools-adb android-tools-fastboot sudo
#RUN apt-get install -qy ccache
RUN alias python='/usr/bin/python2.7'
RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /bin/repo
RUN chmod a+x /bin/repo
RUN mkdir -p /android/omni && cd /android/omni
RUN mkdir -p /android/omni/.repo/local_manifests/
COPY ./local_manifest/local_manifest.xml /android/omni/.repo/local_manifests/local_manifest.xml
COPY ./repo_prep.sh /android/omni/repo_prep.sh
RUN export USE_CCACHE=1

RUN mkdir -p /android/sys_dump
RUN cd /android/sys_dump
RUN wget -c "https://dl.omnirom.org/ether/omni-7.1.1-20170319-ether-WEEKLY.zip"
RUN unzip omni-7.1.1-20170319-ether-WEEKLY.zip system/*
RUN cd /android/omni/device/nextbit/ether
RUN ./extract-files.sh -d /android/sys_dump/

RUN source /android/build/envsetup.sh
CMD sh /android/omni/repo_prep.sh
