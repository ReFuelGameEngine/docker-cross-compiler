# QUIK Toolchain file for Linux-x64 (amd64) systems.
# Copyright (C) 2023

set(CMAKE_SYSTEM_NAME Linux)

set(CMAKE_C_COMPILER gcc)
set(CMAKE_CXX_COMPILER g++)

add_compile_options(-m64)
