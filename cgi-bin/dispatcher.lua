package.path = package.path .. ";/www/?.lua"

_Cjson = require("cjson")
_Code_handler = require "core/code_handler"
_Request_validator = require "app/middleware/request_validator"
_Request = require "utils.request"
_Response = require "utils/response"

local request_parser = require "utils/request_parser"
local router = require "router/router"

local function send_response()
    _Response:set_input("headers", {})
    table.insert(_Response:get_input("headers"), "Content-Type: application/json\n")
    table.insert(_Response:get_input("headers"), "Cache-Control: no-cache\n\n")

    for k, v in pairs(_Response:get_input("headers")) do uhttpd.send(k .. v) end
    _Response:set_input("body",
                            _Cjson.encode({["body_data"] = _Request:get_input("body_data")}) ..
                            "\n" ..
                            _Cjson.encode( {["uri_data"] = _Request:get_input("uri_data")}))
    uhttpd.send(_Response:get_input("body"))
end

-- Main body required by uhhtpd-lua plugin
function handle_request(env)

    request_parser.parse_request(env)
    router:direct(_Request:get_input("path"))
    send_response()
end
