local product_controller = {}

function product_controller.index()
        _Code_handler:send_200()
        return "product GET (index) reached"
end

function product_controller.store()
        _Code_handler:send_200()
        return "product POST (store) reached"
end

function product_controller.destroy()
        _Code_handler:send_200()
        return "product DELETE (destroy) reached"
end

function product_controller.update()
        _Code_handler:send_200()
        return "product PUT (update) reached"
end

return product_controller