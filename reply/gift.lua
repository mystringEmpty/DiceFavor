msg_reply.send_gift = {
    keyword = {
        prefix = {"送{strSelfNick}"}
    },
    limit = {
        cd = { user = 30 },
        today = { user = 10 },
    },
    echo = { lua="reply_send_gift" }
}