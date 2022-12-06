# async-uv.nvim

Every libuv function that has a callback, now wrapped in async/await syntax.

## Installation

With [Packer](https://github.com/wbthomason/packer.nvim)

```lua
 use { "ec965/async-uv.nvim", requires = { "ms-jpq/lua-async-await" }}
```

## Usage

```lua
local uv = require"async-uv"
local a = require"async"

function readFile(path)
  return a.sync(function()
    local err, fd = a.wait(uv.fs_open(path, "r", 438))
    assert(not err, err)
    local err, stat = a.wait(uv.fs_fstat(fd))
    assert(not err, err)
    local err, data = a.wait(uv.fs_read(fd, stat.size, 0))
    assert(not err, err)
    return data
  end)
end
```
