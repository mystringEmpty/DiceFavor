Gift = getSelfData("gift.json")
local daily_gift_limit = Gift.daily_send_limit or 3   --单日次数上限
local gift_favor_limit = Gift.favor_limit or 100 --送礼能达到的好感上限
local user_today = getUserToday(msg.uid)
local today_gift = user_today.rcv_gifts or 0
if(today_gift >= daily_gift_limit)then
    return "{gift_send_daily_limit}"
end
user_today.rcv_gifts = today_gift+1
local gift = string.match(msg.suffix,"^[%s]*(.-)[%s]*$")
if #gift==0 then
    return "{gift_send_empty}"
end
local my_today = getUserToday(getDiceQQ())
local self_today_gift = my_today.gifts or 0
local user = msg.user
local favor = user["&favor_field"] or 0
local giftsp = getSelfData("gift/special_present.json")
local list = giftsp:get()
if not next(list) then
    list = loadLua("gift.init_present")
    giftsp:set(list)
end
local react = giftsp[gift]
if(react)then
    local add_favor = react.favor or 1
    if(react.favor<0)then
        user["&favor_field"] = favor + add_favor
    elseif(ranint(1,gift_favor_limit)>favor)then
        user["&favor_field"] = math.min(gift_favor_limit,favor + add_favor)
    end
    if(react.refuse)then
        return react.reply
    end
    my_today.gifts = self_today_gift+1
    return react.reply.."\n今日收礼:"..string.format("%d",self_today_gift).."件"
end
if gift_favor_limit>favor then loadLua("favor_develop")(msg.uid,gift_favor_limit,1) end
my_today.gifts = self_today_gift+1
Gift.rcv_total = (Gift.rcv_total or 0) + 1
return "谢谢{nick}送的"..gift.."~\n今日收礼:"..string.format("%d",self_today_gift).."件"