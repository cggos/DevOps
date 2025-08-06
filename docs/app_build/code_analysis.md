# Code Analysis

-----

[TOC]

## Cppcheck - a static analysis tool for C/C++ code

[Cppcheck](http://cppcheck.sourceforge.net/) provides unique code analysis to detect bugs and focuses on detecting undefined behaviour and dangerous coding constructs. The goal is to detect only real errors in the code (i.e. have very few false positives).

```sh
cppcheck --enable=all src/
```

## Valgrind - a dynamic analysis tools

[Valgrind](http://valgrind.org/) is an instrumentation framework for building dynamic analysis tools. There are Valgrind tools that can **automatically detect many memory management and threading bugs, and profile your programs in detail**. You can also use Valgrind to build new tools.

```sh
valgrind --tool=memcheck --leak-check=full <program args>
```

## gprof and gcov

[gprof and gcov](https://alex.dzyoba.com/blog/gprof-gcov/) are classical profilers that are still in use. Since the dawn of time, they were used by hackers to gain insight into their programs at the source code level.

* **[gprof](https://sourceware.org/binutils/docs/gprof/) (GNU Profiler)** – simple and easy profiler that can show how much time your program spends in routines in percents and seconds. gprof uses source code instrumentation by inserting special mcount function call to gather metrics of your program.
  ```sh
  gprof <program_name> gmon.out
  ```

* **[gcov](https://gcc.gnu.org/onlinedocs/gcc/Gcov.html) (short for GNU Coverage)** is a tool you can use in conjunction with GCC to test code coverage in your programs. Usually it’s used in pair with gprof to understand what exact line in slacking function is holds your program down.
  ```sh
  gcov -b *.gcno
  ```

* [cpp-coveralls](https://github.com/eddyxu/cpp-coveralls) - Upload C/C++ coverage report to coveralls.io


## Code Quantity

* [WakaTime](https://wakatime.com/): Open source plugins for automatic programming metrics
* [Landscape](https://landscape.io/) is an early warning system for your Python codebase
* [Synk](https://snyk.io/): A developer-first solution that automates finding & fixing vulnerabilities in your dependencies

### 代码量统计

- Source Counter
- LineCount（智能源码统计专家）
- cloc
- git log

#### cloc

```bash
sudo apt-get install cloc
```

```bash
./cloc
```

#### git scripts

```bash
# code_count.sh

printf "\n1. 项目成员数量：";
git log --pretty='%aN' | sort -u | wc -l

printf "\n\n2. 按用户名统计代码提交次数：\n\n"
printf "%10s  %s\n" "次数" "用户名"
git log --pretty='%aN' | sort | uniq -c | sort -k1 -n -r | head -n 5
printf "\n%10s" "合计"; printf "\n%5s" ""; git log --oneline | wc -l

printf "\n3. 按用户名统计代码提交行数：\n\n"
printf "%15s %20s+ %20s- %18s\n" "用户名" "总行数" "添加行数" "删除行数"
git log --format='%aN' | sort -u -r | while read name; do printf "%15s" "$name"; \
git log --author="$name" --pretty=tformat: --numstat | \
awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "%15s %15s %15s \n", loc, add, subs }' \
-; done

printf "\n%15s   " "总计："; git log --pretty=tformat: --numstat | \
awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "%15s %15s %15s \n", loc, add, subs }'

echo ""
# shellcheck disable=SC2162
read -n 1 -p "请按任意键继续..."
```

排除多个文件夹

```bash
git log  --author="songyang" --since="2019-05-01" --until="2019-05-31" --pretty=tformat:  --numstat  -- . ":(exclude)static/built" ":(exclude)static/bower_components" | awk '{ add += $1; subs += $2; loc += $1 - $2 } END { printf "added lines: %s, removed lines: %s, total lines: %s\n", add, subs, loc }'
```

```bash
git log -- . ":(exclude)file.txt" ":(exclude)another_file.txt"
```

- author: 作者，
- since: 起始时间
- until: 结束时间
- `-- . ":(exclude)folderName"` 排除文件夹
- `-- . ":(exclude)folderName1" ":(exclude)folderName2"` 排除多个文件夹

