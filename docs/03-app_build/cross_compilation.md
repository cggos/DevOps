# Cross Compilation

---

## CImg

Add the following code in `CImg.h` from https://github.com/dtschump/CImg.git to **NOT** use `Xlib.h`:

```c++
#undef cimg_display
#define cimg_display 0
```


## OpenCV

* Android: https://blog.csdn.net/u011178262/article/details/78209791#for_Android_127


## Suitsparse

* Android: https://github.com/cggos/suitesparse_for_android


## Google Ceres-Solver

### ceres-solver-1.14.0 for Android

ref: [How to Compile Ceres Android Library with NDK under Mac](https://programmer.group/how-to-compile-ceres-android-library-with-ndk-under-mac.html)

替换 `ceres-solver-1.14.0/jni` 下 `Application.mk` 中的内容为

```makefile
APP_BUILD_SCRIPT := $(call my-dir)/Android.mk
APP_PROJECT_PATH := $(call my-dir)

APP_CPPFLAGS := -frtti -fexceptions -std=c++0x
APP_OPTIM := release

APP_STL := gnustl_static
APP_ABI := armeabi-v7a
```

在 `ceres-solver-1.14.0/jni` 下

```sh
EIGEN_PATH=/home/cg/projects/3rdparty/eigen-3.3.7 ndk-build -j1
```

编译完后，在 `ceres-solver-1.14.0/obj/local/armeabi-v7a` 下生成 `libceres.a` 文件。

## FFTW

It is best to download official tarballs from http://fftw.org/, other than using its github repository!!!

### for Android

Build Reference: [fftw_android( from he-kai github )](https://github.com/hekai/fftw_android)

```sh
#!/bin/sh
set -o errexit

# Compiles fftw3 for Android
# Make sure you have ANDROID_NDK defined in .bashrc or .bash_profile

PROJECT_ROOT="`pwd`/../"
INSTALL_DIR="$PROJECT_ROOT/jni/ndk-modules/fftw3"
mkdir -p $INSTALL_DIR

NDK_DIR=${ANDROID_NDK}

export PATH="$NDK_DIR/toolchains/arm-linux-androideabi-4.9/prebuilt/linux-x86_64/bin/:$PATH"
export SYS_ROOT="$NDK_DIR/platforms/android-9/arch-arm/"
export CC="arm-linux-androideabi-gcc --sysroot=$SYS_ROOT"
export CXX="arm-linux-androideabi-g++"
export LD="arm-linux-androideabi-ld"
export AR="arm-linux-androideabi-ar"
export RANLIB="arm-linux-androideabi-ranlib"
export STRIP="arm-linux-androideabi-strip"
export CFLAGS="-mfpu=neon -march=armv7-a -mfloat-abi=softfp" #use Thumb-2 instructs
export CXXFLAGS="-lstdc++"
export LDFLAGS="-lc -lgcc"

SRC_DIR="./fftw-3.3.3"
cd $SRC_DIR

##### configure & make & make install #####

./configure --host=arm-eabi --prefix=$INSTALL_DIR --enable-float --enable-neon

make -j$(nproc)
make install -j$(nproc)

exit 0
```
