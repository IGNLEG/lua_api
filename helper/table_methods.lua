local tbl_methods = {}

function tbl_methods.contains(table, value)
        for _, v in pairs(table) do if v == value then return true end end
        return false
    end

function tbl_methods.size(table)
    local counter = 0
    for _,_ in pairs(table) do 
        counter = counter + 1
    end
    return counter
end


return tbl_methods
