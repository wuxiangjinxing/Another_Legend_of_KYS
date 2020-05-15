--[[
30010 - quest
30015 - gambling
30050 - random stuff

63, 0 - # of random stuff
63, 1 - battle protagonist
63, 2 - battle antagonist

63, 3 - quest type
63, 4 - quest completion status
63, 5 - duel enemy
63, 6 - guard quest destination
63, 7 - #of quests

63, 20 - rumor battle #
63, 21 - rumor battle type
]]

local function randomPD(tt)
	local max = 0
	for i = 1, #tt do
		max = max + tt[i]
	end
	local event = math.random(max)
	local count = 0
	local result = 1
	for i = 1, #tt do
		if event > count and event <= tt[i] + count then
			result = i
			break
		end
		count = tt[i] + count
	end
	return result
end


local function changeattrib(id, str, flag) -- flag 0 - random, 1 - +, 2 - -
	local change = 0
	local word = "增加"
	if math.random(50) <= 5 or flag == 2 then
		change = 1
		word = "减少"
	end
	if flag == 1 then
		change = 0
		word = "增加"
	end
	local number = math.random(0, 10)
	if str == "攻击力" or str == "轻功" or str == "防御力" then
		number = number + 5
	end
	if change == 1 then
		number = math.modf(number * -1)
	end	
	AddPersonAttrib(id, str, number)
	if id == 0 then
		id = zj()
	end
	return JY.Person[id]["姓名"].."的"..str..word..math.abs(number).."点"
end

local function conversion (pp)
	if pp == 1 then
		pp = "攻击力"
	elseif pp == 2 then
		pp = "轻功"
	elseif pp == 3 then
		pp = "防御力"
	elseif pp == 4 then
		pp = "拳掌功夫"
	elseif pp == 5 then
		pp = "御剑能力"
	elseif pp == 6 then
		pp = "耍刀技巧"
	else
		pp = "特殊兵器"
	end
	return pp
end


--[[
63, 3 - quest type 
1 保镖 
2 讨伐
3 夺还 
4 决斗 
5 除害
63, 4 - quest completion status
63, 5 - duel enemy
63, 6 - guard quest destination
63, 7 - #of quests
]]
OEVENTLUA[30010] = function() --接任务
	if GetS(106, 63, 3, 0) ~= 0 and GetS(106, 63, 4, 0) == 1 then --完成
		say("做得好！这是你的酬金。", 96, 0, "中介人")
		Cls()
		if GetS(106, 63, 3, 0) == 2 then --讨伐
			local times = math.random(2, 5)
			for i = 1, times do
				if math.random(100) <= 30 then
					addthing(174, math.random(500, 3000))		
				else
					local thing = randomthing()
					addthing(thing, math.random(1, 5))		
				end
			end			
		elseif GetS(106, 63, 3, 0) == 3 then --夺还
			local times = math.random(5)
			for i = 1, times do
				if math.random(50) == 1 then
					local thing = randomwugong()
					addthing(thing, 1)						
				elseif math.random(100) <= 20 then
					addthing(174, math.random(200, 1000))		
				else
					local thing = randomthing()
					addthing(thing, math.random(2, 5))		
				end
			end					
		elseif GetS(106, 63, 3, 0) == 5 then --除害
			local times = math.random(5)
			for i = 1, times do
				if math.random(100) <= 40 then
					addthing(174, math.random(500, 2000))		
				else
					addthing(210, math.random(20))	
					addthing(209, math.random(20))	
				end
				if math.random(100) <= 30 then
					addthing(math.random(14, 17), math.random(2))
				end
			end			
		end
		SetS(106, 63, 3, 0, 0)
		SetS(106, 63, 4, 0, 0)
		SetS(106, 63, 5, 0, 0)
		SetS(106, 63, 6, 0, 0)	
		do return end
	end
	if GetS(106, 63, 3, 0) == 1 and JY.SubScene == GetS(106, 63, 6, 0) then --完成保镖
		say("这一路辛苦了，这里是你的酬金。", 96, 0, "中介人")
		addthing(174, math.random(500, 5000))	
		for i=1, CC.TeamNum do
			if JY.Base["队伍"..i] >= 0 then
				AddPersonAttrib(JY.Base["队伍"..i], "实战", 20)
			end
		end	
		QZXS("全体队友实战增加20点");		
		SetS(106, 63, 3, 0, 0)
		SetS(106, 63, 4, 0, 0)
		SetS(106, 63, 5, 0, 0)
		SetS(106, 63, 6, 0, 0)
		do return end
	end
	if GetS(106, 63, 3, 0) ~= 0 then
		say("这么多任务你忙不过来的，先把你手上的任务完成掉吧。", 96, 0, "中介人")
		do return end
	end
	if GetS(106, 63, 7, 0) > 20 and hasHZ(21) == false then
		say("这段时间多亏了你四处奔走，这是辛苦费，请继续努力。", 96, 0, "中介人")
		addHZ(21)
		do return end
	end
	if GetS(106, 63, 7, 0) >= math.modf(3 + 3 * tianshu()) then
		say("暂时没有任务给你，过阵子再来吧。", 96, 0, "中介人")
		do return end
	end
	Cls()
	local quest = math.random(5)		
	if quest == 1 then
		say("委托人有一趟镖急需今天出发。你想接受这个任务吗？", 96, 0, "中介人")	
		Cls()
		if DrawStrBoxYesNo(-1, -1, "要接受吗？", C_WHITE, 30) == false then		
			do return end
		end
		OEVENTLUA[30013]()				
	elseif quest == 2 then
		say("附近有山贼作恶，官府悬赏能人进行讨伐。你想接受这个任务吗？", 96, 0, "中介人")	
		Cls()
		if DrawStrBoxYesNo(-1, -1, "要接受吗？", C_WHITE, 30) == false then		
			do return end
		end	
		SetS(106, 63, 3, 0, 2)
		Cls()
		say("他们就在附近的山岭里，请多小心。", 96, 0, "中介人")	
	elseif quest == 3 then
		say("委托人的传家之宝多年之前因故流落民间，最近终于重出江湖。", 96, 0, "中介人")	
		Cls()
		say("委托人希望你能悄悄地把它夺回来。你想接受这个任务吗？", 96, 0, "中介人")
		Cls()
		if DrawStrBoxYesNo(-1, -1, "要接受吗？", C_WHITE, 30) == false then		
			do return end
		end			
		SetS(106, 63, 3, 0, 3)
		Cls()
		say("得到此宝的那个人最近会在附近出现，请多小心。", 96, 0, "中介人")	
	elseif quest == 4 then		
		say("委托人与人约好了在这里对决，但是突然来不了了。", 96, 0, "中介人")	
		Cls()
		say("为了名誉着想，需要一个人替他应战。你想接受这个任务吗？", 96, 0, "中介人")	
		if DrawStrBoxYesNo(-1, -1, "要接受吗？", C_WHITE, 30) == false then		
			do return end
		end
		OEVENTLUA[30012]()		
	elseif quest == 5 then
		say("附近最近有野兽横行伤人，官府正在悬赏除害。你想接受这个任务吗？", 96, 0, "中介人")	
		Cls()
		if DrawStrBoxYesNo(-1, -1, "要接受吗？", C_WHITE, 30) == false then		
			do return end
		end	
		SetS(106, 63, 3, 0, 5)
		Cls()
		say("野兽群就在附近的山岭里，请多小心。", 96, 0, "中介人")	
	end
	SetS(106, 63, 7, 0, GetS(106, 63, 7, 0) + 1)
