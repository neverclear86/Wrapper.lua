# Util.lua

## tableutil.lua
- Tableにmetatableとしてセットするといい感じになるやつ

### 使い方
```lua
require "tableutil"

local tbl = setmetatable({}, tableutil)
local tbl = tableutil({})
-- 上下で意味は同じ
```

### Methods
#### 標準のtableの関数
- insert
- move
- pack
- remove
- sort
- unpack
  - 5.3~

#### 追加された関数
- inspect
  - tostring
- concat
  - table.concatではない
  - +演算子
- difference
  - -演算子
- insert
- push
- remove
- pop
- shift
- find
- isexist
- clone
- clear
- join
  - table.concat
- uniq
- isempty
- map
- dmap
- sort
- dsort
- filter
- slice
- each
  - alias: foreach
- matchAll
- machAny
- sum
- mul (\*演算子)
