-- DIY用参数定义
local nexty;	--对话框长度控制变量
local s;		--队友在队伍中的位置(相对编号)
local r;		--武功序号(相对)
local pid;		--队友的绝对编号
local f;		--武功等级(相对)
local kfid;		--武功ID
local i = nil
local j = nil

--[[
出门无敌DIY-3.1版说明：
1、开放桃花套装和五岳套装的队友领悟，添加五指刀和斗转领悟。

2、解除未开放领悟的外功限制，也就是说，以后出了新的外功领悟，只要用手动输入的方式都可以领悟。
	在开发人员尚未开放领悟前，也可以用本DIY进行领悟，只不过没有啥效果而已。
	
3、添加后台功能，修改“我的代码”函数，每次游戏中，只有第一次运行本DIY时，会询问是否运行DIY啦。

4、友情提示：如果用本DIY开启了队友的领悟的话，请务必在再次进入游戏时运行一下本DIY，哪怕休息恢复一下也可以，
	本DIY没有运行的情况下，队友领悟是无效的。
]]
--DIY正式内容
local ms=JYMsgBox("出门无敌",
		"请问，需要使用DIY的什么功能？                               ",
		{"休息恢复","升级修炼","物品印信","人物相关","全局参数","关闭取消","赤血真龙"}
		,6,320)

	--休息恢复（恢复血、内、体，不解毒，不解除内伤）
	if ms == 1 then
		for i = 1, CC.TeamNum do                 
			local id = JY.Base["队伍" .. i];
			if id >= 0 then
				AddPersonAttrib(id, "生命", 2000);
				AddPersonAttrib(id, "内力", 10000);
				AddPersonAttrib(id, "体力", 100);
			end
		end
		QZXS("休息~休息一下~")		
	end
	
	--升级修炼（等同于懒人DIY）
	if ms == 2 then
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
	
	--物品印信（单个物品、多个物品、获得印信）
	if ms == 3 then
		local ms3 = JYMsgBox("物品印信",
				"请选择需要获得物品还是印信。              ",
				{"单个物品","多个物品","获得印信","关闭取消"}
				,4,320)	
			
			--单个物品
			if ms3 == 1 then
				DrawStrBoxWaitKey("输入物品编号", C_WHITE, CC.DefaultFont, 1)
				local thing = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				for i=thing,thing do
					instruct_2(i,1)
				end
			end
			
			--多个物品
			if ms3 == 2 then
				DrawStrBoxWaitKey("输入物品编号", C_WHITE, CC.DefaultFont, 1)
				local thing = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				DrawStrBoxWaitKey("输入物品数量", C_WHITE, CC.DefaultFont, 1)
				local num = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				for i = thing, thing do
					for j = num, num do
						instruct_2(i,j)
					end
				end
			end
			
			--获得印信
			if ms3 == 3 then
				DrawStrBoxWaitKey("输入印信编号。", C_WHITE, CC.DefaultFont, 1)
	    		local yinxin = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				for i = yinxin, yinxin do
					addHZ(i)
				end
			end
	end
	
	--人物相关（资质、天赋、门派、领悟（内功领悟、外功领悟）、忘却）
	if ms == 4 then
		local ms4 = JYMsgBox("人物相关",
				"请选择需要修改的人物相关数据。",
				{"资质","天赋","门派","领悟","忘却","取消"}
				,6,320)
				
		--人物资质		
		if ms4 == 1 then
			Cls()
			DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "谁需要调整资质?", C_WHITE, CC.DefaultFont);
			nexty = CC.MainSubMenuY + CC.SingleLineHeight;
			s = SelectTeamMenu(CC.MainSubMenuX, nexty);
			if s == 0 then 
			return end
			pid = JY.Base["队伍"..s];
			DrawStrBoxWaitKey("输入资质(1-100)", C_WHITE, CC.DefaultFont, 1)
			local zizhi = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
			for i = zizhi, zizhi do
				JY.Person[pid]["资质"] = i
			end
			QZXS(JY.Person[pid]["姓名"].." 资质已调整为 "..zizhi);
		end
		
		--人物天赋技能
		if ms4 == 2 then
			Cls()
			DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "谁需要调整天赋?", C_WHITE, CC.DefaultFont);
			nexty = CC.MainSubMenuY + CC.SingleLineHeight;
			s = SelectTeamMenu(CC.MainSubMenuX, nexty);
			if s == 0 then 
			return end
			pid = JY.Base["队伍"..s];
			local tianfumingcheng = {}
			for i = 1, 5 do
				if JY.Person[pid]["技能"..i] ~= 0 and JY.Person[pid]["技能"..i] ~= nil then
					tianfumingcheng[i] = CC.TFlist[JY.Person[pid]["技能"..i]][1]
				else
					tianfumingcheng[i] = "空     "
				end
			end
			local ms42 = JYMsgBox(JY.Person[pid]["姓名"].." 天赋调整",
				JY.Person[pid]["姓名"].." 目前的天赋有："..
				"*天赋1："..tianfumingcheng[1].."   天赋2："..tianfumingcheng[2].."   天赋3："..tianfumingcheng[3]..
				"*天赋4："..tianfumingcheng[4].."   天赋5："..tianfumingcheng[5]..
				"*请选择需要修改的天赋 ",
				{"天赋1","天赋2","天赋3","天赋4","天赋5"," 取消 "}
				,6,320)
				
			if ms42 == 6 then
				return
			else
				DrawStrBoxWaitKey("输入天赋编号（参考印信）", C_WHITE, CC.DefaultFont, 1)
				local tianfu = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				for i = tianfu, tianfu do
					JY.Person[pid]["技能"..ms42] = i
				end
				QZXS(JY.Person[pid]["姓名"].." 天赋"..ms42.."变为 "..CC.TFlist[JY.Person[pid]["技能"..ms42]][1]);
			end
		end
		
		--人物门派调整
		if ms4 == 3 then
			Cls()
			DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "谁需要调整门派?", C_WHITE, CC.DefaultFont);
			nexty = CC.MainSubMenuY + CC.SingleLineHeight;
			s = SelectTeamMenu(CC.MainSubMenuX, nexty);
			if s == 0 then 
			return end
			pid = JY.Base["队伍"..s];
			local menpaixianshi = "江湖人士"
			if MPPD(pid)~= 0 then
				local mptype, mpdj = MPDISPLAY(pid)
				if mptype ~= nil then
					menpaixianshi = mptype .. mpdj
				end
			end
			local ms43 = JYMsgBox(JY.Person[pid]["姓名"].." 门派调整",
				JY.Person[pid]["姓名"].."现在的门派为："..menpaixianshi..
				"*可供选择的门派有："..
				"*01星宿 02丐帮 03古墓 04武当 05少林 06密宗 07逍遥 08白驼 09唐门"..
				"*10桃花 11刀宗 12日月 13明教 14五岳 15大理 16全真 17峨眉 18无派 "..
				"*请选择想要加入的门派（已脱离的门派无法再次加入） ",
				{"01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","取消"}
				,19,320)
				
			if ms43 == 19 then
				return
			elseif ms43 == 18 then	--恢复江湖人士
				JoinMP(pid, 0, 0)
			elseif ms43 == 6 or ms43 == 9 or ms43 == 10 or ms43 == 15 then --等级为2的几个门派
				JoinMP(pid, ms43, 2)
			elseif ms43 == 4 or ms43 == 12 or ms43 == 13 then	--等级为4的几个门派
				JoinMP(pid, ms43, 4)
			elseif ms43 == 11 then	--刀宗要附带洗武功的功能
				JoinMP(pid, ms43, 3)
				JY.Person[pid]["武功1"] = 131
				JY.Person[pid]["武功等级1"] = 9999
			else		--其他等级为3
				JoinMP(pid, ms43, 3)
			end
			if MPPD(pid)~= 0 then
				local mptype, mpdj = MPDISPLAY(pid)
				if mptype ~= nil then
					menpaixianshi = mptype .. mpdj
				end
			else
				menpaixianshi = "江湖人士"
			end
				QZXS(JY.Person[pid]["姓名"].."成为："..menpaixianshi)
		end
		
		--人物领悟调整
		if ms4 == 4 then
			Cls()
			DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "谁需要调整领悟?", C_WHITE, CC.DefaultFont);
			nexty = CC.MainSubMenuY + CC.SingleLineHeight;
			s = SelectTeamMenu(CC.MainSubMenuX, nexty);
			if s == 0 then 
			return end
			pid = JY.Base["队伍"..s];
			
			local ms44 = JYMsgBox(JY.Person[pid]["姓名"].." 领悟调整",
				"要调整哪种领悟                        ",
				{"内功领悟","外功领悟","轻功领悟","关闭取消"}
				,4,320)
			
			--内功领悟调整
			if ms44 == 1 then
				local nglw = 0
				local ms441a = JYMsgBox(JY.Person[pid]["姓名"].."内功领悟",
					"请选择想要领悟的内功："..
					"*01化功 02吸星 03紫霞 04混元 05六如 06狮吼 07圣火 08神照 09蛤蟆"..
					"*10罗汉 11乾坤 12无相 13纯阳 14先天 15八荒 16太玄 17龙象 18逆运"..
					"*下一页继续",
					{"01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","->"}
					,19,320)
				if ms441a ~= 19 then	--本页内功按顺序的
					nglw = ms441a + 86
				else
					local ms441b = JYMsgBox(JY.Person[pid]["姓名"].."内功领悟",
						"请选择想要领悟的内功："..
						"*19葵花 20九阳 21九阴 22易筋 23玉女 24寒冰 25金关 26金刚 27天南"..
						"*28临济 29碧海 30擒龙 31太虚 32北冥 33独孤 34左右 35逍遥 36放空",
						{"19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","X"}
						,19,320)
					if ms441b >= 1 and ms441b <= 4 then	--葵花到易筋
						nglw = ms441b + 104
					elseif ms441b == 5 then	--玉女
							nglw = 121
					elseif ms441b == 6 then	--寒冰
						nglw = 124
					elseif ms441b == 7 then --金关
						nglw = 150
					elseif ms441b == 8 or ms441b == 9 or ms441b == 10 then	 --金刚、天南、临济
						nglw = ms441b + 143
					elseif ms441b == 11 then	--碧海
						nglw = 6
					elseif ms441b == 12 then	--擒龙
						nglw = 178
					elseif ms441b == 13 then 	--太虚
						nglw = 180
					elseif ms441b == 14 then	--北冥
						nglw = 85
					elseif ms441b == 15 then	--独孤
						nglw = 592	
					elseif ms441b == 16 then	--左右
						nglw = 999
					elseif ms441b == 17 then	--逍遥
						nglw = 998
					elseif ms441b == 18 then	--放空
						nglw = 997
					elseif ms441b == 19 then	--取消
						return
					end
				end
				
				--把没开放领悟的摘出来（91六如，97乾坤，111金关，152天南，153临济）
				if nglw == 91 then
					QZXS(JY.Wugong[nglw]["名称"].."尚未开放领悟")
				
				--独孤领悟
				elseif nglw == 592 then
					if pid == 0 then
						setLW(nglw);
					elseif pid > 0 then
						JY.Person[pid]["无用13"] = nglw
					end
					QZXS(JY.Person[pid]["姓名"].."领悟独孤真意")
					
				--逍遥绝学领悟
				elseif nglw == 998 then
					if pid == 0 then
						setLW(nglw);
					elseif pid > 0 then
						JY.Person[pid]["无用13"] = nglw
					end
					QZXS(JY.Person[pid]["姓名"].."领悟逍遥绝学")
					
				--左右互搏领悟
				elseif nglw == 999 then
					if pid == 0 then
						setLW(nglw);
					elseif pid > 0 then
						JY.Person[pid]["无用13"] = nglw
					end
					QZXS(JY.Person[pid]["姓名"].."领悟左右互搏")
					
				--放空领悟
				elseif nglw == 997 then
					if pid == 0 then
						setLW(nglw);
					elseif pid > 0 then
						JY.Person[pid]["无用13"] = nglw
					end
					QZXS(JY.Person[pid]["姓名"].."放空领悟")
				
				--正常的领悟
				else
					if pid == 0 then
						setLW(nglw);
					elseif pid > 0 then
						JY.Person[pid]["无用13"] = nglw
					end
					QZXS(JY.Person[pid]["姓名"].."领悟"..JY.Wugong[nglw]["名称"])				
				end
			end
			
			--外功领悟调整
			if ms44 == 2 then
				local wailw = 0
				local ms442 = JYMsgBox(JY.Person[pid]["姓名"].."外功领悟",
					"请选择想要领悟的外功："..
					"*01黯然掌 02降龙掌 03落英掌 04玉箫剑 05血刀 "..
					"*06恒山剑 07泰山剑 08衡山剑 09嵩山剑 10华山剑"..
					"*11五指刀 12斗转功 13手动输入",
					{"01","02","03","04","05","06","07","08","09","10","11","12","13","X"}
					,14,320)
				if ms442 == 1 then	--领悟黯然
					wailw = 997
				elseif ms442 == 2 then --领悟降龙
					wailw = 26
				elseif ms442 == 3 then	--领悟落英
					wailw = 12
				elseif ms442 == 4 then	--领悟玉箫
					wailw = 38
				elseif ms442 == 5 then	--领悟血刀
					wailw = 63
				elseif ms442 >= 6 and ms442 <= 10 then	--领悟五岳
					wailw = ms442 + 24
				elseif ms442 == 11 then --领悟五指刀
					wailw = 155
				elseif ms442 == 12 then --领悟斗转星移
					wailw = 43
				elseif ms442 == 13 then	--输入领悟
					DrawStrBoxWaitKey("输入外功编号", C_WHITE, CC.DefaultFont, 1)
					local waigong = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
					for i = waigong, waigong do
						wailw = i
					end
				end
				
				if pid == 0 then
					setLW1(wailw)
				elseif pid > 0 then
					JY.Person[pid]["无用15"] = wailw
				end
				if wailw ~= 997 then
				QZXS(JY.Person[pid]["姓名"].."领悟"..JY.Wugong[wailw]["名称"])
				else
				QZXS(JY.Person[pid]["姓名"].."领悟萨埵十二诀")
				end
			end
			if ms44 == 3 then
				local qinglw = 0
				DrawStrBoxWaitKey("输入轻功编号", C_WHITE, CC.DefaultFont, 1)
					local qinggong = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
					for i = qinggong, qinggong do
						qinglw = i
					end
				if pid == 0 then
					setLW2(qinglw)
				elseif pid > 0 then
					JY.Person[pid]["无用15"] = qinglw
				end
				QZXS(JY.Person[pid]["姓名"].."领悟"..JY.Wugong[qinglw]["名称"])
			end
		end
		--人物武功忘却
		if ms4 == 5 then
			Cls()
			DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "谁要遗忘技能?", C_WHITE, CC.DefaultFont);
			nexty = CC.MainSubMenuY + CC.SingleLineHeight;
			s = SelectTeamMenu(CC.MainSubMenuX, nexty);
			if s==0 then return end
			pid = JY.Base["队伍"..s];
			if JY.Person[pid]["武功1"]==0 then
				QZXS("未学习武功，无法忘却")
				return
			end
			local kfmenu={{nil,nil,0},{nil,nil,0},{nil,nil,0},{nil,nil,0},{nil,nil,0},
						{nil,nil,0},{nil,nil,0},{nil,nil,0},{nil,nil,0},{nil,nil,0},{nil,nil,0},{nil,nil,0}};
			for i=1,12 do
				kfmenu[i][1]=JY.Wugong[JY.Person[pid]["武功"..i]]["名称"]
				if JY.Person[pid]["武功"..i]~=0 then
					kfmenu[i][3]=1
				end
			end
			Cls();
			local r=ShowMenu(kfmenu,12,0,12,12,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE)
			if r==0 then return end
			if JY.Person[pid]["武功"..r]==91 or (JY.Person[pid]["武功"..r]>108 and 113>JY.Person[pid]["武功"..r]) then
				QZXS(JY.Wugong[JY.Person[pid]["武功"..r]]["名称"].."不能被遗忘！")
				return
			elseif JY.Person[pid]["武功2"]==91 and JY.Person[pid]["武功3"]==0 then
				QZXS("学了风林或者六如后至少要留一个技能，不能遗忘！")
				return
			end
			if DrawStrBoxYesNo(-1,-1,"确定要遗忘"..JY.Wugong[JY.Person[pid]["武功"..r]]["名称"].."吗？",C_WHITE,CC.DefaultFont)==false then
				Cls();
			else
				QZXS(JY.Wugong[JY.Person[pid]["武功"..r]]["名称"].."已经被遗忘")
				if r > 0 then
					local i=nil
					for i=r,12 do
						if JY.Person[pid]["武功"..i]==0 then 
							break 
						end
						if JY.Person[pid]["武功2"]==91 and i==1 then
							JY.Person[pid]["武功等级1"]=JY.Person[pid]["武功等级3"]
							JY.Person[pid]["武功1"]=JY.Person[pid]["武功3"]
						elseif JY.Person[pid]["武功2"]==91 and i==2 then
						elseif i==12 then
							JY.Person[pid]["武功等级12"]=0
							JY.Person[pid]["武功12"]=0
						else
							JY.Person[pid]["武功等级"..i]=JY.Person[pid]["武功等级"..i+1]
							JY.Person[pid]["武功"..i]=JY.Person[pid]["武功"..i+1]
						end
					end
				end
			end
		end
	end
	
	--全局参数（道德值、技能点、难度值、周目数、神队友）
	if ms == 5 then
		local ms5 = JYMsgBox("全局参数",
				"请选择需要修改的人物相关数据。               ",
				{"道德值","技能点","难度值","周目数","神队友","取消"}
				,6,320)
				
		--道德值
		if ms5 == 1 then
			Cls()
			DrawStrBoxWaitKey("输入需要的道德值。", C_WHITE, CC.DefaultFont, 1)
			local daode = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
			for i=daode, daode do
				JY.Person[0]["品德"] = i
			end
			QZXS("道德值变为"..JY.Person[0]["品德"])
		end
		
		--技能点
		if ms5 == 2 then
			DrawStrBoxWaitKey("输入增加的技能点", C_WHITE, CC.DefaultFont, 1)
	    	local jinengdian = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
			for i=jinengdian,jinengdian do
				CC.SKpoint = CC.SKpoint + i
			end
			QZXS("技能点修改，请存档后重开游戏");
		end
		
		--难度值
		if ms5 == 3 then
			DrawStrBoxWaitKey("请输入难度（1-6）", C_WHITE, CC.DefaultFont, 1)
			local nandu = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
			for i=nandu, nandu do
				JY.Thing[202] [WZ7] = i
			end
			QZXS("修改难度值貌似没有啥效果");
		end
		
		--周目数
		if ms5 == 4 then
			DrawStrBoxWaitKey("请输入周目数（1-99）", C_WHITE, CC.DefaultFont, 1)
			local zhoumu = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
			for i=zhoumu, zhoumu do
				JY.Thing[203] [WZ6] = i
			end	
			QZXS("周目数修改，请存档后重开游戏");
		end	

		--神队友
		if ms5 == 5 then
			local ms55 = JYMsgBox("添加队友", 
				"请选择想要添加入队的人员。                                  ",
				{"无酒不欢","  黄裳  "," 逍遥子 ","独孤求败","手动输入","取消添加"}
				,6,320)
			
			--定义新队友位置
			local duiyounum = 1
			for i = 1, CC.TeamNum do                 
				local id = JY.Base["队伍" .. i];
				if id >= 0 then
					duiyounum = duiyounum + 1
				end
			end
			if duiyounum > CC.TeamNum then
				duiyounum = CC.TeamNum
			end
			
			--添加新队友
			if ms55 == 1 then --无酒不欢
				JY.Base ["队伍"..duiyounum] = 455
			end
			if ms55 == 2 then --黄裳
				JY.Base ["队伍"..duiyounum] = 599
			end
			if ms55 == 3 then --逍遥子
				JY.Base ["队伍"..duiyounum] = 618
			end
			if ms55 == 4 then --独孤求败
				JY.Base ["队伍"..duiyounum] = 592
			end	
			if ms55 == 5 then --手动输入
				Cls()
				DrawStrBoxWaitKey("输入添加的队友编号。", C_WHITE, CC.DefaultFont, 1)
				local duiyou = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				for i = duiyou, duiyou do
					JY.Base ["队伍"..duiyounum] = i
				end
			end
		end		
	end
	
	--隐藏功能：赤血真龙诀
	if ms == 7 then
		JY.Wugong[91]["名称"] = "赤血真龙诀"
		JY.ZLXF = 1
		for i = 1, CC.TeamNum do                 
			local id = JY.Base["队伍" .. i];
			if id >= 0 then
				local wg = 1
				local zl = 0
				for i = 1, 12 do
					if JY.Person[id]["武功"..i] ~= nil and JY.Person[id]["武功"..i] ~= 0 then
						wg = i + 1
					end
					if JY.Person[id]["武功"..i] == 91 then
						zl = 1
					end
				end
				if zl == 0 then
					if wg < 13 then
						JY.Person[id]["武功"..wg] = 91
						JY.Person[id]["武功等级"..wg] = 30000
					else
						JY.Person[id]["武功12"] = 91
						JY.Person[id]["武功等级12"] = 30000
					end
					AddPersonAttrib(id, "生命最大值", 2000)
					AddPersonAttrib(id, "内力最大值", 10000)
					QZXS(JY.Person[id]["姓名"].."领悟赤血真龙诀")
				end
			end
		end
	end

	
--后台功能

--添加队友内功领悟功能
local wglw_old = wglw
function wglw(pid, f) --领悟
	local lwold = wglw_old(pid, f)
	if lwold then

	else
		if JY.Person[pid]["无用13"] == f and PersonKF(pid,f) then
			lwold = true
  		end
	end
	return lwold
end

--添加队友外功领悟功能
local wglw1_old = wglw1
function wglw1(pid, f) --领悟
	local lw1old = wglw1_old(pid, f)
	if lw1old then

	else
		if JY.Person[pid]["无用15"] == f and PersonKF(pid,f) then
			lw1old = true
  		end
	end
	return lw1old
end

--修改我的代码程序，取消掉询问是否开启
function Menu_MYDIY()
  Cls()
  dofile(CONFIG.ScriptPath .. "DIY.lua")
  return 1
end