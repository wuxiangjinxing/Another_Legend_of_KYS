--instruct_3(3,1,-2,-2,30015,-2,-2,-2,-2,-2,-2,-2,-2)
--instruct_3(60,0,-2,-2,30015,-2,-2,-2,-2,-2,-2,-2,-2)
--instruct_3(61,3,-2,-2,30015,-2,-2,-2,-2,-2,-2,-2,-2)

local function char(aa)
	local str = ""
	local names = 
		{{1,"一" },
		{2, "二"},
		{3,"三" },
		{4, "四"},
		{5, "五"},
		{6, "六"},
		{7, "七"},
		{8, "八"},
		{9, "九"},
		{10, "一十"},
		{11, "一十一"},
		{12,"一十二" },
		{13, "一十三"},
		{14, "一十四"},
		{15, "一十五"},
		{16, "一十六"},
		{17, "一十七"},
		{18, "一十八"},	
	}
	for i = 1, #names do
		if aa == i then
			str = names[i][2]
			break
		end
	end
	return str
end

function play()
	local a, b, c = 0
	local count = math.random(10, 20) 
	local bg = CONFIG.PicturePath .. "game.jpg"
	local x = CC.ScreenW / 2
	local y = CC.ScreenH / 2	
	for i = 1, count do
		a = math.random(224, 229)
		b = math.random(224, 229)
		c = math.random(224, 229)
		Cls()
		--lib.LoadPicture(bg, -1, -1)
		lib.PicLoadCache(8,a*2,x - 180, y)
		lib.PicLoadCache(8,b*2,x, y)
		lib.PicLoadCache(8,c*2,x + 180, y)
		ShowScreen()
		lib.Delay(100)
		if i >= count - 5 then
			lib.Delay(300)
		end
		if i >= count - 2 then
			lib.Delay(500)
		end		
	end
	lib.Delay(700)
	a = a - 223
	b = b - 223
	c = c - 223
	return a, b, c
end

