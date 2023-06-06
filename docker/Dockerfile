FROM debian:bookworm

# Should we check that locales is installed? aptitude install locales
# Set all variables that affect programs to follow same encoding
ENV LANG=C.UTF-8 LANGUAGE=C.UTF-8 LC_ALL=C.UTF-8

# libgtk-3-0 dependency added because Firefox installation from conda-forge 
# depends on this library and it wasn't available in the base container

RUN apt-get update --fix-missing \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        wget \
        bzip2 \
        ca-certificates \
        curl \
        bash \
        chromium \
        chromium-driver \
        build-essential \
        libgtk-3-0 \
        git \
        fonts-indic \
        fonts-noto \
        fonts-noto-cjk \
        zip \
        libdbus-glib-1-2 \
        wkhtmltopdf \
        xvfb \
        libreoffice \
        unoconv \
    && export PATH=$PATH:/usr/lib/chromium-browser/ \
    && echo "Chromium Version: " && chromium --product-version && chromedriver --version \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* \
    && echo "Installed Packages: " && dpkg -l

RUN useradd --no-log-init --system --create-home --shell /bin/bash worker

# Running as non sudo user 'worker'
USER worker
WORKDIR /home/worker

RUN mkdir -p /home/worker/bin && \
    mkdir -p /home/worker/.robocorp && \
    mkdir -p /home/worker/bin/conda && \
    mkdir -p /home/worker/instance

COPY ./start.sh start.sh

RUN curl --silent --show-error --fail -o /home/worker/bin/robocorp-workforce-agent-core https://downloads.robocorp.com/workforce-agent-core/releases/latest/linux64/robocorp-workforce-agent-core
RUN chmod +x /home/worker/bin/robocorp-workforce-agent-core

# initialize the Agent Core and build default environment
RUN /home/worker/bin/robocorp-workforce-agent-core init --log-level TRACE --rcc-exec-path /home/worker/bin/rcc \
    && rm -rf /home/worker/.robocorp/base
RUN /home/worker/bin/rcc robot initialize --directory /home/worker/default_env --template standard \
    && /home/worker/bin/rcc holotree variables --space workforce --controller agent.core.container --liveonly --timeline /home/worker/default_env/conda.yaml \
    && rm -rf /home/worker/.robocorp/holotree/v*h \
    && rm -rf /home/worker/.robocorp/hololib \
    && rm -rf /home/worker/.robocorp/pipcache \
    && rm -rf /home/worker/.robocorp/pkgs \
    && rm -rf /home/worker/default_env \
    && rm -f .robocorp/templates/*

CMD [ "./start.sh" ]