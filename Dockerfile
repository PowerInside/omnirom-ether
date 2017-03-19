FROM ubuntu:16.10

ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/main$/main universe/' /etc/apt/sources.list
RUN apt-get -qq update
RUN apt-get -qqy upgrade
RUN apt-get -qy git git-core gnupg flex bison gperf libsdl1.2-dev libesd0-dev libwxgtk2.8-dev squashfs-tools build-essential zip curl libncurses5-dev zlib1g-dev openjdk-6-jre openjdk-6-jdk pngcrush schedtool libxml2 libxml2-utils xsltproc lzop libc6-dev schedtool g++-multilib lib32z1-dev lib32ncurses5-dev lib32readline-gplv2-dev gcc-multilib 

#RUN apt-get -qy vim wget bash-completion tmux
#RUN apt-get -qy android-tools-adb android-tools-fastboot sudo
#RUN apt-get install -qy ccache

RUN curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > /bin
RUN chmod a+x /bin/repo

RUN mkdir -p /android/omni
RUN cd /android/omni

RUN repo init -u https://github.com/omnirom/android.git -b android-7.1
RUN repo sync -j16 -f --no-clone-bundle
RUN export USE_CCACHE=1
RUN /android/omni/prebuilts/misc/linux-x86/ccache/ccache -M 15G
