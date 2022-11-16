function rank_user(field,formater)
    local datas = getUserConf(nil,field)
    local rank = {}
    for id,val in pairs(datas) do
        local idx=1
        for i,data in ipairs(rank) do
            if data.val<=val or i>10 then
                break
            end
            idx = i+1
        end
        if idx<=10 then table.insert(rank,idx,{id=id,val=val}) end
    end
    local res = {}
    for idx,data in ipairs(rank) do
        if idx>10 and data.val<rank[10].val then
            break
        end
        table.insert(res,string.format(formater, data.val).."~"..getUserConf(data.id,"nick"))
    end
    return table.concat(res,"\n")
end
function rank_group_member(gid,field,formater)
    local mem = getGroupConf(gid,"members")
    local rank = {}
    for i,uid in ipairs(mem) do
        local val = getUserConf(uid,field)
        if not val then goto continue end
        local idx = 1
        for j,data in ipairs(rank) do
            if data.val<=val or j>10 then
                break
            end
            idx = j+1
        end
        log("插入用户"..uid.."~"..val)
        if idx<=10 then table.insert(rank,idx,{id=uid,val=val}) end
        ::continue::
    end
    local res = {}
    for idx,data in ipairs(rank) do
        if idx>10 and data.val<rank[10].val then
            break
        end
        table.insert(res,string.format(formater, data.val).."~"..getUserConf(data.id,"nick"))
    end
    return table.concat(res,"\n")
end