#!/bin/bash
curl -s https://raw.githubusercontent.com/neovim/neovim/master/runtime/doc/luvref.txt | grep -e "^uv.*callback" | sed 's/(.*$//'
