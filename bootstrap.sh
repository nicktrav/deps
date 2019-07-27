#!/bin/bash

set -euo pipefail

# install Go
apt-get -y update && apt-get -y install git wget tar

wget https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz
tar xzf go1.12.6.linux-amd64.tar.gz
mv go /usr/local/

# install matryoshka
rm -rf /tmp/matryoshka
git clone https://github.com/nicktrav/matryoshka.git /tmp/matryoshka
cd /tmp/matryoshka || exit 1
go build -o /usr/local/bin/matryoshka ./cmd/matryoshka/matryoshka.go

# set up deps
rm -rf ~/.config/matryoshka/deps
mkdir -p ~/.config/matryoshka && cd ~/.config/matryoshka && git clone https://github.com/nicktrav/deps.git
matryoshka -dir ~/.config/matryoshka/deps -debug
