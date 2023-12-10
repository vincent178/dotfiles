#!/usr/bin/env bash

set -e

NPM_MIRROR="https://registry.npm.taobao.org"
PIP_MIRROR="https://pypi.tuna.tsinghua.edu.cn/simple"
GO_MIRROR="https://goproxy.cn"

if command -v npm &>/dev/null; then
    npm config set registry $NPM_MIRROR
    echo "success set npm registry to $NPM_MIRROR"
fi

if command -v yarn &>/dev/null; then
    yarn config set registry $NPM_MIRROR
    echo "success set yarn registry to $NPM_MIRROR"
fi

if command -v pip3 &>/dev/null; then
    pip3 config set global.index-url $PIP_MIRROR
    echo "success set pip3 index to $PIP_MIRROR"
fi

if command -v go &>/dev/null; then
    go env -w GOPROXY=$GO_MIRROR,direct
    echo "success set go proxy to $GO_MIRROR"
fi
