local jwt_auth = {}
local key = "this_key_should_be_more_secure"
local alg = "HS256"

function jwt_auth.generate_token()
    local token_body = {strt = os.time(), exp = os.time() + 3600}

    local token, err = _Jwt.encode(token_body, key, alg)
    if token then return token end
    return false
end

function jwt_auth.decode_token(token)
    local decoded, err 
    if token then decoded, err = _Jwt.verify(token, alg, key) end
    if decoded then return decoded end
    return false
end

function jwt_auth.check_token_exp(exp_time)
    if os.time() >= exp_time then return false end
    return true
end

return jwt_auth
