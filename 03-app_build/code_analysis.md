# Code Analysis

-----

[TOC]

## Cppcheck - a static analysis tool for C/C++ code
[Cppcheck](http://cppcheck.sourceforge.net/) provides unique code analysis to detect bugs and focuses on detecting undefined behaviour and dangerous coding constructs. The goal is to detect only real errors in the code (i.e. have very few false positives).
```
cppcheck --enable=all src/
```

## Valgrind - a dynamic analysis tools
[Valgrind](http://valgrind.org/) is an instrumentation framework for building dynamic analysis tools. There are Valgrind tools that can **automatically detect many memory management and threading bugs, and profile your programs in detail**. You can also use Valgrind to build new tools.
```
valgrind --tool=memcheck --leak-check=full <program args>
```

## gprof and gcov

[gprof and gcov](https://alex.dzyoba.com/blog/gprof-gcov/) are classical profilers that are still in use. Since the dawn of time, they were used by hackers to gain insight into their programs at the source code level.

* **[gprof](https://sourceware.org/binutils/docs/gprof/) (GNU Profiler)** – simple and easy profiler that can show how much time your program spends in routines in percents and seconds. gprof uses source code instrumentation by inserting special mcount function call to gather metrics of your program.
```
gprof <program_name> gmon.out
```

* **[gcov](https://gcc.gnu.org/onlinedocs/gcc/Gcov.html) (short for GNU Coverage)** is a tool you can use in conjunction with GCC to test code coverage in your programs. Usually it’s used in pair with gprof to understand what exact line in slacking function is holds your program down.
```
gcov -b *.gcno
```

* [cpp-coveralls](https://github.com/eddyxu/cpp-coveralls) - Upload C/C++ coverage report to coveralls.io


## Code Quantity

* [WakaTime](https://wakatime.com/): Open source plugins for automatic programming metrics
* [Landscape](https://landscape.io/) is an early warning system for your Python codebase
* [Synk](https://snyk.io/): A developer-first solution that automates finding & fixing vulnerabilities in your dependencies
