local user_controller = {}

local function check_if_exists()
    local User = dofile("www/app/models/user.lua")
    local user
    if _Request:get_input("body_data")["id"] then user = User:get():where({id = _Request:get_input("body_data")["id"]}):done()
    else user = User:get():where(_Request:get_input("body_data")):done()
    end
    if user then
        User:close_conn()
        return true
    end
    User:close_conn()
    return false
end

function user_controller.index()
    local User = dofile("www/app/models/user.lua")
    local data = User:get():limit(5):orderBy({desc('id'), asc('name')}):offset(5):where({id_lt = 40}):orderBy({"id"}):done()
    if data then
        _Code_handler:send_200()
        return data
    end
    _Code_handler:send_400()
    return {message = "Error getting user data."}
end

function user_controller.store()
    local User = dofile("www/app/models/user.lua")
    if check_if_exists() then
        _Code_handler:send_400()
        User:close_conn()
        return {message = "User already exists."}
    end
    if User:insert(_Request:get_input("body_data")):done() then 
        _Code_handler:send_201()
        return {message = "User created successfully."}
    end

    _Code_handler:send_400()
    return {message = "Error while creating user."}    
end

function user_controller.destroy()
    local User = dofile("www/app/models/user.lua")
    if not check_if_exists() then 
        User:close_conn()
        _Code_handler:send_404()
        return {message = "User does not exist."} 
    end    
    if User:delete():where({id = _Request:get_input("body_data")["id"]}):done() then
        _Code_handler:send_200()
        return {message = "User deleted successfully."}
    end
    _Code_handler:send_400()
    return {message = "Error while deleting user."}
end

function user_controller.update()
    local User = dofile("www/app/models/user.lua")
    if not check_if_exists() then 
        _Code_handler:send_404()
        User:close_conn()
        return {message = "User does not exist."} 
    end    

    if User:update(_Request:get_input("body_data")):where({id = _Request:get_input("body_data")["id"]}):done() then
        _Code_handler:send_200()
        return {message = "User successfully updated."}
    end
    _Code_handler:send_400()
    return {message = "Error while updating user."}
end

return user_controller
