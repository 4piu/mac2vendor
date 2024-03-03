cmake_minimum_required(VERSION 3.25)
project(mac2vendor)

set(CMAKE_CXX_STANDARD 20)

set(CMAKE_CXX_FLAGS "-Wall -Wextra")
set(CMAKE_CXX_FLAGS_RELEASE "-O0")

add_custom_command(
    OUTPUT "${CMAKE_SOURCE_DIR}/db/ma.h"
    COMMAND "${CMAKE_SOURCE_DIR}/gen_header.sh"
    WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
    COMMENT "Downloading CSV and generating ma.h"
)

add_custom_target(
    GenerateHeader ALL
    DEPENDS "${CMAKE_SOURCE_DIR}/db/ma.h"
)

add_executable(mac2vendor main.cpp)

add_dependencies(${PROJECT_NAME} GenerateHeader)