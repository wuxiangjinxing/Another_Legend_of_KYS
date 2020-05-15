local first = 598
local last = 604

 --声望4字节，资金4字节，镖师人数4字节，队友4字节，保镖总数，成功数，失败数
function savebj(r)
	local data = Byte.create(10 * 4)
	Byte.set32(data, 0, limitX(BJ.fame, 0, 500))	
	Byte.set32(data, 4, limitX(BJ.cash, 0, 100000))	
	Byte.set32(data, 8, limitX(BJ.bouncer, 0, 10))	
	Byte.set32(data, 12, BJ.team)	
	Byte.set32(data, 16, BJ.total)
	Byte.set32(data, 20, BJ.win)
	Byte.set32(data, 24, BJ.lose)
	Byte.savefile(data, '.\\data\\SAVE\\bjdata'..r, 0, 10 * 4)
end

function loadbj(r)
	local data = Byte.create(10 * 4)
	Byte.loadfile(data, '.\\data\\SAVE\\bjdata'..r, 0, 10 * 4)
	BJ.fame = limitX(Byte.get32(data, 0), 0, 500)
	BJ.cash = limitX(Byte.get32(data, 4), 0, 100000)
	BJ.bouncer = limitX(Byte.get32(data, 8), 0, 8)
	BJ.team = Byte.get32(data, 12)
	BJ.total = limitX(Byte.get32(data, 16), 0, 10000)
	BJ.win = limitX(Byte.get32(data, 20), 0, 10000)
	BJ.lose = limitX(Byte.get32(data, 24), 0, 10000)
end

function tb(s)
	DrawStrBoxWaitKey(s, C_GOLD, 30)
end

OEVENTLUA[3000] = function() --镖局开张
	if JY.GOLD <= 20000 then --减少要求
		do return end
	end
	Cls()
	say("这曾经兴旺一时的镖局，如今却也人去楼空。江湖浮沉，苦乐自知。")
	Cls()
	say("这偌大的地方空置着也是浪费，不如我盘下来经营也好。")
	addevent(-2, -2, 0, 0, 0)
	if yesno("要经营镖局吗？") == false then						
		do return end
	end		
	Cls()
	say("先雇几个伙计打理一下镖局事务吧。")
	dark()
	addevent(-2, 21, 1, 3001, 1, 6094)
	addevent(-2, 22, 1, 3002, 1, 6092)
	addevent(-2, 23, 1, 3003, 1, 6092)
	light()
	instruct_2(174, -20000)
	addtime(20)
	resetbj()
	BJ.cash = 10000
	local pid
	local name = {"黄天霸", "贾必真", "骆震山"}
	for i = 1, #name do
		pid = freespot()
		generate(pid)
		JY.Person[pid]["姓名"] = name[i]
		hire(pid)
	end
	Cls()
	say("忙碌了这大半个月，终于可以开张了。")		
end
	
OEVENTLUA[3001] = function()
	Cls()
	say("头儿来这练功房有事？",220,0,"教头") 
	local r = JYMsgBox("管理镖局", "修炼：消耗资金提升等级*练武：消耗资金修炼武功*镖师：察看镖师状态", {"修炼", "练武", "镖师", "取消"}, 4, 220)	
	if r <= 0 then
		do return end
	end
	if r == 1 then
		if BJ.cash < 2000 then
			Cls()
			say("资金不够了。",220,0,"教头") 	
			do return end
		end
		local pid = selectteam()
		Cls()
		ShowPersonStatus_sub(pid, 1)
		ShowScreen()
		lib.Delay(500)
		WaitKey()
		Cls()
		if yesno("开始吗？") == false then
			do return end
		end			
		BJ.cash = BJ.cash - 2000
		tb("镖局资金减少2000两")
		dark()
		light()
		JY.Person[pid]["经验"] = JY.Person[pid]["经验"] + math.random(1000, JY.Person[pid]["资质"] * 1000)
		War_AddPersonLVUP(pid)	
		addtime(1)			
	elseif r == 2 then
		if BJ.cash < 1000 then
			Cls()
			say("资金不够了。",220,0,"教头") 	
			do return end
		end	
		local pid = selectteam()
		Cls()
		ShowPersonStatus_sub(pid, 1)
		ShowScreen()
		lib.Delay(500)
		WaitKey()
		Cls()		
		local thing = DIY_Menu_Thing(4, pid)	
		if thing ~= 1 then
			do return end
		end	
		if yesno("开始吗？") == false then
			do return end
		end
		BJ.cash = BJ.cash - 1000
		tb("镖局资金减少1000两")
		dark()
		light()
		JY.Person[pid]["修炼点数"] = JY.Person[pid]["修炼点数"] + math.random(800, JY.Person[pid]["资质"] * 800)
		War_PersonTrainBook(pid)
		addtime(1)		
	elseif r == 3 then
		if BJ.bouncer == 0 then
			Cls()
			say("镖局里还没有聘请镖师。",220,0,"账房") 	
			do return end
		end
		bsstatus()		
	end
	
