msg_reply.send_gift = {
    keyword = {
        prefix = {"{strPresentSpell}"}
    },
    limit = {
        cd = {
            user = 30,
            echo = "{gift_send_colding}"
        },
        lock = "gifts",
    },
    echo = { lua = "gift.reply_send" }
}
msg_reply.demand_gift = {
    keyword = {
        prefix = {"{strDemandSpell}"}
    },
    limit = {
        cd = {
            user = 30,
            echo = "{gift_demand_colding}"
        },
        lock = "gifts",
    },
    echo = { lua = "gift.reply_demand" }
}