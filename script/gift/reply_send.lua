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
local favor = getUserConf(msg.uid, "&favor_field", 0)
local giftsp = getSelfData("gift/special_present.json")
local list = giftsp:get()
if not next(list) then
    list = loadLua("gift.init_present")
    giftsp:set(list)
end
local react = list[gift]
if(react)then
    local add_favor = react.favor or 1
    if(add_favor<0)then
        setUserConf(msg.uid, "&favor_field", favor + add_favor)
    elseif(ranint(1,gift_favor_limit)>favor)then
        setUserConf(msg.uid, "&favor_field", math.min(gift_favor_limit,favor + add_favor))
    end
    if(react.refuse)then
        return react.reply
    end
    self_today_gift = self_today_gift+1
    my_today.gifts = self_today_gift
    msg.rcv_today = self_today_gift
    return react.reply.."{gift_send_today_stat}"
end
local refuse = Gift.refuse_default  --拒绝来路不明
msg.gift = gift
if refuse then return "{gift_send_refuse_default}" end
if gift_favor_limit>favor then loadLua("favor_develop")(msg.uid,gift_favor_limit,1) end
self_today_gift = self_today_gift+1
my_today.gifts = self_today_gift
msg.rcv_today = self_today_gift
Gift.rcv_total = (Gift.rcv_total or 0) + 1
return "{gift_send_accept_default}"