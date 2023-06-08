function _G.desc(column)
        return column .. " DESC"
end

function _G.asc(column)
        return column .. " ASC"
end

function _G.sum(column)
        return "SUM(" .. column .. ")"
end

function _G.avg(column)
        return "AVG(" .. column .. ")"
end

function _G.count(column)
        return "COUNT(" .. column .. ")"
end

function _G.max(column)
        return "MAX(" .. column .. ")"
end

function _G.min(column)
        return "MIN(" .. column .. ")"
end