FROM gitpod/workspace-postgres:latest

USER root

RUN apt-get update
RUN add-apt-repository ppa:git-core/ppa -y
RUN apt-get install -y software-properties-common build-essential curl file git

RUN curl -L https://get.rvm.io | bash -s stable

USER gitpod
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

USER root
