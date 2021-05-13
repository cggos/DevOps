#!/bin/bash


#for-loop
echo
echo "for-loop:"
for planet in "Mercury 36" "Venus 67" "Earth 93"
do
	set -- $planet	#"--"将防止$planet为空，或者是以一个破折号开头
	echo "$1		$2,000,000 miles from the sun"
done

#while-loop
echo
echo "while-loop:"
var0=0
LIMIT=10
while [ "$var0" -lt "$LIMIT" ]
do
	echo -n "$var0"		#-n将会阻止产生新行
	#expr命令计算其后参数的值，然后将结果写入到标准输出
	var0=`expr $var0 + 1`	#var0=$(($var0+1))也可以
done
echo

#until-loop
echo
echo "until-loop:"
END_CONDITION=q
until [ "$var1" = "$END_CONDITION" ]	#在循环的顶部判断条件
do
	echo -n "Input variable #1 ($END_CONDITION to exit): "
	read var1
	echo "variable #1 = $var1"
done

#case-cmd
echo
echo "case-cmd:"
case $(arch) in
	i368) echo "80386";;
	i486) echo "80486";;
	i586) echo "Pentium";;
	i686) echo "Pentium2+";;
	x86_64) echo "x86_64";;
	*	) echo "Other";;
esac

#select-cmd
echo
echo "select-cmd:"
PS3='Choose your favorite vegetable:'	#设置提示字符串
select vegetable in "beans" "carrots" "potatoes"
do
	echo "Your favorite veggie is $vegetable."
	echo "Yuck!"
	echo
	break
done

exit 0