end

function jiebiao()

end

OEVENTLUA[3002] = function()
	Cls()
	say("头儿有啥吩咐？",220,0,"账房") 
	local r = JYMsgBox("管理镖局", "接镖：接受任务*状态：查看镖局状态*镖师：察看镖师状态*取钱：从库房取钱", {"接镖", "状态", "镖师", "取钱", "取消"}, 5, 220)	
	if r <= 0 then
		do return end
	end
	if r == 1 then
	
	elseif r == 2 then
		bjstatus()
		lib.Delay(500)
		WaitKey()
	elseif r == 3 then
		if BJ.bouncer == 0 then
			Cls()
			say("镖局里还没有聘请镖师。",220,0,"账房") 	
			do return end
		end
		bsstatus()		
	elseif r == 4 then
		if BJ.cash <= 10000 then
			Cls()
			say("库房里的钱不多了，营运资金还是不要动的好。",220,0,"账房") 	
			do return end			
		end
		local difference = limitX((BJ.cash - 10000), 0, math.min(32000 - JY.GOLD, BJ.cash - 10000))
		BJ.cash = BJ.cash - difference
		instruct_2(174, difference)		
	end
end

OEVENTLUA[3003] = function()
	local pid = freespot()
	say("头儿，最近兄弟们越来越有干劲了。",220,0,"镖师") 	
	Cls()
	local r = JYMsgBox("管理镖局", "聘请：聘请武林人士*客卿：请队友加入保镖*解雇：解雇镖师", {"聘请", "客卿", "解雇", "取消"}, 4, 220)
	if r <= 0 then 
		do return end
	end
	if r == 1 then	
		if pid == -1 or BJ.bouncer >= (last - first + 1) then
			Cls()
			say("咱们镖局已经有足够的人手了。",220,0,"镖师") 	
			do return end
		end
		if BJ.cash < 5000 then
			Cls()
			say("最近镖局手头有点紧，不能请人了。",220,0,"镖师") 	
			do return end		
		end		
		say("让我看看....",220,0,"镖师") 	
		Cls()
		say("这儿有一位上门应聘的人。哎，你叫啥名字来着？",220,0,"镖师") 	
		generate(pid)
		Cls()
		say("我叫......",JY.Person[pid]["头像代号"],0,"？？？") 	
		JY.Person[pid]["姓名"] = "";
		while JY.Person[pid]["姓名"] == "" do
			JY.Person[pid]["姓名"] = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
			if JY.Person[pid]["姓名"] == "" then
				DrawStrBoxWaitKey("人在江湖漂，哪能没名字。", C_WHITE, 30)
			end
		end
		Cls()
		ShowPersonStatus_sub(pid, 1)
		ShowScreen()
		lib.Delay(500)	
		local keyPress = WaitKey()			
		Cls()
		say("头儿您看看合不合意？",220,0,"镖师") 	
		if yesno("要聘请吗？") == false then
			Cls()
			say("不行吗？好吧，这位您还是另谋高就吧。",220,0,"镖师") 		
			Cls()
			say("不请我，是你的损失！",JY.Person[pid]["头像代号"],0,JY.Person[pid]["姓名"]) 	
			do return end
		end
		Cls()
		say("好咧，我这就叫人帮忙整理行李和打扫房间，欢迎新伙计！",220,0,"镖师") 	
		Cls()
		say("谢谢！我不会让您失望的！",JY.Person[pid]["头像代号"],0,JY.Person[pid]["姓名"]) 
		Cls()
		BJ.cash = BJ.cash - 5000
		tb("镖局资金减少5000两")
		hire(pid)
		addtime(1)
	elseif r == 2 then
		--[[Cls()
		say("镖局里暂时还不需要客卿。",220,0,"镖师") 			
		do return end]]
		if BJ.team ~= 0 then
			Cls()
			say("现在的客卿是"..JY.Person[BJ.team]["姓名"].."，头儿您想换人吗？",220,0,"镖师") 	
			Cls()
			if yesno("换客卿？") == false then
				do return end
			end
		end		
		Cls()
		local pid = selectdy()
		if pid == -1 then
			Cls()
			say("头儿您没有带人来啊。",220,0,"镖师") 			
			do return end			
		end

		instruct_21(pid)
		if BJ.team ~= 0 then
			instruct_10(BJ.team)
		end
		hire(pid)
		BJ.team = pid
		tb(JY.Person[pid]["姓名"].."成为镖局客卿")
	elseif r == 3 then
		if BJ.bouncer < 1 then
			Cls()
			say("镖局里还没有聘请镖师。",220,0,"镖师") 	
			do return end
		end
		Cls()
		say("头儿您对哪位兄弟不满意？",220,0,"镖师") 	
		local pid = selectteam()
		Cls()
		ShowPersonStatus_sub(pid, 1)
		ShowScreen()
		lib.Delay(500)
		WaitKey()
		Cls()
		say("头儿您请三思啊。",220,0,"镖师") 
		if yesno("解雇此人？") == false then
			Cls()
			say("没事就好。真不希望看到兄弟离开啊。",220,0,"镖师") 	
			do return end
		else
			Cls()
			say("好吧，我会跟那位兄弟解释的。",220,0,"镖师") 
			layoff(pid)
			BJ.fame = limitX(BJ.fame - 10, 0, 500)
		end			
	end		
