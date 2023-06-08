package.path = package.path .. ";/www/?.lua"

_Cjson = require("cjson")
_Code_handler = require "core/code_handler"
_Request_validator = require "app/middleware/request_validator"
_Request = require "utils.request"
_Response = require "utils/response"
_Tbl = require "helper.table_methods"
_Jwt = require "luajwtjitsi"
local request_parser = require "utils/request_parser"
local router = require "router/router"

local function send_response(response_data)
    uhttpd.send(_Response:get_input("status"))
    _Response:set_input("headers", {})
    table.insert(_Response:get_input("headers"), "Content-Type: application/json\n")
    table.insert(_Response:get_input("headers"), "Cache-Control: no-cache\n\n")

    for k, v in pairs(_Response:get_input("headers")) do uhttpd.send(v) end
    _Response:set_input("body",
                            _Cjson.encode({["body_data"] = _Request:get_input("body_data")}) ..
                            "\n" ..
                            _Cjson.encode( {["uri_data"] = _Request:get_input("uri_data")}))
    uhttpd.send(_Response:get_input("body"))
    if response_data then uhttpd.send("\n" .. _Cjson.encode(response_data)) end
    --uhttpd.send(_Cjson.encode(_Request:get_input("env")))

end

-- Main body required by uhhtpd-lua plugin
function handle_request(env)

    router.initialize()
    if(request_parser.parse_request(env)) then
        local response_data = router.direct(_Request:get_input("path") ,_Request:get_input("env").REQUEST_METHOD)
        send_response(response_data)
    else
        uhttpd.send(_Response:get_input("status"))
        uhttpd.send("\n sum ting wong")
    end

end



