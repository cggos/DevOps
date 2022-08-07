# Compiler

-----

[TOC]

## GCC/G++

* [How to Install the Latest GCC on Windows](https://preshing.com/20141108/how-to-install-the-latest-gcc-on-windows/)

### gcc/g++ Options

* `-dumpmachine`: print **the compiler's target machine** (for example, arm-linux-gnueabihf)
* `-dM -E`:
    - `gcc -dM -E - < /dev/null`: 显示所有预定义的宏

## Faster Compilers

* [Compile faster with Ccache and Distcc](https://rtt-lwr.readthedocs.io/en/latest/adv-tutos/ccache-distcc.html)
* [Speeding Up Compilation with ccache and distcc](http://www.jamessjackson.com/gcc/ccache/distcc/compiling/c++/2017/07/25/ccache-and-distcc/)

### ccache: a fast C/C++ compiler cache

[ccache](https://ccache.samba.org/) is a compiler cache. It speeds up recompilation by caching previous compilations and detecting when the same compilation is being done again. Supported languages are C, C++, Objective-C and Objective-C++.

* install in Ubuntu
  ```sh
  sudo apt install ccache
  ```

* CMake configuration:
  ```cmake
  # Configure CCache if available
  find_program(CCACHE_FOUND ccache)
  if(CCACHE_FOUND)
          set_property(GLOBAL PROPERTY RULE_LAUNCH_COMPILE ccache)
          set_property(GLOBAL PROPERTY RULE_LAUNCH_LINK ccache)
  endif(CCACHE_FOUND)  
  ```

* Usage with Android NDK
  ```sh
  export NDK_CCACHE=/usr/bin/ccache

  ndk-build -j9
  ```

* To see if ccache is really working, you can use `ccache -s` command, which will display ccache statistics, on second and all subsequent compilations the **cache hit** values should increase and thus show that ccache is working:
  ```
  cache directory                     /home/cg/.ccache
  primary config                      /home/cg/.ccache/ccache.conf
  secondary config      (readonly)    /etc/ccache.conf
  cache hit (direct)                     0
  cache hit (preprocessed)               0
  cache miss                             0
  files in cache                         0
  cache size                           0.0 kB
  max cache size                       5.0 GB
  ```


### distcc: a fast, free distributed C/C++ compiler

[distcc](https://distcc.github.io/) is a program to distribute builds of C, C++, Objective C or Objective C++ code across several machines on a network. distcc should always generate the same results as a local build, is simple to install and use, and is usually much faster than a local compile.
