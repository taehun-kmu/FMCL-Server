FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

ENV TZ=Asia/Seoul \
    TERM=xterm-256color \
    LC_ALL=C.UTF-8

# sudo 설치 및 사용자 생성
RUN sed -i 's|http://archive.ubuntu.com|https://ftp.kaist.ac.kr|g; s|http://security.ubuntu.com|https://ftp.kaist.ac.kr|g' /etc/apt/sources.list && \
    apt-get update && apt-get install -y sudo && rm -rf /var/lib/apt/lists/* && \
    adduser user -u 1000 --quiet --gecos "" --disabled-password && \
    echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user

# 생성한 사용자로 스위치
USER user

