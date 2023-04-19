local Number

local operators = {
  ["+"] = function(a, b)
    return a + b
  end,
  ["-"] = function(a, b)
    return a - b
  end,
  ["*"] = function(a, b)
    return a * b
  end,
  ["/"] = function(a, b)
    return a / b
  end,
  ["+="] = function(a, b)
    a.n = (a + b).n
    return a
  end,
  ["-="] = function(a, b)
    a.n = (a - b).n
    return a
  end,
  ["*="] = function(a, b)
    a.n = (a * b).n
    return a
  end,
  ["/="] = function (a, b)
    a.n = (a / b).n
    return a
  end,
  ["=="] = function (a, b)
    return a == b
  end,
  ["~="] = function (a, b)
    return a ~= b
  end,
  ["!="] = function (a, b)
    return a ~= b
  end,
  ["=~="] = function (a, b)
    return a + 0.0001 > b and a - 0.0001 < b
  end,
}

local function c_type(v)
  if type(v) == "number" then
    return Number(v)
  end
  return v
end

local nmt = {
  __call = function(self, operator)
    if type(operator) ~= "string" then
      error("Cannot do whatever you're trying to do here lol", 2)
    end
    if not operators[operator] then
      error(("Unknown operator: %s"):format(operator), 2)
    end

    return function(value)
      if type(value) == "table" and type(table.n) == "number" then
        return operators[operator](self, value)
      elseif type(value) == "number" then
        return operators[operator](self, Number(value))
      end
    end
  end,
  __add = function(self, v)
    v = c_type(v)
    return Number(self.n + v.n)
  end,
  __sub = function(self, v)
    v = c_type(v)
    return Number(self.n - v.n)
  end,
  __mul = function(self, v)
    v = c_type(v)
    return Number(self.n * v.n)
  end,
  __div = function(self, v)
    v = c_type(v)
    return Number(self.n / v.n)
  end,
  __mod = function(self, v)
    v = c_type(v)
    return Number(self.n % v.n)
  end,
  __pow = function(self, v)
    v = c_type(v)
    return Number(self.n ^ v.n)
  end,

  __eq = function(self, v)
    v = c_type(v)
    return self.n == v.n
  end,
  __lt = function(self, v)
    v = c_type(v)
    return self.n < v.n
  end,
  __le = function(self, v)
    v = c_type(v)
    return self.n <= v.n
  end,
  
  __unm = function(self)
    return Number(-self.n)
  end,

  __tostring = function(self)
    return tostring(self.n)
  end
}

function Number(n)
  return setmetatable({n=n}, nmt)
end

return Number
