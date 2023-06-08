
-- local cjson = require "cjson"
-- require "global_methods"

-- local User = require "user"

-- local user = User:new({name = "poe", surname = "allen", email = "email"})
-- -- User:insert(user):done()
-- local curs = User:get({"id", "name", "email"}):where({id_lte = 5}):done()

-- -- user:update({name = "changed_name"}):where({name = "bingo"}):done()

-- -- local data = {}
-- -- local row
-- -- if curs then
-- --     row = curs:fetch({}, "a")

-- --     while row do
-- --         table.insert(data, row)
-- --         row = curs:fetch({}, "a")
-- --     end
-- -- end

-- -- for _, v in pairs(data) do
-- --         print(cjson.encode(v))
-- -- end