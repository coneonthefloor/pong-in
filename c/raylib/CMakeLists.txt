cmake_minimum_required(VERSION 3.25)

set(CMAKE_TOOLCHAIN_FILE ${CMAKE_CURRENT_SOURCE_DIR}/vcpkg/scripts/buildsystems/vcpkg.cmake)
list(APPEND CMAKE_PREFIX_PATH ${CMAKE_CURRENT_SOURCE_DIR}/vcpkg/installed/x64-windows/share/raylib)

project(Cong C)

find_package(raylib "4.5.0" REQUIRED)

set(CMAKE_C_STANDARD 11)

add_subdirectory(Cong)
