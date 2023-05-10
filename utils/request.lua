local request = {}
request.__index = request

function request:new()
        local self = setmetatable({}, request)
        return self
end

function request:set_input(key, value) self[key] = value end
function request:get_input(key) return self[key] end

return request