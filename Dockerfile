FROM debian:10.5

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ca-certificates \
      build-essential \
      locales \
      python3 \
      python3-dev \
      libncurses-dev \
      gdb \
      lldb \
      make \
      curl \
      git \
      less \
      man \
      manpages \
      manpages-dev \
      procps \
      && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen en_US.UTF-8

COPY ./deps/vim /tmp/vim

RUN cd /tmp/vim && \
    ./configure \
      --with-features=huge \
      --enable-multibyte \
      --with-tlib=ncurses \
      --enable-cscope \
      --enable-terminal \
      --enable-python3interp \
      --enable-gui=no \
      --without-x \
      --with-python3-config-dir=/usr/lib/python3.7/config-3.7m-x86_64-linux-gnu/ \
      --enable-fail-if-missing \
      && \
    make -C src && \
    make -C src install

COPY . /app
RUN make -C /app install