end
--[[
OEVENTLUA[30011] = function() --大地图任务
	local yes = 0
	if math.random(100) == 100 then
		yes = 1
	end
	if yes == 0 then
		do return end
	end
	if yes == 1 then
		if GetS(106, 63, 3, 0) == 1 then
			Cls()	
			say("此路是我开，此树是我栽，要想从此过，留下买路财！", math.random(100, 200), 0, "山贼")		
			if WarMain(287) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end			
			light()
			do return end
		elseif GetS(106, 63, 3, 0) == 2 and GetS(106, 63, 4, 0) ~= 1 then
			Cls()	
			say("谁敢闯山！", math.random(100, 200), 0, "山贼甲")	
			Cls()	
			say("大胆山贼！速速放下武器投降！")				
			Cls()	
			say("哈哈哈，又是官府派来送死的。", math.random(100, 200), 0, "山贼乙")	
			Cls()	
			say("兄弟们上！", math.random(100, 200), 0, "山贼丙")				
			if WarMain(286) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end		
			SetS(106, 63, 4, 0, 1)	
			light()
			say("终于解决掉了。回去交差吧。")	
			do return end	
		elseif GetS(106, 63, 3, 0) == 3 and GetS(106, 63, 4, 0) ~= 1 then
			Cls()	
			say("看到了！应该就是那个人。虽然有点对不起他....但是没办法了....")				
			if WarMain(290) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end		
			SetS(106, 63, 4, 0, 1)	
			light()
			say("终于抢回来了，回去交差吧。")	
			do return end				
		elseif GetS(106, 63, 3, 0) == 5 and GetS(106, 63, 4, 0) ~= 1 then
			Cls()	
			say("是这里了！果然很多野兽横行！")							
			if WarMain(286) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end		
			SetS(106, 63, 4, 0, 1)	
			light()
			say("终于解决掉了。回去交差吧。")	
			do return end			
		end	
			
	end		
end
]]
OEVENTLUA[30012] = function() --决斗任务	
	Cls()
	local enemy = -1
	while true do
		enemy = math.random(1, 130)
		if not xiaobin(enemy) and not duiyou(enemy) then
			break
		end
	end
	SetS(106, 63, 5, 0, enemy)
	if WarMain(289) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end	
	light()
	Cls()
	say("做得好！这是你的酬金。", 96, 0, "中介人")
	local times = math.random(5)
	for i = 1, times do
		if math.random(40) == 1 then
			local thing = randomwugong()
			addthing(thing, 1)						
		elseif math.random(100) <= 20 then
			addthing(174, math.random(200, 1000))		
		else
			local thing = randomthing()
			addthing(thing, math.random(2, 5))		
		end
	end			
	AddPersonAttrib(zj(), "实战", 15)
	QZXS(JY.Person[zj()]["姓名"].."实战增加15点！")		
end

