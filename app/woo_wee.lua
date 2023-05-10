_Woo_wee = {}

_Woo_wee.allowed_methods = {"GET", "POST", "PUT", "DELETE"}

function _Woo_wee.get()
    _Request_validator:validate(_Request_body)
    return "GET route reached"
end

function _Woo_wee.post()
    _Request_validator:validate(_Request_body)
    return _Response:add_body("POST route reached")
end

function _Woo_wee.delete()
    _Request_validator:validate(_Request_body)
    return _Response:add_body("DELETE route reached")
end

function _Woo_wee.put()
    _Request_validator:validate(_Request_body)
    return _Response:add_body("PUT route reached")
end

return _Woo_wee
