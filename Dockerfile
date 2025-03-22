FROM ubuntu:24.04
ARG USRNAME=
ARG USR_UID=
ARG USR_GID=
ARG REPO_PATH=
ARG HTTP_PROXY=
ARG HTTPS_PROXY=
ARG AQUASCOPE_VERSION=0.3.4
ARG MDBOOK_VERSION=0.4.47
ARG AQUASCOPE_TOOLCHAIN=nightly-2023-08-25
ENV DEBIAN_FRONTEND=noninteractive

# set proxy for docker build
ENV https_proxy=$HTTPS_PROXY
ENV http_proxy=$HTTP_PROXY
# Activate bash color in terminal
ENV force_color_prompt=yes

RUN apt update && apt upgrade -y && apt install -y software-properties-common \
  && add-apt-repository ppa:fish-shell/release-4

RUN \
    apt update && apt install -y \
    build-essential \
    curl \
    fish \
    git \
    git-lfs \
    iproute2 \
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
  if [ ${USR_UID} -eq 1000 ]; then \
    usermod --login ${USRNAME} ubuntu; \
    usermod --move-home --home /home/${USRNAME} ${USRNAME}; \
  else \
    useradd --no-log-init --uid ${USR_UID} -m ${USRNAME}; \
  fi

# Allow user to run sudo and set default password
RUN \
     groupadd admin \
  && usermod -aG admin ${USRNAME} \
  && echo "${USRNAME} ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/${USRNAME}

USER ${USRNAME}
WORKDIR ${REPO_PATH}

# make fish to generate the .config/fish
RUN fish -c "ls"
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# install nvim based on nvchad
COPY --chown=${USRNAME} docker_build_files/nvim/ /home/${USRNAME}/.config/nvim

SHELL ["/bin/bash", "-l", "-c"]
# neovim last
RUN \
     cd /tmp \
  && mkdir /home/${USRNAME}/bin \
  && curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz \
  && tar -C /home/${USRNAME}/bin -xzf nvim-linux-x86_64.tar.gz \
  && rm /tmp/nvim-linux-x86_64.tar.gz \
  && echo "export PATH=/home/${USRNAME}/bin/nvim-linux-x86_64/bin:\$PATH" >> /home/$USRNAME/.bashrc \
  && echo "set -x PATH ~/bin ~/.cargo/bin ~/bin/nvim-linux-x86_64/bin \$PATH" >> /home/${USRNAME}/.config/fish/config.fish

# inspired by: https://github.com/cognitive-engineering-lab/rust-book/blob/main/.github/workflows/main.yml
RUN  \
     curl -sSL https://github.com/rust-lang/mdBook/releases/download/v${MDBOOK_VERSION}/mdbook-v${MDBOOK_VERSION}-x86_64-unknown-linux-gnu.tar.gz | tar -xz --directory=/home/${USRNAME}/bin \
  && curl -sSL https://github.com/cognitive-engineering-lab/aquascope/releases/download/v${AQUASCOPE_VERSION}/aquascope-x86_64-unknown-linux-gnu.tar.gz | tar -xz --directory=/home/${USRNAME}/bin

# use login shell inorder to have .hashrc sourced.
RUN \
     rustup set profile minimal \
  && rustup toolchain install 1.81 -c rust-docs,rust-analyzer \
  && rustup default 1.81 \
  && rustup toolchain install ${AQUASCOPE_TOOLCHAIN} -c rust-src,rustc-dev,llvm-tools-preview,miri,rust-analyzer \
  && cargo +${AQUASCOPE_TOOLCHAIN} miri setup \
  && echo "set -x LD_LIBRARY_PATH $($(rustup which --toolchain ${AQUASCOPE_TOOLCHAIN} rustc) --print target-libdir) \$LD_LIBRARY_PATH" >> /home/${USRNAME}/.config/fish/config.fish

# remove proxy var from the image
ENV https_proxy=
ENV http_proxy=

ENTRYPOINT ["bash", "-l", "-c"]
CMD ["mdbook build"]
