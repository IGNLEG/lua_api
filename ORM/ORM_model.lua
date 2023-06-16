local ORM_model = {
    query_table = {
        select = nil,
        select_cols = {},
        from_table = nil,
        where = nil,
        where_conditions = {},
        update = nil,
        update_table = nil,
        update_vals = {},
        insert = nil,
        insert_table = nil,
        insert_cols = {},
        insert_vals = {},
        delete = nil,
        delete_table = nil,
        limit = nil,
        limit_size = nil,
        offset = nil,
        offset_size = nil,
        order_by = nil,
        order_by_conditions = {},
        group_by = nil,
        group_by_cols = {},
        join = nil,
        join_tbls = {}
    },
    db = dofile("www/ORM/db.lua"):new()
}

local LESS_THAN = "_lt"
local EQ_OR_LESS_THAN = "_lte"
local MORE_THAN = "_gt"
local EQ_OR_MORE_THAN = "_gte"

function ORM_model.set_query_table_val(query_val, set_val)
    ORM_model.query_table[query_val] = set_val
end

function ORM_model:close_conn() return self.db.conn:close() end

function ORM_model:select(model, cols)
    self.query_table.select = "SELECT "
    self.query_table.from_table = model._tablename

    if not cols then
        for _, v in pairs(model.fields) do
        v = self.db.conn:escape(v)
        table.insert(self.query_table.select_cols, v)
        end
        return self end
    for _, v in cols do
        v = self.db.conn:escape(v)
        table.insert(self.query_table.select_cols, v)
    end
    return self
end

local function parse_compare(condition, v)
    local where_operator
    local colname
    if string.ends_with(condition, LESS_THAN) and type(v) == type(1) then
        where_operator = " < "
        colname = string.cut_ending(condition, LESS_THAN)

    elseif string.ends_with(condition, MORE_THAN) and type(v) == type(1) then
        where_operator = " > "
        colname = string.cut_ending(condition, MORE_THAN)

    elseif string.ends_with(condition, EQ_OR_MORE_THAN) and type(v) == type(1) then
        where_operator = " >= "
        colname = string.cut_ending(condition, EQ_OR_MORE_THAN)

    elseif string.ends_with(condition, EQ_OR_LESS_THAN) and type(v) == type(1) then
        where_operator = " <= "
        colname = string.cut_ending(condition, EQ_OR_LESS_THAN)

    else
        where_operator = " = "
        colname = condition
    end
    return where_operator, colname
end

function ORM_model:join(j_table, l_val, r_val, select)
    self.query_table.join = " JOIN "
    table.insert(self.query_table.join_tbls, {["j_table"] = j_table, ["l_val"] = l_val, ["r_val"] = r_val, ["select"] = select})
    return self
end


function ORM_model:where(conditions)
    self.query_table.where = " WHERE "
    local where_operator = ''
    local colname = ''

    if not conditions then
        self.query_table.where_conditions = nil
        return self
    end
    for condition, v in pairs(conditions) do
        where_operator, colname = parse_compare(condition, v)
        v = self.db.conn:escape(v)
        colname = self.db.conn:escape(colname)
        where_operator = self.db.conn:escape(where_operator)
        table.insert(self.query_table.where_conditions,
                     colname .. where_operator .. v)
    end
    return self
end

function ORM_model:update(model, fields)
    fields = discard_non_fillable(model.fillabe, fields)
    self.query_table.update = "UPDATE "
    self.query_table.update_table = model._tablename
    self.query_table.update_vals = fields
    return self
end

function ORM_model:delete(model)
    self.query_table.delete = "DELETE FROM " .. model._tablename
    return self
end

function ORM_model:limit(size)
    self.query_table.limit = " LIMIT "
    self.query_table.limit_size = size
    return self
end

function ORM_model:offset(size)
    self.query_table.offset = " OFFSET "
    self.query_table.offset_size = size
    return self
end

function ORM_model:insert(model, fields)
    fields = discard_non_fillable(model.fillabe, fields)
    self.query_table.insert = "INSERT INTO "
    self.query_table.insert_table =  model._tablename
    for k, v in pairs(fields) do
        k = self.db.conn:escape(k)
        v = self.db.conn:escape(v)
        table.insert(self.query_table.insert_cols, k)
        table.insert(self.query_table.insert_vals, v)
    end
    return self
end

function ORM_model:orderBy(conditions)
    self.query_table.order_by = " ORDER BY "
    for _, v in pairs(conditions) do
        v = self.db.conn:escape(v)
        table.insert(self.query_table.order_by_conditions, v)
    end
    return self
end

function ORM_model:groupBy(cols)
    self.query_table.group_by = " GROUP BY "
    for _, v in pairs(cols) do
        v = self.db.conn:escape(v)
        table.insert(self.query_table.group_by_cols, v)
    end
    return self
end

function ORM_model:first()
    self.query_table.limit = " LIMIT "
    self.query_table.limit_size = 1
    return self
end

local function get_select_data(self, curs)
    local data = {}
    local row
    row = curs:fetch({}, "a")
    if not row then return nil
    else
        for k, v in pairs(row) do
            if string.match(v, "%b{}") then row[k] = _Cjson.decode(v) end
        end
        table.insert(data, row)
    end
    if curs then
        row = curs:fetch({}, "a")
        while row do
            for k, v in pairs(row) do
                if string.match(v, "%b{}") then row[k] = _Cjson.decode(v) end
            end
            table.insert(data, row)
            row = curs:fetch({}, "a")
        end
    end
    curs:close()
    self.db.conn:close()
    return data
end

local function parse_cursor(self, query, curs)
    if string.match(query, "SELECT") then return get_select_data(self, curs) end
    self.db.conn:close()
    return curs
end

function ORM_model:done()
    local query = dofile("www/ORM/query_builder.lua").build_query(self.query_table)
    uhttpd.send("\n\n" .. query)    
    local curs = self.db.conn:execute(query)
    return parse_cursor(self, query, curs)
end

return ORM_model
