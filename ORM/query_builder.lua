local query_builder = {}
local query = ""

local function add_query_vals(vals, separator, table_name)
    local counter = 0
    if not table_name then
        table_name = ""
    else
        table_name = table_name .. "."
    end
    for _, v in pairs(vals) do
        if counter ~= 0 then
            query = query .. separator .. table_name .. v
        else
            query = query .. table_name .. v
        end
        counter = counter + 1
    end
end

local function build_where(where, where_conds, table_name)
    if not where and #where_conds == 0 then return end
    query = query .. where
    add_query_vals(where_conds, " AND ", table_name)
    return query
end

local function build_group_by(group_by, group_by_cols, table_name)
    if not group_by and #group_by_cols == 0 then return end
    query = query .. group_by
    add_query_vals(group_by_cols, ", ", table_name)
    return query
end

local function build_order_by(order_by, order_by_conditions, table_name)
    if not order_by and #order_by_conditions == 0 then return end
    query = query .. order_by
    add_query_vals(order_by_conditions, ", ", table_name)
    return query
end

local function build_join(join_tbl)
    for _, v in pairs(join_tbl) do
        query = query .. " JOIN " .. v.j_table._tablename .. " ON " .. v.l_val .. " = " .. v.r_val
    end
    return query
end

local function build_json(table_name, cols, array)
    if not table and not table.fields then return end
    if array then query = query .. ', JSON_GROUP_ARRAY(JSON_OBJECT('
    end
    local counter = 0
    for _, v in pairs(cols) do
        if not string.match(query, table_name .. "." .. v) then
            if counter ~= 0 then
                query = query .. ', ' .. "'" .. v .. "'"
                query = query .. ', ' .. table_name .. "." .. v
            else
                query = query .. "'" .. v .. "'"
                query = query .. ', ' .. table_name .. "." .. v
            end
            counter = counter + 1
        end
    end
    if array then query = query .. "))"
    end
    return query
end

local function build_select_cols(select_cols, parent_tbl, child_tbls)
    query = query .. "JSON_OBJECT("
    build_json(parent_tbl, select_cols)
    query = query .. ") AS " .. parent_tbl .. "_info"

    if _Tbl.size(child_tbls) < 1 then
        return query
    end

    for _, v in pairs(child_tbls) do
        if v.select then
        build_json(v.j_table._tablename, v.j_table.fields, true)
        query = query .. " AS " .. v.j_table._tablename
        end
    end
    return query
end

local function build_select(query_table)
    if not query_table.select and #query_table.from_table == nil then
        return false
    end
    query = query_table.select

    if #query_table.select_cols ~= 0 then
        build_select_cols(query_table.select_cols, query_table.from_table, query_table.join_tbls)
    end

    query = query .. " FROM " .. query_table.from_table
    if query_table.join then
        build_join(query_table.join_tbls)
    end
    build_where(query_table.where, query_table.where_conditions,
                query_table.from_table)
    build_group_by(query_table.group_by, query_table.group_by_cols,
                   query_table.from_table)
    build_order_by(query_table.order_by, query_table.order_by_conditions,
                   query_table.from_table)
    if query_table.limit then
        query = query .. query_table.limit .. query_table.limit_size
        if query_table.offset then
            query = query .. query_table.offset .. query_table.offset_size
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
            temp = "," .. k .. " = " .. '"' .. v .. '"'
        else
            temp = k .. " = " .. '"' .. v .. '"'
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
    query = query_table.insert .. query_table.insert_table .. "("
    add_query_vals(query_table.insert_cols, ", ")
    query = query .. ") VALUES ("
    local counter = 0
    local temp = ""
    for k, v in pairs(query_table.insert_vals) do
        if counter ~= 0 then
            temp = "," .. '"' .. v .. '"'
        else
            temp = '"' .. v .. '"'
        end
        counter = counter + 1
        query = query .. temp
    end
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