function daxiao() --大小
		Cls()	
		local dx = {
				{"大",nil,1},   
				{"小",nil,1},
			}	
		local bet = {0, 0}
		local r2 = ShowMenu3(dx, #dx, 2, -2, -2, -2, -2, 1, 0, 30, C_GOLD, C_WHITE, "买哪个？")		
		if r2 == 1 then
			bet = {11, 17}
		else
			bet = {4, 10}
		end
		local a, b, c = play()
		local sum = a + b + c
		local word = ""	
		if a == b and b == c then
			Cls()
			say(char(a).."，"..char(b).."，"..char(c).."！围骰！庄家通吃！",220,0,"兼职小二") 	
			return false	
		end
		if sum >= 11 and sum <= 17 then
			word = "大"
		end
		if sum >= 4 and sum <= 10 then
			word = "小"
		end			
		if sum >= bet[1] and sum <= bet[2] then
			Cls()
			say(char(a).."，"..char(b).."，"..char(c).."！"..word.."！闲家赢！",220,0,"兼职小二") 			
			return true
		else
			Cls()
			say(char(a).."，"..char(b).."，"..char(c).."！"..word.."！庄家赢！",220,0,"兼职小二") 		
			return false
		end
	end
	
function twodie() --兩骰
	Cls()	
	local dx = {
			{"一",nil,1},   
			{"二",nil,1},
			{"三",nil,1},   
			{"四",nil,1},
			{"五",nil,1},   
			{"六",nil,1},				
		}	
	local x = ShowMenu3(dx, #dx, 3, -2, -2, -2, -2, 1, 0, 30, C_GOLD, C_WHITE, "请选第一个数字", "", M_DimGray)	
	dx[x][3] = 2
	Cls()
	local y = ShowMenu3(dx, #dx, 3, -2, -2, -2, -2, 1, 0, 30, C_GOLD, C_WHITE, "请选第二个数字", "", M_DimGray)	
	local a, b, c = play()
	local pd = 0
	if a == x or b == x or c == x then
		pd = pd + 1
	end
	if a == y or b == y or c == y then
		pd = pd + 1
	end
	if pd == 2 then
		Cls()
		say(char(a).."，"..char(b).."，"..char(c).."！有"..char(x).."和"..char(y).."这两个数！您猜中了！",220,0,"兼职小二") 	
		return true
	else
		Cls()
		say(char(a).."，"..char(b).."，"..char(c).."！很抱歉，您落空了！",220,0,"兼职小二") 			
		return false
	end
end	

function doubledie() --雙骰
	Cls()	
	local dx = {
			{"一",nil,1},   
			{"二",nil,1},
			{"三",nil,1},   
			{"四",nil,1},
			{"五",nil,1},   
			{"六",nil,1},				
		}	
	local x = ShowMenu3(dx, #dx, 3, -2, -2, -2, -2, 1, 0, 30, C_GOLD, C_WHITE, "请选择一个数字", "", M_DimGray)		
	local a, b, c = play()
	local pd = 0
	if a == x then
		pd = pd + 1
	end
	if b == x then
		pd = pd + 1
	end
	if c == x then
		pd = pd + 1
	end		
	if pd >= 2 then
		Cls()
		say(char(a).."，"..char(b).."，"..char(c).."！双骰！您猜中了！",220,0,"兼职小二") 	
		return true
	else
		Cls()
		say(char(a).."，"..char(b).."，"..char(c).."！很抱歉，您落空了！",220,0,"兼职小二") 			
		return false
	end
end		

function tripledie() --圍骰
	Cls()	
	local dx = {
			{"一",nil,1},   
			{"二",nil,1},
			{"三",nil,1},   
			{"四",nil,1},
			{"五",nil,1},   
			{"六",nil,1},				
		}	
	local x = ShowMenu3(dx, #dx, 3, -2, -2, -2, -2, 1, 0, 30, C_GOLD, C_WHITE, "请选择一个数字", "", M_DimGray)		
	local a, b, c = play()
	local pd = 0
	if a == x then
		pd = pd + 1
	end
	if b == x then
		pd = pd + 1
	end
	if c == x then
		pd = pd + 1
	end		
	if pd > 2 then
		Cls()
		say(char(a).."，"..char(b).."，"..char(c).."！围"..char(x).."！您猜中了！",220,0,"兼职小二") 	
		return true
	else
		Cls()
		say(char(a).."，"..char(b).."，"..char(c).."！很抱歉，您落空了！",220,0,"兼职小二") 			
		return false
	end
end			

function samedie() --全圍
		Cls()		
		local a, b, c = play()
		local pd = 0
		if a == b then
			pd = pd + 1
		end
		if b == c then
			pd = pd + 1
		end	
		if pd > 1 then
			Cls()
			say(char(a).."，"..char(b).."，"..char(c).."！豹子！您猜中了！",220,0,"兼职小二") 	
			return true
		else
			Cls()
			say(char(a).."，"..char(b).."，"..char(c).."！很抱歉，您落空了！",220,0,"兼职小二") 			
			return false
		end	
	end
	
OEVENTLUA[30015] = function() --赌博	
	Cls()
	say("本店最近兼职游乐业，客官要不要玩点东西？赌博每局二百两，游戏每局五百两。",220,0,"兼职小二") 	
	local menuItem = {
			{"赌博",nil,1},   
			{"游戏",nil,1},
			{"兑奖",nil,1},
			{"取消",nil,1},
		}
	local r = 0
	Cls()
	r = ShowMenu3(menuItem, #menuItem, 1, -2, -2, -2, -2, 1, 0, 30, C_GOLD, C_WHITE, "要玩什么？")
	if r < 1 or r == 4 then
		do return end
	end	
	if r == 2 then
		if JY.GOLD < 500 then
			Cls()
			say("您身上的钱不够。",220,0,"兼职小二") 		
			do return end
		end	
		OEVENTLUA[4000]()
		do return end
	end	
	if r == 3 then
		if (JY.Thing[203][WZ6] or 0) < 0 then
			do return end
		end
		OEVENTLUA[4001]()
		do return end
	end
	if JY.GOLD < 200 then
		Cls()
		say("您身上的钱不够。",220,0,"兼职小二") 		
		do return end
	end	
	Cls()
	say("友情提示，小赌怡情，大赌伤身，客官请量力而行。",220,0,"兼职小二") 	
	local menuItem = {
			{"大小",nil,1},   
			{"两骰",nil,1},
			{"双骰",nil,1},
			{"围骰",nil,1},
			{"全围",nil,1},
		}
	local r = 0
	Cls()
	r = ShowMenu3(menuItem, #menuItem, 5, -2, -2, -2, -2, 1, 0, 30, C_GOLD, C_WHITE, "要玩哪种骰子？")
	if r < 1 then
		do return end
	end
	local win = false
	local ratio = 0
	addthing(174, -200)
	if r == 1 then
		Cls()
		say("赌大小：四至十点为小，十一至十七点为大，遇围骰庄家通吃。赔率一比一。",220,0,"兼职小二") 
		win = daxiao() 	
		ratio = 1
	elseif r == 2 then
		Cls()
		say("两颗骰子：猜中三枚骰子里任意两枚的数字则赢。赔率一比五。",220,0,"兼职小二") 
		win = twodie() 	
		ratio = 5		
	elseif r == 3 then
		Cls()
		say("双骰：指定一个数字，如果三枚骰子中出现两个以上的指定数字则赢。赔率一比十。",220,0,"兼职小二") 
		win = doubledie() 
		ratio = 10
	elseif r == 4 then
		Cls()
		say("围骰：指定一个数字，如果三枚骰子全为指定数字则赢。赔率一比一百八十。",220,0,"兼职小二") 
		win = tripledie()
		ratio = 180 		
	elseif r == 5 then
		Cls()
		say("全围：又称豹子，不需要指定数字，如果三枚骰子数字相同则赢。赔率一比三十。",220,0,"兼职小二") 
		win = samedie()
		ratio = 30 		
	end
	if not win then
		say("您这盘手气不好，没关系，再来一局吧？",220,0,"兼职小二") 
		do return end
	end
	say("恭喜！这是您的奖品！",220,0,"兼职小二") 
	addthing(174, math.modf(200 + 200 * ratio))
	tb(jiadian(ratio * 2))
end
	
OEVENTLUA[4000] = function() --游戏
	local gf = {CONFIG.DataPath .. "game.idx", CONFIG.DataPath .. "game.grp"}
	lib.PicLoadFile(gf[1], gf[2], 8)
	if JY.GOLD < 500 then
		Cls()
		say("您身上的钱不够。",220,0,"兼职小二") 		
		do return end
	end
	Cls()
	say("友情提示，游戏伤身伤神，客官请量力而行。",220,0,"兼职小二") 
	local menuItem = {
			{"采药草",nil,1},   
			{"挖宝藏",nil,1},
			{"黑白棋",nil,1},
			{"缺角图",nil,1},
			{"打猎",nil,1},
		}
	local r = 0
	Cls()
	r = ShowMenu3(menuItem, #menuItem, 1, -2, -2, -2, -2, 1, 0, 30, C_GOLD, C_WHITE, "要玩哪种游戏？")
	if r < 1 then
		do return end
	end
	local win = false
	addthing(174, -500)		
	if r == 1 then
		win = plant(-1, math.random(1, 2), 1)
		if win then
			say("恭喜！这是您的奖品！",220,0,"兼职小二") 
			instruct_2(math.random(0, 35), math.random(1, 2))
			instruct_2(174, math.random(5) * 100)
			tb(jiadian(100))
			do return end
		end
	elseif r == 2 then
		local coin, item, treasure = mining()
		local total = coin * 2 + item * 10 + treasure * 200
		local aaa = 0
		for i = coin, 1, -1 do
			aaa = aaa + math.random(10, 50)		
		end
		instruct_2(174, aaa)
		for i = item, 1, -1 do
			instruct_2(math.random(0, 35), math.random(1, 2))
		end
		if treasure ~= 0 then
			tb("恭喜挖到宝藏！")
			instruct_2(174, math.random(1000, 2000))
		end		
		tb(jiadian(total))	
		do return end
	elseif r == 3 then
		win = chess2()
		if win then
			say("恭喜！这是您的奖品！",220,0,"兼职小二") 
			AddPersonAttrib(zj(), "暗器技巧", math.random(3, 5))
			tb(JY.Person[zj()]["姓名"].."暗器技巧提升！")	
			instruct_2(174, math.random(3) * 100)
			tb(jiadian(200))	
			do return end
		end	
	elseif r == 4 then
		win = puzzle()
		if win then
			say("恭喜！这是您的奖品！",220,0,"兼职小二") 
			AddPersonAttrib(zj(), "拳掌功夫", math.random(3, 4))
			AddPersonAttrib(zj(), "御剑能力", math.random(4, 4))
			AddPersonAttrib(zj(), "耍刀技巧", math.random(3, 4))
			AddPersonAttrib(zj(), "特殊兵器", math.random(3, 4))
			tb(JY.Person[zj()]["姓名"].."四系兵器值提升！")	
			instruct_2(174, math.random(3, 5) * 100)
			tb(jiadian(250))				
			do return end
		end		
	elseif r == 5 then
		local total = hunt()
		tb("捕获了"..total.."只猎物！")
		if total >= 20 then
			AddPersonAttrib(zj(), "轻功", math.modf(total / 20))
			tb(JY.Person[zj()]["姓名"].."轻功上升"..math.modf(total / 20).."点！")
		end		
		instruct_2(174, math.random(2) * 100)
		tb(jiadian(total * 2))		
	end
	Cls()
	say("客官要不要再来一局？",220,0,"兼职小二") 
	do return end
end
	
	
OEVENTLUA[4001] = function() --积分换奖
	local x1 = CC.MainSubMenuX
	local y1 = CC.MainSubMenuY
	Cls()
	DrawStrBox(x1, y1, "现有"..JY.Base["点数"].."点积分可用",C_WHITE, CC.DefaultFont);
	local menu = {
		{"物品", nil, 1},
		{"装备", nil, 1},
		{"秘籍", nil, 1},
		{"印信", nil, 1},
	}
	local r = ShowMenu(menu,#menu,0,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
	if r <= 0 then do return end end
	local list = {}
	local price = {}
	if r == 1 then
		--list = {2, 6, 8, 11, 13, 14, 15, 16, 17, 256, 257, 258, 28, 29, 30, 31, 32, 33, 34, 35}
		for i = 0, JY.ThingNum - 1 do
			if JY.Thing[i]["类型"] == 3 then
				list[#list + 1] = i
			end
		end
	elseif r == 2 then
		--list = {53,41,42,62,46,39,45,48,50,230,245,243,248}
		for i = 0, JY.ThingNum - 1 do
			if JY.Thing[i]["类型"] == 1 then
				list[#list + 1] = i
			end
		end		
	elseif r == 3 then
		if (JY.Thing[203][WZ6] or 0) < 3 then
			do return end
		end
		for i = 0, JY.ThingNum - 1 do
			if JY.Thing[i]["类型"] == 2 then
				list[#list + 1] = i
			end
		end
	elseif r == 4 then
		if (JY.Thing[203][WZ6] or 0) < 5 then
			do return end
		end
		for i = 1, #CC.HZ do
			list[i] = i
		end
		local menu = {}
		for i = 1, #list do
			menu[i] = {string.format("%-12s %5d",CC.HZ[list[i]][2],25000), nil, 1}
			if hasHZ(i) then
				menu[i][3] = 0
			end
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
		if r <= 0 then do return end end
		if JY.Base["点数"] < 25000 then
			say("对不起，客官你的积分不够。",220,0,"兼职小二") 	
			do return end
		end
		addHZ(r)
		tb(jiadian(-25000))		
		do return end
	end
	for i = 1, #list do
		--if r == 1 then
		--	price[i] = math.modf(JY.Thing[list[i]]["价钱"] / 10)
		--elseif r == 2 then
		--	price[i] = math.modf(JY.Thing[list[i]]["价钱"] / 7)
		--elseif r == 3 then
		--	price[i] = math.modf(JY.Thing[list[i]]["价钱"] / 4)
		--end
		price[i] = JY.Thing[list[i]]["价钱"]
	end	
	local menu = {};
	for i = 1, #list do
		menu[i] = {string.format("%-12s %5d",JY.Thing[list[i]]["名称"],price[i]), nil, 1};
		if r == 2 or r == 3 then
			if hasthing(list[i]) then
				menu[i][3] = 0
			end
		end		
	end

	local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
	if r <= 0 then do return end end
	if JY.Base["点数"] < price[r] then
		say("对不起，客官你的积分不够。",220,0,"兼职小二") 	
		do return end
	end
	instruct_2(list[r], 1)
	tb(jiadian(-price[r]))
end
	
function plant(need, number, flag)
	local a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16
	local sx = 70
	local sy = 70
	local x0 = CC.ScreenW/2 - (sx/2 + 10) * 7
	local y0 = CC.ScreenH/2 - (sy/2 + 10) * 4
	local chance = math.modf(JY.Person[zj()]["医疗能力"] / 30)	 --5次机会
	if number > 1 then
		chance = chance + 3
	end
	local bg = CONFIG.PicturePath .. "game.jpg"

	local tmp = {
		{1, a1, x0 + sx, y0},
		{2, a2, x0 + sx, y0},
		{3, a3, x0 + sx, y0},
		{4, a4, x0 + sx, y0},
		{5, a5, x0 + sx, y0},
		{6, a6, x0 + sx, y0},
		{7, a7, x0 + sx, y0},
		{8, a8, x0 + sx, y0},
		{9, a9, x0 + sx, y0},
		{10, a10, x0 + sx, y0},
		{11, a11, x0 + sx, y0},
		{12, a12, x0 + sx, y0},
		{13, a13, x0 + sx, y0},
		{14, a14, x0 + sx, y0},
		{15, a15, x0 + sx, y0},
		{16, a16, x0 + sx, y0},
	}
	if need == -1 then
		need = math.random(#tmp)
	end	
	local dup = -1
	if flag ~= nil and flag == 1 then
		dup = math.random(1, #tmp)
	end	

	for i = 1, #tmp do
		tmp[i][2] = CONFIG.PicturePath .. i ..".png"
	end
	
	if dup ~= -1 then
		tmp[dup][2] = CONFIG.PicturePath .. need ..".png"
	end
	
	for i = 2, 6 do
		tmp[i][3] = tmp[i - 1][3] + sx + 10
	end
	for i = 7, 9 do
		tmp[i][3] = tmp[i - 1][3] 
		tmp[i][4] = tmp[i - 1][4] + sy + 10
	end
	for i = 10, 14 do
		tmp[i][3] = tmp[i - 1][3] - sx - 10
		tmp[i][4] = tmp[i - 1][4]
	end
	for i = 15, 16 do
		tmp[i][3] = tmp[i - 1][3]
		tmp[i][4] = tmp[i - 1][4] - sy - 10
	end
	
	local total = #tmp
	local target = need
	if target == 0 then
		target = math.random(#tmp)
	end
	local size = 30
	Cls()
	lib.LoadPicture(bg, -1, -1)
	lib.LoadPicture(tmp[target][2], CC.ScreenW/2 - sx/2, CC.ScreenH/2 - sy * 2)
	DrawBox3(CC.ScreenW/2 - sx/2 - 5, CC.ScreenH/2 - sy * 2 - 5, CC.ScreenW/2 - sx/2 + sx + 5, CC.ScreenH/2 - sy * 2 + sx + 5, C_RED)
	DrawStrBox(CC.ScreenW/2 - size * 7, CC.ScreenH/2 - size, "这是你需要采摘的药草，请采"..number.."棵", C_WHITE, size)	
	ShowScreen()
	local p = WaitKey()
	
	while true do
		Cls()
		lib.LoadPicture(bg, -1, -1)
		for i = 1, total do
			lib.LoadPicture(tmp[i][2], tmp[i][3], tmp[i][4])
			DrawBox3(tmp[i][3] - 5, tmp[i][4] - 5, tmp[i][3] + sx + 5, tmp[i][4] + sy + 5, C_WHITE)
		end
		local times = 1
		local count
		local count2 = #tmp * 1 + 2 * math.random(0, #tmp)
		local start = math.random(#tmp)
		
		for i = start, count2 + start do
			count = i
			if count > total * times then 
				count = i - total * times	
				times = math.modf(i / total)
			end
			if count ~= 1 then
				DrawBox3(tmp[count - 1][3] - 5, tmp[count - 1][4] - 5, tmp[count - 1][3] + sx + 5, tmp[count - 1][4] + sy + 5, C_WHITE)
			else
				DrawBox3(tmp[total][3] - 5, tmp[total][4] - 5, tmp[total][3] + sx + 5, tmp[total][4] + sy + 5, C_WHITE)
			end
			DrawBox3(tmp[count][3] - 5, tmp[count][4] - 5, tmp[count][3] + sx + 5, tmp[count][4] + sy + 5, C_BLACK)
			lib.LoadPicture(tmp[target][2], CC.ScreenW/2 - sx/2 - 5, CC.ScreenH/2 - sy/2 - 20)
			DrawBox3(CC.ScreenW/2 - sx/2 - 10, CC.ScreenH/2 - sy/2 - 25, CC.ScreenW/2 - sx/2 + sx, CC.ScreenH/2 - sy/2 + sy - 15, C_RED)		
			ShowScreen()
			lib.Delay(20)
			lib.Delay(times * 50 + i * 5)				
		end	
		ShowScreen()
		local p = WaitKey()
		chance = chance - 1
		Cls()
		lib.LoadPicture(bg, -1, -1)
		--tb2(target.."::"..count)
		--count = 1
		if target == count or (dup ~= -1 and count == dup) then
			local word = "采到了一棵药草！"
			number = number - 1
			if number > 0 then
				word = word.."还需要"..number.."棵。"
			end	
			tb2(word)
		else
			local word = "真可惜，差一点就到手了！"
			if chance > 0 then
				word = word.."还有"..chance.."次机会。"
			end		
			tb2(word)	
		end
		ShowScreen()
		WaitKey()
		if number <= 0 or chance <= 0 then
			break
		end
	end
	if number <= 0 then
		tb("终于采到了所需要的药草，累死了")
		return true
	else	
		tb("失败了，唉")
		return false
	end
	
end	

function mining()
	--local a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16
	local sx = 80
	local sy = 80
	local x0 = CC.ScreenW/2 - (sx/2 + 10) * 6
	local y0 = CC.ScreenH/2 - (sy/2 + 10) * 5
	local chance = 5 + math.modf((101 - JY.Person[zj()]["资质"]) * 0.1)	 --5次机会
	local bg = CONFIG.PicturePath .. "game.jpg"
	--local block = CONFIG.PicturePath .. "\\mine\\0.png"
	local tmp = {} --num, x, y, cover 0/1, thing 0-block, 1-nothing, 2-coin, 3-item, 4-treasure
	local num = 0
	local coin = 0
	local item = 0
	local treasure = 0

	
	for i = 1, 7 do
		for j = 1, 6 do
			local thing = 1
			if math.random(100) <= 40 then
				if math.random(100) <= 80 then
					thing = 2
				else
					if math.random(100) <= 90 then
						thing = 3
					else
						thing = 4
					end
				end
			end
			num = num + 1
			tmp[num] = {x0 + (i - 1) * sx + 30, y0 + (j - 1) * sy + 50, 0, thing}
			--lib.LoadPicture(block, x0 + (i - 1) * sx, y0 + (j - 1) * sy)
			--DrawStrBox(x0 + (i - 1) * sx + 30, y0 + (j - 1) * sy, ""..num, C_GOLD, 30)

		end
	end
	
	local current = 1
	while true do
		Cls()
		lib.LoadPicture(bg, -1, -1)	
		for i = 1, #tmp do
			if tmp[i][3] == 0 then
				lib.PicLoadCache(8, 0, tmp[i][1], tmp[i][2])
			else
				lib.PicLoadCache(8, tmp[i][4] * 2, tmp[i][1], tmp[i][2])				
			end
		end
		DrawBox3(tmp[current][1] - 5 - 35, tmp[current][2] - 40, tmp[current][1] + sx - 40, tmp[current][2] + sy - 40, C_RED)
		DrawString(x0 + 30 + 70 * 7 + 50, y0 + sy - 70, "机会："..chance, M_Wheat, 30)
		DrawString(x0 + 30 + 70 * 7 + 50, y0 + sy - 35, "金子："..coin, M_Wheat, 30)
		DrawString(x0 + 30 + 70 * 7 + 50, y0 + sy , "物品："..item, M_Wheat, 30)
		DrawString(x0 + 30 + 70 * 7 + 50, y0 + sy + 35, "宝藏："..treasure, M_Wheat, 30)
		ShowScreen()	
		local p = WaitKey()
		if chance <= 0 then break end
		if p == VK_SPACE then
			if tmp[current][3] ~= 1 then
				chance = chance - 1
				tmp[current][3] = 1
				if tmp[current][4] == 2 then
					coin = coin + 1
				elseif tmp[current][4] == 3 then
					item = item + 1
				elseif tmp[current][4] == 4 then		
					treasure = treasure + 1
				end
			end
		elseif p == VK_UP then
			current = limitX(current - 1, 1, 42)
		elseif p == VK_DOWN then
			current = limitX(current + 1, 1, 42)
		elseif p == VK_LEFT then
			current = limitX(current - 6, 1, 42)
		elseif p == VK_RIGHT then
			current = limitX(current + 6, 1, 42)
		end		
	end
	
	return coin, item, treasure
end

function chess()
	local sx = 80
	local sy = 80
	local x0 = CC.ScreenW/2 - (sx/2 + 10) * 6
	local y0 = CC.ScreenH/2 - (sy/2 + 10) * 5
	local move = 0
	local bg = CONFIG.PicturePath .. "game.jpg"
	local picstart = 5
	local tmp = {} --x, y, color 0/1
	local num = 0
	
	for j = 1, 4 do
		for i = 1, 4 do
			num = num + 1
			tmp[num] = {x0 + (i) * sx + 105, y0 + (j - 1) * sy + 105, 1}
		end
	end	
	tmp[6][3] = 0
	tmp[7][3] = 0
	tmp[10][3] = 0
	tmp[11][3] = 0
	local function flipown(a)
		if tmp[a][3] == 0 then
			tmp[a][3] = 1
		elseif tmp[a][3] == 1 then
			tmp[a][3] = 0
		end		
	end
	local function flipup(a)
		if a <= 4 then
			return
		end
		flipown(a - 4)		
	end
	local function flipdown(a)
		if a > 12 then
			return
		end
		flipown(a + 4)		
	end	
	local function flipleft(a)
		if math.fmod(a, 4) == 1 then
			return
		end
		flipown(a - 1)
	end
	local function flipright(a)
		if math.fmod(a, 4) == 0 then
			return
		end
		flipown(a + 1)
	end
	local function flip(a)
		flipown(a)
		flipleft(a)
		flipright(a)
		flipup(a)
		flipdown(a)
	end
	local function gameend()
		local ok = 0
		for i = 1, #tmp do
			if tmp[i][3] == 1 then
				ok = 1
				break
			end
		end
		if ok == 1 then
			return false
		else
			return true
		end
	end


	local times = math.random(3, 10)
	for i = 1, times do
		flip(math.random(#tmp))
	end	
	
	local current = 1
	local win = false
	while true do		
		Cls()
		lib.LoadPicture(bg, -1, -1)	
		DrawBox(x0 + sx - 10, y0 + 50 - 50, x0 + sx + sx * 5 + 60 , y0 + sy * 5 + 40, C_WHITE)
		for i = 1, #tmp do
			if tmp[i][3] == 0 then
				lib.PicLoadCache(8, 2 * 5, tmp[i][1], tmp[i][2])
			else
				lib.PicLoadCache(8, 2 * 6, tmp[i][1], tmp[i][2])
			end
		end		
		DrawBox3(tmp[current][1] - 5 - 35, tmp[current][2] - 40, tmp[current][1] + sx - 40, tmp[current][2] + sy - 40, C_RED)
		DrawString(x0 + 30 * 5 + 100, y0 + sy * 5, "步数："..move, C_GOLD, 30)
		ShowScreen()
		local p = WaitKey()
		win = gameend()
		if win == true then
			lib.Delay(200)
			break
		end		
		if p == VK_ESCAPE then
			Cls()
			lib.LoadPicture(bg, -1, -1)	
			if yesno("放弃吗？") then
				break
			end
		elseif p == VK_SPACE then
			move = move + 1
			flip(current)		
		elseif p == VK_UP then
			current = limitX(current - 4, 1, 16)
		elseif p == VK_DOWN then
			current = limitX(current + 4, 1, 16)
		elseif p == VK_LEFT then
			current = limitX(current - 1, 1, 16)
		elseif p == VK_RIGHT then
			current = limitX(current + 1, 1, 16)
		end		
	end
	if win == true then
		tb("恭喜！你赢了！")
	end
	return win
end

function chess2()
	local sx = 80
	local sy = 80
	local x0 = CC.ScreenW/2 - (sx/2 + 10) * 6
	local y0 = CC.ScreenH/2 - (sy/2 + 10) * 5
	local move = 0
	local bg = CONFIG.PicturePath .. "game.jpg"
	local picstart = 5
	local tmp = {} --x, y, color 0/1
	local num = 0
	
	for j = 1, 5 do
		for i = 1, 5 do
			num = num + 1
			tmp[num] = {x0 + (i) * sx + 70, y0 + (j - 1) * sy + 50, 1}
			--lib.PicLoadCache(8, 2 * (tmp[num][3] + picstart + 1), tmp[num][1], tmp[num][2])
		end
	end	
	
	local function flipown(a)
		if tmp[a][3] == 0 then
			tmp[a][3] = 1
		elseif tmp[a][3] == 1 then
			tmp[a][3] = 0
		end		
	end
	local function flipup(a)
		if a <= 5 then
			return
		end
		flipown(a - 5)		
	end
	local function flipdown(a)
		if a > 20 then
			return
		end
		flipown(a + 5)		
	end	
	local function flipleft(a)
		if math.fmod(a, 5) == 1 then
			return
		end
		flipown(a - 1)
	end
	local function flipright(a)
		if math.fmod(a, 5) == 0 then
			return
		end
		flipown(a + 1)
	end
	local function flip(a)
		flipown(a)
		flipleft(a)
		flipright(a)
		flipup(a)
		flipdown(a)
	end
	local function gameend()
		local ok = 0
		for i = 1, #tmp do
			if tmp[i][3] == 1 then
				ok = 1
				break
			end
		end
		if ok == 1 then
			return false
		else
			return true
		end
	end	

	local times = math.random(3, 10)
	for i = 1, times do
		flip(math.random(#tmp))
	end	
	
	local win = false
	local current = 1
	while true do		
		Cls()
		lib.LoadPicture(bg, -1, -1)	
		DrawBox(x0 + sx - 10, y0 + 50 - 70, x0 + sx + sx * 5 + 70 , y0 + sy * 5 + 60, C_WHITE)
		for i = 1, #tmp do
			if tmp[i][3] == 0 then
				lib.PicLoadCache(8, 2 * 5, tmp[i][1], tmp[i][2])
			else
				lib.PicLoadCache(8, 2 * 6, tmp[i][1], tmp[i][2])
			end
		end		
		DrawBox3(tmp[current][1] - 5 - 35, tmp[current][2] - 40, tmp[current][1] + sx - 40, tmp[current][2] + sy - 40, C_RED)
		DrawString(x0 + 30 * 5 + 100, y0 + sy * 5 + 20, "步数："..move, C_GOLD, 30)
		ShowScreen()
		local p = WaitKey()
		win = gameend()
		if win == true then
			lib.Delay(200)
			break
		end				
		if p == VK_ESCAPE then
			Cls()
			lib.LoadPicture(bg, -1, -1)	
			if yesno("放弃吗？") then
				break
			end
		elseif p == VK_SPACE then
			move = move + 1
			flip(current)			
		elseif p == VK_UP then
			current = limitX(current - 5, 1, 25)
		elseif p == VK_DOWN then
			current = limitX(current + 5, 1, 25)
		elseif p == VK_LEFT then
			current = limitX(current - 1, 1, 25)
		elseif p == VK_RIGHT then
			current = limitX(current + 1, 1, 25)
		end		
	end
	if win == true then
		tb("恭喜！你赢了！")
	end
	return win	
end

function puzzle()	
	local sx = 60
	local sy = 60
	local x0 = CC.ScreenW/2 - (sx/2 + 10) * 6
	local y0 = CC.ScreenH/2 - (sy/2 + 10) * 5
	local move = 0
	local blank = 1
	local bg = CONFIG.PicturePath .. "game.jpg"
	local start = {11, 36, 61, 86, 111, 136, 161, 186}
	local picstart = start[math.random(#start)] --随机换
	
	--picstart = 186
	
	local empty = 10
	local tmp = {} --number, x, y, position, pic
	local sample = {}
	local num = 0
			Cls()
		lib.LoadPicture(bg, -1, -1)	
		--DrawBox(sx, y0 + 50 - 100, sx + sx * 5 + 40 , y0 + sy * 5 + 60, C_WHITE)
		
	for i = 1, 5 do
		for j = 1, 5 do
			num = num + 1
			tmp[num] = {num, (j) * (sx) + 400, y0 + (i - 1) * (sy) + 50, num, num + picstart - 1}
			sample[num] = {num, (j) * (sx) + 50, y0 + (i - 1) * (sy) + 50, num, num + picstart - 1}
			--DrawStrBox(tmp[num][2], tmp[num][3], num.."", C_ORANGE, 20)
		end
	end	

	--top right = blank
	tmp[1][1] = 0
	tmp[1][4] = 0
	tmp[1][5] = 10
	sample[1][5] = 10
	
	local function gameend()
		if move == 0 then
			return false
		end
		local a = true
		for i = 1, num do
			if tmp[i][1] ~= tmp[i][4] then
				a = false
				break
			end
		end
		return a
	end

	local function canmove(a)
		if blank == a + 1 or blank == a - 1 or blank == a + 5 or blank == a - 5 then
			return true
		end
		return false
	end

	local function moveit(a)
		if canmove(a) then
			--blank and a change in x, y, position, NOT in number
			--local tmp = {} --number, x, y, position
			local b = tmp[a][5]
			local c = tmp[a][4]
			tmp[a][5] = tmp[blank][5]
			tmp[a][4] = tmp[blank][4]
			tmp[blank][5] = b
			tmp[blank][4] = c
			local d = blank
			blank = a
			--a = d			
		end
		return a
	end
	local function moveup(a)
		if a <= 5 then
			return -1
		end
		return a - 5
	end
	local function movedown(a)
		if a > 20 then
			return -1
		end
		return a + 5
	end	
	local function moveleft(a)
		if math.fmod(a, 5) == 1 then
			return -1
		end
		return a - 1
	end
	local function moveright(a)
		if math.fmod(a, 5) == 0 then
			return -1
		end
		return a + 1
	end		
	local function randommove()
		local store = {}
		local n = 0
		local up = moveup(blank)
		local down = movedown(blank)
		local left = moveleft(blank)
		local right = moveright(blank)
		--if blank == a + 1 or blank == a - 1 or blank == a + 5 or blank == a - 5 then
		if up ~= -1 then
			n = n + 1
			store[n] = up
		end
		if down ~= -1 then
			n = n + 1
			store[n] = down
		end
		if left ~= -1 then
			n = n + 1
			store[n] = left
		end
		if right ~= -1 then
			n = n + 1
			store[n] = right
		end
		local result = store[math.random(#store)]
		return result
	end
	
	local function generate()
		local a = math.random(200, 500)
		for i = 1, a do
			local result = randommove()
			moveit(result)
		end
	end	
	generate()
	local win = false
	local current = 1
	while true do		
		Cls()
		lib.LoadPicture(bg, -1, -1)	
		for i = 1, num do
			lib.PicLoadCache(8, 2 * sample[i][5], sample[i][2], sample[i][3])
			lib.PicLoadCache(8, 2 * tmp[i][5], tmp[i][2], tmp[i][3])
			--DrawStrBox(tmp[i][2] - 20, tmp[i][3], tmp[i][1].."::"..tmp[i][4], C_ORANGE, 15)			
			DrawBox3(tmp[i][2] - 30, tmp[i][3] - 30, tmp[i][2] + sx - 30, tmp[i][3] + sy - 30, M_LightBlue)
			DrawBox3(sample[i][2] - 30, sample[i][3] - 30, sample[i][2] + sx - 30, sample[i][3] + sy - 30, M_LightBlue)
		end		
		DrawBox3(tmp[current][2] - 30, tmp[current][3] - 30, tmp[current][2] + sx - 30, tmp[current][3] + sy - 30, C_RED)
		DrawString(x0 + 30 * 5 - 110, y0 + sy * 5 + 20, "样品", C_GOLD, 30)
		DrawString(x0 + 30 * 5 + 205, y0 + sy * 5 + 20, "步数："..move, C_GOLD, 30)
		ShowScreen()
		local p = WaitKey()
		win = gameend()
		if win == true then
			lib.Delay(200)
			break
		end				
		if p == VK_ESCAPE then
			Cls()
			lib.LoadPicture(bg, -1, -1)	
			if yesno("放弃吗？") then
				break
			end
		elseif p == VK_SPACE then
			if canmove(current) then
				move = move + 1
			end		
			current = moveit(current)
			--generate()
		elseif p == VK_UP then
			current = limitX(current - 5, 1, 25)
		elseif p == VK_DOWN then
			current = limitX(current + 5, 1, 25)
		elseif p == VK_LEFT then
			current = limitX(current - 1, 1, 25)
		elseif p == VK_RIGHT then
			current = limitX(current + 1, 1, 25)
		end		
	end
	if win == true then
		tb("恭喜！你赢了！")
	end
	return win		
end

function hunt()	
	local bg = CONFIG.PicturePath .. "game.jpg"
	local bg2 = CONFIG.PicturePath .. "hunt.png"
	local start = 212
	local width = 100
	local height = 145
	local current = 1
	local shoot = false
	local path = 1
	local m = 1
	local arrow = 10 --箭矢数
	local limit = 60000
	limit = math.modf(50 * (JY.Person[zj()]["攻击力"] + JY.Person[zj()]["防御力"] + JY.Person[zj()]["轻功"]))
	local aa = math.modf(limit / 1000)
	local menu = { --num, x, y, type, dead
	}
	local menu2 = {}
	local menu3 = {
		{1, "熊", 0},
		{2, "蛇", 0},
		{3, "雁", 0},
		{4, "猪", 0},
		{5, "鹿", 0},
		{6, "兔", 0},
	}
	local p
	for i = 1, 8 do
		menu[i] = {i, 50 + width * (i - 1), 130, nil, false}
		menu2[i] = {i, 50 + width * (i - 1), 540, 211, false}
	end
	
	menu2[1][5] = true
	
	
	for i = 1, 8 do
		if menu[i][4] ~= nil and menu[i][5] then
			menu[i][4] = menu[i][4] + 6
		elseif math.random(8) == 1 then
			menu[i][4] = math.random(start, start + 5)
		else
			menu[i][4] = nil
		end
	end
	local t1 = lib.GetTime()
	local starttime = lib.GetTime()
		
	while true do
		local t2 = lib.GetTime();
		if t2 - t1 > 2000 then --重置
			for i = 1, 8 do
				if math.random(5) == 1 then
					menu[i][4] = math.random(start, start + 5)
				else
					menu[i][4] = nil
				end
				menu[i][5] = false
			end
			t1 = t2
		end	
		--for i = 1, 40 do
		Cls()		
		lib.LoadPicture(bg2, -1, -1)	
		--lib.PicLoadCache(8, 2 * 211, 400, 550 - i * 10)
		for i = 1, 8 do
			if menu[i][4] ~= nil then
				if menu[i][5] then
					lib.PicLoadCache(8, 2 * (menu[i][4] + 6), menu[i][2], menu[i][3])
				else
					lib.PicLoadCache(8, 2 * menu[i][4], menu[i][2], menu[i][3])
				end
			end
			if menu2[i][5] then
				lib.PicLoadCache(8, 2 * menu2[i][4], menu2[i][2], menu2[i][3])
			end
		end
		if shoot then
			lib.PicLoadCache(8, 2 * menu2[path][4], menu2[path][2], menu2[path][3] - m * 10)
			m = m + 1		
			if m == 38 then --射到底重置
				shoot = false
				m = 1
				if menu[path][4] ~= nil and not menu[path][5] then
					menu[path][5] = true
					menu3[menu[path][4] - start + 1][3] = menu3[menu[path][4] - start + 1][3] + 1
					PlayWavAtk(3)
				end
			end
			--lib.PicLoadCache(8, 2 * 211, 400, 550 - i * 10)			
		end
		for i = 1, #menu3 do
			DrawString(CC.ScreenW / 2 + 22 * 3 * (i - 1), 0, menu3[i][2]..":"..menu3[i][3], C_GOLD, 20)
		end
		DrawString(10, 0, "剩余时间:"..aa.."秒", C_GOLD, 20)
		ShowScreen()
		p = lib.GetKey()
		if p == VK_ESCAPE then
			break
		elseif p == VK_RIGHT then
			menu2[current][5] = false
			current = limitX(current + 1, 1, 8)
			menu2[current][5] = true
		elseif p == VK_LEFT then
			menu2[current][5] = false
			current = limitX(current - 1, 1, 8)
			menu2[current][5] = true
		elseif p == VK_SPACE and not shoot then
			shoot = true
			path = current
		end
		local endtime = lib.GetTime()
		local diff = endtime - starttime
		aa = math.modf((limit - diff) / 1000)
		if aa == -1 then
			break
		end
		lib.Delay(10)
	end
	local total = 0
	for i = 1, #menu3 do
		total = total + menu3[i][3]
	end	
	return total, menu3
end	

function craft (weapon)
	local starttime = lib.GetTime() --起始时间
	local endtime = -1 --结束时间
	local duration = 30 * 1000 --总时间，根据武器难度变换，*1000=秒
	local timer = math.modf(duration / 1000) --显示剩余时间，= duration - (endtime - starttime) all divided by 1000
	local key
	--local weapon = 36 --打造的东西编号
	local iron = 0 --能量值 600 100%成功 550-600有1-50%几率成功
	local level = 100 -- 每成功一组能量值增加这么多，难度越大这个越小，与武器有关
	local count = 1
	local win = 0 --结果 0--时间到 1/2--打造成功
	local group = {
		{0, 0, 180, 320, false}, --num, direction, x, y, clicked 0/1
		{0, 0, 280, 320, false},
		{0, 0, 380, 320, false},
		{0, 0, 480, 320, false},
		{0, 0, 580, 320, false},
	}
	local function randomgroup()
		local a = {{232, VK_LEFT}, {233, VK_RIGHT}, {234, VK_UP}, {235, VK_DOWN}}
		for i = 1, #group do
			local r = math.random(#a)
			group[i][1] = a[r][1]
			group[i][2] = a[r][2]
			group[i][5] = false
		end
		count = 1
	end
	randomgroup()
	while true do
		Cls()		
		lib.LoadPicture(CONFIG.PicturePath .. "game.jpg", -1, -1)
		lib.PicLoadCache(8, 231 * 2, 100, 200, 1)
		lib.SetClip(100, 200, 100 + iron, 300)  
		lib.PicLoadCache(8, 230 * 2, 100, 200, 1)
		lib.SetClip(0, 0, 0, 0)
		DrawString(10, 0, "剩余时间:"..timer.."秒", C_GOLD, 25)
		DrawString(10, 30, "打造物品:"..JY.Thing[weapon]["名称"], C_ORANGE, 25)
		DrawString(10, 60, "打造难度:".."高级", C_RED, 25)
		for i = 1, #group do
			if not group[i][5] then
				lib.PicLoadCache(8, group[i][1] * 2, group[i][3], group[i][4], 1)
			else
				lib.PicLoadCache(8, group[i][1] * 2, group[i][3], group[i][4], 3, 150)
			end
		end
		ShowScreen()
		key = lib.GetKey()
		if key == VK_ESCAPE then
			break
		elseif key == group[count][2] then
			group[count][5] = true
			count = count + 1
		elseif key > 99999 then
		
		elseif key ~= -1 then
			randomgroup()			
			iron = limitX(iron - 20, 0, 600)
			lib.PicLoadCache(8, 237 * 2, 300, 400, 1)	
			ShowScreen()
			lib.Delay(200)	
		end
		if count > 5 then
			iron = iron + level
			randomgroup()
			lib.PicLoadCache(8, 236 * 2, 300, 400, 1)
			ShowScreen()
			lib.Delay(200)	
		end
		lib.Delay(10)
		if iron >= 600 then
			win = 1
			break
		end
		endtime = lib.GetTime()
		timer = math.modf((duration - (endtime - starttime)) / 1000)
		if timer < 0 then
			if iron >= 550 then
				if JLSD(10, 10 + (iron - 550), zj()) then
					win = 2
				end	
			end
			break
		end		
	end
	return win
	--[[Cls()
	lib.LoadPicture(CONFIG.PicturePath .. "game.jpg", -1, -1)
	if win == 1 then
		tb2("打造成功！", nil, nil, C_ORANGE, 30)
		ShowScreen()
		WaitKey()
		instruct_2(weapon, 1)
	elseif win == 2 then
		tb2("天降奇遇！打造成功！", nil, nil, C_ORANGE, 30)
		ShowScreen()
		WaitKey()
		instruct_2(weapon, 1)
	else
		tb2("失败了，真可惜。", nil, nil, C_ORANGE, 30)
		ShowScreen()
		WaitKey()
	end]]
end

function makedrug(drug)
	local top = 120
	local bottom = 530
	local count = 1
	local current = 1
	local column = 8
	local key
	local fire = 0
	local grass = 0
	local water = 0
	local drop = {}
	local win = false
	lib.PicLoadFile(CC.GamePicFile[1], CC.GamePicFile[2], 8)
	for i = 1, 20 do
		 --#, x, y, speed, location
		drop[i] = {[0] = 0, math.random(238, 240), 40 + math.random(column) * 80, top, math.random(10), 1}
		if math.random(10) <= 2 then
			drop[i][0] = 1
		end
	end
	while true do
		Cls()
		lib.LoadPicture(CONFIG.PicturePath .. "game.jpg", -1, -1)

		lib.PicLoadCache(8, 239 * 2, 50, 5, 1)
		lib.PicLoadCache(8, 240 * 2, 270, 5, 1)
		lib.PicLoadCache(8, 242 * 2, 100, 20, 1)
		lib.PicLoadCache(8, 242 * 2, 320, 20, 1)

		lib.SetClip(100, 20, 100 + fire, 50)  
		lib.PicLoadCache(8, 243 * 2, 100, 20, 1)

		lib.SetClip(320, 20, 320 + grass, 50) 
		lib.PicLoadCache(8, 244 * 2, 320, 20, 1)

		lib.SetClip(0, 0, 0, 0)
		for i = 1, 5 do
			lib.PicLoadCache(8, 238 * 2, 490 + (i - 1) * 50, 5, 1)
		end

		for i = 1, water do
			lib.PicLoadCache(8, 245 * 2, 490 + (i - 1) * 50, 5, 1)
		end

		DrawBox(60, top - 50, 740, bottom + 60, C_GOLD)
		for i = 1, #drop do
			if drop[i][0] ~= 0 then
				if current == (drop[i][2] - 40) / 80 and top + (drop[i][5] + 1) * drop[i][4] > bottom - 30 then
					if drop[i][1] == 239 then
						fire = fire + 20
					elseif drop[i][1] == 240 then
						grass = grass + 20
					elseif drop[i][1] == 238 then
						water = water + 1
					end
					drop[i] = {[0] = 0, math.random(238, 240), 40 + math.random(column) * 80, top, math.random(10), 1}
				else
					lib.PicLoadCache(8, drop[i][1] * 2, drop[i][2], top + drop[i][5] * drop[i][4])
				end
				drop[i][5] = drop[i][5] + 1
				if top + drop[i][5] * drop[i][4] > bottom + 30 then
					drop[i] = {[0] = 0, math.random(238, 240), 40 + math.random(column) * 80, top, math.random(10), 1}
				end
			else
				if math.random(200) <= 1 then
					drop[i][0] = 1
				end
			end
		end
		lib.PicLoadCache(8, 241 * 2, 40 + current * 80, bottom)
		ShowScreen()
		if water >= 5 then
			lib.PicLoadCache(8, 245 * 2, 490 + 4 * 50, 5, 1)
			tb2("炼药失败！", nil, nil, C_GOLD, 50)	
			ShowScreen()
			lib.Delay(1500)
			WaitKey()
			break
		end
		if fire >= 160 and grass >= 160 then
			lib.PicLoadCache(8, 239 * 2, 50, 5, 1)
			lib.PicLoadCache(8, 240 * 2, 270, 5, 1)
			lib.PicLoadCache(8, 242 * 2, 100, 20, 1)
			lib.PicLoadCache(8, 242 * 2, 320, 20, 1)

			lib.SetClip(100, 20, 100 + fire, 50)  
			lib.PicLoadCache(8, 243 * 2, 100, 20, 1)

			lib.SetClip(320, 20, 320 + grass, 50) 
			lib.PicLoadCache(8, 244 * 2, 320, 20, 1)

			lib.SetClip(0, 0, 0, 0)
			tb2("炼药成功！", nil, nil, C_GOLD, 50)	
			ShowScreen()
			lib.Delay(1500)
			WaitKey()
			win = true
			break
		end
		key = lib.GetKey()
		if key == VK_RIGHT then
			current = limitX(current + 1, 1, column)
		elseif key == VK_LEFT then
			current = limitX(current - 1, 1, column)
		elseif key == VK_ESCAPE then
			break
		end

		lib.Delay(20)
	end
	return win
end