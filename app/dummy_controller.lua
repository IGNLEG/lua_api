local temp_controller = {}

function temp_controller.index()
        _Code_handler:send_200()
        return "GET (index) reached"
end

function temp_controller.store()
        _Code_handler:send_200()
        return "POST (store) reached"
end

function temp_controller.destroy()
        _Code_handler:send_200()
        return "POST (store) reached"
end

function temp_controller.update()
        _Code_handler:send_200()
        return "POST (store) reached"
end

return temp_controller