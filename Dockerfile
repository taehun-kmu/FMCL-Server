FROM nvidia/cuda:12.1.0-cudnn8-devel-ubuntu22.04

FROM taehun3446/setup:user

ENV TZ=Asia/Seoul

CMD [ "zsh" ]

RUN sudo ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime && \ 
    echo ${TZ} | sudo tee /etc/timezone && \
    sudo apt update && sudo apt install nala -y && \
    sudo nala install zsh \
                      git curl wget -y && \
    sudo apt clean && sudo apt autoclean && \
    sudo rm -rf /var/lib/apt/lists/* && \
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" && \
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && \
    sed -i 's|robbyrussell|powerlevel10k/powerlevel10k|g' ~/.zshrc

