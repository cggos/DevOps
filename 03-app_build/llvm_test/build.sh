cmake -B build -DCMAKE_TOOLCHAIN_FILE=./linux.toolchain.cmake -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON
cmake --build build/
