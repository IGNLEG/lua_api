package.path = package.path .. ";/www/?.lua"
_Cjson = require("cjson")
local request_parser = require "utils/request_parser"
local router = require "router/router"
_Code_handler = require "core/code_handler"
_Request_validator = require "app/middleware/request_validator"
_Request = require "utils.request"
_Response = require "utils/response"

_Request_body = ""

local function send_response()
    _Response:add_header("Content-Type:", "application/json\n")
    _Response:add_header("Cache-Control:", "no-cache\n\n")

    for k, v in pairs(_Response.headers) do uhttpd.send(k .. v) end

    uhttpd.send(_Cjson.encode(_Request.body))
end

-- Main body required by uhhtpd-lua plugin
function handle_request(env)

    _Request.body = io.read("*all")
    

    request_parser.parse_request(env)
    router:direct(_Request.path)
    send_response()

end
