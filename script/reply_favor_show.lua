local favor = getUserConf(msg.uid,"&favor_field")
if favor then
    msg.favor = favor
    return "{reply_favor_show}"
else
    return "{reply_favor_show_nil}"
end