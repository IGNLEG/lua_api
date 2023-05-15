local request = {}
request.__index = request

function request:new()
    local self = setmetatable({}, request)
    return self
end

function request:set_input(key, value)
    if key and value and key ~= "" and value ~= "" then self[key] = value end
end

function request:get_input(key) if self[key] then return self[key] end end

return request
