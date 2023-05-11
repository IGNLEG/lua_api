_Woo_wee = {}

_Woo_wee.allowed_methods = {"GET", "POST", "PUT", "DELETE"}

function _Woo_wee.get() _Request_validator.validate(_Request:get_input("body")) end

function _Woo_wee.post() _Request_validator.validate(_Request:get_input("body")) end

function _Woo_wee.delete() _Request_validator.validate(_Request:get_input("body")) end

function _Woo_wee.put() _Request_validator.validate(_Request:get_input("body")) end

return _Woo_wee
