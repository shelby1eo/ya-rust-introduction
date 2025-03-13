FROM ubuntu:24.04
ARG USRNAME={USRNAME}
ARG USR_UID={USR_UID}
ARG USR_GID={USR_GID}
ARG REPO_PATH={REPO_PATH}

# Activate bash color in terminal
ENV force_color_prompt=yes

RUN apt update && apt upgrade -y && apt install -y software-properties-common \
  && add-apt-repository ppa:fish-shell/release-4

RUN apt update && apt install -y \
    build-essential \
    curl \
    fish \
    git \
    git-lfs \
    ripgrep \
    sudo \
    tmux \
    tree \
    unzip \
    vim \
    wget


# Ubuntu 24.04 has already the user 1000(ubuntu) and the group users(100) 1000(ubuntu).
# Add user if not using default uid like in a enterprise.
# otherwise rename the user ubuntu with the current username.
RUN \
  if [ $USR_UID -eq 1000 ]; then \
    usermod --login $USRNAME ubuntu; \
    usermod --move-home --home /home/$USRNAME $USRNAME; \
  else \
    useradd --no-log-init --uid $USR_UID -m $USRNAME; \
  fi

# Allow user to run sudo and set default password
RUN groupadd admin \
  && usermod -aG admin $USRNAME \
  && echo "$USRNAME ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USRNAME

USER $USRNAME
WORKDIR ${REPO_PATH}

# make fish to generate the .config/fish
RUN fish -c "ls"
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# install nvim based on nvchad
COPY --chown=$USRNAME docker_build_files/nvim/ /home/$USRNAME/.config/nvim
# get last tarball release of neovim
RUN cd /tmp \
  && mkdir /home/$USRNAME/bin \
  && curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
  && tar -C /home/$USRNAME/bin -xzf nvim-linux-x86_64.tar.gz \
  && rm /tmp/nvim-linux-x86_64.tar.gz \
  && echo export PATH="\$PATH:/home/$USRNAME/bin/nvim-linux-x86_64/bin" >> /home/$USRNAME/.bashrc \
  && echo "set -x PATH ~/.cargo/bin \$PATH" >> /home/$USRNAME/.config/fish/config.fish

ENTRYPOINT ["fish"]
