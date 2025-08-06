# Software Debug

---

## Overview

* [Debuggers and Debugging Techniques](https://www.cprogramming.com/debugging/)

* [Debug (CGABC)](https://cgabc.xyz/tags/Debug/)

## GDB

<p align="center">
  <iframe src="https://www.youtube.com/embed/PorfLSr3DDI?rel=0&showinfo=0"
    width="780" height="480" frameborder="no" scrolling="no" allowfullscreen="true">
  </iframe>
</p>

* [GDB](https://www.gnu.org/software/gdb/): The GNU Project Debugger
* [gdb Debugging Full Example (Tutorial): ncurses](http://www.brendangregg.com/blog/2016-08-09/gdb-example-ncurses.html)
* [GDB - Debugging stripped binaries](https://felix.abecassis.me/2012/08/gdb-debugging-stripped-binaries/)
* [一次调试C++程序的艰苦历程](http://airekans.github.io/cpp/2014/03/11/cpp-debug-01)
* [图文并茂 | 彻底弄懂GDB调试原理](https://www.eet-china.com/mp/a34200.html)

### Build

```sh
g++ -g fun.cpp
```

### Start GDB

```sh
gdb a.out [--tui] # or open TUI by Ctrl-X-O after entering gdb
```

### Usage

```sh
(gdb) directory
(gdb) show directories

(gdb) set args xxx
(gdb) show args

(gdb) i r

(gdb) set print pretty
(gdb) p /d var # /x /o /t /f /c 
(gdb) p &var
(gdb) p var = 20
(gdb) p sizeof(long)
(gdb) set print array on

(gdb) x addr

(gdb) bt
(gdb) info frame
(gdb) info args
(gdb) info locals
(gdb) info catch
```

## Debug Utils

* dmesg
	```sh
	dmesg | tail
	```

* readelf

* strace

* addr2line
	```sh
	# 根据 函数地址，查看函数名
	addr2line -e a.out 0x4004e5 -f [--demangle=gnu-v3]
	```

* nm: list symbols from object files
	```sh
	nm libhello.so
	```

* strip

* [Backward-cpp](https://github.com/bombela/backward-cpp): a beautiful stack trace pretty printer for C++

* od: dump files in octal and other formats

* objdump: display information from object files
	```sh
	# 查看.so文件的依赖关系
	objdump -x libxxx.so | grep NEEDED

	# 查看动态库和静态库是32位，还是64位
	file *.so  # 动态库
	objdump -x *.a  # 静态
	```

* ldd: print shared object dependencies
	```sh
	ldd /bin/lnlibc.so.6
	```

* WinDbg
  	- 不仅可以用于Kernel模式调试和用户模式调试，还可以调试Dump文件
	  - Dump文件是进程的内存镜像，可以把程序的执行状态通过调试器保存到dump文件中

* SxsTrace: 跟踪调试应用程序


## Bug Manager

* [bugclose](https://www.bugclose.com/): 云端BUG管理工具
* [Bugzilla](https://www.bugzilla.org/) is server software designed to help you manage software development.
