FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

FROM taehun3446/setup:user

FROM taehun3446/setup:zsh

RUN sudo nala update && \
    # 기본 개발 도구
    sudo nala install software-properties-common \
                      build-essential pkg-config zlib1g-dev yasm checkinstall \
                      make cmake meson \
                      zip unzip \
    # 이미지 포맷 지원 
                      libjpeg-dev libpng-dev libtiff-dev \
                      libopenexr-dev libwebp-dev libglew-dev \
    # 비디오 포맷 지원 
                      libavcodec-dev libavformat-dev libswscale-dev libxvidcore-dev \ 
                      libx264-dev libxine2-dev \
                      libv4l-dev v4l-utils qv4l2 \
    # 비디오 스트리밍 
                      gstreamer1.0-tools libgstreamer-plugins-base1.0-dev libgstreamer-plugins-good1.0-dev \
    # GUI 지원 
                      libgtk2.0-dev libgtk-3-dev 'libcanberra-gtk*' \
    # 최적화 라이브러리 
                      libtbb2-dev libeigen3-dev libatlas-base-dev gfortran \
                      libprotobuf-dev protobuf-compiler libgoogle-glog-dev libgflags-dev \
                      libgphoto2-dev libhdf5-dev libtesseract-dev libpostproc-dev libvorbis-dev \
                      libfaac-dev libmp3lame-dev libtheora-dev libopencore-amrnb-dev libopencore-amrwb-dev \
                      libdc1394-dev libopenblas-dev libblas-dev liblapack-dev liblapacke-dev \
    # Python
                      python3 python3-dev python3-pip python3-venv \
                      python3-numpy python3-matplotlib -y && \
    sudo apt clean && sudo apt autoclean && \
    sudo rm -rf /var/lib/apt/lists/*

