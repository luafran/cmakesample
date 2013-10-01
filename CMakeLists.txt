CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

project(cmake_demo)
# Appends the cmake/modules path inside the MAKE_MODULE_PATH variable which stores the
# directories of additional CMake modules (eg MacroOutOfSourceBuild.cmake):
set(CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/build/modules ${CMAKE_MODULE_PATH})

# The macro below forces the build directory to be different from source directory
include(MacroOutOfSourceBuild)
macro_ensure_out_of_source_build("${PROJECT_NAME} requires an out of source build. Please, see README.")

# All artifacts are dumped in output directory.
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/output)
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/output)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/output)

enable_testing()
#find_package(GTest REQUIRED)
#find_package(GMock REQUIRED)
add_subdirectory(lib)
add_subdirectory(src)
