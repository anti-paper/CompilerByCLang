FROM ubuntu:latest
WORKDIR /app

RUN apt-get update && apt-get install -y \
    gcc \
    make \
    git \
    binutils \
    libc-dev \
    gdb \
    sudo \
    vim \
    less
