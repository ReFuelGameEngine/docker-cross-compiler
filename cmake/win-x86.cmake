# ReFuel Toolchain file for Windows-x86 systems.
# Copyright (C) 2023

set(CMAKE_SYSTEM_NAME Windows)

set(CMAKE_C_COMPILER   i686-w64-mingw32-gcc)
set(CMAKE_CXX_COMPILER i686-w64-mingw32-g++)

set(CMAKE_FIND_ROOT_PATH "/usr/i686-w64-mingw32")
add_compile_options(-m32)

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
