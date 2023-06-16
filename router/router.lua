local _Router = {}

local function placeholder_middleware()
end

local route = require "app.route"
local jwt_auth = require "app.middleware.jwt_auth"
--pakeisti require i dinamini failu uzkrovima--

 --write your endpoints here--
function _Router.initialize()
    route.post('basket', dofile("www/app/controllers/basket_controller.lua").store, placeholder_middleware, 'protected')
    route.get('basket', dofile("www/app/controllers/basket_controller.lua").index, placeholder_middleware, 'protected')

    route.post('car', dofile("www/app/controllers/car_controller.lua").store, placeholder_middleware, 'protected')
    route.get('car', dofile("www/app/controllers/car_controller.lua").index, placeholder_middleware, 'protected')

    route.put('path', dofile("www/app/controllers/path_controller.lua").update, placeholder_middleware, 'protected')
    route.get('path', dofile("www/app/controllers/path_controller.lua").index, placeholder_middleware, 'protected')

    route.post('payment', dofile("www/app/controllers/payment_controller.lua").store, placeholder_middleware, 'protected')
    route.delete('payment', dofile("www/app/controllers/payment_controller.lua").destroy, placeholder_middleware, 'protected')

    route.put('picture', dofile("www/app/controllers/picture_controller.lua").update, placeholder_middleware, 'protected')
    route.get('picture', dofile("www/app/controllers/picture_controller.lua").index, placeholder_middleware, 'protected')

    route.post('comment', dofile("www/app/controllers/comment_controller.lua").store, placeholder_middleware, 'protected')
    route.get('comment', dofile("www/app/controllers/comment_controller.lua").index, placeholder_middleware, 'protected')

    route.delete('user', dofile("www/app/controllers/user_controller.lua").destroy, placeholder_middleware, 'protected')
    route.get('user', dofile("www/app/controllers/user_controller.lua").index, placeholder_middleware, 'protected')
    route.post('user', dofile("www/app/controllers/user_controller.lua").store, placeholder_middleware, 'protected')
    route.put('user', dofile("www/app/controllers/user_controller.lua").update, placeholder_middleware, 'protected')


    route.post('login', dofile("www/app/controllers/auth_controller.lua").store, placeholder_middleware, 'public')
end
------------------------------
function _Router.direct(endpoint, request_method)
    if not dofile("www/app/middleware/route_validator.lua").validate_route(endpoint, request_method, route) then
        return
    end
    local req_route, table = route.get_route(endpoint, request_method)
    if req_route and req_route["type"] == 'protected' then
        local token_data = jwt_auth.decode_token(_Request:get_input("jwt"))
        if token_data and jwt_auth.check_token_exp(token_data["exp"]) then
            if table then return req_route["controller_method"](table) end
            return req_route["controller_method"]()
        end
        return _Code_handler:send_401()
    end
    if req_route and req_route["type"] == 'public' then
        if table then return req_route["controller_method"](table) end
        return req_route["controller_method"]()
    end
    return false
end

return _Router
