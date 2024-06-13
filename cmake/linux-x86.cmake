# QUIK Toolchain file for Linux-x86 (i386) systems.
# Copyright (C) 2023

set(CMAKE_SYSTEM_NAME Linux)

set(CMAKE_C_COMPILER i686-linux-gnu-gcc)
set(CMAKE_CXX_COMPILER i686-linux-gnu-g++)

add_compile_options(-m32 -march=i686)

set(CMAKE_FIND_ROOT_PATH "/usr/i686-linux-gnu")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
