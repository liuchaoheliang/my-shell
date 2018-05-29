#!/bin/bash

echo "====开始执行启动脚本，时间:`date +%Y-%m-%d" "%H:%M:%S`"

basePath=/opt/application/appservershell
jarName=appservershell.jar


echo "----1:检查是否存在当前程序的进程----"
pidlist=`ps -ef | grep "${basePath}/${jarName}" | grep -v "grep" |awk '{print $2}'`
if [ "$pidlist" != "" ];then
    echo "  已存在当前程序的进程，列表:$pidlist"
    for pid in $pidlist
    do
        kill -9 $pid
        echo "    杀死进程:${pid}"
    done
else
    echo "  不存在当前程序的进程"
fi

echo

echo "----2:检查是否存在已经下载完成的新版程序文件----"
if [ -f "${basePath}/upgrade/download/completed" ]; then
    echo "  发现新版本文件，准备替换当前版本"

    rm -f ${basePath}/${jarName}
    echo "  删除当前版本文件"

    mv ${basePath}/upgrade/download/upgrade.zip ${basePath}/${jarName}
    echo "  复制新版本文件到目标目录"

    mv ${basePath}/upgrade/download/upgrade.cfg ${basePath}/project.properties
    echo "  复制新版本信息文件到目标目录"

    rm -f ${basePath}/upgrade/download/completed
    echo "  删除新版本完成标记文件"

    echo "  替换新版本完成"
else
    echo "  无新版本文件，未执行替换"
fi

echo

echo "----3:启动主程序----"
nohup java -jar ${basePath}/${jarName} &

