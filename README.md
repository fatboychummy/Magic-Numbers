# Magic-Numbers
The ability to use epic operators on "numbers" in Lua is now at your fingertips.

# Usage
```lua
local Number = require "magic-numbers"

local x = Number(32)
print(x)
print(x + 3)
x '+=' (10)
print(x)
print(x '==' (42))
```

```
32
35
42
true
```
