# ReFuel Toolchain file for OSX-ARM64 systems.
# Copyright (C) 2024

set(CMAKE_SYSTEM_NAME OSX)

set(CMAKE_C_COMPILER x86_64-apple-darwin23-clang)
set(CMAKE_CXX_COMPILER x86_64-apple-darwin23-clang++)

set(CMAKE_FIND_ROOT_PATH "/usr/local/SDK/MacOSX14.0.sdk/usr"
                         "/usr/local/SDK/MacOSX14.0.sdk/System")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
