local user_controller = {}

function user_controller.index()
        _Code_handler:send_200()
        return "user GET (index) reached"
end

function user_controller.store()
        _Code_handler:send_200()
        return "user POST (store) reached"
end

function user_controller.destroy()
        _Code_handler:send_200()
        return "user DELETE (destroy) reached"
end

function user_controller.update()
        _Code_handler:send_200()
        return "user PUT (update) reached"
end

return user_controller