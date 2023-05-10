_Request_parser = {}

function _Request_parser.parse_request(env)
    _Request.path = string.match(env.PATH_INFO, "^/*(.+)")
    _Request.env = env
    _Request.body = io.read("*all")
    for k, v in string.gmatch(env.REQUEST_URI, "(%w+)=(%w+)") do
        _Request.uri_data[k] = v
    end
end

return _Request_parser
