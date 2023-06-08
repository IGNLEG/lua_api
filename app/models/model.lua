local Model = {_ORM_instance = dofile("www/ORM/ORM_model.lua")}

function Model:new(obj)
    obj = obj or {}
    setmetatable(obj, self)
    self.__index = self
    self._tablename = "default"
    return obj
end

function Model:get(fields) return self._ORM_instance:select(self, fields) end

function Model:update(fields) return self._ORM_instance:update(self, fields) end

function Model:delete() return self._ORM_instance:delete(self) end

function Model:insert(vals) return self._ORM_instance:insert(self, vals) end

function Model:close_conn() return self._ORM_instance:close_conn() end

function Model:set_table_name(name)
        self._tablename = name
end
return Model