OEVENTLUA[30013] = function() --保镖任务
	local list = {1, 3, 40, 60, 61}
	local word = {"河洛客栈", "有间客栈", "洛阳城", "龙门客栈", "高升客栈"}
	local place
	while true do
		place = math.random(#list)
		if list[place] ~= JY.SubScene then
			break
		end
	end
	SetS(106, 63, 6, 0, list[place])
	SetS(106, 63, 3, 0, 1)
	say("请把镖安全的送到"..word[place].."，拜托了。", 96, 0, "中介人")	
end

OEVENTLUA[30014] = function() --擂台
	local pid, eid = -1
	local number = math.random(3)
	say("这里是江湖传闻小站，一切皆有可能，本客栈概不负责任。",220,0,"传闻站") 	
	Cls()
	if GetS(106, 63, 20, 0) >= math.modf(5 + 5 * tianshu()) then
		say("最近暂时没有什么传闻，过段时间再来吧。",220,0,"传闻站") 	
		do return end
	end	
	local event = math.random(#CC.battle)
	say(CC.battle[event][4],220,0,"传闻站") 
	Cls()
	if not inteam(CC.battle[event][2]) then
		do return end
	end
	say("咦？难道你就是传闻中的人？",220,0,"传闻站") 	
	Cls()
	if DrawStrBoxYesNo(-1, -1, "要接受吗？", C_WHITE, 30) == false then		
		say("对不起，原来我看错了。",220,0,"传闻站") 	
		do return end
	end		
	SetS(106, 63, 21, 0, CC.battle[event][1])
	SetS(106, 63, 20, 0, GetS(106, 63, 20, 0) + 1)
	
	pid = CC.battle[event][2]
	eid = CC.battle[event][3]
	local tmp1 = JY.Person[eid]["攻击力"] 	
	local tmp2 = JY.Person[eid]["轻功"]
	local tmp3 = JY.Person[eid]["防御力"]	
	
	JY.Person[eid]["攻击力"] = math.modf(JY.Person[pid]["攻击力"] * 0.7) + math.random(100)
	JY.Person[eid]["轻功"] = math.modf(JY.Person[pid]["轻功"] * 0.6) + 50
	JY.Person[eid]["防御力"] = math.modf(JY.Person[pid]["防御力"] * 0.7) + math.random(100)
	
	if WarMain(291) == false then
		Cls()
		JY.Person[eid]["攻击力"] = tmp1
		JY.Person[eid]["轻功"] = tmp2
		JY.Person[eid]["防御力"] = tmp3
		light()
		say("看来你修行还不够啊....",220,0,"传闻站") 	
		for i = 1, number do
			local str = math.random(7)
			str = conversion(str)
			QZXS(changeattrib(pid, str, 2))
		end
		do return end
	end
	Cls()
	JY.Person[eid]["攻击力"] = tmp1
	JY.Person[eid]["轻功"] = tmp2
	JY.Person[eid]["防御力"] = tmp3	
	light()
	for i = 1, number + 1 do
		local str = math.random(7)
		str = conversion(str)
		QZXS(changeattrib(pid, str, 1))
	end	
	Cls()
	say("恭喜你顺利解决了传闻。",220,0,"传闻站") 		
end

OEVENTLUA[30050] = function() --奇遇总汇
	local pd = math.modf((101 - JY.Person[zj()]["资质"]) * 0.1)
	if putong() == 11 then
		pd = pd + 3
	end
	if GetS(106, 63, 0, 0) >= math.modf(pd + 5 + 5 * tianshu()) then
		do return end
	end
	local yes = 0
	if math.random(20) == 5 then
		yes = 1
	end
	if yes == 0 then
		do return end
	end
	if yes == 1 then
		local bonus = tianshu()
		local bonus2 = math.modf((101 - JY.Person[zj()]["资质"]) * 0.1)
		local lv = randomPD({10, 9, 8, 7, 6, 5, 4, 3, 2, 1})
		if hasHZ(94) then --getHZ(zj(), 21) or hasTF(zj(), 94) 武骧金星：修正BUG
			lv = randomPD({0, 0, 0, 7, 6, 5, 4, 3, 2, 1})
		end
		if putong() == 11 and lv < 5 then
			lv = randomPD({0, 0, 0, 7, 6, 5, 4, 3, 2, 1})
		end
		local prob = {
			{0, 10, 15, 25, 25, 15, 10}, --1
			{0, 15, 10, 25, 25, 10, 15}, --2
			{0, 15, 10, 25, 25, 10, 15}, --3
			{0, 15, 10, 25, 25, 10, 15}, --4
			{0, 20, 10, 20, 20, 10, 20}, --5
			{0, 20, 10, 20, 20, 10, 20}, --6
			{0, 20, 10, 20, 20, 10, 20}, --7
			{0, 25, 10, 15, 15, 10, 25}, --8
			{0, 25, 10, 15, 15, 10, 25}, --9
			{0, 30, 10, 10, 10, 10, 30}, --10
		}
		local qy = randomPD(prob[lv])                                     --math.random(2, 7)                  --randomPD(prob[lv])
		--while qy == 3 do
		--	qy = randomPD(prob[lv]) -- 测试
		--end
		if (JY.Thing[203][WZ6] or 0) >= 20 then
			if qy <= 5 then
				qy = 5
			else
				qy = 7
			end
		end
		if qy == 1 then
			OEVENTLUA[30051](lv)
		elseif qy == 2 then
			local tmp = lv - 2
			if tmp <= 0 then
				tmp = 1
			end
			if lv > 11 then
				lv = 15
				tmp = 9
			end
			if lv == tmp then
				lv = lv + 1
			end
			OEVENTLUA[30052](tmp, lv)
		elseif qy == 3 then
			OEVENTLUA[30053]()
		elseif qy == 4 then
			OEVENTLUA[30054]()
		elseif qy == 5 then
			OEVENTLUA[30055]()
		elseif qy == 6 then
			OEVENTLUA[30056]()
		elseif qy == 7 then
			local tmp = lv
			if lv == 10 then
				lv = 15
			end
			OEVENTLUA[30057](tmp, lv)		
		end	
		SetS(106, 63, 0, 0, GetS(106, 63, 0, 0) + 1)
	end	
end

OEVENTLUA[30051] = function(aa) --捡物品
	say("咦？地上好像有什么东西....")
	local times = math.random(aa) + 1
	for i = 1, times do
		if math.random(100) <= 30 then
			addthing(174, math.random(100, 1000))		
		else
			local thing = randomthing()
			addthing(thing, math.random(1, 3))		
		end
	end
	say("哈哈！赚到了赚到了！")
end

OEVENTLUA[30052] = function(aa, bb) --捡武功
	say("咦？地上好像有本书....")
	local thing = randomwugong2(aa, bb)
	local count = 0
	while true do
		if hasthing(thing) == false or count >= 25 then
			break
		end
		count = count + 1
		thing = randomwugong2(aa, bb)
	end
	addthing(thing, 1)		
	if count >=25 then
		say("原来是已经看过的旧书。")
	else
		say("哈哈！赚到了赚到了！")
	end
end

OEVENTLUA[30053] = function() --挑战
	local teamnum = 1
	local enemy = -1
	local prot = -1
	for i = 2, CC.TeamNum do
		if JY.Base["队伍" .. i] > 0 then
			teamnum = teamnum + 1
		end
	end
	prot = JY.Base["队伍" .. math.random(teamnum)]
	SetS(106, 63, 1, 0, prot)
	while true do
		enemy = math.random(1, 500)
		if xiaobin(enemy) then
			break
		end
	end
	SetS(106, 63, 2, 0, enemy)
	Cls()	
	say("站住！久闻"..JY.Person[prot]["姓名"].."大名，在下不才，倒想领教一番！", math.random(100, 200), 0, "江湖客")
	if DrawStrBoxYesNo(-1, -1, "要比武么？", C_WHITE, 30) == false then	
		say("在下实力不济，不敢献丑！")	
		do return end
	end
	JY.Person[enemy]["攻击力"] = JY.Person[enemy]["攻击力"] + 150
	JY.Person[enemy]["轻功"] = JY.Person[enemy]["轻功"] + 150
	JY.Person[enemy]["防御力"] = JY.Person[enemy]["防御力"] + 150	
	JY.Person[enemy]["生命最大值"] = JY.Person[enemy]["生命最大值"] + 500	
	JY.Person[enemy]["生命"] = JY.Person[enemy]["生命最大值"]			
	if WarMain(288) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end	
	JY.Person[enemy]["攻击力"] = JY.Person[enemy]["攻击力"] - 150
	JY.Person[enemy]["轻功"] = JY.Person[enemy]["轻功"] - 150
	JY.Person[enemy]["防御力"] = JY.Person[enemy]["防御力"] - 150	
	JY.Person[enemy]["生命最大值"] = JY.Person[enemy]["生命最大值"] - 500	
	JY.Person[enemy]["生命"] = JY.Person[enemy]["生命最大值"]		
	light()	
	AddPersonAttrib(prot, "实战", 25)
	AddPersonAttrib(prot, "攻击力", 12)
	AddPersonAttrib(prot, "轻功", 12)
	AddPersonAttrib(prot, "防御力", 12)
	QZXS(JY.Person[prot]["姓名"].."实战增加25点！攻防轻增加12点！")
end


OEVENTLUA[30054] = function() --捡药
	local money = math.random(3) * 1000
	local head = math.random(350, 575)
	Cls()
	say("这位少侠，我这里有秘制的灵丹，可以助你增进修为。现在只要"..money.."两银子。不知道你有没有兴趣？", head, 0, "商人")
	Cls()
	if DrawStrBoxYesNo(-1, -1, "要给钱么？", C_WHITE, 30) == false then	
		say("我看起来像是这么好骗的人吗？一边去！")	
		do return end
	end
	Cls()
	if JY.GOLD < money then
		say("原来是个穷鬼，浪费我时间！", head, 0, "商人")
		do return end
	end
	Cls()
	say("我买了！")	
	instruct_2(174, -money)
	Cls()

        local x1 = CC.MainSubMenuX
        local y1 = CC.MainSubMenuY + CC.SingleLineHeight
        CC.DYRW = -1
        CC.DYRW2 = -1
	DrawStrBox(x1, y1, "想让谁服用这秘制丹药呢？",C_WHITE, CC.DefaultFont);
	local menu = {}
	local menu2 = {}
	local id = -1
	for i = 1, CC.TeamNum do
		menu[i] = {"", nil, 0}
		id = JY.Base["队伍" .. i]	
		if id >= 0 and duiyou(id) then
			menu[i] = { JY.Person[id]["姓名"], nil, 1}
		end
	end
	local numItem = table.getn(menu);
	local size = CC.DefaultFont;
	local r = ShowMenu(menu,numItem,0,x1,y1+40,0,0,1,1,size,C_ORANGE,C_WHITE);	
               id = JY.Base["队伍" .. r]
	CC.DYRW = id
        local aa = math.random(7, 14)
        AddPersonAttrib(id, "攻击力", aa)
        QZXS(JY.Person[id]["姓名"].."攻击力增加".. aa.."点！")        
        local bb = math.random(6, 15)
        AddPersonAttrib(id, "轻功", bb)
        QZXS(JY.Person[id]["姓名"].."轻功增加".. bb.."点！")      
        local cc = math.random(7, 14)
        AddPersonAttrib(id, "防御力", cc)
        QZXS(JY.Person[id]["姓名"].."防御力增加".. cc.."点！")      

end


OEVENTLUA[30055] = function() --遇大侠
	local money = math.random(3) * 1000
	if (JY.Thing[203][WZ6] or 0) >= 20 then money = 3000 end
	local head = math.random(350, 575)
	Cls()
	say("本大侠的补习班，只需要"..money.."两银子，有兴趣吗？", head, 0, "大侠")
	Cls()
	if DrawStrBoxYesNo(-1, -1, "要给钱么？", C_WHITE, 30) == false then	
		say("我看起来像是这么好骗的人吗？一边去！")	
		do return end
	end
	Cls()
	if JY.GOLD < money then
		say("原来是个穷鬼，浪费我时间！", head, 0, "大侠")
		do return end
	end
	Cls()
	say("我要报名！")	
	instruct_2(174, -money)
	Cls()
    local x1 = CC.MainSubMenuX
    local y1 = CC.MainSubMenuY + CC.SingleLineHeight
    CC.DYRW = -1
    CC.DYRW2 = -1
	DrawStrBox(x1, y1, "想让谁跟大侠学习下呢？",C_WHITE, CC.DefaultFont);
	local menu = {}
	local menu2 = {}
	local id = -1
	for i = 1, CC.TeamNum do
		menu[i] = {"", nil, 0}
		id = JY.Base["队伍" .. i]	
		if id >= 0 and duiyou(id) then
			menu[i] = { JY.Person[id]["姓名"], nil, 1}
		end
	end
	local numItem = table.getn(menu);
	local size = CC.DefaultFont;
	local r = ShowMenu(menu,numItem,0,x1,y1+40,0,0,1,1,size,C_ORANGE,C_WHITE);	
        id = JY.Base["队伍" .. r]
	CC.DYRW = id
        local aa = math.random(6, 8)
		if (JY.Thing[203][WZ6] or 0) >= 20 then aa = 8 end
        AddPersonAttrib(id, "拳掌功夫", aa)
	QZXS(JY.Person[id]["姓名"].."拳掌功夫增加".. aa.."点！")        
        local bb = math.random(6, 8)
		if (JY.Thing[203][WZ6] or 0) >= 20 then bb = 8 end
        AddPersonAttrib(id, "御剑能力", bb)
	QZXS(JY.Person[id]["姓名"].."御剑能力增加".. bb.."点！")      
        local cc = math.random(6, 8)
		if (JY.Thing[203][WZ6] or 0) >= 20 then cc = 8 end
        AddPersonAttrib(id, "耍刀技巧", cc)
	QZXS(JY.Person[id]["姓名"].."耍刀技巧增加".. cc.."点！")      
        local dd = math.random(6, 8)
		if (JY.Thing[203][WZ6] or 0) >= 20 then dd = 8 end
        AddPersonAttrib(id, "特殊兵器", dd)
	QZXS(JY.Person[id]["姓名"].."特殊兵器增加".. dd.."点！")      
        local ee = math.random(6, 8)
		if (JY.Thing[203][WZ6] or 0) >= 20 then ee = 8 end
        AddPersonAttrib(id, "暗器技巧", ee)
	QZXS(JY.Person[id]["姓名"].."暗器技巧增加".. ee.."点！")      
end

OEVENTLUA[30056] = function() --遇铁匠
	local money = math.random(3) * 1000
	local head = math.random(350, 575)
	Cls()
	say("这位少侠，我可以帮你锻炼身上的神兵利器，只需要"..money.."两银子，你有兴趣吗？", head, 0, "铁匠")
	Cls()
	if DrawStrBoxYesNo(-1, -1, "要给钱么？", C_WHITE, 30) == false then	
		say("我看起来像是这么好骗的人吗？一边去！")	
		do return end
	end
	Cls()
	if JY.GOLD < money then
		say("原来是个穷鬼，浪费我时间！", head, 0, "铁匠")
		do return end
	end
	Cls()
    local thing = {}
    local thingnum = {}
    for i = 0, CC.MyThingNum - 1 do
      thing[i] = -1
      thingnum[i] = 0
    end
    local num = 0
    for i = 0, CC.MyThingNum - 1 do
      local id = JY.Base["物品" .. i + 1]
      if id >= 0 then
		if JY.Thing[id]["类型"] == 1 then
		  thing[num] = id
		  thingnum[num] = JY.Base["物品数量" .. i + 1]
		  num = num + 1
		end
      end 
    end
    local r = 0
	r = SelectThing(thing, thingnum)	
	if r < 1 then
		Cls()
		say("不要就算了！", head, 0, "铁匠")
		do return end
	end
	
	Cls()
	say("那就拜托了。")	
	instruct_2(174, -money)
	Cls()
	local aa, bb
	aa = math.random(2, 5) * 2
	bb = aa
	if JY.Thing[r]["使用人"] >= 0 then
		if JY.Thing[r]["装备类型"] == 1 then
			if doublearmor(JY.Thing[r]["使用人"]) then
				aa = aa * 2
			end
		end
		if JY.Thing[r]["装备类型"] == 0 then
			if doubleweapon(JY.Thing[r]["使用人"]) then
				aa = aa * 2
			end		
		end
	end	
	JY.Thing[r]["加攻击力"] = JY.Thing[r]["加攻击力"] + aa
	QZXS(JY.Thing[r]["名称"].."增加攻击力".. bb.."点")
	aa = math.random(2, 5) * 2
	bb = aa
	if JY.Thing[r]["使用人"] >= 0 then
		if JY.Thing[r]["装备类型"] == 1 then
			if doublearmor(JY.Thing[r]["使用人"]) then
				aa = aa * 2
			end
		end
		if JY.Thing[r]["装备类型"] == 0 then
			if doubleweapon(JY.Thing[r]["使用人"]) then
				aa = aa * 2
			end		
		end
	end	
	JY.Thing[r]["加防御力"] = JY.Thing[r]["加防御力"] + aa
	QZXS(JY.Thing[r]["名称"].."增加防御力".. bb.."点")	
	aa = math.random(2, 5) * 2
	bb = aa
	if JY.Thing[r]["使用人"] >= 0 then
		if JY.Thing[r]["装备类型"] == 1 then
			if doublearmor(JY.Thing[r]["使用人"]) then
				aa = aa * 2
			end
		end
		if JY.Thing[r]["装备类型"] == 0 then
			if doubleweapon(JY.Thing[r]["使用人"]) then
				aa = aa * 2
			end		
		end
	end	
	JY.Thing[r]["加轻功"] = JY.Thing[r]["加轻功"] + aa
	QZXS(JY.Thing[r]["名称"].."增加轻功".. bb.."点")
end

OEVENTLUA[30057] = function(aa, bb) --洗武功
    local teamnum = 1
	local enemy = -1
	local prot = -1
	for i = 2, CC.TeamNum do
		if JY.Base["队伍" .. i] > 0 then
			teamnum = teamnum + 1
		end
	end
	prot = JY.Base["队伍" .. math.random(teamnum)]
	SetS(106, 63, 1, 0, prot)	
    local head = math.random(350, 575)	
	Cls()
	say("糟糕....好像迷路了。啊，怎么又下起雨来了，怎么办....", prot)	
	Cls()
	say("前面好像有个山洞，不管了，先进去避一避再说。", prot)	
	Cls()
	say("这位少侠...", head, 0, "？？？")
	Cls()
	say("啊！吓我一跳....老前辈，你在这抓松鼠啊！？", prot)	
	Cls()
	say("我在此隐居多年，还从来没有人找到过这里。你我有缘，我传你一些武功如何？", head, 0, "？？？")	
	Cls()
	say("真的假的....山谷里的奇遇？我难道真的是主角？", prot)	
	if DrawStrBoxYesNo(-1, -1, "要接受么？", C_WHITE, 30) == false then	
		Cls()
		say("多谢前辈，只是晚辈以为，武学之道贵精不贵多，前辈的好意晚辈心领了。" , prot)	
		Cls()
		say("也罢，你既然有此眼界，我也不勉强你了。", head, 0, "？？？")	
		do return end
	end
	Cls()
	say("让我看看你的基础如何。", head, 0, "？？？")
	local thing, wugong = -1
	local hasit = 1	
	local count = 0
	while hasit == 1 do
		thing = randomwugong2(aa, bb)
		wugong = JY.Thing[thing]["练出武功"]
		hasit = 0
		for i = 1, 10 do
			if JY.Person[prot]["武功"..i] > 0 and JY.Person[prot]["武功"..i] == wugong then
				hasit = 1	
			end
		end
		count = count + 1
		if count >= 100 then
			break
		end
	end
	if count >= 100 then
		Cls()
		say("你小小年纪，竟然已经练到如此境界。真是后生可畏。", head, 0, "？？？")	
		Cls()
		say("我没有东西可以教你了，你还是早日上路完成你的使命吧。", head, 0, "？？？")	
		do return end
	end
	Cls()
	say("基础不错，我就把我这绝学"..JY.Wugong[wugong]["名称"].."传授给你，看好了。", head, 0, "？？？")	
	JY.Person[prot]["武功1"] = wugong
	JY.Person[prot]["武功等级1"] = 90 --math.random(750, 900) 武骧金星：取消这个没有意义的设置
	Cls()
	dark()
	light()
	QZXS(JY.Person[prot]["姓名"].."领悟"..JY.Wugong[wugong]["名称"].."！")
	say("如何？看懂了吗？", head, 0, "？？？")	
	Cls()
	say("懂了。谢谢前辈指点。", prot)	
	Cls()
	say("很好！你可以跟他们上路了。以后永远不要跟人说你见过我。", head, 0, "？？？")	
	Cls()
	say("好的，前辈保重！", prot)	
end

OEVENTLUA[30010] = function()
	if RW.fame >= 50 and hasHZ(94) == false then
		say("少侠最近名声鹊起，在江湖上实在是闯出了一番名堂。这点小小心意请笑纳。", 96, 0, "中介人")
		addHZ(94) --21 武骧金星：修正BUG
		do return end
	end
	local menu = {
		{"任务状态", nil, 1},
		{"取消任务", nil, 1},
		{"特殊任务", nil, 1},
	}	
	local r = ShowMenu3(menu,#menu,1,-2,-2,-2,-2,1,1,24,C_GOLD,C_WHITE,nil, nil,M_DimGray,C_RED)
	if r == 1 then
		RWstatus()
	elseif r == 2 then
		Cls()
		if yesno("要取消任务么？") then			
			displayRW(3, RW.scene, RW.location)	
			displayRW(3, RW.targetscene, RW.target)			
			for i = 1, #RW.special do
				if RW.special[i][1] == RW.event then
					null(RW.special[i][2], 110)
				end
			end
			resetRW()
		end
	elseif r == 3 then
		local teshu = {
			{"寒冰？？？", nil, not setRW(1) and 1 or 0},
			{"捕蛇人", nil, not setRW(2) and 1 or 0},
			{"射雕比赛", nil, not setRW(3) and 1 or 0},
			{"乞丐与道姑", nil, not setRW(4) and 1 or 0},
			{"蜀中唐门", nil, not setRW(5) and 1 or 0},
			{"恩怨难清", nil, not setRW(6) and 1 or 0},
			{"蛛儿与蛛儿", nil, not setRW(7) and 1 or 0},
			{"白猿与少女", nil, not setRW(8) and 1 or 0},
			{"比武招亲", nil, not setRW(9) and 1 or 0},
		}
		if #teshu > 0 then
			local rt = ShowMenu3(teshu,#teshu,1,-2,-2,-2,-2,1,1,24,C_GOLD,C_WHITE,nil, nil,M_DimGray,C_RED)
			if rt > 0 then getRW(VK_SPACE, rt + 100) end
		end
	end
end

function autostats(a)
	local p1 = 0	
	if duiyou(a) then
		p1 = (limitX(JY.Person[a]["排行"], 4, 5) + 1) * (limitX(JY.Person[a]["排行"], 4, 5) + 1) * 25
	else
		p1 = JY.Person[a]["排行"] * JY.Person[a]["排行"] * 30
	end
	if CC.NLJS[JY.Person[a]["姓名"]] ~= nil then --天赋加成150
		p1 = p1 + 150
	end	
	p1 = p1 + math.modf((sixi(a, 1) + sixi(a, 2) + sixi(a, 3) + sixi(a, 4)) / 5) --四系加0.2 max192
	p1 = p1 + math.modf((JY.Person[a]["攻击力"] + JY.Person[a]["防御力"] + JY.Person[a]["轻功"]) / 15) --三围加0.07 max120
	p1 = p1 + math.modf(JY.Person[a]["武学常识"]) --武常max50
	if JY.Person[a]["左右互搏"] == 1 then p1 = p1 + 50 end --左右加50
	p1 = p1 + JY.Wugong[JY.Person[a]["声望"]]["等级"] * 10 --功体加10 max100
	p1 = p1 + math.modf(JY.Person[a]["实战"] / 10) --实战加0.1 max 50
	p1 = p1 + math.modf(JY.Person[a]["内力最大值"] / 10) --内力加0.1
	for i = 1, HHH_GAME_SETTING["WG_COUNT_MAX"] do
		if JY.Person[a]["武功"..i] > 0 and JY.Person[a]["武功等级"..i] >= 900 then
			if duiyou(a) then
				p1 = p1 + JY.Wugong[JY.Person[a]["武功"..i]]["等级"] * 7
			else
				p1 = p1 + JY.Wugong[JY.Person[a]["武功"..i]]["等级"] * 5
			end
		end
	end	
	return p1
end
function lottery(a, b)
	local p1, p2 = 0, 0
	--[[if math.abs(JY.Person[a]["排行"] - JY.Person[b]["排行"]) >= 2 then --越两级必输
		if JY.Person[a]["排行"] > JY.Person[b]["排行"] then 
			return a
		else
			return b
		end
	end	]]	
	p1 = autostats(a)
	p2 = autostats(b)
	local x, y = 0, 0
	local total = math.modf(p1 + p2)
	for i = 1, 50 do
		if math.random(total) <= p1 then
			x = x + 1
		else
			y = y + 1
		end
	end
	if x > y then
		return a
	elseif y > x then
		return b
	else
		if p1 > p2 then
			return a
		else
			return b
		end
	end
	--return JY.Person[a]["姓名"]..p1.."  :  "..JY.Person[b]["姓名"]..p2
end

function drawline(x1, y1, x2, y2, color)
	if color == nil then
		color = C_RED
	end
	DrawBox3(x1, y1, x2, y1, color)
	DrawBox3(x2, y1, x2, y2, color)
end
	
function drawmatch(list)

	lib.LoadPicture(CONFIG.PicturePath.."scroll.png", -1, -1)  
	local color = M_Cyan

	for i = 1, 16 do
		color = M_Cyan
		if list[i][3] == -1 then
			color = M_Silver
		end
		DrawString(25, 36 * i - 10, list[i][2], color, 30)	
		color = M_Cyan
		if list[i + 16][3] == -1 then
			color = M_Silver
		end		
		DrawString(CC.ScreenW - 150, 36 * i - 10, list[i + 16][2], color, 30)	
	
	end
	local line = {
			{{155, 41, 205, 59}, {205, 59, 255, 95}, {255, 95, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}}, --2, 4, 8
			{{155, 77, 205, 59}, {205, 59, 255, 95}, {255, 95, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}},
			{{155, 113, 205, 131}, {205, 131, 255, 95}, {255, 95, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}},
			{{155, 149, 205, 131}, {205, 131, 255, 95}, {255, 95, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}},
			{{155, 185, 205, 203}, {205, 203, 255, 239},{255, 239, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}},
			{{155, 221, 205, 203}, {205, 203, 255, 239}, {255, 239, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}},
			{{155, 257, 205, 275}, {205, 275, 255, 239}, {255, 239, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}},
			{{155, 293, 205, 275}, {205, 275, 255, 239}, {255, 239, 305, 167}, {305, 167, 355, 311}, {355, 311, 398, 311}},

			{{155, 329, 205, 347}, {205, 347, 255, 383}, {255, 383, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},
			{{155, 365, 205, 347}, {205, 347, 255, 383}, {255, 383, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},
			{{155, 401, 205, 419}, {205, 419, 255, 383}, {255, 383, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},
			{{155, 437, 205, 419}, {205, 419, 255, 383}, {255, 383, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},
			{{155, 473, 205, 491}, {205, 491, 255, 527}, {255, 527, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},
			{{155, 509, 205, 491}, {205, 491, 255, 527}, {255, 527, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},
			{{155, 545, 205, 563}, {205, 563, 255, 527}, {255, 527, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},
			{{155, 581, 205, 563}, {205, 563, 255, 527}, {255, 527, 305, 455}, {305, 455, 355, 311}, {355, 311, 398, 311}},

			{{640, 41, 590, 59}, {590, 59, 540, 95}, {540, 95, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}}, --2, 4, 8
			{{640, 77, 590, 59}, {590, 59, 540, 95}, {540, 95, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}},
			{{640, 113, 590, 131}, {590, 131, 540, 95}, {540, 95, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}},
			{{640, 149, 590, 131}, {590, 131, 540, 95}, {540, 95, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}},
			{{640, 185, 590, 203}, {590, 203, 540, 239},{540, 239, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}},
			{{640, 221, 590, 203}, {590, 203, 540, 239}, {540, 239, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}},
			{{640, 257, 590, 275}, {590, 275, 540, 239}, {540, 239, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}},
			{{640, 293, 590, 275}, {590, 275, 540, 239}, {540, 239, 490, 167}, {490, 167, 440, 311}, {440, 311, 398, 311}},

			{{640, 329, 590, 347}, {590, 347, 540, 383}, {540, 383, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
			{{640, 365, 590, 347}, {590, 347, 540, 383}, {540, 383, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
			{{640, 401, 590, 419}, {590, 419, 540, 383}, {540, 383, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
			{{640, 437, 590, 419}, {590, 419, 540, 383}, {540, 383, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
			{{640, 473, 590, 491}, {590, 491, 540, 527}, {540, 527, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
			{{640, 509, 590, 491}, {590, 491, 540, 527}, {540, 527, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
			{{640, 545, 590, 563}, {590, 563, 540, 527}, {540, 527, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
			{{640, 581, 590, 563}, {590, 563, 540, 527}, {540, 527, 490, 455}, {490, 455, 440, 311}, {440, 311, 398, 311}},
		}
		for i = 1, #line do
			for j = 1, #line[i] do
				drawline(line[i][j][1], line[i][j][2], line[i][j][3], line[i][j][4], M_RoyalBlue)
			end
		end
		drawline(355, 311, 440, 311, M_RoyalBlue)
		
		for i = 1, #line do
			if list[i][3] < 1 or list[i][3] > 5 then
			
			else
				for j = 1, list[i][3] do
					drawline(line[i][j][1], line[i][j][2], line[i][j][3], line[i][j][4])
				end
			end
		end
			
end

function shuffle(t)
	local n = #t
	while n >= 2 do
		local k = math.random(n)
		t[n], t[k] = t[k], t[n]
		n = n - 1
	end
	return t	
end

function participant(flag)
	local total = 32
	local r4, r5, r6, r7, r8 = {}, {}, {}, {}, {}
	for i = 0, JY.PersonNum - 1 do
		local pp = JY.Person[i]["排行"]
		if i >= 594 and i <= 596 then
			pp = 0
		elseif i >= 497 and i <= 577 then
			pp = 0
		elseif i >= 607 and i <= 613 then
			pp = 0	
		elseif i == 620 then
			pp = 0
		elseif duiyou(i) then
			if inteam(i) then
				pp = pp + 1
			else
				pp = 0
			end
			if pp > 6 then pp = 6 end
		end
		if pp == 4 then
			r4[#r4 + 1] = {i, 0} --30%
		elseif pp == 5 then
			r5[#r5 + 1] =  {i, 0} --50%
		elseif pp == 6 then
			r6[#r6 + 1] =  {i, 0} --65$
		elseif pp == 7 then
			r7[#r7 + 1] =  {i, 0}	--80%
		end
	end
	r4 = shuffle(r4)
	r5 = shuffle(r5)
	r6 = shuffle(r6)
	r7 = shuffle(r7)
	local list = {}
	for i = 1, total do
		list[i] = {nil, nil, 0}
	end
	list[1] = {zj(), JY.Person[zj()]["姓名"], 0}
	local n = 2
	while n <= total do
		for i = 1, #r7 do
			if math.random(100) <= 80 and r7[i][2] == 0 then
				list[n] = {r7[i][1], JY.Person[r7[i][1]]["姓名"], 0}
				n = n + 1
				r7[i][2] = 1
				if n > total then break end
			end
		end
		if n > total then break end
		for i = 1, #r6 do
			if math.random(100) <= 65 and r6[i][2] == 0 then
				list[n] = {r6[i][1], JY.Person[r6[i][1]]["姓名"], 0}
				n = n + 1
				r6[i][2] = 1
				if n > total then break end
			end
		end		
		if n > total then break end
		for i = 1, #r5 do
			if math.random(100) <= 50 and r5[i][2] == 0 then
				list[n] = {r5[i][1], JY.Person[r5[i][1]]["姓名"], 0}
				n = n + 1
				r5[i][2] = 1
				if n > total then break end
			end
		end		
		if n > total then break end
		for i = 1, #r4 do
			if math.random(100) <= 30 and r4[i][2] == 0 then
				list[n] = {r4[i][1], JY.Person[r4[i][1]]["姓名"], 0}
				n = n + 1
				r4[i][2] = 1
				if n > total then break end
			end
		end		
		if n > total then break end
	end
	list = shuffle(list)
	list = shuffle(list)
	CC.Match = list
	return list
end

function biwu()
	local gstatus = JY.Status
	lib.Delay(100)
	say("听说一年一度的华山论剑即将召开了，各大门派都摩拳擦掌准备夺第一之名呢。", math.random(1, 189), 0, "商人")
	say("华山论剑？我要参加吗？")
	if yesno("参加吗？") == false then
		
	else
		say("去看看也好。")
		My_Enter_SubScene(25,28,26,2)
		say("欢迎各位来到本届华山论剑！", 585)
		biwu_sub()
		say("果然不虚此行！")
		JY.Status = gstatus
		lib.PicInit()
		CleanMemory()
		lib.ShowSlow(50, 1)
		if JY.MmapMusic < 0 then
		  JY.MmapMusic = 16
		end
		Init_MMap()
		JY.SubScene = -1
		JY.oldSMapX = -1
		JY.oldSMapY = -1
		lib.DrawMMap(JY.Base["人X"], JY.Base["人Y"], GetMyPic())
		lib.ShowSlow(50, 0)
		lib.GetKey()
		addtime(3)		
	end
end

function biwu_sub()
	local jiangli = 1
	local tmp = JY.Status
	local list = participant()
	local store = {}
	for i = 1, #list do
		store[list[i][1]] = {}
		store[list[i][1]][1] = JY.Person[list[i][1]][CC.EVB29] 
		store[list[i][1]][2] = JY.Person[list[i][1]][CC.EVB30]
		store[list[i][1]][3] = JY.Person[list[i][1]][CC.EVB31]
		store[list[i][1]][4] = JY.Person[list[i][1]][CC.EVB32]
		JY.Person[list[i][1]][CC.EVB29] = -1
		JY.Person[list[i][1]][CC.EVB30] = -1
		JY.Person[list[i][1]][CC.EVB31] = -1
		JY.Person[list[i][1]][CC.EVB32] = -1	
	end
	CC.MatchTurn = 1 --晋级数，共5级，初选赛晋级赛四强赛半决赛总决赛
	CC.MatchMe = -1
	CC.MatchYou = -1	
	CC.MatchAuto = 0
	local one = -1
	local winner = -1
	JY.Status = GAME_MATCH
	Cls()
	local word = {"初选赛：", "晋级赛：", "四强赛：", "半决赛：", "总决赛："}
	local menu = {
		{"观棋不语", nil, 1}, 
		{"身临其境", nil, 1},
		{"听天由命", nil, 1},
	}
	local menu2 = {}
	local r = -1
	say("我宣布，华山论剑正式开始！", 585)
	for i = 1, #list, 2 do
		CC.MatchAuto = 0
		list[i][3] = CC.MatchTurn
		list[i + 1][3] = CC.MatchTurn
		say(word[CC.MatchTurn]..list[i][2].."对"..list[i + 1][2].."！", 585)
		if inteam(list[i][1]) or inteam(list[i + 1][1]) then
			if inteam(list[i][1]) then
				CC.MatchMe = list[i][1]
				CC.MatchYou = list[i + 1][1]			
			else
				CC.MatchMe = list[i + 1][1]
				CC.MatchYou = list[i][1]			
			end
			if WarMain(342) then
				winner = CC.MatchMe
			else
				winner = CC.MatchYou
			end			
		else
			--r = ShowMenu3(menu,#menu,1,-2,-2,-2,-2,1,1,24,C_GOLD,C_WHITE,"请选择", nil,M_DimGray,C_RED)
			r = 3
			if r == 1 then
				jiangli = 0
				CC.MatchAuto = 1
				if math.random(2) == 1 then
					CC.MatchMe = list[i][1]
					CC.MatchYou = list[i + 1][1]
				else
					CC.MatchMe = list[i + 1][1]
					CC.MatchYou = list[i][1]
				end
				if WarMain(342) then
					winner = CC.MatchMe
				else
					winner = CC.MatchYou
				end
			elseif r == 2 then
				jiangli = 0
				local p1, p2 = list[i][1], list[i + 1][1]
				menu2 = {
					{JY.Person[p1]["姓名"], nil, 1, p1},
					{JY.Person[p2]["姓名"], nil, 1, p2},
				}
				Cls()
				local r2 = ShowMenu3(menu2,#menu2,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"想操作谁？", nil,M_DimGray,C_RED)
				if r2 == 1 then
					CC.MatchMe = p1
					CC.MatchYou = p2
				else
					CC.MatchMe = p2
					CC.MatchYou = p1
				end
				if WarMain(342) then
					winner = CC.MatchMe
				else
					winner = CC.MatchYou
				end			
			else
				winner = lottery(list[i][1], list[i + 1][1])
			end
		end
		if list[i][1] == winner then
			list[i + 1][3] = -1
			list[i][3] = list[i][3] + 1
		else
			list[i][3] = -1
			list[i + 1][3] = list[i + 1][3] + 1
		end
		say("胜方："..JY.Person[winner]["姓名"].."！", 585)
	end
	CC.MatchTurn = CC.MatchTurn + 1
	
	for i = 2, 5 do
		CC.MatchAuto = 0
		local tlist = {}
		for i = 1, #list do
			if list[i][3] > 0 then
				tlist[#tlist + 1] = {list[i][1], list[i][2], list[i][3], i}
			end
		end
		for i = 1, #tlist, 2 do
			say(word[CC.MatchTurn]..tlist[i][2].."对"..tlist[i + 1][2].."！", 585)
			if inteam(tlist[i][1]) or inteam(tlist[i + 1][1]) then
				if inteam(tlist[i][1]) then
					CC.MatchMe = tlist[i][1]
					CC.MatchYou = tlist[i + 1][1]			
				else
					CC.MatchMe = tlist[i + 1][1]
					CC.MatchYou = tlist[i][1]			
				end
				if WarMain(342) then
					winner = CC.MatchMe
				else
					winner = CC.MatchYou
				end			
			else
				--r = ShowMenu3(menu,#menu,1,-2,-2,-2,-2,1,1,24,C_GOLD,C_WHITE,"请选择", nil,M_DimGray,C_RED)
				r = 3
				if r == 1 then 
					jiangli = 0
					CC.MatchAuto = 1
					if math.random(2) == 1 then
						CC.MatchMe = tlist[i][1]
						CC.MatchYou = tlist[i + 1][1]
					else
						CC.MatchMe = tlist[i + 1][1]
						CC.MatchYou = tlist[i][1]
					end
					if WarMain(342) then
						winner = CC.MatchMe
					else
						winner = CC.MatchYou
					end
				elseif r == 2 then
					jiangli = 0
					local p1, p2 = tlist[i][1], tlist[i + 1][1]
					menu2 = {
						{JY.Person[p1]["姓名"], nil, 1, p1},
						{JY.Person[p2]["姓名"], nil, 1, p2},
					}
					Cls()
					local r2 = ShowMenu3(menu2,#menu2,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"想操作谁？", nil,M_DimGray,C_RED)
					if r2 == 1 then
						CC.MatchMe = p1
						CC.MatchYou = p2
					else
						CC.MatchMe = p2
						CC.MatchYou = p1
					end
					if WarMain(342) then
						winner = CC.MatchMe
					else
						winner = CC.MatchYou
					end			
				else
					winner = lottery(tlist[i][1], tlist[i + 1][1])
				end
			end		
			if CC.MatchTurn < 5 then
				if tlist[i][1] == winner then
					list[tlist[i + 1][4]][3] = -1
					list[tlist[i][4]][3] = list[tlist[i][4]][3] + 1
				else
					list[tlist[i][4]][3] = -1
					list[tlist[i + 1][4]][3] = list[tlist[i + 1][4]][3] + 1
				end
			else
				one = winner
			end
			say("胜方："..JY.Person[winner]["姓名"].."！", 585)	
			--if CC.MatchTurn >= 3 then
			--	if winner == zj() or inteam(winner) then
			--		addHZ(math.random(#CC.HZ))
			--	end
			--end
		end
		CC.MatchTurn = CC.MatchTurn + 1
	end
	say("本届华山论剑最终胜利者，武功天下第一："..JY.Person[one]["姓名"].."！", 585)
	--if inteam(one) then AddPersonAttrib(one, "实战", 500) end
	if inteam(one) and jiangli == 1 and (not hasHZ(90)) then addHZ(90) end
	for i = 1, #list do
		JY.Person[list[i][1]][CC.EVB29] = store[list[i][1]][1]
		JY.Person[list[i][1]][CC.EVB30] = store[list[i][1]][2]
		JY.Person[list[i][1]][CC.EVB31] = store[list[i][1]][3] 
		JY.Person[list[i][1]][CC.EVB32] = store[list[i][1]][4]
	end	
	JY.Status = tmp
end
