local car_controller = {}

function car_controller.index()
        _Code_handler:send_200()
        return "car GET (index) reached"
end

function car_controller.store()
        _Code_handler:send_200()
        return "car POST (store) reached"
end

function car_controller.destroy()
        _Code_handler:send_200()
        return "car DELETE (destroy) reached"
end

function car_controller.update()
        _Code_handler:send_200()
        return "car PUT (update) reached"
end

return car_controller