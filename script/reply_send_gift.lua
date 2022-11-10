local gifts = getSelfData("gifts.json")
local daily_gift_limit = gifts.daili_times or 3   --单日次数上限
local gift_favor_limit = gifts.favor_limit or 100 --送礼能达到的好感上限
local gift_list = gifts.special or {   --特殊对待的礼物名
    ["肖战"] = {
        refuse = true, --是否拒收
        favor = -10,  --好感变化
        reply = "谁要这玩意儿啊！你自己留着吧！\f*{self}一把把那玩意儿糊到了{nick}脸上*",
    },
    ["丛雨陪睡券"] = {
        refuse = false, --是否拒收
        favor = 3,  --好感变化
        reply = "嘿嘿，谢谢{nick}送的陪睡券～晚上这就去找丛雨~",
    },
}
local user_today = getUserToday(msg.uid)
local today_gift = user_today.rcv_gifts or 0
if(today_gift >= daily_gift_limit)then
    return "够啦～{nick}今天已经送得太多了"
end
user_today.rcv_gifts = today_gift+1
local gift = string.match(msg.suffix,"^[%s]*(.-)[%s]*$")
if gift=="" then
    return "嗯？{nick}要送{self}什么？"
end
local my_today = getUserToday(getDiceQQ())
local self_today_gift = my_today.gifts or 0
local favor = getUserConf(msg.fromQQ, favor_title, 0)
local react = gift_list[gift]
if(react)then
    local add_favor = react.favor or 1
    if(react.favor<0)then
        setUserConf(msg.fromQQ, favor_title, favor + add_favor)
    elseif(ranint(1,gift_favor_limit)>favor)then
        setUserConf(msg.fromQQ, favor_title, math.min(gift_favor_limit,favor + add_favor))
    end
    if(react.refuse)then
        return react.reply
    end
    my_today.gifts = self_today_gift+1
    return react.reply.."\n今日收礼:"..string.format("%d",self_today_gift).."件"
end
--local self_total_gift = getUserConf(me, "gifts", 0)+1
--setUserConf(me, "gifts", self_total_gift)
if(ranint(1,gift_favor_limit)>favor)then setUserConf(msg.fromQQ, favor_title, favor + 1) end
my_today.gifts = self_today_gift+1
return "谢谢{nick}送的"..gift.."~\n今日收礼:"..string.format("%d",self_today_gift).."件"