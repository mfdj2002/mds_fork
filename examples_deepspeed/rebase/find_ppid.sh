#!/bin/bash

pid=$(fuser gpu_usage.log 2>/dev/null)

if [ -z "$pid" ]; then
    echo "No process is currently accessing gpu_usage.log"
else
    ps -o pid,ppid,cmd -p $pid
fi
