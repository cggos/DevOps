add_definitions(-w)

set(CMAKE_SYSTEM_NAME Linux)

# Configure cmake to look for libraries, include directories and packages inside the target root prefix.
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CMAKE_FIND_ROOT_PATH "${INSTALL_ROOT}")

if(PLATFORM_ARCH STREQUAL "aarch64")
  set(CMAKE_SYSTEM_PROCESSOR aarch64)

  set(TARGET_ARCH aarch64-none-linux-gnu)
  set(CMAKE_LIBRARY_ARCHITECTURE ${TARGET_ARCH} CACHE STRING "" FORCE)

  set(CMAKE_FIND_ROOT_PATH "/opt/rk_toolchain ${INSTALL_ROOT}")
  find_program(CMAKE_C_COMPILER ${TARGET_ARCH}-gcc)
  find_program(CMAKE_CXX_COMPILER ${TARGET_ARCH}-g++)

  # needed to avoid doing some more strict compiler checks that are failing when cross-compiling
  # set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
  set(CMAKE_AR ${TARGET_ARCH}-ar CACHE FILEPATH "" FORCE)
  set(CMAKE_RANLIB ${TARGET_ARCH}-ranlib)
  set(CMAKE_LINKER ${TARGET_ARCH}-ld)

  # Not all shared libraries dependencies are instaled in host machine.
  # Make sure linker doesn't complain.
  set(CMAKE_EXE_LINKER_FLAGS_INIT -Wl,--allow-shlib-undefined)

  # set(CMAKE_C_FLAGS "-mcpu=cortex-m3 -mthumb")
  # set(CMAKE_CXX_FLAGS "-mcpu=cortex-m3 -mthumb")
  # set(CMAKE_EXE_LINKER_FLAGS "-T/path/to/linker_script.ld")

  # instruct nvcc to use our cross-compiler
  # set(CMAKE_CUDA_FLAGS "-ccbin ${CMAKE_CXX_COMPILER} -Xcompiler -fPIC" CACHE STRING "" FORCE)
endif()

if(LIB_NAME STREQUAL "sophus" OR LIB_NAME STREQUAL "ceres_solver")
  set($ENV{PKG_CONFIG_PATH} "${INSTALL_ROOT}/eigen3/share/pkgconfig/")
  set(Eigen3_DIR "${INSTALL_ROOT}/eigen3/share/eigen3/cmake/")
endif()

if(LIB_NAME STREQUAL "flann" OR LIB_NAME STREQUAL "pcl" OR LIB_NAME STREQUAL "vrlm_vp")
  include_directories(${INSTALL_ROOT}/lz4/include)
  link_directories(${INSTALL_ROOT}/lz4/lib)
endif()

if(LIB_NAME STREQUAL "pcl")
  # set(Boost_DIR "${INSTALL_ROOT}/boost/lib/cmake/Boost-1.81.0/")
  # set(boost_atomic_DIR "${INSTALL_ROOT}/boost/lib/cmake/boost_atomic-1.81.0/")
  # set(boost_headers_DIR "${INSTALL_ROOT}/boost/lib/cmake/boost_headers-1.81.0/")
  # set(boost_filesystem_DIR "${INSTALL_ROOT}/boost/lib/cmake/boost_filesystem-1.81.0/")
  # set(boost_date_time_DIR "${INSTALL_ROOT}/boost/lib/cmake/boost_date_time-1.81.0/")
  # set(boost_iostreams_DIR "${INSTALL_ROOT}/boost/lib/cmake/boost_iostreams-1.81.0/")
  # set(boost_system_DIR "${INSTALL_ROOT}/boost/lib/cmake/boost_system-1.81.0/")
  set(Boost_LIBRARY_DIR "${INSTALL_ROOT}/boost/lib")
  set(Boost_INCLUDE_DIR "${INSTALL_ROOT}/boost/include")

  set(flann_DIR "${INSTALL_ROOT}/flann/lib/cmake/flann/")
endif()

message("\n--------------------------------- toolchain_aarch64.cmake ---------------------------------")

if(PLATFORM_ARCH STREQUAL "aarch64")
  message("TARGET_ARCH: ${TARGET_ARCH}")

  if(NOT CMAKE_C_COMPILER OR NOT CMAKE_CXX_COMPILER)
    message(FATAL_ERROR "Can't find suitable C/C++ cross compiler for ${TARGET_ARCH}")
  else()
    message("")
    message("CMAKE_C_COMPILER:   ${CMAKE_C_COMPILER}")
    message("CMAKE_CXX_COMPILER: ${CMAKE_CXX_COMPILER}")
    message("")
  endif()
endif()

message("PLATFORM_ARCH: ${PLATFORM_ARCH} \n")
message("CMAKE_SYSTEM_PROCESSOR: ${CMAKE_SYSTEM_PROCESSOR}\n")
message("CMAKE_HOST_SYSTEM_PROCESSOR: ${CMAKE_HOST_SYSTEM_PROCESSOR}")

message("--------------------------------- toolchain_aarch64.cmake ---------------------------------\n")
