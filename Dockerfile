FROM debian:bullseye
RUN apt-get update && apt-get install -y \
  openssh-server \
  git \
  libjson-perl \
  locales \
  && rm -rf /var/lib/apt/lists/*
RUN mkdir /var/run/sshd \
  && useradd -m git \
  && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
  && sed -i -e 's/AcceptEnv/# AcceptEnv/' /etc/ssh/sshd_config \
  && locale-gen en_US.UTF-8
WORKDIR /home/git
USER git
RUN mkdir /home/git/bin \
  && git clone https://github.com/sitaramc/gitolite \
  && /home/git/gitolite/install -ln
EXPOSE 22
VOLUME [ "/home/git" ]
USER root
COPY docker-entrypoint.sh /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
