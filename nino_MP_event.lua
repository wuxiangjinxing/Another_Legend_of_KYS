--[[
10000 - stuff
20000 - team
30000 - trial patch, 0 - betray; 1 - teach; 2 - own MP
30010 on - quest
31000 - MP
星宿31000-31009；0-就职任务，1-战斗，2-入门，3-升级
丐帮31010-31019；0，1-就职任务，3-升级
武当31020-31029：0-入门，2-晋级
少林31030-31039：0-入门，2-晋级
血刀31040-31049：0-入门，1-晋级
逍遥31050-31059：0-高资入门，1-低资入门，2-灵鹫正，3-灵鹫邪
灵鹫31052-31053
nevent105 - 唐门入门
]]
OEVENTLUA[30000] = function() --叛教
	if MPPD(0) ~= 0 then
		local tmp = ""
		if ownMP() and MPPD(0) == 63 then
			tmp = ownMPstat(1)[1]
		else
			tmp = CC.MP[MPPD(0)][1]
		end
		if (MPPD(0) == 1 and MPDJ(0) == 3) or (MPPD(0) == 6 and MPDJ(0) == 2)
			or (MPPD(0) == 7 and MPDJ(0) == 2) or (MPPD(0) == 8 and MPDJ(0) == 2) or (MPPD(0) == 11 and MPDJ(0) == 4) or (MPPD(0) == 12 and MPDJ(0) > 3)
            or (MPPD(0) == 10 and MPDJ(0) == 3) or (MPPD(0) == 13 and MPDJ(0) > 3) or MPPD(0) == 63 then
			instruct_0()
			say("客官您可是堂堂掌门，怎么可以弃弟子而不顾呢？",220,0,"神秘小二") 			
		elseif (CC.MPDJ[MPPD(0)][MPDJ(0)] == "掌门") or (CC.MPDJ[MPPD(0)][MPDJ(0)] == "门主") 
			or (CC.MPDJ[MPPD(0)][MPDJ(0)] == "庄主") or (CC.MPDJ[MPPD(0)][MPDJ(0)] == "教主") then
			instruct_0()
			say("客官您可是堂堂掌门，怎么可以弃弟子而不顾呢？",220,0,"神秘小二") 				
		else
			instruct_0()
			say("客官你乌云盖顶印堂发黑，近日必有血光之灾。",220,0,"神秘小二") 	
			instruct_0()
			say("待我掐指算一算....是了！肯定是客官您对现在的职业不满。",220,0,"神秘小二") 			
			instruct_0()
			say("我完全可以理解，想当年我也是想做个大掌柜的，结果却沦落到这个地步。",220,0,"神秘小二") 	
			instruct_0()
			say("闲话少说，您要叛教吗？我不是在教唆您哦，请务必三思而后行。丢了性命我可不管。",220,0,"神秘小二") 	
			instruct_0()
			if DrawStrBoxYesNo(-1, -1, "要叛教吗？", C_WHITE, 30) == true then	
				SetS(106, MPPD(0), 0, 0, 1)
				SetS(106, MPPD(0), 1, 0, 0)
				instruct_0()
				JY.Person[931]["无用13"] = 1
				say("客官您已经脱离"..tmp.."了，请小心。",220,0,"神秘小二")
				--[[
				for i = 1 , JY.PersonNum - 1 do
					if (MPPD(0) == 10 or MPPD(0) == 11) and MPPD(i) == MPPD(0) and inteam(i) then
						say("叛徒！哼！",i) 				
						instruct_21(i) 
					end
                end 
				]]
				JoinMP(0, 0, 0)
			end
		end
	else
		instruct_0()
		say("客官您现在没有加入任何门派。",220,0,"神秘小二") 	
	end
end

