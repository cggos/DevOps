# Files & File Systems

-----

## File Systems

* NTFS

* FAT

* exFAT

* NFS

* CIFS

* SMB
    * SMBv1.0
    * SMBv2.1
    * SMBv3.0



## Statistics

```sh
# 查看当前目录下的文件数量（包含子目录中的文件） 注意：R，代表子目录
ls -lR|grep "^-"| wc -l
```

统计文件的数目:

```bash
#!/bin/bash

#变量counter用于统计文件的数目
counter=0
#变量files遍历当前文件夹
for files in *
do
	#判断files是否是文件，若是，就将counter变量的值加1，再赋给自己
	if [ -f "files" ]
	then
		counter=`expr $counter + 1`
	fi
done
echo $counter
exit 0
```

## xargs

```sh
cat install_manifest.txt | xargs sudo rm {} -fr
```

## Find

* [25 simple examples of Linux find command](http://www.binarytides.com/linux-find-command-examples/)

* [Linux下的五个查找命令：grep、find、locate、whereis、which](http://www.cnblogs.com/wanqieddy/archive/2011/07/15/2107071.html)

* [fzf](https://github.com/junegunn/fzf): a general-purpose command-line fuzzy finder
  - install fzf
	- alias
	  ```sh
		alias ff='find * -type f | fzf > selected'
		```
	- use in cli: `ff`

* pdfgrep

* [Recoll](https://www.lesbonscomptes.com/recoll/) is a desktop full-text search tool.

```bash
# 在当前目录下查找"hello"字符串
grep -rn "hello"

# 只能寻找执行文件 ，并在PATH变量里面寻找
which

# 从linux文件数据库（/var/lib/slocate/slocate.db）寻找，所以有可能找到刚刚删除或者没有发现新建的文件
# 先运行updatedb（无论在那个目录中均可，可以放在crontab中 ）后在/var/lib/slocate/下生成 slocate.db 数据库即可快速查找，在命令提示符下直接执行#updatedb命令即可
updatedb
whereis

# 同上,不过文件名是部分匹配
updatedb
locate

# 直接在硬盘上搜寻，功能强大，但耗硬盘，一般不要用
find

# 删除目录及其子目录下某种类型文件，比如说所有的txt文件
find . -name "*.txt" -type f -print -exec rm -rf {} \;
```


## Compress & Uncompress

* 多卷压缩
  ```sh
  zip -r -s 2g nutstore_papers.zip nutstore_papers/
  ```
