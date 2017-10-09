local function checkType(a, t)
  return type(a) == t
end
local function isNum(a)
  return checkType(a, "number")
end
local function isStr(a)
  return checkType(a, "string")
end
local function isTable(a)
  return checkType(a, "table")
end

--- Table class is table wrapper
--
Table = {}

  function Table.new(val)
    local this = isTable(val) and val or {}
    setmetatable(this, {
      __class = "Table",
      __index = Table,
      __tostring = Table.tostring,
    })
    return this
  end

  function Table:tostring()
    return tostring(self)
  end

  function Table:concat(tbl)

  end


  function Table:insert(key, value)
    if value == nil then
      value = key
      key = #self + 1
    end

    local ret = false
    if isNum(key) then
      table.insert(self, key, value)
      ret = true
    elseif isStr(key) then
      self[key] = value
      ret = true
    end
    return ret
  end

  function Table:add(key, value)
    return self:insert(key, value)
  end

  function Table:remove(key)
    local ret = false
    if isNum(key) then
      table.remove(self, key)
      ret = true
    elseif isStr(key) then
      self[key] = nil
      ret = true
    end
    return ret
  end

  function Table:find(value)
    local list = {}
    for k, v in pairs(self) do
      if v == value then
        table.insert(list, k)
      end
    end
    unpack = unpack == nil and table.unpack or unpack
    return unpack(list)
  end

  function Table:clone()
    local meta = getmetatable(self)
    local copy = {}
    for k, v in pairs(self) do
      if isTable(v) then
        copy[k] = Table:new(v):clone()
      else
        copy[k] = v
      end
    end
    setmetatable(copy, meta)
    return copy
  end

  function Table:clear()
    self = Table.new({})
  end

  -- stream
  -- 中間操作
  function Table:map(callback)
    local new = {}
    for k, v in pairs(self) do
      table.insert(new, callback(v, k))
    end
    return Table.new(new)
  end

  function Table:dmap(callback)
    for k, v in pairs(self) do
      self[v] = callback(v, k)
    end
    return self
  end

  function Table:sort(comparator)
    local new = self:clone()
    table.sort(new, comparator)
    return Table.new(new)
  end

  function Table:dsort(comparator)
    table.sort(self, comparator)
    return self
  end

  function Table:filter(condition)
    local new = {}
    for i, v in pairs(self) do
      if condition(v, i) then
        table.insert(new, v)
      end
    end
    return Table.new(new)
  end

  function Table:slice(a, b)
    local start, finish
    if b == nil then
      start = 1
      finish = a
    else
      start = a
      finish = b
    end

    local new = {}
    for i = start, finish do
      table.insert(new, self[i])
    end
    return Table.new(new)
  end


  -- 終端操作
  function Table:each(callback)
    for k, v in pairs(self) do
      callback(v, k)
    end
  end

  function Table:foreach(callback)
    return self:each(callback)
  end

  function Table:matchAll(condition)
    for k, v in pairs(self) do
      if not condition(v, k) then
        return false
      end
    end
    return true
  end

  function Table:matchAny(condition)
    for k, v in pairs(self) do
      if condition(v, k) then
        return true
      end
    end
    return false
  end

  function Table:sum()
    local sum = 0
    for i, v in pairs(self) do
      sum = sum + v
    end
    return sum
  end

  -- Table()でもインスタンス生成
  setmetatable(Table, {__call = function(t, val) return t.new(val) end})

-- Table Class