OEVENTLUA[30001] = function() --队友就职
	if MPPD(0) == 0 then
		instruct_0()
		say("客官您现在没有加入任何门派。",220,0,"神秘小二") 	
		do return end
	end
	local tmp = ""
	if ownMP() and MPPD(0) == 63 then
		tmp = ownMPstat(1)[1]
	else
		tmp = CC.MP[MPPD(0)][1]
	end
	instruct_0()
	say("客官您有啥吩咐？",220,0,"神秘小二") 	
	instruct_0()
	say("要开课指导队友"..tmp.."的武功？等我看看您有没有授业资格....",220,0,"神秘小二") 
	local teamnum = 1
	for i = 2, CC.TeamNum do
		if JY.Base["队伍" .. i] > 0 then
			teamnum = teamnum + 1
		end
	end
	if teamnum < 2 then
		instruct_0()
		say("您队伍里没有合适的学生。",220,0,"神秘小二") 			
		do return end	
	end
	if MPPD(0) ~= 0 and MPDJ(0) > 1 then
		local menu = {}
		local PD = false
		for i = 1, teamnum do
			local pid = JY.Base["队伍" .. i]
			menu[i] = {JY.Person[pid]["姓名"], nil, 0, pid}
		end

		for i = 2, teamnum do
			if MPReq(menu[i][4], MPPD(0)) and MPPD(menu[i][4])== 0 then
				menu[i][3] = 1
				PD = true
			end
		end
		if PD == false then
			instruct_0()
			say("您队伍里没有合适的学生。",220,0,"神秘小二") 			
			do return end		
		end
		Cls();
		DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY,"选择授课对象", C_WHITE, CC.DefaultFont);		
		local r = ShowMenu(menu,#menu,0,CC.MainSubMenuX,CC.MainSubMenuY+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
		if r < 1 then
			instruct_0()
			say("放弃了吗？好吧。",220,0,"神秘小二") 		
			do return end
		else
			local pid = menu[r][4]
			if MPPD(0) == 7 then 
			JoinMP(pid, MPPD(0), 1)
			else 
			JoinMP(pid, MPPD(0), MPDJ(0) - 1)
			end
			if MPPD(0) == 11 then
			   JY.Person[pid]["武功1"] = 131
			   JY.Person[pid]["武功等级1"] = 999
			end   
			instruct_0()
			say(JY.Person[pid]["姓名"].."学会了"..tmp.."的技能。",220,0,"神秘小二") 			
		end
		
	else
		instruct_0()
		say("很抱歉，您暂时没有授业的资格。",220,0,"神秘小二") 	
	end
end

OEVENTLUA[30002] = function() --自创门派
	local yes = 0	
	if math.random(300) == 150 and MPPD(0) == 0 and GetS(106, 0, 0, 0) ~= 1 and tianshu() >= 8
		and JY.Person[zj()]["实战"] >= 500 then
		local count = 0		
		for i = 1, CC.HZNum do --要改了
			if hasHZ(i) then --and i ~= 21 and i ~= 15 then 武骧金星：修正BUG
				count = count + 1
			end
		end
		if count >= 6 then
			yes = 1
		end
	end	
	if yes == 0 then
		do return end
	end
	local wugong = 122
	local a, b, c, d, e
	Cls()
	say("眼前这一片浮云流水，竟似与我至今所学隐隐相映。这一番思索下来，真是让我获益不浅。")
	Cls()
	say("想当年我初出茅庐之时，曾立下豪言要站上武学之巅。数百年来这武林奇人迭出如大浪淘沙，别人能开宗立派，我又为何不能！")
	Cls()		
	if DrawStrBoxYesNo(-1, -1, "要自立门派吗？", C_WHITE, 30) == false then		
		do return end
	end	
	Cls()
	say("应该给我的门派起个什么样的名字呢？")		
	Cls()
	JY.Wugong[wugong]["名称"] = "";
	while JY.Wugong[wugong]["名称"] == "" do
		JY.Wugong[wugong]["名称"] = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
		if JY.Wugong[wugong]["名称"] == "" then
			DrawStrBoxWaitKey("请给你的门派起一个名字", C_WHITE, 30)
		end
	end
	
	Cls()
	say("我的门派应该侧重哪个方面呢？")				
	local menu = {
		{"攻击", nil, 1},
		{"防御", nil, 1},
		{"敏捷", nil, 1},
		{"医疗", nil, 1},
		{"用毒", nil, 1},
		{"解毒", nil, 0},
		{"暗器", nil, 1},
		{"生命", nil, 1},
		{"内力", nil, 1},
	}
	local r = ShowMenu3(menu,#menu,8,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"请选择门派侧重点","",M_DimGray,C_RED)
	for i = 1, 3 do
		JY.Wugong[wugong]["杀内力"..i] = 10
	end
	for i = 4, 7 do
		JY.Wugong[wugong]["杀内力"..i] = 0
		
	end		
	for i = 8, 9 do
		JY.Wugong[wugong]["杀内力"..i] = 10
	end		
	if (r >= 1 and r <= 3) or (r >= 8 and r <= 9) then
		JY.Wugong[wugong]["杀内力"..r] = 11
	end
	if r >= 4 and r <= 7 then
		JY.Wugong[wugong]["杀内力"..r] = 1000
	end
	
	
	Cls()
	say("我的门派应该修炼哪些技能呢？")			
	Cls()
	local menu = {}
	for i = 1, #CC.HZ do
		menu[i] = {}
		if hasHZ(i) then --i ~= 21 and i ~= 15 then 武骧金星：修正BUG
			menu[i][1] = CC.HZ[i][2]
			menu[i][3] = 1
		else
			menu[i][1] = "无法使用"
			menu[i][3] = 2			
		end
	end
	for i = 1, 5 do
		Cls()
		--local r = ShowMenu3(menu,#menu,7,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"请选择第"..i.."个门派被动技能","",M_DimGray,C_RED)
		local r = ShowMenu3(menu,#menu,7,-2,-2,-2,-2,1,1,24,C_GOLD,C_WHITE,"请选择第"..i.."个门派被动技能","",M_DimGray,C_RED,13)
		JY.Wugong[wugong]["未知"..i] = r
		menu[r][3] = 2	
	end

	
	local menu = {}
	local teamnum = 1
	for i = 2, CC.TeamNum do
		if JY.Base["队伍" .. i] > 0 then
			local pid = JY.Base["队伍" .. i]
			if GRTS[pid] ~= nil then
				menu[teamnum] = {}
				menu[teamnum][1] = GRTS[pid]
				menu[teamnum][3] = 1
				teamnum = teamnum + 1					
			end
		end
	end
	
	local menu = {}
	local teamnum = 1
	for i = 2, CC.TeamNum do
		if JY.Base["队伍" .. i] > 0 then
			local pid = JY.Base["队伍" .. i]
			if GRTS[pid] ~= nil and pid ~= 92 and pid ~= 53 and pid ~= 51 and pid ~= 11 then
				menu[teamnum] = {}
				menu[teamnum][1] = GRTS[pid]
				menu[teamnum][3] = 1
				menu[teamnum][4] = pid
				teamnum = teamnum + 1					
			end
		end
	end
	if teamnum > 1 then
		Cls()
		say("和我一路走来的朋友们也各有所长，我是否应该钻研一下他们的特技呢？")					
		Cls()
		local r = ShowMenu3(menu,#menu,5,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"请选择一个门派主动技能","",M_DimGray,C_RED)
		JY.Wugong[wugong]["未知4"] = menu[r][4]
		menu[r][3] = 2	
		if teamnum > 2 then
			Cls()
			local r = ShowMenu3(menu,#menu,5,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"请选择第二个门派主动技能","",M_DimGray,C_RED)
			JY.Wugong[wugong]["未知5"] = menu[r][4]
			menu[r][3] = 2				
		end
	end
	Cls()
	say("好！我一定要把我的门派发扬光大！")			
	QZXS(JY.Person[zj()]["姓名"].."创立了"..JY.Wugong[wugong]["名称"].."！")
	JoinMP(0, 63, 3)
	SetS(106, 0, 0, 0, 1)
end

OEVENTLUA[31000] = function() --星宿就职任务
    Cls()
	if MPPD(0) == 0 then
	say("小子，我看你资质不错，要不要加入我星宿派？",46,0,"丁春秋")
	end
	if instruct_18(200) == false and JY.Person[0]["品德"] <= 30 and MPPD(0) == 0 and PJPD(1) == false then
		Cls()
		if DrawStrBoxYesNo(-1, -1, "要拜师吗？", C_WHITE, 30) == true then	
			Cls()
			say("师父在上，请受弟子一拜！")
			Cls()
			say("且慢，我有一个任务交给你。你完成之后我再正式收你入门。",46,0,"丁春秋")	
			Cls()
			say("我命你立刻起程去擂鼓山，把七宝指环和小无相功拿到手。",46,0,"丁春秋")			
			Cls()
			say("遵命！")	
			instruct_3(53,0,-2,-2,31001,-2,-2,-2,-2,-2,-2,-2,-2)	
			instruct_3(-2,0,-2,-2,31002,-2,-2,-2,-2,-2,-2,-2,-2)	
			do return end
		end
	end
	
	if MPPD(0) == 1 and MPDJ(0) == 1 and tianshu() >= 5 then
		Cls()
		say("不错不错，你果然没有让我失望。只要你赢了他们几个，我就让你做大师兄！",46,0,"丁春秋")
		if WarMain(276) == false then
			instruct_15(0);   
			instruct_0();  
			do return; end			
		end
		Cls()
		instruct_13()
		Cls()
		say("很好！从今天开始你就是大师兄！",46,0,"丁春秋")	
		Cls()
		say("谢师尊！")		
		SetS(106, 1, 0, 0, 2)
		instruct_3(-2,0,-2,-2,31003,-2,-2,-2,-2,-2,-2,-2,-2)
		JoinMP(0, 1, 2)
		do return end
	end	
end

OEVENTLUA[31001] = function() --擂鼓山抢东西
	Cls()
	say("星宿老仙有令，速速将七宝指环和小无相功交出，饶你不死！")	
	Cls()
	say("那叛徒竟然还有脸派人来抢师门印信？给我滚！",115,0,"苏星河")	
	Cls()
	say("竟敢和我星宿派作对，简直是自取灭亡！")		
	if WarMain(277) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end
	instruct_3(53,0,-2,-2,0,0,0,0,0,0,0,0,0)
	instruct_37(-3)
	instruct_0()
	instruct_13()
	instruct_2(200,1)
	instruct_2(247,1)
	Cls()
	instruct_2(75,1)
end

OEVENTLUA[31002] = function() --星宿就职任务2
	if instruct_18(200) and instruct_18(75) then
		Cls()
		say("禀告师尊，托师尊洪福，东西已经到手。")			
		instruct_2(200,-1)
		Cls()
		instruct_2(75,-1)		
		Cls()
		say("好！做得好！我终于成为逍遥派的掌门了，哈哈哈！！",46,0,"丁春秋")	
		Cls()
		say("我现在就正式收你做弟子。这些入门功夫你先学着，等你融会贯通后我就把你升为大师兄！",46,0,"丁春秋")	
		Cls()
		say("谢师尊！")
		JoinMP(0, 1, 1)
		instruct_3(-2,0,-2,-2,31003,-2,-2,-2,-2,-2,-2,-2,-2)	
		Cls()
		QZXS(JY.Person[zj()]["姓名"].."成为星宿派弟子！")
	else
		Cls()
		say("东西拿到手了吗？",46,0,"丁春秋")		
	end
end

OEVENTLUA[31003] = function() --星宿等级提升
	if MPPD(0) == 1 and MPDJ(0) == 2 and (tianshu() >= 7 or (JX(0) and tianshu() >= 6)) and JY.Person[0]["品德"] <= 20 then
		Cls()
		say("你今天来有何事禀报？",46,0,"丁春秋")	
		Cls()
		say("禀师尊，最近江湖上发生了一件大事....（低语，俯身接近）")				
		Cls()
		say("啊！！你竟然敢暗算我！！",46,0,"丁春秋")	
		Cls()
		say("哈哈哈，师尊不是常说能者居之。您在这椅子上做了这么久，也是时候退位让贤了。")	
		Cls()
		say("我和你拼了！",46,0,"丁春秋")			
		JY.Person[46]["攻击力"] = JY.Person[46]["攻击力"] + 150
		JY.Person[46]["轻功"] = JY.Person[46]["轻功"] + 50
		JY.Person[46]["防御力"] = JY.Person[46]["防御力"] + 150		
		if WarMain(278) == false then
			instruct_15(0);   
			instruct_0();  
			do return; end			
		end		
		JY.Person[46]["攻击力"] = JY.Person[46]["攻击力"] - 150
		JY.Person[46]["轻功"] = JY.Person[46]["轻功"] - 50
		JY.Person[46]["防御力"] = JY.Person[46]["防御力"] - 150					
		if PersonKF(0,20) then
			say("等、等一下，不要杀我！！",46,0,"丁春秋")				
			Cls()
			say("嗯？你不会以为我会挂念什么师徒之情吧？")
			Cls()
			say("不，不。我这等卑劣小人哪里够格当少侠您的师父！",46,0,"丁春秋")
			Cls()
			say("我，我发现少侠应该有学「少林派」的「龙爪手」对吧？",46,0,"丁春秋")
			Cls()
			say("...有话快说，有屁快放，再说废话就给我死！")	
			Cls()
			say("哇阿阿别别别，少侠您请耐心听我说！！",46,0,"丁春秋")	
			Cls()
			say("龙爪手是少林绝技，虽然不知道少侠是怎么得到这门技艺的",46,0,"丁春秋")
			Cls()
			say("但必然无法习得其中精要...对吧？",46,0,"丁春秋")
			Cls()
			say("哼！继续说！")
			Cls()
			say("是是是。小人虽无法帮少侠补全龙爪手的精要",46,0,"丁春秋")
			Cls()
			say("但小的另有一门爪法「三阴蜈蚣爪」",46,0,"丁春秋")
			Cls()
			say("龙形与蜈蚣虽然天壤之别，但仍有可互相借鉴之处",46,0,"丁春秋")
			Cls()
			say("小人愿为少侠尝试揉合这两门武功...",46,0,"丁春秋")
			if DrawStrBoxYesNo(-1, -1, "是否让丁春秋帮你？", C_WHITE, 30) == true then
				Cls()
				say("你知道我看的穿你是不是在搞鬼吧？")
				Cls()
				say("要是让我发现你有留手...你就真的可以去死了")
				Cls()
				say("请少侠放心、放心",46,0,"丁春秋")
				dark()
				light()
				QZXS("领悟九死龙爪手")
				setLW1(20)
				AddPersonAttrib(0, "攻击带毒", 100)
				Cls()
				say("哈哈哈，这门爪法甚合我心意。你做的很好啊！")
				Cls()
				say("少侠谬赞了，这门爪法还未臻完美，若能习得其他爪功，可以更强！",46,0,"丁春秋")
				Cls()
				say("好、非常好，谢谢你阿，「师父」！")
				Cls()
				say("别别，折杀小人...呜......你，你怎能...",46,0,"丁春秋")
				Cls()
				bgtalk("丁春秋双眼大睁，茫然的看著穿肠破肚的一爪，那正是自己为求生而苦心钻研出的「九死龙爪手」")
				Cls()
				say("这就是「徒儿」送给您最后的礼物了，哈哈哈哈！")
			else
				Cls()
				say("我怎么可能相信你呢，死吧！！！")
				Cls()
				say("呜哇！！！！！",46,0,"丁春秋")
			end
		end	
		instruct_3(35,0,-2,-2,0,0,0,0,0,0,0,0,0)
		SetS(106, 1, 0, 0, 0)
		instruct_37(-2)
		JoinMP(0, 1, 3)		
		SetS(60,34,30,3,99); 
		instruct_3(60,99,1,0,10001,0,0,6376,6376,6376,-2,-2,-2); 	
		instruct_0()
		instruct_13()
		instruct_2(200,1)
		Cls()
		instruct_2(75,1)
		Cls()
		instruct_2(66,1)	
		Cls()
		instruct_2(360,1)	
		Cls()
		addHZ(20)			
		Cls()
		say("哈哈哈！我终于成为掌门了！！！")				
		Cls()
		say("丁老怪灯烛之火，居然也敢和日月争光。恭贺掌门师兄成为新一代星宿老仙。",206,0,"星宿门人") 
		Cls()
		say("星宿老仙，法驾中原，神通广大，法力无边。",206,0,"星宿门人")
		Cls()
		say("哈哈哈哈哈哈！！！！")			
		do return end
	end	
	
	if MPPD(0) == 1 and MPDJ(0) == 1 and tianshu() >= 5 then
		Cls()
		say("不错不错，你果然没有让我失望。只要你赢了他们几个，我就让你做大师兄！",46,0,"丁春秋")
		if WarMain(276) == false then
			instruct_15(0);   
			instruct_0();  
			do return; end			
		end
		Cls()
		instruct_13()
		Cls()
		say("很好！从今天开始你就是大师兄！",46,0,"丁春秋")	
		Cls()
		say("谢师尊！")		
		SetS(106, 1, 0, 0, 2)
		JoinMP(0, 1, 2)
		do return end
	end
	if MPPD(0) == 0 then
		Cls()
		say("叛徒！你还有胆来见我！",46,0,"丁春秋")		
		JY.Person[46]["攻击力"] = JY.Person[46]["攻击力"] + 150
		JY.Person[46]["轻功"] = JY.Person[46]["轻功"] + 50
		JY.Person[46]["防御力"] = JY.Person[46]["防御力"] + 150		
		if WarMain(278) == false then
			instruct_15(0);   
			instruct_0();  
			do return; end			
		end		
		JY.Person[46]["攻击力"] = JY.Person[46]["攻击力"] - 150
		JY.Person[46]["轻功"] = JY.Person[46]["轻功"] - 50
		JY.Person[46]["防御力"] = JY.Person[46]["防御力"] - 150	
		instruct_3(35,0,-2,-2,0,0,0,0,0,0,0,0,0)
		SetS(60,34,30,3,99);
		instruct_3(60,99,1,0,10001,0,0,6376,6376,6376,-2,-2,-2); 	
		Cls()
		instruct_13()
		instruct_2(66,1)
		do return end
	end
	Cls()
	say("等你把功夫练得熟练些再来找我。",46,0,"丁春秋")	
end

OEVENTLUA[31010] = function() --丐帮就职1
	local aa = 18 --math.random(18, 21)
	local bb = 22 --math.random(22, 25)
	Cls()
	say("真想再尝一尝"..JY.Thing[aa]["名称"].."和"..JY.Thing[bb]["名称"].."的味道啊....",207,0,"老乞丐")		
	if hasthing(aa) and hasthing(bb) then
		Cls()
		if DrawStrBoxYesNo(-1, -1, "要请客么？", C_WHITE, 30) == false then	
			do return end
		end	
		addthing(aa, -1, 1)
		addthing(bb, -1, 1)
		Cls()
		say("老先生如果不介意，晚辈可以做东。")		
		dark()
		light()
		Cls()
		say("不错不错，你小子很好。老叫化欠你一个人情，有缘再会吧。",207,0,"老乞丐")	
		dark()
		instruct_3(-2,-2,0,0,0,0,0,2,2,2,-2,-2,-2); 	
		SetS(51, 25, 16, 3, 100)
		instruct_3(51,100,1,0,31011,0,0,6266,6266,6266,-2,-2,-2); 				
		light()		
	end
end

OEVENTLUA[31011] = function() --丐帮就职2
	Cls()
	say("小子，我们又见面了。",207,0,"鲁有脚")	
	if PDReq(0, "品德", 60, 100) and MPPD(0) == 0 and PJPD(2) == false then
		Cls()
		say("上次欠你的人情老叫化不还心理不舒服。这样吧，看你功夫人品都不错，要不要加入我们丐帮？",207,0,"鲁有脚")		
		if DrawStrBoxYesNo(-1, -1, "要拜师吗？", C_WHITE, 30) == true then	
			Cls()
			say("师父在上，请受弟子一拜！")
			Cls()
			say("好，好！我现在就教你丐帮的入门功夫。",207,0,"鲁有脚")			
			JoinMP(0, 2, 1)
			instruct_3(-2,-2,-2,-2,31012,-2,-2,-2,-2,-2,-2,-2,-2)	
			Cls()
			QZXS(JY.Person[zj()]["姓名"].."成为丐派弟子！")
			addHZ(60)
		end
	else
		Cls()
		say("我虽有心收你为徒，可惜丐帮似乎不适合你，再去江湖上历练一下吧。",207,0,"鲁有脚")	
	end	
end

OEVENTLUA[31012] = function() --丐帮等级提升
	if MPPD(0) == 2 and MPDJ(0) == 3 then
		Cls()
		say("盼你能善用所学行侠仗义。",207,0,"鲁有脚")				
		Cls()
		say("是！弟子定不负师父教诲！")			
		do return end	
	end
	if MPPD(0) == 2 and MPDJ(0) == 2 and tianshu() >= 7 and hasthing(147)
		and GetS(106, 2, 2, 0) ~= 1 and PDReq(0, "品德", 70, 100) then
		Cls()
		say("看你为我丐帮作了这么多事，为师甚是欣慰。",207,0,"鲁有脚")		
		Cls()
		say("一代新人胜旧人，我也准备退位让贤了。如果你能闯过这一关，传功长老之位就是你的了。",207,0,"鲁有脚")			
		local name = JY.Person[458]["姓名"]
		JY.Person[458]["姓名"] = "鲁有脚"
		if WarMain(280) == false then
			Cls()
			say("看来你还是得勤加练习啊。",207,0,"鲁有脚")
			JY.Person[458]["姓名"] = name
			do return; end			
		end		
		JY.Person[458]["姓名"] = name			
		JoinMP(0, 2, 3)		
		instruct_0()
		instruct_13()
		Cls()
		say("好！从今天起你就是传功长老了。盼你能善用所学行侠仗义。",207,0,"鲁有脚")				
		Cls()
		say("是！弟子定不负师父教诲！")			
		do return end
	end		
	if MPPD(0) == 2 and MPDJ(0) == 1 and tianshu() >= 5 then
		Cls()
		say("看来你功夫大有长进，来试试这打狗阵如何。",207,0,"鲁有脚")	
		if WarMain(279) == false then
			Cls()
			say("看来你还是得勤加练习啊。",207,0,"鲁有脚")
			do return; end			
		end
		Cls()
		instruct_13()
		say("很好，看样子我可以教你更高深的武学了。",207,0,"鲁有脚")		
		Cls()
		say("谢谢师父！")		
		JoinMP(0, 2, 2)
		do return end
	end
	if MPPD(0) == 0 then
		Cls()
		say("唉，你走吧，我不想再见到你。",207,0,"鲁有脚")	
		do return end
	end
	Cls()
	say("等你把功夫练得熟练些再来找我。",207,0,"鲁有脚")	
end

OEVENTLUA[31020] = function() --武当入门
    if PDReq(0, "品德", 90, 100) and  PJPD(4) == false then
		if JY.Person[zj()]["实战"] >= 50 and MPPD(0) == 0 then
		Cls()
		--say("小兄弟来得正好，老朽刚刚对太极有了新的领悟，来切磋一番如何？",5,0,"张三丰")	
		--Cls()
		--say("请前辈指点。")		
		--if WarMain(281) == false then
		--	Cls()
		--	say("看来你还是得勤加练习啊。",5,0,"张三丰")
		--	do return; end			
		--end
		Cls()
		instruct_13()		
		Cls()
		say("小兄弟人品正直，武功高强，比我门下几个弟子强多了。",5,0,"张三丰")	
		Cls()
		say("前辈过誉了，晚辈怎能跟武当七侠比肩。")			
		Cls()
		say("唉，我有心收你为弟子，可惜我看小兄弟你非池中之物，只怕武当山也不能令你大展拳脚。",5,0,"张三丰")	
		Cls()
		say("小子何德何能，能够入前辈法眼。")	
		Cls()
		say("哈哈，你不用激我。这样吧，我传你武功，但不需要你拜师。你用武当派武学之际，是我弟子，除此之外，却是我的朋友。你明白么？",5,0,"张三丰")		
		Cls()
		say("是！多谢前辈指点！")	
		JoinMP(0, 4, 1)
		instruct_3(-2,-2,1,0,31021,0,0,-2,-2,-2,-2,-2,-2)
		Cls()
		QZXS(JY.Person[zj()]["姓名"].."领悟武当派武学精要！")	
			if GetS(113,0,0,0) == 0 and JY.Person[0]["御剑能力"] >= 200 then 
				say("看小友也是用剑之人，这套太极剑法是老道近年所悟，讲究的是以慢打快、后发制人，也一并传予你造福武林！",5) 
				instruct_0();
				if instruct_11(0,188) == true then 
					QZXS("领悟太极剑精要！")
					say("记住，这套剑法用意不用力，切莫强记招式！",5)
					say("再次感谢前辈指点",0)
					instruct_0();
					setLW1(46)
				else
					say("老道就不勉强你了。",5) 
				end	
			end
		elseif MPPD(0) == 4 and MPDJ(0) ~= nil then
		instruct_13()		
		Cls()
		say("哈哈哈，徒儿回来啦～",5,0,"张三丰")	
		Cls()
		say("徒儿参见师尊。师尊今日心情似乎不错？")			
		Cls()
		say("哈哈哈，老道得知徒儿下山之后行事侠义，好名声都传到山上来啦，老道能不开心么",5,0,"张三丰")	
		Cls()
		say("都是得虧师尊平日的教导，徒儿愧不敢当。")	
		Cls()
		say("行了行了，下山倒是学了繁文缛节回来(挥了挥衣袖)。年已近百，老道终也可放心传衣钵了，徒儿意下如何？",5,0,"张三丰")		
		Cls()
		say("是！多谢师尊！")
			if GetS(113,0,0,0) == 0 and JY.Person[0]["御剑能力"] >= 200 then 
				say("如今观徒儿在剑之一道上走的甚远，老道近年研究出一套太极剑法，讲究的是园转如意、意在剑先，就传予徒儿吧！",5) 
				instruct_0();
				if instruct_11(0,188) == true then 
					QZXS("领悟太极剑精要！")
					say("记住，这套剑法用意不用力，切莫强记招式！",5)
					say("是！",0)
					instruct_0();
					setLW1(46)
				else
					say("老道就不勉强你了。",5) 
				end	
			end
			if GetS(113,0,0,0) == 0 and JY.Person[0]["拳掌功夫"] >= 200 then 
				say("如今观徒儿在拳之一道上甚有建树，老道近年研究出一套太极拳法，讲究的是刚柔相济、阴阳互辅，就传予徒儿吧！",5) 
				instruct_0();
				if instruct_11(0,188) == true then 
					QZXS("领悟太极拳精要！")
					say("记住，这套拳法切忌急躁，以静制动方为精髓！",5)
					say("是！",0)
					instruct_0();
					setLW1(16)
				else
					say("老道就不勉强你了。",5) 
				end	
			end
		end
	else
		Cls()
		say("少侠武功已到如此境界，老道也没什麽好教你的了。",5,0,"张三丰")		
	end
end

OEVENTLUA[31021] = function() --武当晋级
	if MPPD(0) == 4 and MPDJ(0) == 3 then
		Cls()
		say("望小兄弟日后行走江湖时多行善助人。",5,0,"张三丰")					
		Cls()
		say("是！小子定不负前辈教诲！")			
		do return end	
	end
	if MPPD(0) == 4 and MPDJ(0) == 1 and tianshu() >= 5 and PDReq(0, "品德", 80, 100) then
		Cls()
		say("小兄弟想切磋一番么？",5,0,"张三丰")		
		Cls()
		say("请前辈指点。")			
		if WarMain(281) == false then
			Cls()
			say("看来你还是得勤加练习啊。",5,0,"张三丰")
			do return; end			
		end		
		JoinMP(0, 4, 2)		
		instruct_0()
		instruct_13()
		Cls()
		say("好，好，小兄弟武功果然一日千里。",5,0,"张三丰")				
		Cls()
		say("这都是前辈指点有方。")		
		Cls()
		QZXS(JY.Person[zj()]["姓名"].."对武当派武学领悟加深！")			
		do return end
	end		
	if MPPD(0) == 4 and MPDJ(0) == 2 and tianshu() >= 7 and PDReq(0, "品德", 80, 100) then
		Cls()
		say("小兄弟想切磋一番么？",5,0,"张三丰")		
		Cls()
		say("请前辈指点。")			
		if WarMain(281) == false then
			Cls()
			say("看来你还是得勤加练习啊。",5,0,"张三丰")
			do return; end			
		end		
		JoinMP(0, 4, 3)		
		instruct_0()
		instruct_13()
		Cls()
		say("好，好，小兄弟武功果然一日千里。",5,0,"张三丰")				
		Cls()
		say("这都是前辈指点有方。")	
		Cls()
		if GetS(113,0,0,0) == 0 and JY.Person[0]["拳掌功夫"] >= 250 and JY.Person[0]["品德"] >= 100 then 
	        say("难得小兄弟人品、武学如此之高，老朽这套太极拳法就传予你造福苍生！",5) 
	        instruct_0();
			if instruct_11(0,188) == true then 
	            QZXS("领悟太极拳精要！")
				say("太极拳与百家武学截然不同，讲究以静制动、后发制人！",5)
				say("感谢前辈指点",0)
	            instruct_0();
	            setLW1(16)
			else
				say("老朽就不勉强你了。",5) 
			end	
	    end		
		say("在送你一样东西，以后行走江湖会对你有帮助！",5) 
		addHZ(149)
		QZXS(JY.Person[zj()]["姓名"].."对武当派武学领悟加深！")		
		do return end
	end
	if MPPD(0) == 0 then
		Cls()
		say("望小兄弟日后多行善助人，也不枉费了我一番苦心。",5,0,"张三丰")	
		do return end
	end
	Cls()
	say("小兄弟还是得勤加练习啊。",5,0,"张三丰")		
end

OEVENTLUA[31030] = function() --少林入门
    if PDReq(0, "品德", 80, 100) and MPPD(0) == 0 and PJPD(5) == false and JY.Person[0]["性别"] == 0 then
		Cls()
		say("晚辈拜见空闻大师。")			
		Cls()
		say("老衲看小施主颇有慧根，更难得的是人品清正。不知小施主可否愿意拜入少林门下？",169,0,"空闻")
		if DrawStrBoxYesNo(-1, -1, "要拜师吗？", C_WHITE, 30) == false then	
			do return end
		end
		Cls()
		say("晚辈愿意！")		
		Cls()
		say("好，好。老衲就收你为俗家弟子。",169,0,"空闻")
		Cls()
		say("师父在上，请受弟子一拜！")
		addHZ(32)
		JoinMP(0, 5, 1)
		instruct_3(-2,-2,1,0,31031,0,0,-2,-2,-2,-2,-2,-2)
		Cls()
		QZXS(JY.Person[zj()]["姓名"].."成为少林俗家弟子！")	
		if GetS(113,0,0,0) == 20 then
			setLW1(0)
		end	
	else
		Cls()
		say("阿弥陀佛。",169,0,"空闻")		
	end
end

OEVENTLUA[31031] = function() --少林入门
	if MPPD(0) == 5 and MPDJ(0) == 3 then
		Cls()
		say("阿弥陀佛，为师盼望你能尽己所学造福武林。",169,0,"空闻")	
		Cls()
		say("是！师父！")		
		do return end	
	end
	if MPPD(0) == 5 and MPDJ(0) == 2 and hasthing(85) then
		Cls()
		say("阿弥陀佛。既然你已经通过铜人巷，证明你已可以出师了。",169,0,"空闻")		
		Cls()
		say("分别在即，为师就再传你一些功夫，对你行走江湖应该有用。",169,0,"空闻")
		Cls()
		say("谢谢师父！")			
		JoinMP(0, 5, 3)		
		Cls()
		QZXS(JY.Person[zj()]["姓名"].."对少林武学领悟加深！")	
		Cls()
		say("好了，你已经可以下山了。为师盼望你能尽己所学造福武林。",169,0,"空闻")	
		Cls()
		say("是！师父！")		
		do return end
	end		
	if MPPD(0) == 5 and MPDJ(0) == 1 and hasthing(168) then
		Cls()
		say("阿弥陀佛。你竟然能够在短短时日之内通过木人巷，真是后生可畏。",169,0,"空闻")		
		Cls()
		say("这多亏了师父悉心教诲。")			
		JoinMP(0, 5, 2)		
		Cls()
		say("我今天就传给你更深的武功，希望你勤加练习。",169,0,"空闻")			
		Cls()
		say("是！")	
		Cls()
		if PersonKF(0, 86) and GetS(113,0,0,0) == 0 then 
	        say("为师见你伏魔杖法小有所成，在指点你一下让你有更好的见解。",169) 
	        instruct_0();
			if instruct_11(0,188) == true then 
	            QZXS("领悟伏魔杖法！")
				say("多谢师傅！",0)
	            instruct_0();
	            setLW1(86)
			else
				say("也罢。",169) 
			end	
	    end
		QZXS(JY.Person[zj()]["姓名"].."对少林武学领悟加深！")		
		do return end
	end
	if MPPD(0) == 0 then
		Cls()
		say("阿弥陀佛。",169,0,"空闻")	
		do return end
	end
	Cls()
	say("阿弥陀佛。",169,0,"空闻")			
end

OEVENTLUA[31040] = function() --血刀入门
    if PDReq(0, "品德", 0, 30) and MPPD(0) == 0 and PJPD(6) == false and JY.Person[0]["性别"] == 0 then
		Cls()
		--say("怎么样？改变主意了想加入我血刀门了？",97,0,"血刀老祖")
		--Cls()
		if DrawStrBoxYesNo(-1, -1, "要加入血刀门吗？", C_WHITE, 30) == true then
			say("这血刀大法实在奥妙无比，请大师收我为徒！")		
			Cls()
			say("嘿嘿，看在你帮过我的份上，收你为徒也行，你就把我血刀门的厉害传扬江湖吧。",97,0,"血刀老祖")	
			Cls()
			say("谢谢师尊！")					
			JoinMP(0, 6, 1)
			instruct_3(-2,-2,1,0,31041,0,0,-2,-2,-2,-2,-2,-2)
			Cls()
			QZXS(JY.Person[zj()]["姓名"].."加入血刀门！")
		else
			OEVENTLUA[42]()			
		end
	else
		Cls()
		OEVENTLUA[42]()	
		--say("没事一边去！",97,0,"血刀老祖")	
	end
end

OEVENTLUA[31041] = function() --血刀晋级
	if MPPD(0) == 6 and MPDJ(0) == 1 and tianshu() >= 6 and PDReq(0, "品德", 0, 20) then
		Cls()
		say("徒儿参见师尊！")		
		Cls()
		say("你有什么事？",97,0,"血刀老祖")	
		Cls()
		say("徒儿听说本门有一镇教之宝名曰血刀，与血刀大法配合使用威力倍增。徒儿斗胆，想借血刀一观。")		
		Cls()
		say("血刀乃是门主传教之物，旁人不得观看。",97,0,"血刀老祖")	
		Cls()
		say("也就是说，如果我成了门主就可以得到血刀？")		
		Cls()
		say("大胆，你这是什么意思！",97,0,"血刀老祖")	
		Cls()
		say("就是这个意思！看招！")	
		JY.Person[97]["攻击力"] = JY.Person[97]["攻击力"] + 150
		JY.Person[97]["轻功"] = JY.Person[97]["轻功"] + 150
		JY.Person[97]["防御力"] = JY.Person[97]["防御力"] + 150	
		JY.Person[97]["生命最大值"] = JY.Person[97]["生命最大值"] + 700	
		JY.Person[97]["生命"] = JY.Person[97]["生命最大值"]			
		if WarMain(284) == false then
			instruct_15(0);   
			instruct_0();  
			do return; end			
		end				
		instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0)
		instruct_37(-2)
		Cls()
		light()
		instruct_47(zj(), 20)
		QZXS(JY.Person[zj()]["姓名"].."增加攻击力20点")
		instruct_2(44, 1)
		instruct_2(356,1)
		JoinMP(0, 6, 2)
		say("哈哈！果然是好刀！")			
		do return end
	end		
	if MPPD(0) == 0 then
		Cls()
		say("叛徒！受死！",97,0,"血刀老祖")	
		JY.Person[97]["攻击力"] = JY.Person[97]["攻击力"] + 150
		JY.Person[97]["轻功"] = JY.Person[97]["轻功"] + 150
		JY.Person[97]["防御力"] = JY.Person[97]["防御力"] + 150	
		JY.Person[97]["生命最大值"] = JY.Person[97]["生命最大值"] + 700	
		JY.Person[97]["生命"] = JY.Person[97]["生命最大值"]			
		if WarMain(284) == false then
			instruct_15(0);   
			instruct_0();  
			do return; end			
		end				
		instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0)
		Cls()
		light()
		instruct_2(44, 1)		
		do return end
	end
	Cls()
	say("血刀大法练得怎么样了？",97,0,"血刀老祖")			
end

OEVENTLUA[31050] = function() --逍遥入门，高资
	Cls()
	say("在下对棋艺小有研究，前辈可否让在下一试？")
	Cls()
	say("好，少侠请。",115,0,"苏星河")		
	dark()
	light()
	Cls()
	say("少侠资质过人，竟然解得了这珍珑棋局。真是可喜可贺。",115,0,"苏星河")	
	Cls()
	say("啊！",115,0,"苏星河")
	Cls()
	say("前辈！你怎么了？")	
	Cls()
	say("有人....暗算....",115,0,"苏星河")	
	Cls()
	say("啊！在那里！")	
	if WarMain(285) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end		
	Cls()
	light()
	say("前辈，你怎么样了？")
	Cls()
	say("我中了....丁春秋....的三笑....逍遥散....不行了....你....快点....进屋子里....",115,0,"苏星河")	
	Cls()
	say("前辈！！")		
	dark()
	instruct_3(-2,-2,1,0,0,0,0,0,0,0,0,0,0)
	light()
	Cls()
	say("屋子里到底有什么....")	
    instruct_3(-2,2,0,0,0,0,0,2566*2,2566*2,2566*2,-2,-2,-2)	
	My_Enter_SubScene(JY.SubScene,24,19,0)
	Cls()
	say("你是？")		
	Cls()
	say("你终于来了....让我把一切都告诉你吧....",116,0,"无崖子")		
	dark()
	light()		
	Cls()
	say("你体内已经有我七十年的内功，现在我把掌门之位传给你。你去找丁春秋，帮我和你师兄讨回公道吧....",116,0,"无崖子")	
	Cls()
	if GetS(113, 0, 0, 0) == 0 then
	say("为师..咳咳..现在便将这套天山..咳咳..六阳掌..咳咳..传予你..能学多少..咳咳..看你自己了！",116) 
	SetS(106, 63, 1, 0, 0)
    SetS(106, 63, 2, 0, 116)
		if WarMain(288) == false then
	        instruct_13()  --场景变亮
		    say("真是可惜",0) 
			else
			say("好厉害的武功",0) 
	        QZXS("领悟天山六阳掌！")
	        instruct_0();
	        SetS(113, 0, 0, 0, 8)
		end
    end 
	say("老前辈？老前辈....师父！！")
	JoinMP(0, 7, 2)
	addHZ(37)
	My_Enter_SubScene(JY.SubScene,18,29,3)
	instruct_3(-2,2,0,0,0,0,0,0,0,0,-2,-2,-2)
	addthing(200, 1)
	addthing(247, 1)
	addthing(75, 1)
	addthing(105, 1)	
end

OEVENTLUA[31051] = function() --逍遥入门，低资
	Cls()
	say("可惜在下资质鲁钝，不然定要向先生请教一番。")
	Cls()
	say("少侠过谦了。其实要破这棋局，除了天分，还需要福分。少侠何妨一试？",115,0,"苏星河")		
	Cls()
	say("那在下就献丑了。")	
	dark()
	light()
	Cls()
	say("自填一气，杀死一块白棋，竟然有这样的下法？",115,0,"苏星河")	
	Cls()
	say("这棋局竟然是这种解法，不执著于生死胜败，反而能得到解脱。",115,0,"苏星河")
	Cls()
	say("少侠福分过人，请入屋一叙。",115,0,"苏星河")	
	Cls()
    instruct_3(-2,2,0,0,0,0,0,2566*2,2566*2,2566*2,-2,-2,-2)
	instruct_3(-2,3,0,0,0,0,0,2965*2,2965*2,2965*2,-2,-2,-2)
	My_Enter_SubScene(JY.SubScene,18,29,3)		
	Cls()
	say("你是？")		
	Cls()
	say("你终于来了....让我把一切都告诉你吧....",116,0,"无崖子")		
	dark()
	light()		
	Cls()
	say("你体内已经有我七十年的内功，现在我把掌门之位传给你。你去找丁春秋，帮我和你师兄讨回公道吧。",116,0,"无崖子")	
	Cls()
	say("老前辈....")
	Cls()
	say("事到如今，你还不肯叫我一声师父吗？",116,0,"无崖子")	
	Cls()
	say("师父....！！")	
	if GetS(113, 0, 0, 0) == 0 then
	say("为师..咳咳..现在便将这套天山..咳咳..六阳掌..咳咳..传予你..能学多少..咳咳..看你自己了",116) 
	SetS(106, 63, 1, 0, 0)
    SetS(106, 63, 2, 0, 116)
		if WarMain(288) == false then
	        instruct_13()  --场景变亮
		    say("真是可惜",0) 
		else
			say("好厉害的武功",0) 
	        QZXS("领悟天山六阳掌！")
	        instruct_0();
	        SetS(113, 0, 0, 0, 8)
		end
    end 
	Cls()
	say("好徒儿...咳咳..要把逍遥派发扬光大.....",116,0,"无崖子")	
	SetS(106, MPPD(0), 0, 0, 1)
	SetS(106, MPPD(0), 1, 0, 0)	
	JoinMP(0, 7, 2)
	addHZ(37)
	instruct_40(3)
	dark()
	instruct_3(-2,2,0,0,0,0,0,0,0,0,-2,-2,-2)
	light()
	Cls()
	say("禀掌门，丁春秋如今正在星宿海为恶一方。",115,0,"苏星河")
	Cls()
	say("师，师兄，我会帮师父和你报仇的。")	
	Cls()
	say("多谢掌门。我还有八个弟子散落各地，我准备出游一趟，把他们找回来重建逍遥派。",115,0,"苏星河")	
	Cls()
	say("那就有劳师兄了。")		
	My_Enter_SubScene(JY.SubScene,18,29,3)	
	instruct_3(-2,3,0,0,0,0,0,0,0,0,-2,-2,-2)
	instruct_3(-2,-2,1,0,0,0,0,0,0,0,0,0,0)	
	addthing(200, 1)
	addthing(247, 1)
	addthing(75, 1)	
	addthing(105, 1)	
end

--[[佛刀剧情未完成--tony
OEVENTLUA[31032] = function() --少林入门
	if hasthing(195) then
		say("阿弥陀佛。",169,0,"空见")
		addevent(70,4,1,-2,1)
		addevent(70,4,1,31032,1)
	end	
end
OEVENTLUA[31033] = function() --少林入门
	--if hasthing(195) then
		say("去找平一指。",256,0,"北丑")
		addevent(70,4,1,698,1)
	--else
		
	--end	
end]]



