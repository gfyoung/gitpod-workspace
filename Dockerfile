FROM gitpod/workspace-full:latest

USER root

RUN apt-get update
RUN add-apt-repository ppa:git-core/ppa -y
RUN apt-get install -y software-properties-common build-essential curl file git

RUN curl -L https://get.rvm.io | bash -s stable

USER gitpod

# We use brew as the package manager until https://github.com/gitpod-io/gitpod/issues/39 is resolved.
# If necessary, you can add more packages to "apt-get install" in the Dockerfile. However, brew
# can provide much more flexibility in the middle of working.
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

USER root
