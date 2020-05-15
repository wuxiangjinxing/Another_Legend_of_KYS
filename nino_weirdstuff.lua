instruct_3(1,1,-2,-2,10019,10020,-2,-2,-2,-2,-2,-2,-2)
OEVENTLUA[10020] = function()
	local r = 0
	if instruct_4(153) == true then
		OEVENTLUA[40000]()
		do return end
	end
end

OEVENTLUA[40000] = function()
	instruct_0()
	say("神雕侠侣？这可是本好书啊！",220,0,"神秘小二") 	
	instruct_0()
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY,"请选择任务", C_WHITE, CC.DefaultFont)	
	local test = false
	local menu = {
	{"杨过的单身之旅", nil, 0},
	{"小龙女的单身之旅", nil, 0},
	{"神雕侠侣的江湖", nil, 0},
	{"霍都的逆袭", nil, 0},
	}
	if instruct_16(58) and GetS(1, 1, 0, 1) ~= 9 then
		menu[1][3] = 1
		test = true
	end
	if instruct_16(59) then
		menu[2][3] = 1
		test = true
	end
	if instruct_16(58) and instruct_16(59) then
		menu[3][3] = 1
		test = true
	end
	if instruct_16(84) and GetS(1, 4, 0, 1) ~= 9 then
		menu[4][3] = 1
		test = true
	end	
	if test == false then
		instruct_0()
		say("不把关键的人物带过来我怎么给你分配任务呢？",220,0,"神秘小二") 	
		do return end
	end
	local r = ShowMenu(menu,#menu,0,CC.MainSubMenuX,CC.MainSubMenuY+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
	if r == 1 then
		instruct_0()
		say("其实这是一个穷小子成为高富帅的励志故事....（以下略过千字）",220,0,"神秘小二") 			
		instruct_0()
		say("他风尘困顿，歇息在陆家庄。偏偏遇上了英雄大会。一半为了美人一半为了面子，大战就此展开序幕！",220,0,"神秘小二") 				
		SetS(1, 1, 0, 1, 1)
		if instruct_6(272,4,0,0) == false then --vs霍都
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end		
		instruct_0()
		instruct_13()
		SetS(1, 1, 0, 1, 2)
		if instruct_6(272,4,0,0) == false then --vs达尔巴
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end	
		instruct_0()
		instruct_13()	
		SetS(1, 1, 0, 1, 3)
		if instruct_6(272,4,0,0) == false then --vs金轮
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end	
		instruct_0()
		instruct_13()	
		instruct_0()
		say("再再后来，抱得美人归的他屡遭不幸，美人中毒，留书远走，他只能一雕一剑浪迹江湖，等待重逢的那一天....（以下略过千字）",220,0,"神秘小二") 			
		instruct_0()
		say("无耻胡诌的浪子单身篇结束。",220,0,"神秘小二") 			
		SetS(1, 1, 0, 1, 9)
		elseif r == 2 then
	
	elseif r == 3 then
	
	elseif r == 4 then
		instruct_0()
		say("这是一个在某个平行宇宙发生的事情....",220,0,"神秘小二") 		
		instruct_0()
		say("小顽童竟然敢挑战英勇的小王子，小王子决定给他一点小小的教训。",220,0,"神秘小二") 			
		SetS(1, 4, 0, 1, 1)
		local tmpatk = JY.Person[58]["攻击力"]
		local tmpdef = JY.Person[58]["防御力"]
		local tmpspd = JY.Person[58]["轻功"]	
		JY.Person[58]["攻击力"] = 400
		JY.Person[58]["防御力"] = 400
		JY.Person[58]["轻功"] = 300				
		if instruct_6(275,4,0,0) == false then --vs杨过
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end	
		JY.Person[58]["攻击力"] = tmpatk
		JY.Person[58]["防御力"] = tmpdef
		JY.Person[58]["轻功"] = tmpspd			
		instruct_0()
		instruct_13()
		instruct_0()
		say("战胜了小顽童的小王子意气风发，直嚷着要单挑传说中的侠之大者。",220,0,"神秘小二") 	
		SetS(1, 4, 0, 1, 2)
		local tmpatk = JY.Person[55]["攻击力"]
		local tmpdef = JY.Person[55]["防御力"]
		local tmpspd = JY.Person[55]["轻功"]	
		JY.Person[55]["攻击力"] = 300
		JY.Person[55]["防御力"] = 350
		JY.Person[55]["轻功"] = 250				
		if instruct_6(275,4,0,0) == false then --vs郭靖
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end	
		JY.Person[55]["攻击力"] = tmpatk
		JY.Person[55]["防御力"] = tmpdef
		JY.Person[55]["轻功"] = tmpspd	
		instruct_0()
		instruct_13()
		instruct_0()
		say("莫名其妙地为师父争夺了武林盟主的位置之后，小王子突发奇想：为什么我不能成为武林盟主呢？",220,0,"神秘小二") 			
		SetS(1, 4, 0, 1, 3)
		if instruct_6(275,4,0,0) == false then --vs金轮
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end	
		instruct_0()
		instruct_13()	
		instruct_0()
		say("可惜好景不长，被中原武林众强者赶下台来的小王子潦倒江湖。发誓东山再起的他加入了丐帮。",220,0,"神秘小二") 			
		instruct_0()
		say("边学边练的他养光韬晦，终于在丐帮大会上大显身手，单挑了数十人众。",220,0,"神秘小二") 			
		instruct_0()
		say("现在只剩侠之大者的太太，简称侠太，站在台上了。",220,0,"神秘小二") 	
		SetS(1, 4, 0, 1, 4)
		local tmpatk = JY.Person[56]["攻击力"]
		local tmpdef = JY.Person[56]["防御力"]
		local tmpspd = JY.Person[56]["轻功"]	
		JY.Person[56]["攻击力"] = 350
		JY.Person[56]["防御力"] = 350
		JY.Person[56]["轻功"] = 350				
		if instruct_6(275,4,0,0) == false then --vs黄蓉
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end	
		JY.Person[56]["攻击力"] = tmpatk
		JY.Person[56]["防御力"] = tmpdef
		JY.Person[56]["轻功"] = tmpspd	
		instruct_0()
		instruct_13()		
		instruct_0()
		say("小王子终于有出头天了。从此左钵盂右棒子，带领着丐帮走向改革开放的新明天。",220,0,"神秘小二") 
		instruct_0()
		say("闲扯的小王子复仇记篇结束。",220,0,"神秘小二") 		
		SetS(1, 4, 0, 1, 9)		
	end
end