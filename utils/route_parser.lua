function Convert_id_endpoint(endpoint)
    local capturePattern = "(%w+)" .. "/(%d+)"
    local table, id = string.match(endpoint, capturePattern)
    if id then
        endpoint = string.gsub(endpoint, capturePattern, table .. "/:id")
        return endpoint
    end
    return nil
end

function Parse_data_from_endpoint(endpoint)
    local capturePattern = "(%w+)" .. "/(%d+)"
    local table, id = string.match(endpoint, capturePattern)
    local result = nil
    if id then
        result[table] = id
        return result
    end
    return result
end
