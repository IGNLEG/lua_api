local payment_controller = {}

function payment_controller.index()
        _Code_handler:send_200()
        return "payment GET (index) reached"
end

function payment_controller.store()
        _Code_handler:send_200()
        return "payment POST (store) reached"
end

function payment_controller.destroy()
        _Code_handler:send_200()
        return "payment DELETE (destroy) reached"
end

function payment_controller.update()
        _Code_handler:send_200()
        return "payment PUT (update) reached"
end

return payment_controller