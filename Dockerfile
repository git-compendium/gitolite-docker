FROM debian:buster
RUN apt-get update && apt-get install -y \
  openssh-server \
  git \
  && rm -rf /var/lib/apt/lists/*
COPY docker-entrypoint.sh /
RUN mkdir /var/run/sshd
RUN useradd -m git
WORKDIR /home/git
USER git
RUN mkdir /home/git/bin \
  && git clone https://github.com/sitaramc/gitolite \
  && /home/git/gitolite/install -ln
EXPOSE 22
VOLUME [ "/home/git" ]
USER root
ENTRYPOINT [ "/docker-entrypoint.sh" ]
