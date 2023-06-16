local Comment = dofile("www/app/models/model.lua")
Comment:set_table_name("comments") --specify which DB table model should use

Comment.fields = {
        "id",
        "date",
        "comment",
        --"users_id"
}

function Comment.get_fields()
        return Comment.fields
end

return Comment