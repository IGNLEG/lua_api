local User = dofile("www/app/models/model.lua")

User:set_table_name("users") --specify which DB table model should use

function User:comments(left, right)
        local col_name = "user_id"
        local relationship = "hasMany"
end

return User