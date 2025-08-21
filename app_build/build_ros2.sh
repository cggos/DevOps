#!/usr/bin/env bash

set -e

param_num=$#
if [ $param_num -ne 1 ]; then
  echo "Usage:
        build_ros2.sh <platform-arch>

    platform-arch: aarch64 x86-64
  "
  exit
fi

PLATFORM_ARCH="$1"

sudo ldconfig

colcon build --packages-select ros2 \
  --symlink-install \
  --event-handlers console_direct+ --cmake-args -DCMAKE_VERBOSE_MAKEFILE=ON \
  --cmake-args -DOpenCV_DIR=${CG_THIRDPARTY}/${PLATFORM_ARCH}/opencv/lib/cmake/opencv4/
  # -DVP_WITH_IO_FASTDDS=ON \
  # -DBoost_DIR=${CG_THIRDPARTY}/${PLATFORM_ARCH}/boost/lib/cmake/Boost-1.81.0/
  # -DPCL_DIR=${CG_THIRDPARTY}/${PLATFORM_ARCH}/pcl/share/pcl-1.10/
