local basket_controller = {}

function basket_controller.index()
        _Code_handler:send_200()
        return "basket GET (index) reached"
end

function basket_controller.store()
        _Code_handler:send_200()
        return "basket POST (store) reached"
end

function basket_controller.destroy()
        _Code_handler:send_200()
        return "basket DELETE (destroy) reached"
end

function basket_controller.update()
        _Code_handler:send_200()
        return "basket PUT (update) reached"
end

return basket_controller