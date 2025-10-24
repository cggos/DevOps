#!/usr/bin/env bash
set -e

param_num=$#
if [ $param_num -ne 3 ]; then
  echo "Usage:
        mkdir build & cd build
        build.sh <platform-arch> <lib-name> <lib-src-dir>

    platform-arch: aarch64 x86-64
  "
  exit
fi

if [ -z ${CG_THIRDPARTY} ]; then
  echo "ENV CG_THIRDPARTY NOT set!!! Try export CG_THIRDPARTY, e.g. export CG_THIRDPARTY=/opt/3rdparty"
  exit
fi

########################################## Vars ##########################################

function cur_abs_path {
  dirname $(readlink -f "$0")
}

PLATFORM_ARCH="$1"
# ROOT_PWD=$( cd "$( dirname $0 )" && cd -P "$( dirname "$SOURCE" )" && pwd )
# EXE_ROOT=${EXE_PATH%/*}
EXE_ROOT=$(cur_abs_path)
# LIB_NAME=${BUILD_DIR##*/}
LIB_NAME="$2"
LIB_SRC="$3"
BUILD_DIR=$(pwd)/${LIB_NAME}
INSTALL_ROOT=${CG_THIRDPARTY}/${PLATFORM_ARCH}
INSTALL_DIR=${INSTALL_ROOT}/${LIB_NAME}

TOOL_CHAIN_CMAKE="${EXE_ROOT}/toolchain_aarch64.cmake"

echo "
--------------------------------- build.sh vars ---------------------------------
CG_THIRDPARTY:  ${CG_THIRDPARTY}
EXE_ROOT:       ${EXE_ROOT}

LIB_NAME:       ${LIB_NAME}
LIB_SRC:        ${LIB_SRC}
BUILD_DIR:      ${BUILD_DIR}

INSTALL_ROOT:   ${INSTALL_ROOT}
INSTALL_DIR:    ${INSTALL_DIR}
--------------------------------- build.sh vars ---------------------------------
"

if [ ${PLATFORM_ARCH} == "aarch64" ]; then
  TARGET_ARCH=aarch64-none-linux-gnu
  GNU_C_COMPLILER=${TOOL_CHAIN}/bin/${TARGET_ARCH}-gcc
  GNU_CXX_COMPLILER=${TOOL_CHAIN}/bin/${TARGET_ARCH}-g++

  export PATH=$PATH:${TOOL_CHAIN}/bin
  export LD_LIBRARY_PATH=${TOOL_CHAIN}/lib64:$LD_LIBRARY_PATH

  echo "
--------------------------------- build.sh vars aarch64 ---------------------------------
TOOL_CHAIN_CMAKE:  ${TOOL_CHAIN_CMAKE}

ENV TOOL_CHAIN:    ${TOOL_CHAIN}

GNU_C_COMPLILER:   ${GNU_C_COMPLILER}
GNU_CXX_COMPLILER: ${GNU_CXX_COMPLILER}
--------------------------------- build.sh vars aarch64 ---------------------------------
"
fi

########################################## CMAKE_DEFINES ##########################################

CMAKE_DEFINES="
  -Wno-dev \
  -D CMAKE_BUILD_TYPE=Release \
  -D CMAKE_C_STANDARD=11 \
  -D CMAKE_CXX_STANDARD=17 \
  -D CMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
  -D CPACK_OUTPUT_FILE_PREFIX=${INSTALL_ROOT} \
  -D PLATFORM_ARCH=${PLATFORM_ARCH} \
  -D LIB_NAME=${LIB_NAME} \
  -D INSTALL_ROOT=${INSTALL_ROOT}"
# -D CMAKE_FIND_DEBUG_MODE=ON

if [ ${PLATFORM_ARCH} == "aarch64" ]; then
  CMAKE_DEFINES="${CMAKE_DEFINES} \
    -D CMAKE_C_COMPILER=${GNU_C_COMPLILER} \
    -D CMAKE_CXX_COMPILER=${GNU_CXX_COMPLILER} \
    -D CMAKE_TOOLCHAIN_FILE=${TOOL_CHAIN_CMAKE}"
fi

