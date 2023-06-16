-- #Aggregate functions# -- 
function _G.desc(column) return column .. " DESC" end

function _G.asc(column) return column .. " ASC" end

function _G.sum(column) return "SUM(" .. column .. ")" end

function _G.avg(column) return "AVG(" .. column .. ")" end

function _G.count(column) return "COUNT(" .. column .. ")" end

function _G.max(column) return "MAX(" .. column .. ")" end

function _G.min(column) return "MIN(" .. column .. ")" end

-- #Data validator methods# --

function _G.is_valid_email(str)
    if str == nil or str:len() == 0 then return nil end
    if (type(str) ~= 'string') then
        error("Expected string")
        return nil
    end
    local lastAt = str:find("[^%@]+$")
    local localPart = str:sub(1, (lastAt - 2)) -- Returns the substring before '@' symbol
    local domainPart = str:sub(lastAt, #str) -- Returns the substring after '@' symbol
    -- we werent able to split the email properly
    if localPart == nil then return nil, "Local name is invalid" end

    if domainPart == nil or not domainPart:find("%.") then
        return nil, "Domain is invalid"
    end

    if string.sub(domainPart, 1, 1) == "." then
        return nil, "First character in domain cannot be a dot"
    end

    -- local part is maxed at 64 characters
    if #localPart > 64 then
        return nil, "Local name must be less than 64 characters"
    end

    -- domains are maxed at 253 characters
    if #domainPart > 253 then
        return nil, "Domain must be less than 253 characters"
    end

    -- somthing is wrong
    if lastAt >= 65 then 
        return nil, "Invalid @ symbol usage" end

    -- quotes are only allowed at the beginning of the local name
    local quotes = localPart:find("[\"]")
    if type(quotes) == 'number' and quotes > 1 then
        return nil, "Invalid usage of quotes"
    end

    -- no @ symbols allowed outside quotes
    if localPart:find("%@+") and quotes == nil then
        return nil, "Invalid @ symbol usage in local part"
    end

    -- no dot found in domain name
    if not domainPart:find("%.") then 
        return nil, "No TLD found in domain" end

    -- only 1 period in succession allowed
    if domainPart:find("%.%.") then
        return nil, "Too many periods in domain" end

    if localPart:find("%.%.") then
        return nil, "Too many periods in local part"
    end

    -- just a general match
    if not str:match('[%w]*[%p]*%@+[%w]*[%.]?[%w]*') then
        return nil, "Email pattern test failed"
    end

    -- all our tests passed, so we are ok
    return true
end

function _G.contains_numbers(str)
    if not string.match(str, '%d') then
        return false, "String does not contain numbers"
    end
    return true
end

function _G.contains_specialChars(str)
    if not string.match(str, '%p') then 
        return false end
    return true
end

function _G.contains_letters(str)
    if not string.match(str, '%a') then 
        return false end
    return true
end

function _G.contains_spaces(str)
    if not string.match(str, '%s') then 
        return false end
    return true
end

function _G.contains_lowercase(str)
    if not string.match(str, '%l') then 
        return false end
    return true
end

function _G.contains_uppercase(str)
    if not string.match(str, '%u') then 
        return false end
    return true
end

function _G.discard_non_fillable(fillabe, rqst_fields)
    local temp = {}
    for k, v in pairs(rqst_fields) do
        if _Tbl.contains(fillabe, k) then temp[k] = v end
    end
    return temp
end