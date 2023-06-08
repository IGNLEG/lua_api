local db = {}
local driver = require "luasql.sqlite3"

function db:new(obj)
        obj = obj or {}
        for k, v in pairs(dofile("www/ORM/db_conf.lua")) do
                obj[k] = v
        end
        obj.driver = driver
        obj.env = obj.driver.sqlite3()
        obj.conn = obj.env:connect(obj.db_path)
        setmetatable(obj, self)
        self.__index = self
        return obj
end

return db