FROM debian:stable-slim

LABEL maintainer "Ahmad Thoriq Najahi <najahiii@outlook.co.id>"

# I love bare things.
ARG LLVM_VERSION=10

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
	libc6-dev \
        libelf-dev \
	libgomp1-* \
	libncurses5-dev \
	libssl-dev \
	libstdc++6 \
	libtool \
	libtool-bin \
	m4 \
	make \
	openssl \
	ovmf \
	patch \
	python3 \
	python \
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
RUN rm -rf /var/lib/apt/lists/*

# Install the latest nightly Clang/lld packages from apt.llvm.org
# Delete all the apt list files since they're big and get stale quickly
RUN curl https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - && \
    echo "deb http://apt.llvm.org/buster/ llvm-toolchain-buster$(test ${LLVM_VERSION} -ne 10 && echo "-${LLVM_VERSION}") main" | tee -a /etc/apt/sources.list && \
    apt-get update -qq && \
    apt-get install --no-install-recommends -y \
        clang-${LLVM_VERSION} \
        lld-${LLVM_VERSION} \
        llvm-${LLVM_VERSION} && \
    chmod -f +x /usr/lib/llvm-${LLVM_VERSION}/bin/* && \
    rm -rf /var/lib/apt/lists/*

# Change timezone to GMT+7 (WIB)
RUN apt-get upgrade -y
ENV TZ=Asia/Jakarta
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN date

# Run ninja-build script
COPY scripts/ninja.sh /
RUN bash /ninja.sh && \
    rm /ninja.sh

# Check ninja
RUN ninja --version
