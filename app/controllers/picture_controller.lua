local picture_controller = {}

function picture_controller.index()
        _Code_handler:send_200()
        return "picture GET (index) reached"
end

function picture_controller.store()
        _Code_handler:send_200()
        return "picture POST (store) reached"
end

function picture_controller.destroy()
        _Code_handler:send_200()
        return "picture DELETE (destroy) reached"
end

function picture_controller.update()
        _Code_handler:send_200()
        return "picture PUT (update) reached"
end

return picture_controller