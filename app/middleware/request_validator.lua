_Request_validator = {}

local function validate_data_type(content_type, body)
    if content_type == "application/json" and not _Cjson.encode(body) then
        _Code_handler:send_406()
        return false
    end
end

function _Request_validator.validate_request_method(request_method, allowed_methods)
    local found = false
    local i = 0
    while not found and i <= #allowed_methods do
        i = i + 1
        if allowed_methods[i] == request_method then found = true end
    end
    if found == false then
        return false
    end
    return true
end

function _Request_validator:validate(body)
    if not validate_data_type(_Request.env.headers["content-type"], body) then
        return
    end
end

return _Request_validator
