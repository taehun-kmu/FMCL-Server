FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

ENV TZ=Asia/Seoul

# sudo 설치 및 사용자 생성
RUN ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone && \
    sed -i 's|http://archive.ubuntu.com|https://ftp.kaist.ac.kr|g; s|http://security.ubuntu.com|https://ftp.kaist.ac.kr|g' /etc/apt/sources.list && \
    apt-get update && apt-get install -y sudo zsh nala && sudo apt clean && \
    adduser user -u 1000 --quiet --gecos "" --disabled-password && \
    echo "user ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/user && \
    chmod 0440 /etc/sudoers.d/user

# 생성한 사용자로 스위치
USER user

ENV TERM=xterm-256color
ENV LC_ALL=C.UTF-8

CMD [ "zsh" ]
WORKDIR /home/user

RUN sudo nala update && sudo nala upgrade -y && \
    sudo nala install -y \
        vim \
        git \
        wget curl \
        zip unzip \
        make cmake \
        gcc g++ \
        python3 python3-dev python3-pip python3-numpy python3-venv \
        build-essential pkg-config \
        libpng-dev libjpeg-dev libopenexr-dev libtiff-dev libwebp-dev libxine2-dev libxvidcore-dev libx264-dev libxine2-dev \
        ffmpeg libffmpeg-nvenc-dev \
        libavcodec-dev libavformat-dev libswscale-dev \
        libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev libgtk2.0-dev libgtk-3-dev libharfbuzz-dev && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \
#    sed -i 's|robbyrussell|agnoster|g' ~/.zshrc && \

RUN git clone --depth=1 -b 4.10.0 https://github.com/opencv/opencv.git && \
    git clone --depth=1 -b 4.10.0 https://github.com/opencv/opencv_contrib.git && \
    mkdir -p opencv/build && cd opencv/build && \
        cmake -D CMAKE_BUILD_TYPE=RELEASE \
              -D CMAKE_INSTALL_PREFIX="/usr/local" \
              -D OPENCV_EXTRA_MODULES_PATH="/home/user/opencv_contrib/modules" \
              -D OPENCV_ENABLE_NONFREE=ON \
              -D EIGEN_INCLUDE_PATH=/usr/include/eigen3 \
              -D WITH_OPENCL=OFF \
              -D CUDA_ARCH_BIN=${ARCH} \
              -D CUDA_ARCH_PTX=${PTX} \
              -D WITH_CUDA=ON \
              -D WITH_CUDNN=ON \
              -D ENABLE_FAST_MATH=ON \
              -D CUDA_FAST_MATH=ON \
              -D OPENCV_DNN_CUDA=ON \
              -D WITH_QT=OFF \
              -D WITH_OPENMP=ON \
              -D BUILD_TIFF=ON \
              -D WITH_FFMPEG=ON \
              -D WITH_GSTREAMER=ON \
              -D TBB=ON \
              -D BUILD_TBB=ON \
              -D BUILD_TEST=OFF \
              -D WITH_EIGEN=ON \
              -D WITH_V4L=ON \
              -D WITH_LIBV4L=ON \
              -D WITH_PROTOBUF=ON \
              -D INSTALL_C_EXAMPLES=OFF \
              -D INSTALL_PYTHON_EXAMPLES=OFF \
              -D PYTHON3_PACKAGES_PATH=/usr/lib/python3/dist-packages \
              -D OPENCV_GENERATE_PKGCONFIG=ON \
              -D BUILD_EXAMPLES=OFF \
              -D CMAKE_CXX_FLAGS="-march=native -mtune=native" \
              -D CMAKE_C_FLAGS="-march=native -mtune=native" .. && \
              make -j${nproc} && \
              sudo make install && sudo ldconfig

