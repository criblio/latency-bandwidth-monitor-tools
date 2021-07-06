#!/bin/sh -e

ORIG_DIR=$(pwd)
TMP_DIR=$(mktemp -d)
cd $TMP_DIR
curl -Lo ./mtr.tar.gz https://github.com/traviscross/mtr/archive/refs/tags/v0.94.tar.gz
tar zxvf ./mtr.tar.gz
cd mtr*
./bootstrap.sh
./configure 
make mtr_LDADD="-Wl,-Bstatic -ljansson -Wl,-Bdynamic -lresolv -lm"
cp ./mtr $ORIG_DIR
cd ..
rm -rf mtr*
cd $ORIG_DIR

export GO111MODULE=on
GOPROXY=direct go get github.com/criblio/speedtest-go
cd ~/go/pkg/mod/github.com/criblio/speedtest-go\@*
CGO_ENABLED=0 go build -tags netgo -o $ORIG_DIR/speedtest
cd $ORIG_DIR
