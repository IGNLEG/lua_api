local User = dofile("www/app/models/model.lua")

User:set_table_name("users") --specify which DB table model should use

User.fillabe = {
        "name",
        "surname",
        "email"
}
User.fields = {
        "id",
        "name",
        "surname",
        "email"
}

function User:comments()
        self._ORM_instance.set_query_table_val("join_rtbl", dofile("www/app/models/comment.lua"))
        self._ORM_instance.set_query_table_val("join", " LEFT JOIN ")
        return self
end

return User