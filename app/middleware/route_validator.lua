local route_validator = {}

local function validate_request_method(endpoint, request_method, route_obj)
    for _, v in pairs(route_obj.get_list()) do
        if _Tbl.contains(v, endpoint) and _Tbl.contains(v, request_method) then return true end
    end
    return _Code_handler:send_405()
end

local function route_exists(endpoint, route_obj)
    for _, v in pairs(route_obj.get_list()) do
        if _Tbl.contains(v, endpoint)then return true end
    end
    return _Code_handler:send_404()
end

function route_validator.validate_route(endpoint, request_method, route_obj)
    if not route_exists(endpoint, route_obj) then return end
    if not validate_request_method(endpoint, request_method, route_obj) then return end
    return true
end

return route_validator
