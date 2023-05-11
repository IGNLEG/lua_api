local _Request_parser = {}

local function parse_form_data(data)
    local parsed_data = {}
    if data:sub(-1) ~= "\r\n" then data = data .. "\r\n" end
    local counter = 0
    local keys, values = {}, {}
    for k in data:gmatch("(.-)\r\n") do
        counter = counter + 1
        if string.match(k, "name=") then
            table.insert(keys, string.match(k, 'name="(.+)"'))
        end
        if counter % 4 == 0 then table.insert(values, k) end
    end

    for k, v in ipairs(keys) do parsed_data[v] = values[k] end
    return parsed_data
end

local function parse_form_urlencoded_data(data)
    local parsed_data = {}
    for k, v in string.gmatch(data, "(%w+)=(%w+)") do -- not secure 
        parsed_data[k] = v
    end
    return parsed_data
end

local function parse_json(data) return _Cjson.decode(data) end

local function parse_data(body, content_type)
    if string.match(content_type, "multipart/form%-data") then
        
        return parse_form_data(body)
    end
    if string.match(content_type, "application/json") then
        return parse_json(body)
    end
    if string.match(content_type, "application/x-www-form-urlencoded") then
        return parse_form_urlencoded_data(body)
    end
end

function _Request_parser.parse_request(env)
    _Request:set_input("env", env)
    _Request:set_input("path", string.match(env.PATH_INFO, "^/*(.+)"))
    _Request:set_input("body", io.read("*all"))
    _Request:set_input("body_data", parse_data(_Request:get_input("body"), _Request:get_input("env").CONTENT_TYPE))
    _Request:set_input("uri_data", parse_form_urlencoded_data(env.REQUEST_URI))
end

return _Request_parser
