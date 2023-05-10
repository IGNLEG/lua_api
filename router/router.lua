_Router = {}

local endpoints = {woo_wee = require "app.woo_wee"}

local routes = {["woo/wee"] = endpoints.woo_wee}

function _Router:direct(route)
    local request_method = _Request.env.REQUEST_METHOD

    if not routes[route] then return _Code_handler:send_404() end
    if not _Request_validator.validate_request_method(request_method, routes[route].allowed_methods) then
        return _Code_handler:send_405()
    end
    if request_method == "GET" then return routes[route].get() end
    if request_method == "POST" then return routes[route].post() end
    if request_method == "DELETE" then return routes[route].delete() end
    if request_method == "PUT" then return routes[route].put() end

end

return _Router
