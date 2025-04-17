#!/bin/bash

# 设置工作目录
WORKDIR="/hoshinobot"
cd $WORKDIR

# 设置代理环境变量
export HTTP_PROXY=${HTTP_PROXY:-""}
export HTTPS_PROXY=${HTTPS_PROXY:-""}

# 设置 UID 和 GID 环境变量
export UID=${UID:-1000}
export GID=${GID:-1000}

# 启动主程序并记录 PID
gosu $UID:$GID python3 run.py -g &
echo $! > hoshinobotg.pid

loop=true
while $loop
do
    loop=false
    wait
    if [ -f .HOSHINOBOT_RESTART ]
    then
        loop=true
        rm .HOSHINOBOT_RESTART
    fi
done