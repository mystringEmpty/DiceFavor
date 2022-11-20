--默认机制：D[max]>当前好感或=[max]时成长X或XDY或自定义函数
local function favor_develop(uid,max,exp) --#2要求为正数或空缺；#3要求为整数或“XDY”或function
    local face = max or 100
    local roll = ranint(1,face)
    local favor = getUserConf(uid,"&favor_field",0)
    log("当前好感"..favor)
    if roll<=favor and roll~=face then return end
    if type(exp)=="number" then
        setUserConf(uid,"&favor_field",favor+exp)
        return exp
    elseif type(exp)=="function" then
        local favor_add = exp()
        if favor_add then setUserConf(uid,"&favor_field",favor+favor_add) end
        return favor_add
    elseif type(exp)=="string" then
        local x,y=string.match(exp or "1D10","(%d*)D(%d+)")
        local favor_add = 0
        for i=1,x or 1 do
            favor_add = favor_add + ranint(1,y)
        end
        setUserConf(uid,"&favor_field",favor+favor_add)
        return favor_add
    else
        local favor_add = ranint(1,10)
        setUserConf(uid,"&favor_field",favor+favor_add)
        return favor_add
    end
end
return favor_develop