FROM dockcross/base:latest
MAINTAINER Matt McCormick "matt.mccormick@kitware.com"

RUN dpkg --add-architecture arm64 && apt-get update

RUN apt-get -y update && apt-get install -y \
  crossbuild-essential-arm64 \
  gfortran-aarch64-linux-gnu \
  libbz2-dev:arm64 \
  libexpat1-dev:arm64 \
  ncurses-dev:arm64 \
  libssl-dev:arm64 \
  qemu-system-arm


ENV CROSS_TRIPLE aarch64-linux-gnu
ENV CROSS_ROOT /usr/${CROSS_TRIPLE}
ENV AS=/usr/bin/${CROSS_TRIPLE}-as \
    AR=/usr/bin/${CROSS_TRIPLE}-ar \
    CC=/usr/bin/${CROSS_TRIPLE}-gcc \
    CPP=/usr/bin/${CROSS_TRIPLE}-cpp \
    CXX=/usr/bin/${CROSS_TRIPLE}-g++ \
    LD=/usr/bin/${CROSS_TRIPLE}-ld

ENV DEFAULT_DOCKCROSS_IMAGE dockcross/linux-arm64
WORKDIR /work

# Note: Toolchain file support is currently in debian Experimental according to:
# https://wiki.debian.org/CrossToolchains#In_jessie_.28Debian_8.29
# We can switch to that when it becomes stable.
COPY Toolchain.cmake /usr/lib/${CROSS_TRIPLE}/
ENV CMAKE_TOOLCHAIN_FILE /usr/lib/${CROSS_TRIPLE}/Toolchain.cmake

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG IMAGE
ARG VCS_REF
ARG VCS_URL
LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.name=$IMAGE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url=$VCS_URL \
      org.label-schema.schema-version="1.0"