# if [ ${LIB_NAME} == "app_name" ]; then
#   CMAKE_DEFINES="${CMAKE_DEFINES} \
#     -D foonathan_memory_DIR=${INSTALL_ROOT}/foonathan_memory/lib/foonathan_memory/cmake \
#     -D EIGEN_INCLUDE_DIR=${INSTALL_ROOT}/eigen3/include/eigen3"

#   if [ ${PLATFORM_ARCH} == "aarch64" ]; then
#     CMAKE_DEFINES="${CMAKE_DEFINES} \
#     -D VP_BUILD_TEST=OFF \
#     -D VP_WITH_IO_SERIAL=OFF \
#     -D VP_WITH_IO_FASTDDS=OFF \
#     -D VP_WITH_DL_RKNN=ON \
#     -D VP_WITH_DL_TORCH=OFF \
#     -D VP_WITH_DL_TRT=OFF"
#   fi

#   if [ ${PLATFORM_ARCH} == "x86-64" ]; then
#     CMAKE_DEFINES="${CMAKE_DEFINES} \
#     -D VP_BUILD_TEST=ON \
#     -D VP_WITH_CAM_T265=OFF \
#     -D VP_WITH_IO_SERIAL=ON \
#     -D VP_WITH_IO_FASTDDS=OFF \
#     -D VP_WITH_DL_RKNN=OFF \
#     -D VP_WITH_DL_TORCH=ON \
#     -D VP_WITH_DL_TRT=OFF"
#   fi
# fi

if [ ${LIB_NAME} == "spdlog" ]; then
  CMAKE_DEFINES="${CMAKE_DEFINES} \
    -D CMAKE_POSITION_INDEPENDENT_CODE=ON \
    -D SPDLOG_BUILD_PIC=ON /
    -D SPDLOG_BUILD_SHARED=ON /
    -D SPDLOG_BUILD_EXAMPLE=OFF"
fi

if [ ${LIB_NAME} == "sophus" ]; then
  CMAKE_DEFINES="${CMAKE_DEFINES} \
    -D SOPHUS_USE_BASIC_LOGGING=ON \
    -D BUILD_SOPHUS_EXAMPLES=OFF \
    -D BUILD_SOPHUS_TESTS=OFF"
fi

if [ ${LIB_NAME} == "libsvm" ]; then
  cd ${LIB_SRC}
  make clean
  if [ ${PLATFORM_ARCH} == "x86-64" ]; then
    make lib
  fi
  if [ ${PLATFORM_ARCH} == "aarch64" ]; then
    make lib CC=${GNU_C_COMPLILER} CXX=${GNU_CXX_COMPLILER}
  fi
  cp svm.h ${INSTALL_DIR}/include/libsvm/
  cp libsvm.so* ${INSTALL_DIR}/lib
  cd -
  exit
fi

if [ ${LIB_NAME} == "lz4" ]; then
  CMAKE_DEFINES="${CMAKE_DEFINES} \
    -D LZ4_BUILD_CLI=OFF \
    -D LZ4_BUILD_LEGACY_LZ4C=OFF"
fi

if [ ${LIB_NAME} == "flann" ]; then
  # export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:${INSTALL_ROOT}/lz4/lib/pkgconfig/
  CMAKE_DEFINES="${CMAKE_DEFINES} \
    -D BUILD_PYTHON_BINDINGS=OFF \
    -D BUILD_MATLAB_BINDINGS=OFF \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_TESTS=OFF \
    -D BUILD_DOC=OFF"
fi

if [ ${LIB_NAME} == "boost" ]; then
  cd ${LIB_SRC}
  ./bootstrap.sh \
    --with-libraries=filesystem,iostreams,system,date_time,serialization,mpi,regex,python \
    --with-python=/usr/bin/python3 \
    --prefix=${INSTALL_ROOT}/boost
  if [ ${PLATFORM_ARCH} == "x86-64" ]; then
    sudo ./b2 install
  fi
  if [ ${PLATFORM_ARCH} == "aarch64" ]; then
    # create or edit user-config.jam
    user_config_jam=${EXE_ROOT}/boost/user-config.jam
    echo "using gcc : : ${GNU_C_COMPLILER} : ;" >${user_config_jam}
    echo "============= user_config_jam: ${user_config_jam}"
    # ./b2 --user-config=${user_config_jam}
    sudo ./b2 install --user-config=${user_config_jam}
  fi
  cd -
  exit
