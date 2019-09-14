#!/usr/bin/env bash
git clone git://github.com/ninja-build/ninja.git
cd ninja || exit 1
./configure.py --bootstrap
install ./ninja /usr/local/bin/ninja
rm -rf "${PWD}"
