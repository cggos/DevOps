#!/bin/bash

#最大公约数，使用Euclid算法
#参数检测
ARGS=2
E_BADARGS=85

if [ $# -ne "$ARGS" ]	#方括号两侧需有空格
then
	echo "Usage:`basename $0` first-number second-number"	#后引号或斜引号
	exit $E_BADARGS
fi

gcd(){
	dividend=$1	#赋任意值
	divisor=$2	#这里的两个参数赋值大小没有关系
	remainder=1
	#若在循环中使用未初始化的变量，在循环中第一个传递值会使它返回一条错误信息
	until [ "$remainder" -eq 0 ]
	do
		let "remainder = $dividend % $divisor"
		dividend=$divisor
		divisor=$remainder
	done
}

gcd $1 $2
echo
echo "GCD of $1 and $2 = $dividend"	#双引号为部分引用
echo

exit 0
	
