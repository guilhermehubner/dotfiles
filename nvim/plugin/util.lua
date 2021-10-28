function _G.dump(...)
    print(obj_to_str(...))
end

function _G.obj_to_str(...)
    local objects = vim.tbl_map(vim.inspect, {...})
    return unpack(objects)
end
