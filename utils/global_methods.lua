function table.get_values_as_str(table)
    if not table then return "Empty/null table." end
    local str = ""
    local counter = 0
    for _, v in pairs(table) do
        if counter ~= 0 then v = "," .. v end

        str = str .. tostring(v)
        counter = counter + 1
    end
    return str
end

function string.ends_with(str, ending) 
        return ending == '' or string.sub(str, -#ending) == ending
end

function string.cut_ending(str, ending)
        return ending == '' and str or string.sub(str, 1, -#ending-1)
end