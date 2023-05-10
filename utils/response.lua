_Response = {}

_Response.headers = {}
_Response.body = {}
_Response.status = ""


function _Response:add_header(key, value)
        self.headers[key] = value
end

function _Response:add_body(value)
        table.insert(self.body, value)
end

function _Response:set_status(value)
        self.status = value
end

return _Response