# Software Test

-----

[TOC]

## Unit Test

* CTest

### GTest

* [GTest](https://github.com/google/googletest) - Google C++ Testing Framework

  - [Getting started with Google Test (GTest) on Ubuntu](https://www.eriksmistad.no/getting-started-with-google-test-on-ubuntu/)
  - [玩转Google开源C++单元测试框架Google Test系列(gtest)(总)](http://www.cnblogs.com/coderzh/archive/2009/04/06/1426755.html)

* install
  ```sh 
  sudo apt-get install libgtest-dev
  
  cd /usr/src/gtest
  
  sudo mkdir build
  cd build
  sudo cmake ..
  sudo make -j4

  # copy or symlink libgtest.a and libgtest_main.a to your /usr/lib folder
  sudo cp *.a /usr/lib  
  ```

## Others

* Parasoft C/C++ test