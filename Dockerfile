# Available workspace images can be found at https://github.com/gitpod-io/workspace-images.
FROM gitpod/workspace-postgres:latest

USER root

RUN apt update

# Used for installing brew (https://docs.brew.sh/Homebrew-on-Linux)
#
# We use brew as the package manager until https://github.com/gitpod-io/gitpod/issues/39 is resolved.
# If necessary, you can add more packages to "apt install" in the Dockerfile. However, brew
# can provide much more flexibility in the middle of working.
RUN add-apt-repository ppa:git-core/ppa -y
RUN apt install -y software-properties-common build-essential curl file git

USER gitpod

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

# Install any other packages at root.
USER root

RUN add-apt-repository ppa:longsleep/golang-backports -y

ENV GO_VERSION="1.12"

RUN wget https://dl.google.com/go/go${GO_VERSION}.linux-amd64.tar.gz
RUN tar -C /usr/lib -xzf go${GO_VERSION}.linux-amd64.tar.gz && rm go${GO_VERSION}.linux-amd64.tar.gz

RUN apt install -y libpq-dev redis-server libicu-dev cmake g++ libre2-dev libkrb5-dev libsqlite3-dev \
    zip ed pkg-config graphicsmagick runit libimage-exiftool-perl rsync libssl-dev
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt install -y ./google-chrome-stable_current_amd64.deb

RUN wget https://chromedriver.storage.googleapis.com/79.0.3945.36/chromedriver_linux64.zip
RUN unzip -D chromedriver_linux64.zip && rm chromedriver_linux64.zip && mv chromedriver /usr/lib/chromedriver

ENV PATH="/usr/lib:/usr/lib/go/bin:$PATH"

RUN curl https://cli-assets.heroku.com/install.sh | sh
RUN curl -L https://get.rvm.io | bash -s stable
RUN usermod -a -G rvm gitpod
