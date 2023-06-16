local route = {}

local route_list = {}

function route.get_list() if route_list then return route_list end end

function route.get_route(endpoint, request_method)
    local temp_endpoint = Convert_id_endpoint(endpoint)
    for _, v in ipairs(route_list) do
        if _Tbl.contains(v, endpoint) and _Tbl.contains(v, request_method) then return v end
        if temp_endpoint and _Tbl.contains(v, temp_endpoint) and _Tbl.contains(v, request_method) then return v, Parse_data_from_endpoint(temp_endpoint) end
    end
    return false
end

function route.post(endpoint, controller_method, middleware, type)
    local exists = false
    for _, v in ipairs(route_list) do
        if _Tbl.contains(v, endpoint) and _Tbl.contains(v, 'POST') and
            _Tbl.contains(v, controller_method) and _Tbl.contains(v, middleware) then
            exists = true
        end
    end
    if not exists then
        table.insert(route_list, {
            ["endpoint"] = endpoint,
            ["REQUEST_METHOD"] = 'POST',
            ["controller_method"] = controller_method,
            ["middleware"] = middleware,
            ["type"] = type
        })
        return true
    end
    return false
end

function route.get(endpoint, controller_method, middleware, type)
    local exists = false
    for _, v in ipairs(route_list) do
        if _Tbl.contains(v, endpoint) and _Tbl.contains(v, 'GET') and
            _Tbl.contains(v, controller_method) and _Tbl.contains(v, middleware) then
            exists = true
        end
    end
    if not exists then
        table.insert(route_list, {
            ["endpoint"] = endpoint,
            ["REQUEST_METHOD"] = 'GET',
            ["controller_method"] = controller_method,
            ["middleware"] = middleware,
            ["type"] = type
        })
        return true
    end
    return false
end
function route.delete(endpoint, controller_method, middleware, type)
    local exists = false
    for _, v in ipairs(route_list) do
        if _Tbl.contains(v, endpoint) and _Tbl.contains(v, 'DELETE') and
            _Tbl.contains(v, controller_method) and _Tbl.contains(v, middleware) then
            exists = true
        end
    end
    if not exists then
        table.insert(route_list, {
            ["endpoint"] = endpoint,
            ["REQUEST_METHOD"] = 'DELETE',
            ["controller_method"] = controller_method,
            ["middleware"] = middleware,
            ["type"] = type
        })
        return true
    end
    return false
end
function route.put(endpoint, controller_method, middleware, type)
    local exists = false
    for _, v in ipairs(route_list) do
        if _Tbl.contains(v, endpoint) and _Tbl.contains(v, 'PUT') and
            _Tbl.contains(v, controller_method) and _Tbl.contains(v, middleware) then
            exists = true
        end
    end
    if not exists then
        table.insert(route_list, {
            ["endpoint"] = endpoint,
            ["REQUEST_METHOD"] = 'PUT',
            ["controller_method"] = controller_method,
            ["middleware"] = middleware,
            ["type"] = type
        })
        return true
    end
    return false
end
return route
