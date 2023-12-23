FROM ubuntu:22.04

ENV APP red-view-22dec23-6cb7d502b

ENV DISPLAY :0

ENV USERNAME developer

WORKDIR /workspace

RUN apt update

RUN dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y libc6:i386 libcurl4:i386 \
        libgtk-3-0:i386 libgdk-pixbuf2.0-0:i386

RUN apt update

RUN apt install -y wget

RUN wget https://static.red-lang.org/dl/auto/linux/$APP

RUN chmod +x $APP

RUN ln -s /workspace/$APP /usr/bin/red

# create and switch to a user
RUN echo "backus ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
RUN useradd --no-log-init --home-dir /home/$USERNAME --create-home --shell /bin/bash $USERNAME
RUN adduser $USERNAME sudo
USER $USERNAME

WORKDIR /home/$USERNAME

COPY bin .

CMD red hello.red