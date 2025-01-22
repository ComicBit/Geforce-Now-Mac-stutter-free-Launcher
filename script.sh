#!/bin/bash

disable_awdl0() {
    sudo ifconfig awdl0 down
}

enable_awdl0() {
    sudo ifconfig awdl0 up
}

monitor_geforcenow() {
    while pgrep -x "GeForceNOW" > /dev/null; do
        sleep 5
        awdl_status=$(ifconfig awdl0 | grep "status: active")
        if [ ! -z "$awdl_status" ]; then
            disable_awdl0
        fi
    done
}

disable_awdl0
monitor_geforcenow
enable_awdl0