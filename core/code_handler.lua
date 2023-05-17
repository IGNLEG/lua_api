_Code_handler = {}

function _Code_handler:send_200() _Response:set_input("status","Status: 200 \r\n") return false end

function _Code_handler:send_400() _Response:set_input("status","Status: 400 \r\n") return false end

function _Code_handler:send_401() _Response:set_input("status","Status: 401 \r\n") return false end

function _Code_handler:send_404() _Response:set_input("status","Status: 404 \r\n") return false end

function _Code_handler:send_405() _Response:set_input("status","Status: 405 \r\n") return false end

function _Code_handler:send_406() _Response:set_input("status","Status: 406 \r\n") return false end

function _Code_handler:send_415() _Response:set_input("status","Status: 415 \r\n") return false end


return _Code_handler
