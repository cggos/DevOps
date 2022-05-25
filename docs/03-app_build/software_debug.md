# Software Debug

* [Debuggers and Debugging Techniques](https://www.cprogramming.com/debugging/)
* [类Unix平台程序调试](https://www.cnblogs.com/gaohongchen01/p/8311732.html)

-----

## GDB
* [GDB](https://www.gnu.org/software/gdb/): The GNU Project Debugger
* [gdb Debugging Full Example (Tutorial): ncurses](http://www.brendangregg.com/blog/2016-08-09/gdb-example-ncurses.html)
* [GDB - Debugging stripped binaries](https://felix.abecassis.me/2012/08/gdb-debugging-stripped-binaries/)

```sh
directory: 设置路径
```


## Bug Manager
* [bugclose](https://www.bugclose.com/): 云端BUG管理工具
* [Bugzilla](https://www.bugzilla.org/) is server software designed to help you manage software development.


## Debug Utils

* dmesg
* readelf
* strace
* addr2line
* nm
* strip
* [Backward-cpp](https://github.com/bombela/backward-cpp): a beautiful stack trace pretty printer for C++
* od: dump files in octal and other formats
* objdump: display information from object files
	```sh
	# 查看.so文件的依赖关系
	objdump -x libxxxxx.so | grep NEEDED
	```
* ldd: print shared object dependencies

## ROS Debug
* [How to Roslaunch Nodes in Valgrind or GDB](http://wiki.ros.org/roslaunch/Tutorials/Roslaunch%20Nodes%20in%20Valgrind%20or%20GDB)
* [A Dummy’s Guide to Debugging ROS Systems](https://bluesat.com.au/a-dummys-guide-to-debugging-ros-systems/)

## Others

* WinDbg
	- 不仅可以用于Kernel模式调试和用户模式调试，还可以调试Dump文件
	- Dump文件是进程的内存镜像，可以把程序的执行状态通过调试器保存到dump文件中

* SxsTrace: 跟踪调试应用程序
