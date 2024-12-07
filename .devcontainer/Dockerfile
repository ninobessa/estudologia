ARG VARIANT="3.3.6"
FROM ghcr.io/rails/devcontainer/images/ruby:${VARIANT}

RUN sudo apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && sudo apt-get install -y --no-install-recommends \
        build-essential gnupg2 tar git zsh libssl-dev zlib1g-dev libyaml-dev curl libreadline-dev \
        postgresql-client postgresql-contrib libpq-dev \
        ffmpeg mupdf mupdf-tools libvips-dev poppler-utils \
        libxml2-dev sqlite3 imagemagick \
    && sudo apt-get clean \
    && sudo rm -rf /var/lib/apt/lists/*

USER vscode
ENV ASDF_DIR="/home/vscode/.asdf"
ENV PATH="$ASDF_DIR/bin:$ASDF_DIR/shims:$PATH"

RUN git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR --branch v0.14.1 \
    && echo '. $ASDF_DIR/asdf.sh' >> /home/vscode/.zshrc \
    && echo '. $ASDF_DIR/completions/asdf.zsh' >> /home/vscode/.zshrc \
    && $ASDF_DIR/bin/asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git

ARG RUBY_VERSION="3.3.6"
RUN $ASDF_DIR/bin/asdf install ruby $RUBY_VERSION \
    && $ASDF_DIR/bin/asdf global ruby $RUBY_VERSION \
    && ruby -v

RUN echo 'gem: --no-document' >> /home/vscode/.gemrc
