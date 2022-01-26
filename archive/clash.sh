#!/usr/bin/env bash

set -ueo pipefail

usage() {
    echo "usage: $0 <command>"
    echo
    echo "Commands:"
    echo "  start"
    echo "    start clash service in daemon"
    echo
    echo "  stop"
    echo "    stop clash service"
    exit 1
}

if [[ $# -lt 2 ]]; then
    usage
fi

case $1 in
    start)
    docker run -it --rm -v clash.yaml:/root/.config/clash/config.yaml -p 7890:7890 -p 7891:7891 --name clash -d dreamacro/clash
    ;;
    stop)
    docker rm clash
    ;;
esac

