msg_reply.favor_show = {
    keyword = {
        match = {"{strSelfNick}好感"}
    },
    limit = {
        cd = {
            user = 60
        }
    },
    echo = function()
        if getUserConf(msg.uid,"&favor_field") then
            return "{reply_favor_show}"
        else
            return "{reply_favor_show_nil}"
        end
    end
}
msg_reply.favor_rank = {
    keyword = {
        match = {"{strSelfNick}好感排行"}
    },
    limit = {
        cd = {
            user = 60
        }
    },
    echo = function()
        loadLua("ranking")
        msg.ranking = rank_user("&favor_field","%.0f")
        return "{reply_favor_rank}"
    end
}
msg_reply.favor_group_rank = {
    keyword = {
        match = {"{strSelfNick}群内好感排行"}
    },
    limit = {
        grp_id = {nor = {0}},
        cd = 60
    },
    echo = function()
        loadLua("ranking")
        msg.ranking = rank_group_member(msg.gid,"&favor_field","%.0f")
        return "{reply_favor_rank}"
    end
}