Gift = getSelfData("gift.json")
local daily_limit = Gift.daily_return_limit or 3   --单日次数上限
local user_today = getUserToday(msg.uid)
local today_gift = user_today.ret_gifts or 0
if(today_gift >= daily_limit)then
    return "{gift_demand_daily_limit}"
end
user_today.ret_gifts = today_gift+1
local gift = string.match(msg.suffix,"^[%s]*(.-)[%s]*$")
if #gift==0 then
    return "{gift_return_default}"
end
local giftsp = getSelfData("gift/special_return.json")
local list = giftsp:get()
if not next(list) then
    list = loadLua("gift.init_return")
    giftsp:set(list)
end
local react = giftsp[gift]
if(react)then
    local favor = getUserConf(msg.uid,"&favor_field", 0)
    local cost = react.cost or 0
    if favor < cost or favor < (react.favor_floor or 0) then
        return react.reply_deny or "{gift_demand_favor_limit}"
    end
    if cost~=0 then
        setUserConf(msg.uid,"&favor_field",  - cost)
    end
    msg.ret_gift = gift
    return react.reply or "{gift_return_given}"
end
msg.gift = gift
return "{gift_return_not_met}"