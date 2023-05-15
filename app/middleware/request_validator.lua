local _Request_validator = {}

local function validate_data_type(content_type, body)
    if not (string.match(content_type, "application/json") or
        string.match(content_type, "multipart/form%-data") or
        string.match(content_type, "application/x%-www%-form%-urlencoded")) then
        return _Code_handler:send_415()
    end

    if content_type == "application/json" and not _Cjson.encode(body) then
        return _Code_handler:send_400()
    end
    if content_type == "multipart/form-data" and
        not string.match(body, "Content-Disposition: ") then
        return _Code_handler:send_400()
    end
    if content_type == "application/x-www-form-urlencoded" and
        not string.match(body, "(%w+)=(%w+)") then
        return _Code_handler:send_400()
    end

    return true
end

function _Request_validator.validate(body)
    if not validate_data_type(_Request:get_input("env").headers["content-type"],
                              body) then return false end
    return true
end

return _Request_validator
