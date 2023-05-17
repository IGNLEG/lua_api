local path_controller = {}

function path_controller.index()
        _Code_handler:send_200()
        return "path GET (index) reached"
end

function path_controller.store()
        _Code_handler:send_200()
        return "path POST (store) reached"
end

function path_controller.destroy()
        _Code_handler:send_200()
        return "path DELETE (destroy) reached"
end

function path_controller.update()
        _Code_handler:send_200()
        return "path PUT (update) reached"
end

return path_controller