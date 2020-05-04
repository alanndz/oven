FROM ubuntu:focal
LABEL maintainer "Ahmad Thoriq Najahi <najahiii@outlook.co.id>"

# Indonesian timezone (GMT+8)	
ENV TZ=Asia/Makassar
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Tidy-up
RUN apt-get update -qq && \
    apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
	autoconf \
	autogen \
	automake \
	autotools-dev \
	bc \
	binutils \
	binutils-aarch64-linux-gnu \
	binutils-arm-linux-gnueabi \
	bison \
	bzip2 \
	ca-certificates \
	coreutils \
	cmake \
	curl \
	expect \
	flex \
	g++ \
	gawk \
	gcc \
	git \
	gnupg \
	gperf \
	help2man \
	lftp \
	libc6-dev \
	libelf-dev \
	libgomp1-* \
	liblz4-tool \
	libncurses5-dev \
	libssl-dev \
	libstdc++6 \
	libtool \
	libtool-bin \
	m4 \
	make \
	nano \
	openjdk-8-jdk \
	openssh-client \
	openssl \
	ovmf \
	patch \
	pigz \
	python3 \
	python2 \
	rsync \
	shtool \
	subversion \
	tar \
	texinfo \
	tzdata \
	u-boot-tools \
	unzip \
	wget \
	xz-utils \
	zip \
	zlib1g-dev \
	zstd

# My Github
RUN git config --global user.name "alanndz"
RUN git config --global user.email "alanmahmud0@gmail.com"

# Clang Najahii
RUN git clone https://github.com/NusantaraDevs/clang.git -b dev/10.0 --depth=1 /root/nusantara-10

# Clang from Haseo97
RUN git clone https://github.com/Haseo97/Clang-11.0.0 --depth=1 /root/pendulum-11

# Proton Clang 10
RUN git clone https://github.com/HANA-CI-Build-Project/proton-clang -b master --depth=1 /root/proton-10

# Proton Clang 11
RUN git clone https://github.com/HANA-CI-Build-Project/proton-clang -b proton-clang-11 --depth=1 /root/proton-11

# Avalon Clang 11
RUN git clone https://github.com/Haseo97/Avalon-Clang-11.0.1 -b 11.0.1 --depth=1 root/avalon-11
