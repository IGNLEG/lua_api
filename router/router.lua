local _Router = {}

local function placeholder_middleware()
end

local route = require "app.route"
local route_validator = require "app.middleware.route_validator"
local basket_controller = require "app.controllers.basket_controller"
local car_controller = require "app.controllers.car_controller"
local path_controller = require "app.controllers.path_controller"
local payment_controller = require "app.controllers.payment_controller"
local picture_controller = require "app.controllers.picture_controller"
local product_controller = require "app.controllers.product_controller"
local user_controller = require "app.controllers.user_controller"
local auth_controller = require "app.controllers.auth_controller"
local jwt_auth = require "app.middleware.jwt_auth"
 --write your endpoints here--
function _Router.initialize()
    route.post('basket', basket_controller.store, placeholder_middleware, 'protected')
    route.get('basket', basket_controller.index, placeholder_middleware, 'protected')

    route.post('car', car_controller.store, placeholder_middleware, 'protected')
    route.get('car', car_controller.index, placeholder_middleware, 'protected')

    route.put('path', path_controller.update, placeholder_middleware, 'protected')
    route.get('path', path_controller.index, placeholder_middleware, 'protected')

    route.post('payment', payment_controller.store, placeholder_middleware, 'protected')
    route.delete('payment', payment_controller.destroy, placeholder_middleware, 'protected')

    route.put('picture', picture_controller.update, placeholder_middleware, 'protected')
    route.get('picture', picture_controller.index, placeholder_middleware, 'protected')

    route.post('product', product_controller.store, placeholder_middleware, 'protected')
    route.get('product', product_controller.index, placeholder_middleware, 'protected')

    route.delete('user', user_controller.destroy, placeholder_middleware, 'protected')
    route.get('user', user_controller.index, placeholder_middleware, 'protected')

    route.post('login', auth_controller.store, placeholder_middleware, 'public')
end
------------------------------
function _Router.direct(endpoint, request_method)
    if route_validator.validate_route(endpoint, request_method, route) then
        local req_route = route.get_route(endpoint, request_method)
        if req_route and req_route["type"] == 'protected' then
            local token_data = jwt_auth.decode_token(_Request:get_input("jwt"))
            if token_data and jwt_auth.check_token_exp(token_data["exp"]) then
                return req_route["controller_method"]()
            end
            return _Code_handler:send_401()
        end
        if req_route and req_route["type"] == 'public' then
            return req_route["controller_method"]()
        end
    end
end

return _Router