fi

# for OpenCV 4.2: BUILD_opencv_gapi
if [ ${LIB_NAME} == "opencv" ]; then
  CMAKE_DEFINES="${CMAKE_DEFINES} \
    -D BUILD_LIST=highgui,calib3d,videoio,gapi,ml,dnn,shape,quality,tracking,aruco,ccalib,line_descriptor,stitching,stereo,rgbd,structured_light \
    -D BUILD_SHARED_LIBS=ON \
    -D BUILD_DOCS=OFF \
    -D BUILD_TESTS=OFF \
    -D BUILD_PERF_TESTS=OFF \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_opencv_apps=OFF \
    -D BUILD_opencv_python2=OFF \
    -D BUILD_opencv_python3=OFF \
    -D WITH_MATLAB=OFF \
    -D WITH_VTK=OFF \
    -D WITH_V4L=ON \
    -D WITH_FFMPEG=ON \
    -D WITH_TBB=OFF \
    -D WITH_IPP=OFF \
    -D WITH_OPENMP=ON \
    -D WITH_PTHREADS_PF=ON \
    -D WITH_OPENGL=OFF \
    -D WITH_OPENCL=ON \
    -D WITH_CUDA=OFF \
    -D CUDA_GENERATION=Kepler \
    -D CV_ENABLE_INTRINSICS=ON \
    -D CV_DISABLE_OPTIMIZATION=OFF \
    -D ENABLE_PROFILING=ON \
    -D ENABLE_PRECOMPILED_HEADERS=OFF \
    -D OPENCV_EXTRA_MODULES_PATH=${LIB_SRC}/../opencv_contrib-4.8.0/modules/"
  if [ ${PLATFORM_ARCH} == "aarch64" ]; then
    CMAKE_DEFINES="${CMAKE_DEFINES} \
      -D ENABLE_NEON=ON \
      -D CPU_BASELINE=NEON \
      -D CPU_BASELINE_REQUIRE=NEON \
      -D CPU_DISPATCH=NEON \
      -D CMAKE_TOOLCHAIN_FILE=${LIB_SRC}/platforms/linux/aarch64-gnu.toolchain.cmake"
  else
    CMAKE_DEFINES="${CMAKE_DEFINES} \
      -D CPU_BASELINE=AVX2"
  fi
fi

if [ ${LIB_NAME} == "pcl" ]; then
  CMAKE_DEFINES="${CMAKE_DEFINES} \
    -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_CXX_STANDARD=17 \
    -D CMAKE_CUDA_STANDARD=14 \
    -D BUILD_CUDA=OFF \
    -D BUILD_GPU=OFF \
    -D BUILD_common=ON \
    -D BUILD_io=ON \
    -D BUILD_2d=ON \
    -D BUILD_features=ON \
    -D BUILD_keypoints=OFF \
    -D BUILD_filters=ON \
    -D BUILD_stereo=ON \
    -D BUILD_ml=ON \
    -D BUILD_kdtree=ON \
    -D BUILD_octree=ON \
    -D BUILD_outofcore=OFF \
    -D BUILD_people=OFF \
    -D BUILD_recognition=OFF \
    -D BUILD_registration=ON \
    -D BUILD_search=ON \
    -D BUILD_tracking=OFF \
    -D BUILD_sample_consensus=ON \
    -D BUILD_geometry=ON \
    -D BUILD_surface=OFF \
    -D BUILD_segmentation=ON \
    -D BUILD_visualization=OFF \
    -D BUILD_tools=OFF \
    -D BUILD_apps=OFF \
    -D BUILD_examples=OFF \
    -D BUILD_benchmarks=OFF \
    -D BUILD_global_tests=OFF \
    -D BUILD_simulation=OFF \
    -D WITH_VTK=OFF \
    -D WITH_PCAP=OFF \
    -D WITH_OPENGL=OFF \
    -D WITH_LIBUSB=OFF \
    -D WITH_OPENNI=OFF \
    -D WITH_OPENNI2=OFF \
    -D WITH_RSSDK=OFF \
    -D WITH_RSSDK2=OFF \
    -D PCL_SHARED_LIBS=ON \
    -D EIGEN_INCLUDE_DIR=${INSTALL_ROOT}/eigen3/include/eigen3"
  export PKG_CONFIG_PATH=${PKG_CONFIG_PATH}:${INSTALL_ROOT}/eigen3/share/pkgconfig/