end

function resetbj()
	for i = first, last do		
		layoff(i)
	end
	BJ.fame = 0
	BJ.cash = 0
	BJ.bouncer = 0
	BJ.team = 0
	BJ.total = 0
	BJ.win = 0
	BJ.lose = 0  
	--savebj()
end

function freespot()
	local value = -1
	for i = first, last do		
		if JY.Person[i]["USE"] == 0 then			
			value = i
			break
		end
	end
	return value
end

function bonus(jl)
	jl = jl + math.modf(BJ.fame / 50)
	if math.random(100) <= jl then
		return true
	end
	return false
end

function bjfight(pid, p)
	if (pid >= first and pid <= last) and BJ.team == p and BJ.fame >= 200 then
		return true
	end
	return false
end

function generate(pid)
	local r = math.random(1, 496)
	while (r >= 311 and r <= 319) or (r >= 410 and r <= 440) do
		r = math.random(1, 496)
	end
	JY.Person[pid]["等级"] = math.random(5)
	JY.Person[pid]["经验"] = 0
	JY.Person[pid]["内力性质"] = math.random(0, 2)
	JY.Person[pid]["性别"] = JY.Person[r]["性别"]
	JY.Person[pid]["头像代号"] = JY.Person[r]["头像代号"]
	JY.Person[pid]["生命增长"] = JY.Person[r]["生命增长"]	
	JY.Person[pid]["生命最大值"] = math.random(100, 500)
	JY.Person[pid]["生命"] = JY.Person[pid]["生命最大值"]
	JY.Person[pid]["内力最大值"] = math.random(100, 1000)
	JY.Person[pid]["内力"] = JY.Person[pid]["内力最大值"]
	JY.Person[pid]["攻击力"] = math.random(20, 50) + math.modf(BJ.fame / 25)
	JY.Person[pid]["防御力"] = math.random(20, 50) + math.modf(BJ.fame / 25)
	JY.Person[pid]["轻功"] = math.random(20, 50) + math.modf(BJ.fame / 25)
	if bonus(20) then
		JY.Person[pid]["攻击带毒"] = math.random(10, 50)
	end
	if bonus(15) then
		JY.Person[pid]["武学常识"] = math.random(10, 30)
	end
	if bonus(20) then
		JY.Person[pid]["医疗能力"] = math.random(25, 60)
		JY.Person[pid]["解毒能力"] = math.random(25, 60)
	end
	if bonus(20) then
		JY.Person[pid]["用毒能力"] = math.random(25, 60)
		JY.Person[pid]["解毒能力"] = math.random(25, 60)
	end
	if bonus(25) then
		JY.Person[pid]["抗毒能力"] = math.random(10, 50)
	end
	JY.Person[pid]["拳掌功夫"] = math.random(20, 70) + math.modf(BJ.fame / 25)
	JY.Person[pid]["御剑能力"] = math.random(20, 70) + math.modf(BJ.fame / 25)
	JY.Person[pid]["耍刀技巧"] = math.random(20, 70) + math.modf(BJ.fame / 25)
	JY.Person[pid]["特殊兵器"] = math.random(20, 70) + math.modf(BJ.fame / 25)
	JY.Person[pid]["暗器技巧"] = math.random(10, 100) + math.modf(BJ.fame / 25)
	for i = 1, 5 do
		JY.Person[pid]["出招动画帧数" .. i] = JY.Person[r]["出招动画帧数" .. i]
		JY.Person[pid]["出招动画延迟" .. i] = JY.Person[r]["出招动画延迟" .. i]
		JY.Person[pid]["武功音效延迟" .. i] = JY.Person[r]["武功音效延迟" .. i]
	end		
	JY.Person[pid]["资质"] = math.random(1, 100)
	JY.Person[pid]["左右互搏"] = 0
	if JY.Person[pid]["资质"] <= 70 and bonus(20) then
		JY.Person[pid]["左右互搏"] = 1
	end
	JY.Person[pid]["声望"] = 0
	JoinMP(pid, 0, 0)
	if bonus(10) then
		local nglist = {6,89,90,92,93,94,95,96,97,98,99,121,124,150,151,152,153,178}
		local nglist2 = {100,101,102,103,104,105,106,107,108,180}
		if bonus(20) then
			JY.Person[pid]["声望"] = nglist2[math.random(#nglist2)]
		else
			JY.Person[pid]["声望"] = nglist[math.random(#nglist)]
		end
	end
	if bonus(10) then
		JoinMP(pid, math.random(#CC.MP), 1)
	end	
	local aa = 1 + math.modf(BJ.fame / 100) 
	local bb = 5 + math.modf(BJ.fame / 100) 
	local thing = randomwugong2(aa, bb)
	JY.Person[pid]["武功1"] = JY.Thing[thing]["练出武功"]	
	JY.Person[pid]["武功等级1"] = 999
	if BJ.fame > 50 then
		JY.Person[pid]["实战"] = math.random(BJ.fame)
	end
end

function hire(pid)
	JY.Person[pid]["USE"] = 1 
	BJ.bouncer = BJ.bouncer + 1
end

function layoff(pid)
	JY.Person[pid]["USE"] = 0
	BJ.bouncer = BJ.bouncer - 1
end

function bjstatus()
	local size = CC.DefaultFont
	local width = 13 * size 
	local h = size + CC.PersonStateRowPixel
	local height = 8 * h 
	local dx = (CC.ScreenW - width) / 2
	local dy = (CC.ScreenH - height) / 2
	local i = 1  
	Cls()
	--lib.LoadPicture(CC.STA, -1, -1)
	DrawBox(dx, dy, CC.ScreenW - dx, CC.ScreenH - dy, C_WHITE)
	DrawString(math.modf((CC.ScreenW - dx)/2) + size, dy, "镖局现状", C_GOLD, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "声望", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size, dy + h * i, ""..BJ.fame, M_Wheat, size)
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "收入", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size, dy + h * i, ""..BJ.cash, M_Wheat, size)	
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "客卿", C_ORANGE, size)
	if BJ.team == 0 then
	DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size - 5, dy + h * i, "无", M_Wheat, size)		
	else
		DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size - 5, dy + h * i, JY.Person[BJ.team]["姓名"], M_Wheat, size)		
	end
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "镖师数", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size, dy + h * i, ""..BJ.bouncer, M_Wheat, size)	
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "出镖次数", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size, dy + h * i, ""..BJ.total, M_Wheat, size)	
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "成功率", C_ORANGE, size)
	local tmp = 0
	if BJ.total > 0 then
		tmp = math.modf(BJ.win/BJ.total)
	end
	DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size, dy + h * i, tmp.."％", M_Wheat, size)		
	i = i + 1
	local tmp = 0
	if BJ.total > 0 then
		tmp = math.modf(BJ.lose/BJ.total)
	end	
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "失败率", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 5 * size, dy + h * i, tmp.."％", M_Wheat, size)			
	ShowScreen()
