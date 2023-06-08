local query_builder = {}
local query = ""

local function add_query_vals(vals, separator)
    local counter = 0
    for _, v in pairs(vals) do
        if counter ~= 0 then
            query = query .. separator .. v
        else
            query = query .. v
        end
        counter = counter + 1
    end
end

local function build_where(where, where_conds)
    if not where and #where_conds == 0 then return end
    query = query .. where
    add_query_vals(where_conds, " AND ")
    return query
end

local function build_group_by(group_by, group_by_cols)
    if not group_by and #group_by_cols == 0 then return end
    query = query .. group_by
    add_query_vals(group_by_cols, ", ")
    return query
end

local function build_order_by(order_by, order_by_conditions)
    if not order_by and #order_by_conditions == 0 then return end
    query = query .. order_by
    add_query_vals(order_by_conditions, ", ")
    return query
end

local function build_select(query_table)
    if not query_table.select and #query_table.from_tables == 0 then
        return false
    end
    query = query_table.select

    if #query_table.select_cols ~= 0 then
        add_query_vals(query_table.select_cols, ", ")
    else
        query = query .. "*"
    end
    query = query .. " FROM "
    add_query_vals(query_table.from_tables, ", ")

    build_where(query_table.where, query_table.where_conditions)
    build_group_by(query_table.group_by, query_table.group_by_cols)
    build_order_by(query_table.order_by, query_table.order_by_conditions)
    if query_table.limit then
        query = query .. query_table.limit .. query_table.limit_size
        if query_table.offset then
            query = query .. query_table.offset ..
                        query_table.offset_size
        end
    end

    query = query .. ";"
    return query
end

local function build_delete(query_table)
    if not query_table.delete then return false end
    query = query_table.delete
    build_where(query_table.where, query_table.where_conditions)
    query = query .. ";"
    if not string.match(query, "WHERE") then
        return query, "DELETING WHOLE TABLE (NO WHERE CLAUSE)"
    end
    return query
end

local function build_update(query_table)
    if not query_table.update then return false end
    query = query_table.update .. query_table.update_table .. " SET "
    local counter = 0
    local temp = ""
    for k, v in pairs(query_table.update_vals) do
        if counter ~= 0 then
            temp = "," .. k .. " = " .. "'" .. v .. "'"
        else
            temp = k .. " = " .. "'" .. v .. "'"
        end
        counter = counter + 1
        query = query .. temp
    end

    build_where(query_table.where, query_table.where_conditions)
    query = query .. ";"
    if not string.match(query, "WHERE") then
        return query, "UPDATING WHOLE TABLE (NO WHERE CLAUSE)"
    end
    return query
end

local function build_insert(query_table)
    if not query_table.insert and #query_table.insert_cols == 0 and
        #query_table.insert_vals == 0 then return false end
    query = query_table.insert .. "("
    add_query_vals(query_table.insert_cols, ", ")
    query = query .. ") VALUES ("
    add_query_vals(query_table.insert_vals, ", ")
    query = query .. ");"
    return query
end

function query_builder.build_query(query_table)
    if query_table.select then return build_select(query_table) end
    if query_table.delete then return build_delete(query_table) end
    if query_table.update then return build_update(query_table) end
    if query_table.insert then return build_insert(query_table) end
    return false
end

return query_builder