fi

if [ ${LIB_NAME} == "tbb" ]; then
  CMAKE_DEFINES="${CMAKE_DEFINES} \
    -G Ninja \
    -D BUILD_SHARED_LIBS=YES \
    -D TBB_TEST=OFF \
    -D TBB_EXAMPLES=OFF \
    -D CMAKE_CXX_FLAGS=-DTBB_ALLOCATOR_TRAITS_BROKEN"
fi

if [ ${LIB_NAME} == "dbow3" ]; then
  if [ ${PLATFORM_ARCH} == "aarch64" ]; then
    CMAKE_DEFINES="${CMAKE_DEFINES} \
      -D CMAKE_SYSTEM_PROCESSOR=arm \
      -D OpenCV_DIR=${INSTALL_ROOT}/opencv/lib/cmake/opencv4"
  fi
  CMAKE_DEFINES="${CMAKE_DEFINES} \
    -D BUILD_UTILS=OFF"
fi

if [ ${LIB_NAME} == "foonathan_memory" ]; then
  if [ ${PLATFORM_ARCH} == "aarch64" ]; then
    export CC=${GNU_C_COMPLILER}
    export CXX=${GNU_CXX_COMPLILER}
  fi
  CMAKE_DEFINES="${CMAKE_DEFINES} \
    -D BUILD_SHARED_LIBS=ON \
    -D BUILD_MEMORY_TOOLS=OFF"
fi

if [ ${LIB_NAME} == "fast_dds" ]; then
  CMAKE_DEFINES="${CMAKE_DEFINES} \
    -D BUILD_SHARED_LIBS=ON \
    -D BUILD_TESTING=OFF \
    -D THIRDPARTY=ON \
    -D THIRDPARTY_Asio=ON \
    -D THIRDPARTY_fastcdr=ON \
    -D THIRDPARTY_TinyXML2=ON \
    -D TINYXML2_FROM_SOURCE=ON \
    -D TINYXML2_SOURCE_DIR=${LIB_SRC}/thirdparty/tinyxml2/ \
    -D TINYXML2_INCLUDE_DIR=${LIB_SRC}/thirdparty/tinyxml2/ \
    -D foonathan_memory_DIR=${INSTALL_ROOT}/foonathan_memory/lib/foonathan_memory/cmake"
fi

if [ ${LIB_NAME} == "ceres_solver" ]; then
  CMAKE_DEFINES="${CMAKE_DEFINES} \
    -D MINIGLOG=ON \
    -D MINIGLOG_MAX_LOG_LEVEL=2 \
    -D GFLAGS=OFF \
    -D SUITESPARSE=OFF \
    -D CXSPARSE=OFF \
    -D CUDA=OFF \
    -D LAPACK=OFF \
    -D SCHUR_SPECIALIZATIONS=ON \
    -D CUSTOM_BLAS=ON \
    -D EIGENSPARSE=ON \
    -D BUILD_SHARED_LIBS=ON \
    -D BUILD_TESTING=OFF \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_BENCHMARKS=OFF"
fi

if [ ${LIB_NAME} == "portaudio" ]; then
  CMAKE_DEFINES="${CMAKE_DEFINES} \
    -D PA_BUILD_SHARED=ON \
    -D PA_BUILD_STATIC=OFF
    -D PA_BUILD_TESTS=OFF \
    -D PA_BUILD_EXAMPLES=OFF"
fi

echo "
--------------------------------- CMAKE_DEFINES ---------------------------------
${CMAKE_DEFINES}

--------------------------------- CMAKE_DEFINES ---------------------------------

"

########################################## cmake build, install, package ##########################################

cmake -S ${LIB_SRC} -B ${BUILD_DIR} ${CMAKE_DEFINES}
cmake --build ${BUILD_DIR} --target install/strip --parallel $(($(nproc) / 4))
# after cmake 3.15
# cmake --install ${BUILD_DIR} --prefix ${INSTALL_DIR}

if [ ${LIB_NAME} == "app_name" ]; then
  cmake --build ${BUILD_DIR} --target package
fi