end

function selectteam()
	local menu = {}
	for i = 1, (last - first + 1) do
		menu[i] = {"", nil, 0, nil}
		if JY.Person[first - 1 + i]["USE"] > 0 then
			menu[i][1] = JY.Person[first - 1 + i]["姓名"]
			menu[i][3] = 1
			menu[i][4] = first - 1 + i
		end
	end	
	local r = ShowMenu3(menu,#menu,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"镖师列表：","",M_DimGray,C_RED)
	if r <= 0 then
		return -1
	end
	return menu[r][4]
end

function selectdy()
	local menu = {}
	local num = 0
	for i = 2, CC.TeamNum do
		if JY.Base["队伍" .. i] > 0 then
			local pid = JY.Base["队伍" .. i]
			num = num + 1
			menu[num] = {JY.Person[pid]["姓名"], nil, 1, pid}
		end
	end
	if num == 0 then
		return -1
	end
	local r = ShowMenu3(menu,num,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"队友列表：","",M_DimGray,C_RED)
	if r <= 0 then
		return -1
	end
	return menu[r][4]
end

function bsstatus()
	local menu = {};
	local list = {}
	local page = 1
	for i = 1, (last - first + 1) do
		if JY.Person[first - 1 + i]["USE"] > 0 then
			menu[#menu + 1] = {JY.Person[first - 1 + i]["姓名"], nil, 1}
			list[#list + 1] = first - 1 + i
		end
	end	
	if BJ.team ~= 0 then
		menu[#menu + 1] = {JY.Person[BJ.team]["姓名"], nil, 1, BJ.team}
		list[#list + 1] = BJ.team
	end
	local r = ShowMenu3(menu,#menu,1,-2,-2,-2,-2,1,1,24,C_GOLD,C_WHITE,"镖师列表：",nil,M_DimGray,C_RED)
	if r < 1 then
		return
	end
	local id = list[r] 
	while true do
		Cls()
		page = limitX(page, 1, 2)

		if page == 1 then
			ShowPersonStatus_sub(list[r], page)
		elseif page == 2 then
			page = NLJS(list[r], page)
			if page == -1 then
				break
			end
			Cls()
			ShowPersonStatus_sub(list[r], page)
			ShowScreen()
		else
			ShowPersonStatus_sub(list[r], page)
		end	
		ShowScreen();
		local keypress = WaitKey()
		if keypress == VK_LEFT then
	  		page = page - 1;
   		elseif keypress == VK_RIGHT then
	  		page = page + 1;
	  	elseif keypress == VK_UP then
	  		r = r - 1
	  	elseif keypress == VK_DOWN then
	  		r = r + 1
		elseif keypress == 27 then
	  		break
		end
		if r < 1 then
			r = 1
		end
		if r > #list then
			r = #list
		end
	end
end

function DIY_Menu_Thing(flag, pid)
  local menu = {
{"全部物品", nil, 1}, 
{"剧情物品", nil, 1}, 
{"神兵宝甲", nil, 1}, 
{"武功秘笈", nil, 1}, 
{"灵丹妙药", nil, 1}, 
{"伤人暗器", nil, 1}}
	local r
	if flag ~= nil then
		r = flag
	else
		r = ShowMenu(menu, #menu, 0, CC.MainSubMenuX, CC.MainSubMenuY, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
	end
 if r > 0 then
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
        if r == 1 then
          thing[i] = id
          thingnum[i] = JY.Base["物品数量" .. i + 1]
        else
	        if JY.Thing[id]["类型"] == r - 2 then
	          thing[num] = id
	          thingnum[num] = JY.Base["物品数量" .. i + 1]
	          num = num + 1
	        end
      	end
      end 
    end
    local r = SelectThing(thing, thingnum)
    --[[if r > 236 then
      OVERZB()
    end]]
    if r >= 0 then   	
    	return DIYUseThing(r, pid)
  	end
  end
  return 0
end

function DIYUseThing(id, pid)
	Cls()
	local r
	if pid == nil then
		r = selectteam()
	else
		r = pid
	end
  if r > 0 then
    local personid = r
    local yes, full = nil, nil
    if JY.Thing[id]["练出武功"] >= 0 then
      yes = 0
      full = 1
      for i = 1, 10 do
        if JY.Person[personid]["武功" .. i] == JY.Thing[id]["练出武功"] then
          yes = 1
        else
          if JY.Person[personid]["武功" .. i] == 0 then
            full = 0
          end
        end
      end
    end
    
    --葵花宝典
    if CC.Shemale[id] == 1 then
		if JY.Person[personid]["性别"] == 0 and CanUseThing(id, personid) then
			Cls(CC.MainSubMenuX, CC.MainSubMenuY, CC.ScreenW, CC.ScreenH)
			if DrawStrBoxYesNo(-1, -1, CC.EVB147, C_WHITE, CC.DefaultFont) == false then
			  return 0
			else
				lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_RED, 128)
				ShowScreen()
				lib.Delay(80)
				lib.ShowSlow(15, 1)
				Cls()
				lib.ShowSlow(100, 0)
				JY.Person[personid]["性别"] = 2
				local add, str = AddPersonAttrib(personid, "攻击力", -25)
				DrawStrBoxWaitKey(JY.Person[personid]["姓名"] .. str, C_ORANGE, CC.DefaultFont)
				add, str = AddPersonAttrib(personid, "防御力", -35)
				DrawStrBoxWaitKey(JY.Person[personid]["姓名"] .. str, C_ORANGE, CC.DefaultFont)
			  end
		elseif JY.Person[personid]["性别"] == 1 then
			DrawStrBoxWaitKey(CC.EVB148, C_WHITE, CC.DefaultFont)
			return 0
		end
    end
    
    if yes == 1 or CanUseThing(id, personid) or yes == 2 then
		if yes == 0 and full == 1 then
			if GetS(4, 7, 7, 5) == 0 then
				DrawStrBoxWaitKey(CC.EVB142, C_WHITE, CC.DefaultFont)
			else
				DrawStrBoxWaitKey(CC.EVB142, C_WHITE, CC.DefaultFont)
			end
			Cls();
			return 0
		end	 
		JY.Person[personid]["修炼物品"] = id
		JY.Person[personid]["物品修炼点数"] = 0
    else
    	DrawStrBoxWaitKey("此人不适合修炼此物品", C_WHITE, CC.DefaultFont)
    	return 0
    end
  end
  return 1
end