msg_reply.favor_tuner = {
    keyword = {
        prefix = {"叮~强制好感"}
    },
    limit = {
        user_var = {
            trust = { at_least = 4 }
        },
        lock = "favor",
    },
    echo = function()
        local favor_add,rest = string.match(msg.fromMsg,"([%-]?%d+)[^%d]*(%d*)")
        local obj = string.match(rest or "","%d+") or msg.fromUser
        local favor = getUserConf(obj,"&favor_field",0) + (favor_add or 100)
        setUserConf(obj,"&favor_field",favor)
        msg.favor = favor
        msg.obj = getUserConf(obj,"nick#"..(msg.fromGroup or ""),obj)
        return "{reply_favor_tuner}"
    end
}
msg_reply.favor_develop = {
    keyword = {
        prefix = {"叮~好感成长"}
    },
    limit = {
        user_var = {
            trust = { at_least = 4 }
        },
        lock = "favor",
    },
    echo = function()
        local obj = string.match(msg.fromMsg,"%d+") or msg.fromUser
        local favor_add = loadLua("favor_develop")(obj)
        msg.obj = getUserConf(obj,"nick#"..(msg.fromGroup or ""),obj)
        if favor_add then
            msg.favor_add = favor_add
            msg.favor = getUserConf(obj,"&favor_field")
            return "{reply_favor_developed}"
        else return "{reply_favor_undeveloped}" end
    end
}
msg_reply.favor_rewrite = {
    keyword = {
        prefix = { "叮~好感覆写" }
    },
    limit = {
        user_var = {
            trust = { at_least = 4 }
        },
        lock = "favor",
    },
    echo = function()
        local favor_new,rest = string.match(msg.fromMsg,"([%-]?%d+)[^%d]*(%d*)")
        local obj = string.match(rest or "","%d+") or msg.fromUser
        msg.obj = getUserConf(obj,"nick#"..(msg.fromGroup or ""),obj)
        setUserConf(obj,"&favor_field",favor_new or 0)
        msg.favor = favor_new
        return "{reply_favor_rewrite}"
    end
}
msg_reply.favor_forget = {
    keyword = {
        prefix = { "叮~好感擦除" }
    },
    limit = {
        user_var = {
            trust = { at_least = 4 }
        },
        lock = "favor",
    },
    echo = function()
        local obj = string.match(msg.fromMsg,"%d+") or msg.fromUser
        msg.obj = getUserConf(obj,"nick#"..(msg.fromGroup or ""),obj)
        setUserConf(obj,"&favor_field")
        return "{reply_favor_forgotten}"
    end
}
msg_reply.favor_rename = {
    keyword = {
        prefix = { "好感迁移自" }
    },
    limit = {
        user_var = {
            trust = { at_least = 4 }
        },
        lock = "favor",
    },
    echo = { lua = "favor_rename" }
}
msg_reply.favor_rename_percent = {
    keyword = {
        prefix = { "好感百分比迁移自" }
    },
    limit = {
        user_var = {
            trust = { at_least = 4 }
        },
        lock = "favor",
    },
    echo = { lua = "favor_rename_percent" }
}