_Code_handler = {}

function _Code_handler:send_200() _Response:set_status("Status: 200 \r\n") end

function _Code_handler:send_400() _Response:set_status("Status: 400 \r\n") end

function _Code_handler:send_404() _Response:set_status("Status: 404 \r\n") end

function _Code_handler:send_405() _Response:set_status("Status: 405 \r\n") end

function _Code_handler:send_406() _Response:set_status("Status: 406 \r\n") end

return _Code_handler
