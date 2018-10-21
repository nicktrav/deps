#!/bin/bash

set -euo pipefail

# install Ruby
sudo apt-get -y update
sudo apt-get -y install ruby-full

# install and unpack babuska
rm -rf /tmp/babushka
git clone https://github.com/benhoskings/babushka.git /tmp/babushka
cd /tmp/babushka || exit 1
sudo ./bin/babushka.rb babushka

# set up deps
rm -rf ~/.babushka/deps
mkdir -p ~/.babushka && cd ~/.babushka && git clone https://github.com/nicktrav/deps.git
babushka --debug all
