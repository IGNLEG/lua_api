local Comment = dofile("app/models/model.lua")

Comment.set_table_name("comments") --specify which DB table model should use

function Comment.users(check)
        local relationship = "belongsTo"
end

return Comment