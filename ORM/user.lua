local user = {}

function user:new(obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    self._tablename = "users"
    return obj
end

function user:get(fields) return dofile("ORM_funcs"):select(self, fields) end

function user:update(fields) return dofile("ORM_funcs"):update(self, fields) end

function user:delete() return dofile("ORM_funcs"):delete(self) end

function user:insert(vals) return dofile("ORM_funcs"):insert(self, vals) end

return user
