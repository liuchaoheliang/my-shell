#!/bin/bash

echo 'this is a test shell bash'

name="liuchao"
#输出字符长度
echo ${#name}
echo ${name:1:4}

age=27
sex='man'
#只读变量
readonly sex
#移除变量age
unset age 

#for 循环
for file in $(ls /tmp); do 
	echo "this item is " + $file
done

#while 循环
int i=0
while(($i < 5 ))
do
	echo $i
	let "i++"
done

#until循环
n=0
until [ $n -gt > 10]
do
	echo 'n is '+ n
	$a++
done

#寻找进程，取第二个列  	
pid=`ps -ef | grep 'java' | awk '{print $2}'`

if [ "$pid" != "" ];then
	echo "pid is" + $pid
elif [ "$pid" != "" ];then
	echo "not find pid"
else	
	echo 'others '
fi 

echo 'input a number'
read num1
echo 'input a number'
read num2

addNum(){
	return $($1+$2)
}
res=addNum(num1,num2)
echo '计算结果：'+res

