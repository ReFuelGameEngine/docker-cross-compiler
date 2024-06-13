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
        curl \
        dotnet-sdk-6.0 \
        gcc-arm-linux-gnueabihf \
        gcc-aarch64-linux-gnu \
        gcc-i686-linux-gnu \
        git \
        libbz2-dev \
        libharfbuzz-dev \
        libpng-dev \
        libssl-dev \
        libxml2-dev \
        llvm \
        lzma-dev \
        mingw-w64 \
        meson \
        nuget \
        ninja-build \
        nodejs \
        patch \
        python3 \
        uuid \
        xz-utils \
        zlib1g-dev

    # Clone osxcross
    # Let's do this later.
    RUN git clone --recurse-submodules "https://github.com/tpoechtrager/osxcross.git" osxcross

    # Download packaged SDK from this random github (very safe i know)
    WORKDIR /root/osxcross/tarballs
    RUN wget "https://github.com/joseluisq/macosx-sdks/releases/download/14.0/MacOSX14.0.sdk.tar.xz" -O "MacOSX14.0.sdk.tar.xz"
    
    WORKDIR /root/osxcross
    ENV UNATTENDED=1 TARGET_DIR=/usr/local SDK_DIR=/usr/local/osxcross-sdk
    RUN bash -c "./build.sh"

# Setup interactive shell.
    # Setup sudo. Remove password prompt for group "wheel".
    RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/refuel_sudo_conf

    # Create a default user and switch.
    RUN adduser --comment "" --disabled-password refuel
    RUN addgroup wheel
    RUN usermod -aG wheel refuel
    USER refuel
    WORKDIR /home/refuel

    # Copy bashrc
    RUN cp /etc/bash.bashrc ~/.bashrc
    COPY sh/bashrc.sh /home/refuel/.bashrc

# Execute an interactive shell.
CMD bash
