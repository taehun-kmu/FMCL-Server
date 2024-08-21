FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

ENV TZ=Asia/Seoul \
    TERM=xterm-256color \
    HOME=/home/user \
    USER=user

# sudo 설치 및 사용자 생성
RUN sed -i 's|http://archive.ubuntu.com|https://ftp.kaist.ac.kr|g; \
            s|http://security.ubuntu.com|https://ftp.kaist.ac.kr|g' \
            /etc/apt/sources.list && \
        apt update && \
        apt install sudo git curl build-essential -y && \
        apt autoremove --purge -y && \
        apt clean && apt autoclean && \
        rm -rf /var/lib/apt/lists/* && \
    adduser user -u 1000 --quiet --gecos "" --disabled-password && \
    echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user

USER user

WORKDIR $HOME

