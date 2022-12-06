SHELL:=/bin/bash

FNL := fnl/async-uv.fnl
LUA := lua/async-uv.lua
UV_CALLBACKS := uv-callbacks.txt

.PHONY: all
all: $(LUA)

$(UV_CALLBACKS):
	curl -s https://raw.githubusercontent.com/neovim/neovim/master/runtime/doc/luvref.txt | grep -e "^uv.*callback" | sed 's/(.*$$//' > $(UV_CALLBACKS)

$(LUA): $(FNL) $(UV_CALLBACKS)
	nvim --headless -c 'BulbCompile $(FNL) $(LUA)' +q

.PHONY: fmt
fmt:
	stylua . && fnlfmt --fix $(FNL)

.PHONY: clean
clean:
	rm $(UV_CALLBACKS) $(LUA)
