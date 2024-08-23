FROM taehun3446/setup:root

RUN useradd -m -u 1000 user && \
    usermod -aG sudo user && \
    echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER $USER

WORKDIR $HOME

