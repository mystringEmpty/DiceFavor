favors = getUserConf(nil,"&favor_field")
rank = {}
function printFavor(data)
    return string.format("%.0f",data.favor).."~"..getUserConf(data.uid,"nick").."("..data.uid..")"
end
for uid,favor in pairs(favors) do
    log("favor#"..uid..":"..favor)
    if #rank==0 then table.insert(rank,{uid=uid,favor=favor})
    else
        for idx,data in ipairs(rank) do
            if data.favor<=favor then
                table.insert(rank,idx,{uid=uid,favor=favor})
                break
            elseif idx>10 then
                break
            end
        end
    end
end
res = {}
for idx,data in ipairs(rank) do
    if idx>10 and data.favor<rank[10].favor then
        break
    end
    table.insert(res,printFavor(data))
end
msg.ranking = table.concat(res,"\n")
return "{reply_favor_rank}"