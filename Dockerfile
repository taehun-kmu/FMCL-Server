FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

FROM taehun3446/setup:user

FROM taehun3446/setup:zsh

RUN sudo nala update && \
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" && \ 
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/user/.zshrc && \
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" && \
    sudo apt clean && sudo apt autoclean && \
    sudo rm -rf /var/lib/apt/lists/*

