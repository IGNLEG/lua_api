local _Router = {}

local function placeholder_middleware()
end

local route = require "app.route"
local route_validator = require "app.middleware.route_validator"
local controller = require "app.dummy_controller"
 --write your endpoints here--
function _Router.initialize()
    route.post('wee/woo', controller.store, placeholder_middleware)
    route.get('wee/woo', controller.index, placeholder_middleware)
    route.delete('wee/woo', controller.destroy, placeholder_middleware)
    route.put('wee/woo', controller.update, placeholder_middleware)
end
------------------------------
function _Router.direct(endpoint, request_method)
    if route_validator.validate_route(endpoint, request_method, route) then
        return route.get_route(endpoint, request_method)["controller_method"]()
    end
end

return _Router
