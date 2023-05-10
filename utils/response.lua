local response = {}
response.__index = response

function response:new()
        local self = setmetatable({}, response)
        return self
end

function response:set_input(key, value) self[key] = value end
function response:get_input(key) return self[key] end

return response