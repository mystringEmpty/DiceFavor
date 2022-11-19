return {   --特殊对待的礼物名
    ["拥抱"] = {
        cost = 0,  --好感消耗
        reply = "好，那我{self}就抱一下{nick}当回礼咯",
    },
    ["亲亲"] = {
        favor_floor = 50,  --好感门槛
        cost = 1,  --好感消耗
        cost_deny = 3,  --好感惩罚
        reply = "好，那么，{nick}准备好了吗？",
        reply_deny = "这对{self}与{nick}的关系而言，还有点为时尚早了",
    }
}