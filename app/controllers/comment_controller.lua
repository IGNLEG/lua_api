local comment_controller = {}

function comment_controller.index()
        _Code_handler:send_200()
        return "product GET (index) reached"
end

function comment_controller.store()
        _Code_handler:send_200()
        return "product POST (store) reached"
end

function comment_controller.destroy()
        _Code_handler:send_200()
        return "product DELETE (destroy) reached"
end

function comment_controller.update()
        _Code_handler:send_200()
        return "product PUT (update) reached"
end

return comment_controller