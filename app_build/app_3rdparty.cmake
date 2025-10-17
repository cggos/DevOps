# ############################### vars #################################

if(NOT DEFINED ENV{CG_THIRDPARTY})
  message(FATAL_ERROR "\n********** ENV CG_THIRDPARTY NOT Defined !!! Try export CG_THIRDPARTY, e.g. export CG_THIRDPARTY=/opt/3rdparty **********\n")
else()
  set(CG_THIRDPARTY $ENV{CG_THIRDPARTY})
endif()

set(PLATFORM_ARCH "x86-64")

message("CG_THIRDPARTY: ${CG_THIRDPARTY}")
message("PLATFORM_ARCH: ${PLATFORM_ARCH}\n")

# ############################### find_package #################################
# spdlog
# find_package(spdlog REQUIRED)
# if(spdlog_FOUND)
# # message(${spdlog_INCLUDE_DIR})
# endif()
add_definitions(-DFMT_HEADER_ONLY)

# set(TBB_DIR "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/tbb/lib/cmake/TBB")
# find_package(TBB REQUIRED)

# set(ENV{PKG_CONFIG_PATH} "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/eigen3/share/pkgconfig/")
# set(EIGEN_INCLUDE_DIR "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/eigen3/include/eigen3")
set(Eigen3_DIR "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/eigen3/share/eigen3/cmake/")
find_package(Eigen3 REQUIRED)

if(Eigen3_FOUND)
  include_directories(${EIGEN3_INCLUDE_DIR})
endif()

# Sophus
# set(Sophus_DIR "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/sophus/share/sophus/cmake/")
# find_package(Sophus REQUIRED)
# if(Sophus_FOUND)
# include_directories(${SOPHUS_INCLUDE_DIR})
# endif()
set(SOPHUS_INCLUDE_DIR $ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/sophus/include/)
include_directories(${SOPHUS_INCLUDE_DIR})
add_definitions(-DSOPHUS_USE_BASIC_LOGGING)

# set(OpenCV_DIR "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/opencv/lib/cmake/opencv4/")
# find_package(OpenCV 4 REQUIRED COMPONENTS core imgproc highgui calib3d) # gapi dnn
set(OpenCV_INCLUDE_DIRS "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/opencv/include/opencv4/")
set(OpenCV_LIBRARY_DIRS "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/opencv/lib")
set(OpenCV_LIBS 
  ${OpenCV_LIBRARY_DIRS}/libopencv_core.so
  ${OpenCV_LIBRARY_DIRS}/libopencv_imgproc.so
  ${OpenCV_LIBRARY_DIRS}/libopencv_highgui.so
  ${OpenCV_LIBRARY_DIRS}/libopencv_calib3d.so
  ${OpenCV_LIBRARY_DIRS}/libopencv_gapi.so
  ${OpenCV_LIBRARY_DIRS}/libopencv_dnn.so
)
include_directories(${OpenCV_INCLUDE_DIRS})

# find_package(PkgConfig REQUIRED)
# if(PkgConfig_FOUND)
# pkg_check_modules(YAMLCPP REQUIRED yaml-cpp)
# endif()
# set(ENV{PKG_CONFIG_PATH} "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/yaml-cpp/lib/pkgconfig/")
set(YAMLCPP_INCLUDE_DIRS $ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/yaml-cpp/include)
set(YAMLCPP_LIBRARY_DIRS $ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/yaml-cpp/lib)
include_directories(${YAMLCPP_INCLUDE_DIRS})
link_directories(${YAMLCPP_LIBRARY_DIRS})
set(YAMLCPP_LIBRARIES yaml-cpp)

# set(spdlog_DIR "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/spdlog/lib/cmake/spdlog/")
if(PLATFORM_ARCH STREQUAL "aarch64")
  include_directories("$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/spdlog/include")
  link_directories("$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/spdlog/lib")
endif()
if(PLATFORM_ARCH STREQUAL "x86-64")
  link_directories("/usr/lib/x86_64-linux-gnu") # solve conflicts with ROS2
endif()

set(dbow2_DIR "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/dbow2/lib/cmake/DBoW2")
include_directories("$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/dbow2/include")

set(ENV{PKG_CONFIG_PATH} "$ENV{PKG_CONFIG_PATH} $ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/pcl/lib/pkgconfig/")
set(flann_DIR "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/flann/lib/cmake/flann/")

if(PLATFORM_ARCH STREQUAL "aarch64")
  # set(PCL_DIR "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/pcl/share/pcl-1.13/")
  set(PCL_LIBRARY_DIRS "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/pcl/lib")
  set(PCL_INCLUDE_DIRS "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/pcl/include/pcl-1.13")
endif()

# find_package(PCL 1.13 REQUIRED COMPONENTS common io filters segmentation)
if(TRUE OR PCL_FOUND)
  set(PCL_LIBRARIES pcl_common pcl_io pcl_octree pcl_kdtree pcl_search pcl_sample_consensus pcl_filters pcl_segmentation)

  if(NOT "${PCL_LIBRARIES}" STREQUAL "")
    # For debian: https://github.com/ros-perception/perception_pcl/issues/139
    list(REMOVE_ITEM PCL_LIBRARIES
      "vtkGUISupportQt"
      "vtkGUISupportQtOpenGL"
      "vtkGUISupportQtSQL"
      "vtkGUISupportQtWebkit"
      "vtkViewsQt"
      "vtkRenderingQt")
  endif()

  if(NOT "${PCL_INCLUDE_DIRS}" STREQUAL "")
    foreach(item ${PCL_INCLUDE_DIRS})
      string(REGEX MATCH "/usr/include/.*-linux-gnu/freetype2" item ${item})

      if(item)
        list(REMOVE_ITEM PCL_INCLUDE_DIRS ${item})
      endif()
    endforeach()
  endif()
endif()

if(PLATFORM_ARCH STREQUAL "x86-64")
  # for ROS
  set(PCL_DIR "/usr/lib/x86_64-linux-gnu/cmake/pcl")
  set(PCL_LIBRARY_DIRS "/usr/lib/x86_64-linux-gnu")
  set(PCL_INCLUDE_DIRS "/usr/include/pcl-1.10")
endif()
include_directories(${PCL_INCLUDE_DIRS})

set(GTest_DIR "$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/gtest/lib/cmake/GTest")
include_directories("$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/gtest/include")
link_directories("$ENV{CG_THIRDPARTY}/${PLATFORM_ARCH}/gtest/lib")

# # FastDDS
# set(OPENSSL_CRYPTO_LIBRARY "/usr/lib/x86_64-linux-gnu/libcrypto.so")
# set(OPENSSL_INCLUDE_DIR "/usr/include/")
# set(OPENSSL_SSL_LIBRARY "/usr/lib/x86_64-linux-gnu/libssl.so")
