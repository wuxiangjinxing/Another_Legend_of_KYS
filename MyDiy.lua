if DrawStrBoxYesNo(-1, -1, "要用懒人补丁么？", C_WHITE, 30) == true then
    for i = 1, CC.TeamNum do                 
        local id = JY.Base["队伍" .. i];
		if id >= 0 then
			JY.Person[id]["修炼点数"] = 30000
			War_PersonTrainBook(id)
			JY.Person[id]["经验"] = 52000
			War_AddPersonLVUP(id);		
		end
    end
end

if DrawStrBoxYesNo(-1, -1, "要看看NPC么？", C_WHITE, 30) == true then
instruct_10(50)
instruct_10(592)
instruct_10(455)
instruct_10(597)
instruct_10(607)
instruct_10(419)
instruct_10(430)
instruct_10(440)
instruct_10(580)
instruct_10(613)
end

if DrawStrBoxYesNo(-1, -1, "要初始化人物门派么？", C_WHITE, 30) == true then
JoinMP(7,14,4) --何太冲
JoinMP(24,14,4) --余沧海
JoinMP(25,12,5) --蓝凤凰
JoinMP(43,14,4) --白万剑
JoinMP(67,18,5) --裘千仞
JoinMP(71,13,5) --洪安通
JoinMP(83,12,5) --何铁手
JoinMP(87,13,2) --苏荃
JoinMP(137,14,1) --陈达海
JoinMP(166,14,3) --班淑娴
JoinMP(176,12,2) --何红药
JoinMP(180,14,2) --洞玄
JoinMP(181,14,2) --闵子华
JoinMP(184,14,3) --玉真子
JoinMP(596,13,5) --洪安通
JoinMP(626,14,4) --何足道
JoinMP(629,14,2) --阿九
JoinMP(661,14,2) --白绣

for i = 211, 220 do --青城弟子
	JoinMP(i,14,1)
end

for i = 221, 230 do --五毒教徒
	JoinMP(i,12,1)
end

for i = 241, 250 do --雪山弟子
	JoinMP(i,14,1)
end

for i = 281, 290 do --铁掌帮众
	JoinMP(i,18,1)
end

for i = 340, 349 do --昆仑弟子
	JoinMP(i,14,1)
end

for i = 390, 398 do --神龙教徒
	JoinMP(i,13,1)
end
JoinMP(399,13,2)

for i = 669, 678 do --青城弟子
	JoinMP(i,14,1)
end

for i = 679, 688 do --五毒教徒
	JoinMP(i,12,1)
end

for i = 699, 708 do --雪山弟子
	JoinMP(i,14,1)
end

for i = 739, 748 do --铁掌帮众
	JoinMP(i,18,1)
end

for i = 798, 807 do --昆仑弟子
	JoinMP(i,14,1)
end

for i = 848, 856 do --神龙教徒
	JoinMP(i,13,1)
end
JoinMP(857,13,2)
end

--[[
for id = 0, JY.ThingNum - 1 do
	if JY.Thing[id]["类型"] <= 2 then
		instruct_32(id)
	end
end

for i = 1, CC.HZNum do
	addHZ(i);
end

--DIY专用伤害计算
function War_DIY_WugongHurtLife(emenyid, wugong, hurt, ang, dng)
	local eid = WAR.Person[emenyid]["人物编号"]
	return hurt, ang, dng;
end

--蓝烟清：DIY战斗子函数专用
function War_DIY_Fight(id, wugong, level, ng)
	return ng;
end
]]