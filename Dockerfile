# This is going to create an environment for you to cross compile all the
# packages needed to build this project.
#
# As always, debian > ubuntu <3
FROM debian:stable-slim
WORKDIR /root

# Set host name.
RUN echo docker_cross_compiler > /etc/hostname

# Download and Install dependencies.
    # Install WGET
    RUN apt-get update
    RUN apt-get install -y sudo wget

    # Add the .NET package repository to the repository listing.
    RUN wget https://packages.microsoft.com/config/debian/11/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
    RUN dpkg -i packages-microsoft-prod.deb
    RUN rm packages-microsoft-prod.deb

    # APT dependencies.
    RUN apt-get update
    RUN apt-get install -y \
        build-essential \
        bzip2 \
        cmake \
        clang \
        cpio \
        dotnet-sdk-6.0 \
        gcc-arm-linux-gnueabihf \
        gcc-aarch64-linux-gnu \
        gcc-i686-linux-gnu \
        git \
        libharfbuzz-dev \
        libpng-dev \
        libssl-dev \
        libxml2-dev \
        lzma-dev \
        mingw-w64 \
        meson \
        nuget \
        ninja-build \
        node \
        patch \
        python3 \
        xz-utils \
        zlib1g-dev

    # Clone osxcross
    # Let's do this later.
    # RUN git clone https://github.com/tpoechtrager/osxcross.git osxcross

# Setup interactive shell.
    # Setup sudo. Remove password prompt for group "wheel".
    RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/quik_sudo_conf

    # Create a default user and switch.
    RUN adduser --comment "" --disabled-password quik
    USER quik
    WORKDIR /home/quik

    # Copy bashrc
    RUN cp /etc/bash.bashrc ~/.bashrc
    RUN echo source $HOME/src/sh/bashrc.sh >> ~/.bashrc

# Execute an interactive shell.
CMD bash
