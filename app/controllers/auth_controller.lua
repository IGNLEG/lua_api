local auth_controller = {}

-- local jwt_auth = require "app.middleware.jwt_auth"

function auth_controller.index()
        _Code_handler:send_200()
        return "auth GET (index) reached"
end

function auth_controller.store()
        _Code_handler:send_200()
        return {token = dofile("www/app/middleware/jwt_auth.lua").generate_token()}
end

function auth_controller.destroy()
        _Code_handler:send_200()
        return "auth DELETE (destroy) reached"
end

function auth_controller.update()
        _Code_handler:send_200()
        return "auth PUT (update) reached"
end

return auth_controller