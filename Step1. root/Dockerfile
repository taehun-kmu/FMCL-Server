# syntax = docker/dockerfile:experimental

ARG BASE_IMAGE=ubuntu:22.04
ARG PYTHON_VERSION=3.10

FROM ${BASE_IMAGE} AS dev-base

ENV TZ=Asia/Seoul \
    SOURCES_LIST=https://ftp.kaist.ac.kr \
    TERM=xterm-256color \
    HOME=/home/user \
    USER=user

RUN apt update && apt install -y ca-certificates && \
    sed -i 's|http://archive.ubuntu.com|'"$SOURCES_LIST"'|g; \
            s|http://security.ubuntu.com|'"$SOURCES_LIST"'|g' \
        /etc/apt/sources.list && \
    apt update && apt install --reinstall ca-certificates && \
                  apt install -y --no-install-recommends \
                              sudo \
                              build-essential \
                              curl \
                              git && \
    apt clean && apt autoclean && \
        rm -rf /var/lib/apt/lists/*

