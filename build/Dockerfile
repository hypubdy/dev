FROM cruizba/ubuntu-dind:latest

RUN apt update && apt install -y \
    fish \
    curl \
    git \
    build-essential \
    python3 \
    python3-pip

WORKDIR /root/
COPY init.sh .
RUN ./init.sh
# RUN ./get-docker.sh
# RUN apt install -y neovim

RUN mkdir -p /root/.config/nvim
RUN git clone https://github.com/LazyVim/starter ~/.config/nvim
