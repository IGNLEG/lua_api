local Users_comments = dofile("www/app/models/model.lua")

Users_comments:set_table_name("users_comments") --specify which DB table model should use

Users_comments.fields = {
        "users_id",
        "comments_id"
}
return Users_comments