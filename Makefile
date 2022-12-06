SHELL:=/bin/bash

.PHONY: all
all: lua/async-uv.lua

uv-callbacks.txt:
	curl -s https://raw.githubusercontent.com/neovim/neovim/master/runtime/doc/luvref.txt | grep -e "^uv.*callback" | sed 's/(.*$$//' > uv-callbacks.txt

lua/async-uv.lua: fnl/async-uv.fnl uv-callbacks.txt
	nvim --headless -c 'BulbCompile fnl/async-uv.fnl lua/async-uv.lua' +q

.PHONY: clean
clean:
	rm uv-callbacks.txt lua/async-uv.lua
