--从指定字段迁移数值至favor
key = string.match(msg.fromMsg,"^[%s]*(.-)[%s]*$",#"好感迁移自"+1)
local cnt = 0
for uid,favor in pairs(getUserConf(nil,key)) do
    setUserConf(uid,key)
    setUserConf(uid,"&favor_field",favor/100)
    cnt = cnt + 1
end
msg.cnt = cnt
return "{self}已将{cnt}条好感数据自「"..key.."」以百分比迁移至「{favor_field}」√"