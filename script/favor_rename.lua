--从指定字段迁移数值至favor
local key = string.match(msg.suffix,"^[%s]*(.-)[%s]*$")
if #key==0 then
    return "请{self}指定好感度要从哪个字段迁移至favor"
end
local cnt = 0
for uid,favor in pairs(getUserConf(nil,key)) do
    setUserConf(uid,key)
    setUserConf(uid,"&favor_field",favor)
    cnt = cnt + 1
end
msg.cnt = cnt
return "{self}已将{cnt}条好感数据自「"..key.."」迁移至「{favor_field}」√"