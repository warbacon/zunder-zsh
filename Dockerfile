FROM ubuntu:24.04

RUN apt-get update
RUN apt-get install -y zsh git vim nano eza kitty-terminfo

RUN useradd -m zunder

RUN mkdir -p /home/zunder/.config/zunder-zsh
RUN mkdir -p /home/zunder/.config/zunder-zsh/functions
COPY ./config/zshrc /home/zunder/.zshrc
COPY ./config/zshenv /home/zunder/.zshenv
COPY ./config/after.zsh /home/zunder/.config/zunder-zsh
COPY ./config/before.zsh /home/zunder/.config/zunder-zsh
COPY ./config/spaceship.zsh /home/zunder/.config/zunder-zsh
COPY ./config/functions/* /home/zunder/.config/zunder-zsh/functions

RUN chown -R zunder /home/zunder

USER zunder
ENV USER=zunder

RUN zsh -ic exit

WORKDIR /home/zunder
ENTRYPOINT [ "zsh" ]
