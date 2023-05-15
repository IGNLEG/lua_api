local response = {}
response.__index = response

function response:new()
    local self = setmetatable({}, response)
    return self
end
function response:set_input(key, value)
    if key and value and key ~= "" and value ~= "" then self[key] = value end
end

function response:get_input(key) if self[key] then return self[key] end end

return response
