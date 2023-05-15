local tbl_methods = {}

function tbl_methods.contains(table, value)
        for _, v in pairs(table) do if v == value then return true end end
        return false
    end

return tbl_methods