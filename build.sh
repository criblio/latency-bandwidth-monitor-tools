#!/bin/sh

ORIG_DIR=$(pwd)
TMP_DIR=$(mktemp -d)
cd $TMP_DIR
curl -Lo ./mtr.tar.gz https://github.com/traviscross/mtr/archive/refs/tags/v0.94.tar.gz
tar zxvf ./mtr.tar.gz
cd mtr*
./bootstrap.sh
./configure CFLAGS="-static"
make LDFLAGS="-static"
cp ./mtr $ORIG_DIR
cd ..
rm -rf mtr*
cd $ORIG_DIR

go get github.com/showwin/speedtest-go
cd ~/go/src/github.com/showwin/speedtest-go
CGO_ENABLED=0 go build -tags netgo -o $ORIG_DIR/speedtest
cd $ORIG_DIR
