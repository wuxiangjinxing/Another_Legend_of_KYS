
--传送地址列表
function My_ChuangSong_List()
	local menu = {};
	for i=0, JY.SceneNum-1 do
		menu[i+1] = {i..JY.Scene[i]["名称"], nil, 1};
	end
	
	local r = ShowMenu(menu,JY.SceneNum,15,250,20,0,0,1,1,CC.DefaultFont,C_ORANGE, C_WHITE);
	
	if r == 0 then
		return 0;
	end
	
	if r > 0 then	
		
		local sid = r-1;
		
		if JY.Scene[sid]["进入条件"] == 0 and sid ~= 84 and sid ~= 83  and sid ~= 82 and  sid ~= 13 then
				My_Enter_SubScene(sid,-1,-1,-1);
			else
				say("您目前现在不能进入此场景", 232, 1, "百事通");
				return 1;
			end

	end
	
	return 1;
end

--加强版传送地址菜单
function My_ChuangSong_Ex()     
	local title = "百事通传送功能";
	local str = "这是一个很方便的马车传送系统*请选择你想要的传送方式";
	local btn = {"列表选择","输入代号", "放弃"};
	local num = #btn;
	local r = JYMsgBox(title,str,btn,num,232);
	if r == 1 then
		My_ChuangSong_List();
	elseif r == 2 then
		local result = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6);
		if result == "" then
			return 1;
		end
		local n = tonumber(result);
		if n ~= nil then
			 
			if JY.Scene[n]["进入条件"] == 0 and n ~= 84 and n ~= 83 and n ~= 82 and n ~= 13 then
				My_Enter_SubScene(n,-1,-1,-1);
			else
				say("您目前现在不能进入此场景", 232, 1, "百事通");
				return 1;
			end
		
			
		end
	end
end

--挑战四神
function Fight()
	say("四神可不是这么好惹的，你可得小心了", 232, 1, "百事通");
	SetS(86, 1, 9, 5, 1);
	
	for i=1, 15 do --武骧金星：挑战四神
		if GetS(86, 2, i, 5) == 0 then
			SetS(86, 2, i, 5, 2);
		end
	end
	local x1 = CC.ScreenW/2 - 200 ;
	local y1 = 0;
	DrawStrBox(x1, y1, "请选择挑战对象",C_WHITE, CC.DefaultFont);
	local menu = {
		{"张三丰和乔峰",nil,GetS(86, 2, 1, 5)-1},
		{"张三丰和东方不败",nil,GetS(86, 2, 2, 5)-1},
		{"张三丰和扫地神僧",nil,GetS(86, 2, 3, 5)-1},
		{"乔峰和东方不败",nil,GetS(86, 2, 4, 5)-1},
		{"乔峰和扫地神僧",nil,GetS(86, 2, 5, 5)-1},
		{"东方不败和扫地神僧",nil,GetS(86, 2, 6, 5)-1},
		{"五绝齐聚",nil,GetS(86, 2, 7, 5)-1},
		{"江湖四兄弟",nil,GetS(86, 2, 8, 5)-1},
		{"天机盘龙阵",nil,GetS(86, 2, 9, 5)-1},
		{"夫妻阵",nil,GetS(86, 2, 10, 5)-1},
		{"宗师阵",nil,GetS(86, 2, 11, 5)-1}, --宗师阵
		{"四神封绝阵",nil,GetS(86, 2, 12, 5)-1}, --武骧金星：挑战四神
		{"逍遥三老",nil,GetS(86, 2, 13, 5)-1}, --武骧金星：逍遥三老
		{"天龙传说",nil,GetS(86, 2, 14, 5)-1}, --武骧金星：天龙传说
	    {"山寨作者",nil,GetS(86, 2, 15, 5)-1}, --武骧金星：挑战四神
	};
	
	local numItem = table.getn(menu);
	local size = CC.DefaultFont;
	local r = ShowMenu(menu,numItem,0,x1,y1+40,0,0,1,1,size,C_ORANGE,C_WHITE);
	if r > 0 then
		Cls();
		SetS(86, 2, r, 5, 3);
		if WarMain(226) then
			SetS(86, 2, r, 5, 1);
			say("少侠好身手啊。", 232, 1, "百事通");
			QZXS("全体队友实战增加50点");
			for i=1, CC.TeamNum do
				if JY.Base["队伍"..i] >= 0 then
					AddPersonAttrib(JY.Base["队伍"..i], "实战", 50)
				end
			end
			if r == 1 then --张三丰和乔峰
				addHZ(46) 
				CC.SKpoint = CC.SKpoint + 700
				QZXS("技能点加700点")
			end	
			if r == 2 then --张三丰和东方不败
				addHZ(64) 
				CC.SKpoint = CC.SKpoint + 700
				QZXS("技能点加700点")
			end 	
			if r == 3 then 
				addHZ(67) --张三丰和扫地神僧
				CC.SKpoint = CC.SKpoint + 700
				QZXS("技能点加700点")
			end 		
			if r == 4 then --乔峰和东方不败
				addHZ(83)
				CC.SKpoint = CC.SKpoint + 700
				QZXS("技能点加700点")
			end 	 
			if r == 5 then 
				addHZ(123) --乔峰和扫地神僧
				CC.SKpoint = CC.SKpoint + 700
				QZXS("技能点加700点")
			end 	
			if r == 6 then --东方不败和扫地神僧
				addHZ(126)
				CC.SKpoint = CC.SKpoint + 700
				QZXS("技能点加700点")
			end 	
			if r == 7 then --五绝阵
				addHZ(135) 
				CC.SKpoint = CC.SKpoint + 900
				QZXS("技能点加900点")
			end 	
			if r == 8 then --江湖四兄弟
				addHZ(136) 
				CC.SKpoint = CC.SKpoint + 1500
				QZXS("技能点加1500点")
			end 	
			if r == 9 then --天机盘龙阵
				for i = 0, JY.ThingNum - 1 do
					if JY.Thing[i]["类型"] == 2 then
						instruct_2(i, 1)
					end
				end	
				CC.SKpoint = CC.SKpoint + 2000
				QZXS("技能点加2000点")
			end 	
			if r == 10 then --夫妻阵
				if GetS(111, 0, 0, 0) == 0 then  
	                say("不错不错，拿去好好参详！",455)		
	                   instruct_0();
	                if instruct_11(0,188) == true then 
	                   QZXS("领悟玄武真功！")
		               instruct_0();
	                   say("多谢前辈",0)
	                   SetS(111, 0, 0, 0,181)
		               addthing(341)
		               instruct_35(0,3,181,0)
                       instruct_35(0,3,181,0)
	                else
		               say("有志气。",455) 
	                end	
                end
			end
			if r == 11 then  --宗师阵
				for i=1, CC.TeamNum do
				if JY.Base["队伍"..i] >= 0 then
					AddPersonAttrib(JY.Base["队伍"..i], "武学常识", 100)
				end
				addHZ(150)
			                     end	
				QZXS("全体队友武常增加100点");
				if GetS(111,0,0,0) == 0 then 
                if yesno("要领悟纯阳无极？") then
                   SetS(111,0,0,0,99)
				   addthing(76)
                end
                end
				if GetS(111,0,0,0) == 0 then 
                if yesno("要领悟擒龙控鹤？") then
                   SetS(111,0,0,0,178)
				   addthing(338)
                end
                end
				if GetS(111,0,0,0) == 0 then 
                if yesno("要领悟左右互搏？") then
                   SetS(111,0,0,0,999)
				   addthing(235)
                end
                end
				if GetS(111,0,0,0) == 0 then 
                if yesno("要领悟先天重生？") then
                   SetS(111,0,0,0,100)
				   addthing(77)
                end
                end
				if GetS(111,0,0,0) == 0 then 
                if yesno("要领悟圣火神行？") then
                   SetS(111,0,0,0,93)
				   addthing(70)
                end
                end
				if GetS(111,0,0,0) == 0 then 
                if yesno("要领悟九阴奥义？") then
                   SetS(111,0,0,0,107)
				   addthing(84)
                end
                end
				if GetS(111,0,0,0) == 0 then 
                if yesno("要领悟玉女心经？") then
                   SetS(111,0,0,0,121)
				   instruct_35(0,2,121,0)
				   addthing(254)
                end
                end
				CC.SKpoint = CC.SKpoint + 1600
				QZXS("技能点加1600点")
			end
			if r == 12 then --四神封绝阵
				setJX(5,-2)
				setJX(50,-2)
				setJX(114,-2)
				setJX(27,-2)
				JY.Person[50]["攻击力"] = JY.Person[50]["攻击力"] - 300
				JY.Person[50]["轻功"] = JY.Person[50]["轻功"] - 300
				JY.Person[50]["防御力"] = JY.Person[50]["防御力"] - 300
				JY.Person[50]["生命最大值"] = JY.Person[50]["生命最大值"] - 5000
				JY.Person[50]["生命"] = JY.Person[50]["生命"] - 5000
				JY.Person[50]["内力最大值"] = 10000
				JY.Person[50]["内力"] = 10000
				JY.Person[114]["攻击力"] = JY.Person[114]["攻击力"] - 300
				JY.Person[114]["轻功"] = JY.Person[114]["轻功"] - 300
				JY.Person[114]["防御力"] = JY.Person[114]["防御力"] - 300
				JY.Person[114]["生命最大值"] = JY.Person[114]["生命最大值"] - 5000
				JY.Person[114]["生命"] = JY.Person[114]["生命"] - 5000
				JY.Person[114]["内力最大值"] = 10000
				JY.Person[114]["内力"] = 10000
				JY.Person[27]["攻击力"] = JY.Person[27]["攻击力"] - 300
				JY.Person[27]["轻功"] = JY.Person[27]["轻功"] - 300
				JY.Person[27]["防御力"] = JY.Person[27]["防御力"] - 300
				JY.Person[27]["生命最大值"] = JY.Person[27]["生命最大值"] - 5000
				JY.Person[27]["生命"] = JY.Person[27]["生命"] - 5000
				JY.Person[27]["内力最大值"] = 10000
				JY.Person[27]["内力"] = 10000
				JY.Person[5]["攻击力"] = JY.Person[5]["攻击力"] - 300
				JY.Person[5]["轻功"] = JY.Person[5]["轻功"] - 300
				JY.Person[5]["防御力"] = JY.Person[5]["防御力"] - 300
				JY.Person[5]["生命最大值"] = JY.Person[5]["生命最大值"] - 5000
				JY.Person[5]["生命"] = JY.Person[5]["生命"] - 5000
				JY.Person[5]["内力最大值"] = 10000
				JY.Person[5]["内力"] = 10000
				if PersonKF(0,196) and PersonKF(0,105) and GetS(114,0,0,0) == 0 then
					say("唷，表现不错嘛！",27)
					say("速度也就比我慢了半筹而已！",27)
					say("今天你的教主大人我就发发慈悲吧，拿去！",27)
					if DrawStrBoxYesNo(-1, -1, "要收下吗？", C_WHITE, 30) == true then
						setLW2(196)
						QZXS("领悟暗香疏影身法！")
						say("谢谢东方教主！",0)
					else
						say("抱歉，我的武学志向并不在此！",0)
						say("哎呀呀，你让我更印象深刻了呢～（邪魅一笑）",27)
					end					
				end
				for i=1, CC.TeamNum do
					if JY.Base["队伍"..i] >= 0 then
						AddPersonAttrib(JY.Base["队伍"..i], "武学常识", 40)
					end
                end
				QZXS("全体队友武常增加40点");
				addHZ(140)
				addHZ(141)
				CC.SKpoint = CC.SKpoint + 1200
				QZXS("技能点加1200点")
            end
			if r == 13 then --逍遥三老
			    CC.SKpoint = CC.SKpoint + 800
				QZXS("技能点加800点"); 
			end
			if r == 14 then  --天龙传说
				for i=1, CC.TeamNum do
				if JY.Base["队伍"..i] >= 0 then
					AddPersonAttrib(JY.Base["队伍"..i], "武学常识", 100)
				end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("要领悟易筋经？") then
                   SetS(111,0,0,0,108)
				   addthing(85)
                end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("要领悟洗髓经？") then
                   SetS(111,0,0,0,183)
				   addthing(344)
                end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("要领悟罗汉伏魔功？") then
                   SetS(111,0,0,0,96)
				   addthing(72)
                end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("要领悟金刚不坏神功？") then
                   SetS(111,0,0,0,151)
				   addthing(288)
                end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("要领悟天南易阳诀？") then
                   SetS(111,0,0,0,152)
				   addthing(299)
                end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("要领悟小无相功？") then
                   SetS(111,0,0,0,98)
				   addthing(75)
                end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("要领悟八荒六合功？") then
                   SetS(111,0,0,0,101)
				   addthing(79)
                end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("要领悟北冥神功？") then
                   SetS(111,0,0,0,85)
				   addthing(64)
                end
			    end
				for i=1, CC.TeamNum do
				if JY.Base["队伍"..i] >= 0 then
					AddPersonAttrib(JY.Base["队伍"..i], "武学常识", 100)
				end
			    end	
				QZXS("全体队友武常增加100点");
				CC.SKpoint = CC.SKpoint + 1800
				QZXS("技能点加1800点")
			end 	
			if r == 15 then  --作者阵
				say("恭喜你突破作者阵。", 576, 0, "字母君")
				say("阵中诸位，都曾为山寨江湖添砖加瓦，开枝散叶。", 576, 0, "字母君")
				say("你掌中的神兵，手底的绝招，都饱含他们的心血。", 576, 0, "字母君")
				say("山寨江湖是开源游戏，我们欢迎任何有意参与制作的同好。", 576, 0, "字母君")
				say("你，想不想成为作者阵的下一位成员呢？", 576, 0, "字母君")
				say("哈哈，感谢你听我唠叨这几句，我送你些好东西吧。", 576, 0, "字母君")
			    for i=1,#CC.TFlist do
                    addHZ(i)              
                end				
				CC.SKpoint = CC.SKpoint + 5000
				QZXS("技能点加5000点")
			end
			
		else
			if r == 12 then
				if JY.Wugong[91]["名称"] == "赤血真龙诀" then
					JY.Wugong[91]["名称"] = "六如隼龙诀"
				end
				setJX(5,-2)
				setJX(50,-2)
				setJX(114,-2)
				setJX(27,-2)
				JY.Person[50]["攻击力"] = JY.Person[50]["攻击力"] - 300
				JY.Person[50]["轻功"] = JY.Person[50]["轻功"] - 300
				JY.Person[50]["防御力"] = JY.Person[50]["防御力"] - 300
				JY.Person[50]["生命最大值"] = JY.Person[50]["生命最大值"] - 5000
				JY.Person[50]["生命"] = JY.Person[50]["生命"] - 5000
				JY.Person[50]["内力最大值"] = 10000
				JY.Person[50]["内力"] = 10000
				JY.Person[114]["攻击力"] = JY.Person[114]["攻击力"] - 300
				JY.Person[114]["轻功"] = JY.Person[114]["轻功"] - 300
				JY.Person[114]["防御力"] = JY.Person[114]["防御力"] - 300
				JY.Person[114]["生命最大值"] = JY.Person[114]["生命最大值"] - 5000
				JY.Person[114]["生命"] = JY.Person[114]["生命"] - 5000
				JY.Person[114]["内力最大值"] = 10000
				JY.Person[114]["内力"] = 10000
				JY.Person[27]["攻击力"] = JY.Person[27]["攻击力"] - 300
				JY.Person[27]["轻功"] = JY.Person[27]["轻功"] - 300
				JY.Person[27]["防御力"] = JY.Person[27]["防御力"] - 300
				JY.Person[27]["生命最大值"] = JY.Person[27]["生命最大值"] - 5000
				JY.Person[27]["生命"] = JY.Person[27]["生命"] - 5000
				JY.Person[27]["内力最大值"] = 10000
				JY.Person[27]["内力"] = 10000
				JY.Person[5]["攻击力"] = JY.Person[5]["攻击力"] - 300
				JY.Person[5]["轻功"] = JY.Person[5]["轻功"] - 300
				JY.Person[5]["防御力"] = JY.Person[5]["防御力"] - 300
				JY.Person[5]["生命最大值"] = JY.Person[5]["生命最大值"] - 5000
				JY.Person[5]["生命"] = JY.Person[5]["生命"] - 5000
				JY.Person[5]["内力最大值"] = 10000
				JY.Person[5]["内力"] = 10000
			end	
			SetS(86, 2, r, 5, 2);
			say("很可惜，先提高你的能力再来吧", 232, 1, "百事通");	
		end
	end
	
	SetS(86, 1, 9, 5, 0);
end

--进练功房
function LianGong()
	JY.Person[445]["等级"] = 30 * 350 --武骧金星：经验变多
  JY.Person[446]["等级"] = JY.Person[445]["等级"]
  JY.Person[445]["头像代号"] = math.random(190)
  JY.Person[446]["头像代号"] = math.random(190)
  --JY.Person[445]["生命最大值"] = 1
  --JY.Person[446]["生命最大值"] = 1
  JY.Person[445]["生命"] = 1 --JY.Person[445]["生命最大值"]
  JY.Person[446]["生命"] = 1 --JY.Person[446]["生命最大值"]
  instruct_6(226, 8, 0, 1)
  JY.Person[445]["等级"] = 10
  JY.Person[446]["等级"] = 10
  JY.Person[445]["头像代号"] = 208
  JY.Person[446]["头像代号"] = 208
	return 1;
end

function introduction()
	local menu = {
		{"神兵宝甲",nil,1,CC.SB},
		{"功体搭配",nil,1,CC.GT},
		{"武功组合",nil,1,CC.WG},
		{"状态解说",nil,1,CC.STATUS},		
		{"武学指令",nil,1,CC.WXZL},		
	}
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "要查看什么", C_WHITE, CC.DefaultFont)
	local r = ShowMenu(menu,#menu,0,CC.MainSubMenuX,CC.MainSubMenuY+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
	if r <= 0 then
		do return end
	end
	if r == 2 then
		local zgt = {
			{1, "功体加力时杀怒气%d点"},
			{2, "功体加力时增加伤害%d点"},
			{3, "功体加力时伤害增加百分之%d"},
			{4, "必定连击，百分之%d几率三连击"},
			{5, "攻击后恢复集气%d"},
			{6, "功体加力时杀集气%d点"},
			{7, "必定暴击"},
			{8, "减少内力消耗百分之%d"},
			{9, "功体加力时杀现有体力百分之%d"},
			{10, "封穴几率增加百分之%d"},
			{11, "增加武功威力%d点"},
			{12, "必定上毒%d点"},
			{13, "功体加力时追加敌人中毒值百分之%d的伤害"},
			{14, "功体加力时追加敌人内伤值百分之%d的伤害"},
		}

		local GT = {}
		local t = {CC.ZGT1, CC.ZGT2, CC.ZGT3, CC.ZGT4, CC.ZGT5, CC.ZGT6, CC.ZGT7, CC.ZGT8, CC.ZGT9, CC.ZGT10, CC.ZGT11, CC.ZGT12, CC.ZGT13, CC.ZGT14}
		for i = 1, JY.WugongNum - 1 do
			if i ~= 91 and i ~= 122 and (yongnei(i) or yongqing(i)) then
				GT[#GT + 1] = {JY.Wugong[i]["名称"]}
				GT[#GT][0] = i
			end
		end

		for a = 1, #GT do
				for i = 1, #CC.ZGTATK do
					if CC.ZGTATK[i][1] == GT[a][0] then
						GT[a][#GT[a] + 1] = "气攻值："..CC.ZGTATK[i][2].."－"..CC.ZGTATK[i][3]		
						break
					end
				end
				for i = 1, #CC.ZGTDEF do
					if CC.ZGTDEF[i][1] == GT[a][0] then
						GT[a][#GT[a]] = string.format("%-22s%s", GT[a][#GT[a]], "气防值："..CC.ZGTDEF[i][2].."－"..CC.ZGTDEF[i][3])
						GT[a][#GT[a] + 1] = ""
						break
					end
				end
				for i = 1, #CC.GT do
					if CC.GT[i][1] == GT[a][0] then
						for j = 3, #CC.GT[i] do
							GT[a][#GT[a] + 1] = CC.GT[i][j]
						end
						break
					end
				end		
			for i = 1, #t do
				for j = 1, #t[i] do
					if GT[a][0] == t[i][j][2] then
						GT[a][#GT[a] + 1] = JY.Wugong[t[i][j][1]]["名称"].." "..string.format(zgt[i][2], t[i][j][3])	
					end
				end
			end
		end	
		for i = 1, #GT do
			breakdown(GT[i])
		end
		sidetoside(GT)
	elseif r ~= 4 then
		sidetoside(menu[r][4])
	else
		say("除了封穴，流血，迟缓，冰封，灼烧等常规状态外，还有一些特殊状态需要注意。", 232, 1, "百事通");
		sidetoside(menu[r][4], 1)
	end
end

--装备说明
function ZBInstruce()
	local flag = false
	repeat
		local x1 = CC.ScreenW/2 - 180 ;
		local y1 = 150;
		DrawStrBox(x1, y1, "请选择需要查看的装备",C_WHITE, CC.DefaultFont);
		local menu = {
			{"真武剑",nil,1},
			{"白马",nil,1},
			{"玄铁剑",nil,1},
			{"倚天剑",nil,1},
			{"屠龙刀",nil,1},
			{"软蝟甲",nil,1}
		};
		
		local numItem = table.getn(menu);
		local size = CC.DefaultFont;
		local r = ShowMenu(menu,numItem,0,x1+80,y1+40,0,0,1,1,size,C_ORANGE,C_WHITE);
		if r == 0 then
			flag = true;
		elseif r == 1 then
			say("真武剑，使用太极剑法必连击", 232, 1, "百事通");
		elseif r == 2 then
			say("白马，额外提高五点集气速度", 232, 1, "百事通");	
		elseif r == 3 then
			say("玄铁剑，配合玄铁剑法必暴击，配合其它剑法提高暴击率", 232, 1, "百事通");	
		elseif r == 4 then
			say("倚天剑，攻击必流血，并且一定机率封穴", 232, 1, "百事通");	
		elseif r == 5 then
			say("屠龙刀，使用等级为极的刀法提高百分之四十暴击率，暴击的情况下有百分之五十机率大幅度杀集气，并且造成流血。杀集气量与武功威力有关", 232, 1, "百事通");	
		elseif r == 6 then
			say("软蝟甲，受到拳系武功攻击时反射一定的伤害，受到非拳系武功攻击时减少伤害", 232, 1, "百事通");	
		end
	until flag
end

--brolycjw: 队友挑战
function DYRW()
	local x1 = CC.MainSubMenuX
	local y1 = CC.MainSubMenuY + CC.SingleLineHeight
	CC.DYRW = -1
	CC.DYRW2 = -1
	DrawStrBox(x1, y1, "请选择挑战队友",C_WHITE, CC.DefaultFont);
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
	if r > 0 then
		id = JY.Base["队伍" .. r]
		CC.DYRW = id
		DrawStrBox(x1, y1, "请选择挑战难度",C_WHITE, CC.DefaultFont)
		menu = {			
			{"初级",nil,0}, --3
			{"进阶",nil,0}, --4
			{"中级",nil,0}, --5
			{"高级",nil,0}, --6
			{"神级",nil,0}, --7
		}		
		if JY.Person[id]["挑战"] + 1 > #menu then
			say("已经没有挑战对手了。", 232, 1, "百事通");
			do return end
		end
		menu[JY.Person[id]["挑战"] + 1][3] = 1
		numItem = table.getn(menu);
		local rr = ShowMenu(menu,numItem,0,x1,y1+40,0,0,1,1,size,C_ORANGE,C_WHITE);		
		if rr > 0 then
			local ds = {}
			for i = 0, JY.PersonNum - 1 do
				if not duiyou(i) and JY.Person[i]["排行"] - 2 == rr and JY.Person[i]["挑战"] ~= 999 then
					ds[#ds + 1] = i
				end
			end
			if #ds < 1 then
				for i = 0, JY.PersonNum - 1 do
					if not duiyou(i) and JY.Person[i]["排行"] - 2 == rr then
						ds[#ds + 1] = i
					end
				end				
			end
			if #ds < 1 then
				say("已经没有挑战对手了。", 232, 1, "百事通");
				do return end
			end
			say("请选择挑战对手。", 232, 1, "百事通");
			local dxp = {}
			local num = 1
			for i = 1, #ds do
				dxp[num] = {}
				dxp[num][1] = JY.Person[ds[i]]["姓名"] 
				dxp[num][2] = nil
				dxp[num][3] = 1
				dxp[num][4] = i
				num = num + 1			
			end
			local dsxz = ShowMenu(dxp, num - 1, 15, CC.MainMenuX, CC.MainMenuY + 45, 0, 0, 1, 0, CC.DefaultFont, C_RED, C_GOLD)
			CC.DYRW2 = ds[dxp[dsxz][4]] --ds[math.random(#ds)]
			if CC.DYRW2 == 116 and math.random(3) == 1 and JY.Person[618]["无用13"] == 1000 then 
				CC.DYRW2 = 618 
				JY.Person[618]["武功5"] = 124
				JY.Person[618]["武功6"] = 104
				JY.Person[618]["武功7"] = 105
				JY.Person[618]["武功8"] = 106
				JY.Person[618]["武功9"] = 107
				JY.Person[618]["武功10"] = 108
				for i = 4, 10 do
					JY.Person[618]["武功等级"..i] = JY.Person[618]["武功等级3"]
				end
			end
			if WarMain(341) then
				JY.Person[id]["挑战"] = JY.Person[id]["挑战"] + 1
				JY.Person[CC.DYRW2]["挑战"] = 999
				say("真是好身手啊。", 232, 1, "百事通");
				QZXS(string.format("%s 实战增加%s点",JY.Person[id]["姓名"],rr*12));
				QZXS(string.format("%s 攻防轻增加%s点",JY.Person[id]["姓名"],rr*3));			
				AddPersonAttrib(id, "实战", rr * 12)
				AddPersonAttrib(id, "攻击力", rr*3);
				AddPersonAttrib(id, "防御力", rr*3);
				AddPersonAttrib(id, "轻功", rr*3);

				if CC.DYRW2 == 64 then addHZ(1) end				
				if CC.DYRW2 == 50 then addHZ(7) end
				if CC.DYRW2 == 15 then addHZ(8) end
				if CC.DYRW2 == 102 then addHZ(10) end
				if CC.DYRW2 == 98 then addHZ(13) end
				if CC.DYRW2 == 118 then 
					addHZ(14)
					if id == 0 and GetS(114, 0, 0, 0) == 0 then
						say("你小子不错嘛，长的也俊～给你个奖励，跟姐姐来房间吧～",118)
						say("呃...谢谢姐姐好意，但姐姐随便给我本秘籍就好了，哈哈...",0)
						say("不解风情的傻子～(美目一瞥)，好吧，那姐姐教你一套步法。",118)	
	                    instruct_0();
	                    if instruct_11(0,188) == true then
	                        QZXS("领悟凌波微步！")
							say("谢谢姐姐",0) 
							instruct_0();
							SetS(114,0,0,0,179)
							--addthing(339)
				        else
				            say("哈哈哈，好！我李秋水没必要如此自讨没趣！",118)
							say("滚！！",118)		
				        end
					    do return; end
                    end
					--addHZ(14)
				end				
				if CC.DYRW2 == 67 then addHZ(15) end
				if CC.DYRW2 == 27 then 
					addHZ(16)
					if id == 0 and GetS(114, 0, 0, 0) == 0 and PersonKF(id,196) and PersonKF(id,105) and GetS(111, 0, 0, 0) ~= 105 then
						say("嘿，功夫不错，但身法还可以再练练～",27)
						say("暗香疏影被你用成这样还真不怕丢人",27)
						say("我来好好「矫正」你一番吧！",27)
						if DrawStrBoxYesNo(-1, -1, "要接受教主大人矫正吗？", C_WHITE, 30) == true then
							say("呜喔阿阿阿阿阿！！",0)
							say("教主大人！！东方姐姐！！求放过阿！！！",0)
							say("哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈～",27)
							dark()
							light()
							QZXS("领悟暗香疏影身法！")
							setLW2(196)
							say("呵呵呵，感觉如何？",27)
							say("非常好！非常好...（欲哭无泪）",0)
						else
							say("不，不用了！！（脚底抹油）",0)
							say("啧，玩具跑了",27)
						end
					end	
				end
				if CC.DYRW2 == 18 then 
					addHZ(21) 
					addthing(94) 
				end
				--if CC.DYRW2 == 20 then addHZ(22) end
				if CC.DYRW2 == 117 then addHZ(29) end
				if CC.DYRW2 == 60 then addHZ(33) end
				if CC.DYRW2 == 151 then addHZ(40) end
				if CC.DYRW2 == 100 then addHZ(41) end
				if CC.DYRW2 == 6 then addHZ(42) end
				if CC.DYRW2 == 24 then addHZ(43) end
				if CC.DYRW2 == 12 then addHZ(47) end
				if CC.DYRW2 == 70 then 
					addHZ(48)
					if id == 0 and GetS(113, 0, 0, 0) == 0 and PersonKF(id,24) then
						say("少侠好本事，贫僧观少侠于佛门武学有所研究，就送贫僧的掌法心得与少侠，可好？。",70) 
	                    instruct_0();
			            if instruct_11(0,188) == true then
	                        QZXS("领悟须弥山神掌！")
						    say("多谢方丈！",0) 
	                        instruct_0();
	                        SetS(113, 0, 0, 0,24)
				        else
				            say("呵呵，缘分未至，你我顺其自然吧！",70) 
				        end
				        --addHZ(48) 
					    do return; end
                    end
				end
				if CC.DYRW2 == 10 then addHZ(49) end
				if CC.DYRW2 == 14 then addHZ(50) end
				if CC.DYRW2 == 112 then addHZ(51) end	
				if CC.DYRW2 == 62 then addHZ(52) end	
				if CC.DYRW2 == 5 then 
					addHZ(53)
					if id == 0 and GetS(111, 0, 0, 0) == 0 and PersonKF(id,99) then
						say("少侠好本事，老道这纯阳无极功也算所托非人。",5) 
	                    instruct_0();
			            if instruct_11(0,188) == true then
	                        QZXS("领悟纯阳无极！")
						    say("多谢张真人",0) 
	                        instruct_0();
	                        SetS(111, 0, 0, 0,99)
				        else
				            say("哈哈哈，少侠真是年少有为。",5) 
				        end
				        --addHZ(53) 
					    do return; end
                    end
				end
				if CC.DYRW2 == 69 then 
					if id == 0 and GetS(111, 0, 0, 0) == 0 then
						say("少侠果真是年少有为啊，要不要跟老叫花学两手？",69) 
	                    instruct_0();
			            if instruct_11(0,188) == true then
	                        QZXS("领悟擒龙功！")
						    say("多谢洪老前辈",0) 
	                        instruct_0();
	                        SetS(111, 0, 0, 0,178)
						    addthing(338)
				        else
				            say("哈哈哈，我老叫花果真老了。",69) 
				        end
					    do return; end
                    end
				end
				if CC.DYRW2 == 129 then
					if id == 0 and GetS(114,0,0,0) == 0 and PersonKF(id,192) then
						say("哈哈哈，阁下不愧是小村传人！",129)
						say("承让了",0)
						say("阁下过谦了！",129)
						say("是说我发现阁下似乎有学本门的轻功金雁功？",129)
						say("是，乃全真门下挚友所赠",0)
						say("哈哈哈既然如此，老道就与阁下说道说道？",129)
						if DrawStrBoxYesNo(-1, -1, "要与重阳真人论道吗？", C_WHITE, 30) == true then
							QZXS("领悟金雁功！")
							setLW2(192)
							say("多谢重阳真人指教，在下受益良多",0)
							say("好说好说",129)
						else
							say("在下才疏学浅，却是不敢打搅了重阳真人",0)
							say("无妨，他日若有相聚，再相谈也可。",129)
						end
					end
				end	
				if CC.DYRW2 == 23 then addHZ(54) end
				if CC.DYRW2 == 115 then addHZ(65) end
				if CC.DYRW2 == 57 then addHZ(74) end
				if CC.DYRW2 == 152 then addHZ(78) end
				if CC.DYRW2 == 113 then addHZ(79) end
				if CC.DYRW2 == 71 then addHZ(81) end
				if CC.DYRW2 == 26 then addHZ(86) end				
				
				--if CC.DYRW2 == 131 then addHZ(97) end
				if CC.DYRW2 == 153 then addHZ(100) end
				--if CC.DYRW2 == 618 then addHZ(103) end
				if CC.DYRW2 == 103 then addHZ(104) end
				if CC.DYRW2 == 97 then addHZ(109) end
				if CC.DYRW2 == 22 then
					addHZ(110) 
					if id == 0 and GetS(111, 0, 0, 0) == 0 then
						say("我看你有几分本事，日后待我五岳合一之时祝我一臂之力，我便将这寒冰真气送与你如何？",22) 
	                    instruct_0();
			            if instruct_11(0,188) == true then
	                        QZXS("领悟寒冰气场！")
	                        instruct_0();
	                        SetS(111, 0, 0, 0,124)
						    addthing(261)
				        else
				            say("不识抬举！",22) 
				        end
				            addHZ(110) 
					    do return; end
                    end
				end
				if CC.DYRW2 == 19 then
					if id == 0 and GetS(111, 0, 0, 0) == 0 then
						say("少侠可有兴趣助我华山大兴？",19) 
	                    instruct_0();
			            if instruct_11(0,188) == true then
	                        QZXS("领悟紫霞剑气！")
	                        instruct_0();
	                        SetS(111, 0, 0, 0,89)
				        else
				            say("真是可惜了！",19) 
				        end
					    do return; end
                    end
				end
				if CC.DYRW2 == 114 then
					addHZ(115)
	                if PersonKF(0, 108) and GetS(111, 0, 0, 0) == 0 then
	                    say("少侠武功盖世，可曾想过换一种人生？",114) 
	                    instruct_0();
			            if instruct_11(0,188) == true then
	                        local T = {}
			                for a = 1, 1000 do
				                local b = "" .. a
					                T[b] = a
							end
			                DrawStrBoxWaitKey(CC.EVB124, C_WHITE, 30)
			                JY.Person[0]["资质"] = -1
			                while JY.Person[0]["资质"] == -1 do
								local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
								if T[r] ~= nil and T[r] > -1 and T[r] < 101 then
									JY.Person[0]["资质"] = T[r]
								else
									DrawStrBoxWaitKey(CC.EVB125, C_WHITE, 30)
								end
							end
							SetS(111, 0, 0, 0,108)
						else
							say("现在挺好的。",0) 
						end
					end
					if GetS(114, 0, 0, 0) == 0 and PersonKF(0,143) then
						say("唔...一苇渡江轻功我也会，但看方才神僧的身法...",0)
						say("那种不染周身红尘，怡然自渡的神韵...",0)
						say("哈哈哈，我悟了！",0)	
	                    instruct_0();
	                    QZXS("领悟一苇渡江精髓！") 
						instruct_0();
						SetS(114,0,0,0,143)
                    end
					do return; end 
				end
				if CC.DYRW2 == 189 then addHZ(117) end
				if CC.DYRW2 == 65 then addHZ(118) end
				if CC.DYRW2 == 116 then addHZ(121) end	
				if CC.DYRW2 == 160 then addHZ(125) end
				if CC.DYRW2 == 618 then 
					addHZ(88)
					if id == 0 and PersonKF(id,98) and GetS(111, 0, 0, 0) == 0 then
						say("我逍遥派小无相功可模拟天下武学，你却是未能学精啊，我来教你两手如何？",618) 
	                    instruct_0();
			            if instruct_11(0,188) == true then
	                        QZXS("领悟无相幻化！")
	                        instruct_0();
	                        SetS(111, 0, 0, 0,98)
				        else
				            say("如此也罢。",618) 
				        end
					    do return; end
                    end
					say("！！！我不会是大白天遇到神仙了吧？",CC.DYRW)
					if CC.DYRW > 0 then JY.Person[618]["无用13"] = CC.DYRW end
					--addHZ(88)
				end				
				--[[				
				if rr == 4 and math.random(100) <= 20 then
					local tmp = CC.DYRW2
					if tmp == 5 then

					elseif tmp == 27 then

					elseif tmp == 50 then

					else

					end
				end
				--]]				
			else				
				say("很可惜，先提高你的能力再来吧", 232, 1, "百事通")
				do return end
			end
		end			
	end
end

function DUIYOUSHENGJI()
	local x1 = CC.MainSubMenuX
	local y1 = CC.MainSubMenuY + CC.SingleLineHeight
	CC.DYRW = -1
	CC.DYRW2 = -1
	DrawStrBox(x1, y1, "请选择需要升级的队友",C_WHITE, CC.DefaultFont);
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
	menu[CC.TeamNum + 1] = {'全体', nil, 1}
	local numItem = table.getn(menu);
	local size = CC.DefaultFont;
	local r = ShowMenu(menu,numItem,0,x1,y1+40,0,0,1,1,size,C_ORANGE,C_WHITE);	
	if r > 0 and r <= CC.TeamNum then
		id = JY.Base["队伍" .. r]
		--CC.DYRW = id
		JY.Person[id]["经验"] = 55000
		War_AddPersonLVUP(id);
	elseif r > CC.TeamNum then
		for i = 1, CC.TeamNum do                 
			local id = JY.Base["队伍" .. i];
			if id >= 0 then
				JY.Person[id]["经验"] = 55000
				War_AddPersonLVUP(id);		
			end
		end		
	end
end


--修改原39事件，不可杀狄云
--nino：狄云可杀，进入邪线
OEVENTLUA[39] = function()
    --instruct_3(-2,-2,-2,0,40,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
    instruct_1(179,0,1);   --  1(1):[AAA]说: 你是谁，在这做什么？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(180,37,0);   --  1(1):[狄云]说: 唉，我叫狄云，是个不幸之*人。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(181,0,1);   --  1(1):[AAA]说: 我要找些书，随便到这个山*洞来看看。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(182,37,0);   --  1(1):[狄云]说: 你还是早些离去的好，免得*被我这个不幸之人连累。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(183,0,1);   --  1(1):[AAA]说: 你到底发生了什么事，说来*听听。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(184,37,0);   --  1(1):[狄云]说: 几年前，我随师父和师妹到*荆州去为我万震山万师叔祝*寿，但後来却被师叔他们诬*赖我勾结盗匪，偷了他万家*的金银珠宝，并意图非礼小*师娘。*而县府大人也没明察秋毫，*就把我关了起来。**后来听说我师父死了，我师*妹。。。师妹她。。她。。*竟嫁给了万师兄。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(185,0,1);   --  1(1):[AAA]说: 你很爱你师妹，是吗？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(186,37,0);   --  1(1):[狄云]说: 我师妹怎能…………*怎能嫁给那个姓万的。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(187,0,1);   --  1(1):[AAA]说: 那你后来怎么离开那荆州大*牢，又怎么会在这里？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(188,37,0);   --  1(1):[狄云]说: 在狱中的几年，同牢的丁典*丁大哥告诉了我许多江湖上*的事，也教了我"神照经"大*法。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(189,0,1);   --  1(1):[AAA]说: 神照经？听起来很厉害的样*子……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(190,37,0);   --  1(1):[狄云]说: 突然有一天，丁大哥带我逃*狱，说要去看一位朋友。但*想不到是丁大哥的红粉知己*死了，而她父亲，也就是荆*州府尹，居然在她女儿的棺*木上下毒，为的就是要害死*丁大哥，丁大哥后来就中毒*死了。而我逃走了，后来就*回到了这里。这个山洞，是*我和师妹以前儿时常来玩的*地方。
    instruct_0();   --  0(0)::空语句(清屏)
	
	if PDReq(0, "品德", 0, 30) then
		if DrawStrBoxYesNo(-1, -1, "要和狄云战斗吗？", C_WHITE, 30) == true then	
			Cls()
			say("哪来这么多废话，把神照经交出来！")
			Cls()
			say("不行，这是丁大哥的遗物！",37,0,"狄云")	
			Cls()
			say("找死！")		
			if WarMain(283) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end
			addHZ(55)
			instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0)
			SetS(86, 9, 10, 5, 1)
			SetD(2, 3, 2, 31040)
			instruct_37(-2)
			Cls()
			light()
			instruct_2(59, 1)
			instruct_2(71, 1)
			do return end
		end
	end

    if instruct_9(0,93) ==true then    --  9(9):是否要求加入?否则跳转到:Label0
        instruct_1(191,0,1);   --  1(1):[AAA]说: 看你也无家可归，和我一起*走吧，路上也有个照应。
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_28(0,0,100,0,76) ==true then    --  28(1C):判断AAA品德0-100否则跳转到:Label1

          if instruct_20(32,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label2
		          instruct_37(2);   --  37(25):增加道德2
		          instruct_1(192,37,0);   --  1(1):[狄云]说: 好吧！如果你不怕被我这个*不幸之人连累的话。
							Talk(CC.LTalk91, 37);	--[狄说]：好久没有去祭拜丁大哥了，我想去药王庙看一看。
          
              instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
              instruct_3(104,81,1,0,956,0,0,7232,7232,7232,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [81]
              instruct_10(37);   --  10(A):加入人物[狄云]
              instruct_0();   --  0(0)::空语句(清屏)
              
              instruct_3(103,81,1,0,0,0,0,6700,6700,6700,0,0,0);		--修改药王庙事件
							instruct_3(103,82,1,0,8012,0,0,6696,6696,6696,0,0,0);		--修改药王庙事件
              return
          end    --:Label2

            --instruct_1(12,37,0);   --  1(1):[狄云]说: 你的队伍已满，我就直接去*小村吧。
            Talk(CC.LTalk90, 37);
            
            
            return
        end    --:Label1

        instruct_1(193,37,0);   --  1(1):[狄云]说: 不了！我这个不幸之人还是*别害人的好。
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label0



end

--重新修改雪山事件
OEVENTLUA[41] = function()
		
		--龙门客栈事件还未触发前不可进入
		if GetS(86, 9, 10, 5) ~= 1 then
			Talk(CC.LTalk46,0);		--[主角]：这地方好冷，还是出去吧。
			JY.Base["人X1"] = JY.Scene[JY.SubScene]["出口X1"];
			JY.Base["人Y1"] = JY.Scene[JY.SubScene]["出口Y1"];
			return;
		end

		
    instruct_3(3,5,1,0,643,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[有间客栈]:场景事件编号 [5]
    instruct_3(3,6,1,0,643,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[有间客栈]:场景事件编号 [6]
    instruct_3(3,8,1,0,643,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[有间客栈]:场景事件编号 [8]
    instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
    instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
    instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
    instruct_30(27,49,27,34);   --  30(1E):主角走动27-49--27-34
    instruct_25(27,34,27,30);   --  25(19):场景移动27-34--27-30
    instruct_1(197,0,2);   --  1(1):[AAA]说: "落~花~流~水~"
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(198,0,1);   --  1(1):[AAA]说: 这里怎么这么热闹？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(199,94,0);   --  1(1):[???]说: 哼，邪魔歪道，人人得而诛*之！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(200,95,0);   --  1(1):[???]说: 血刀老祖，你已经走投无路*了！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(201,96,0);   --  1(1):[???]说: 你作恶多端，今日就让你血*债血偿。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(202,52,0);   --  1(1):[花铁干]说: 血刀老祖，看枪。
    instruct_0();   --  0(0)::空语句(清屏)
    Talk(CC.LTalk47,96);		--[水岱]：快把我女儿放了，否则今日我们兄弟定让你生不如死！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(203,97,0);   --  1(1):[???]说: 小子，帮帮我，他们四个欺*负我一个。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(204,246,1);   --  1(1):[???]说: 这个……听说……你是坏人*啊！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(205,97,0);   --  1(1):[???]说: 小子，他们内力已经不行了*，你帮了我，我就送你一本*好书！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(206,0,1);   --  1(1):[AAA]说: 〈书？难道是天书？〉
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(207,96,0);   --  1(1):[???]说: 这位少侠真要与我们为敌吗*？
    instruct_0();   --  0(0)::空语句(清屏)
    Talk(CC.LTalk48,0);	--[主角]：〈怎么办，狄兄弟还在血刀老祖手里。真的要和~~落花流水~~为敌么〉

    if instruct_5(0,198) ==true then    --  5(5):是否选择战斗？否则跳转到:Label0
        instruct_37(-2);   --  37(25):增加道德-2
        instruct_1(208,244,1);   --  1(1):[???]说: 为了天书，只好如此了！
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_6(42,4,0,0) ==false then    --  6(6):战斗[42]是则跳转到:Label1
            instruct_15(0);   --  15(F):战斗失败，死亡
            instruct_0();   --  0(0)::空语句(清屏)
            do return; end
        end    --:Label1
		addHZ(112)
        instruct_17(-2,1,24,31,0);   --  17(11):修改场景贴图:当前场景层1坐标18-1F
        instruct_17(-2,1,27,27,0);   --  17(11):修改场景贴图:当前场景层1坐标1B-1B
        instruct_17(-2,1,30,34,0);   --  17(11):修改场景贴图:当前场景层1坐标1E-22
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(209,52,0);   --  1(1):[花铁干]说: 少侠饶命，少侠饶命……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(210,0,1);   --  1(1):[AAA]说: 喂，你刚才还正义凛然的，*现在怎么了？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(211,52,0);   --  1(1):[花铁干]说: 小人有眼不识泰山，不该与*少侠为敌啊
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_9(0,105) ==true then    --  9(9):是否要求加入?否则跳转到:Label2
            instruct_37(-1);   --  37(25):增加道德-1
            instruct_1(212,247,1);   --  1(1):[???]说: 哈哈哈，看你还挺识相的，*以后就跟着我吧。
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_1(213,52,0);   --  1(1):[花铁干]说: 多谢少侠不杀之恩，花铁干*愿为少侠牵马坠镫。
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_3(104,87,1,0,964,0,0,7236,7236,7236,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [87]

            if instruct_20(30,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label3
                instruct_10(52);   --  10(A):加入人物[花铁干]
                instruct_0();   --  0(0)::空语句(清屏)
                instruct_17(-2,1,25,29,0);   --  17(11):修改场景贴图:当前场景层1坐标19-1D
                instruct_0();   --  0(0)::空语句(清屏)
                instruct_1(214,97,0);   --  1(1):[???]说: 小子，你还不赖嘛，加入我*血刀门吧！
                instruct_0();   --  0(0)::空语句(清屏)
                instruct_1(215,0,1);   --  1(1):[AAA]说: 废话少说，书在哪？
                instruct_0();   --  0(0)::空语句(清屏)
                instruct_1(216,97,0);   --  1(1):[???]说: 够爽快，拿去！
                instruct_0();   --  0(0)::空语句(清屏)
                instruct_2(139,1);   --  2(2):得到物品[血刀经][1]
                instruct_0();   --  0(0)::空语句(清屏)
                do return; end
            end    --:Label3

            instruct_1(12,52,0);   --  1(1):[花铁干]说: 你的队伍已满，我就直接去*小村吧。
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_3(70,41,1,0,141,0,0,7014,7014,7014,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [41]
            instruct_17(-2,1,25,29,0);   --  17(11):修改场景贴图:当前场景层1坐标19-1D
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_1(214,97,0);   --  1(1):[???]说: 小子，你还不赖嘛，加入我*血刀门吧！
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_1(215,0,1);   --  1(1):[AAA]说: 废话少说，书在哪？
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_1(216,97,0);   --  1(1):[???]说: 够爽快，拿去！
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_2(139,1);   --  2(2):得到物品[血刀经][1]
            instruct_0();   --  0(0)::空语句(清屏)
            do return; end
        end    --:Label2

        instruct_1(217,245,1);   --  1(1):[???]说: 哼，我生平最看不起的就是*你这种人。受死吧！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(176,52,0);   --  1(1):[花铁干]说: 啊——
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
        instruct_17(-2,1,25,29,0);   --  17(11):修改场景贴图:当前场景层1坐标19-1D
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        instruct_1(214,97,0);   --  1(1):[???]说: 小子，你还不赖嘛，加入我*血刀门吧！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(215,0,1);   --  1(1):[AAA]说: 废话少说，书在哪？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(216,97,0);   --  1(1):[???]说: 够爽快，拿去！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_2(139,1);   --  2(2):得到物品[血刀经][1]
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0

    instruct_1(218,245,1);   --  1(1):[???]说: 即便为了天书，我也不能做*违反道义之事，血刀老祖，*你觉悟吧！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_37(2);   --  37(25):增加道德2

    if instruct_6(7,5,0,0) ==false then    --  6(6):战斗[7]是则跳转到:Label4
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label4

	instruct_3(-2,3,1,0,0,0,0,8744,8744,8744,0,0,0);			--血刀老祖贴图 变换
	if hasthing(71) == false then		
	Talk(CC.LTalk49, 97);		--[血刀老祖]：徒儿，你居然对我暗下毒手，我绝不饶你，受死吧
	Talk(CC.LTalk50, 37);		--[狄云]：你伤我大哥，我跟你拼了！！！
	DrawStrBoxWaitKey(CC.LTalk51, C_ORANGE, CC.DefaultFont);	--(系统提示：拼搏中狄云神经功意外大成..........）
	instruct_0();   --  0(0)::空语句(清屏)
	
	Talk(CC.LTalk52, 97);		--[血刀老祖]：啊~~~
	instruct_2(356,1);
	Talk(CC.LTalk53, 37);		--[狄云]：呼呼~~~
	Talk(CC.LTalk54,0);		--[主角]：狄兄弟，你没事吧
	Talk(CC.LTalk55, 37);	--[狄云]：没事，刚才在命悬一刻的时候，突然感觉精神力勃然而兴，才得以踹死这老恶僧。丁大哥说得没错，这神照功果然是武功第一奇功。
	
	QZXS(CC.LTalk56);		--(系统提示：狄云攻防轻能力各提升三十点）
	AddPersonAttrib(37, "攻击力", 30)
	AddPersonAttrib(37, "防御力", 30)
	AddPersonAttrib(37, "轻功", 30)

	QZXS(CC.LTalk57);		--(系统提示：狄云四系兵器值各提升十点）
	AddPersonAttrib(37, "拳掌功夫", 10)
    AddPersonAttrib(37, "御剑能力", 10)
    AddPersonAttrib(37, "耍刀技巧", 10)
    AddPersonAttrib(37, "特殊兵器", 10)
	AddPersonAttrib(37, "暗器技巧", 10)
    
    SetS(86, 8, 10, 5, 1);		--判断狄云是否激发神照经
    
    instruct_3(-2,80,1,0,8003,0,0,9228,9228,9228,0,0,0);		--新增事件8003，重新加入狄云
	end	
		
    instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(219,94,0);   --  1(1):[???]说: 我等四人已经内力不济，多*亏少侠及时赶到。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(220,95,0);   --  1(1):[???]说: 是啊，少侠，你是手刃血刀*老祖的大英雄啊
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(221,52,0);   --  1(1):[花铁干]说: 回到中原后，我们一定为少*侠传名啊。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(222,96,0);   --  1(1):[???]说: 少侠，感谢你的救命之恩，*这本刀法你拿去吧，后会有*期。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_2(164,1);   --  2(2):得到物品[鬼头刀法][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_17(-2,1,24,31,0);   --  17(11):修改场景贴图:当前场景层1坐标18-1F
    instruct_17(-2,1,27,27,0);   --  17(11):修改场景贴图:当前场景层1坐标1B-1B
    instruct_17(-2,1,30,34,0);   --  17(11):修改场景贴图:当前场景层1坐标1E-22
    instruct_17(-2,1,25,29,0);   --  17(11):修改场景贴图:当前场景层1坐标19-1D
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
end


--重新邪线之后杀老祖抢血刀事件
OEVENTLUA[42] = function()

	Talk(CC.LTalk79, 0);		--[主角]：人赶紧给放了。
	Talk(CC.LTalk80, 97);		--[血刀老祖]：小子，你脾气挺合老子胃口，加入血刀门吧。
	Talk(CC.LTalk81, 0);		--[主角]：血刀门是什么东西，我倒是觉得你身上这把刀不错。怎么样，也一起送给我吧。
	Talk(CC.LTalk82, 97);		--[血刀老祖]：嘿嘿，小子，好眼力。这把血刀是老祖我的贴身武器，有本事你就过来拿吧。
	if instruct_5(0,38) then    --  5(5):是否选择战斗？否则跳转到:Label0
		if instruct_6(7,4,0,0) == false then   
			instruct_15(0);   --  15(F):战斗失败，死亡
			instruct_0();   --  0(0)::空语句(清屏)
			return;
		end
        
		Talk(CC.LTalk83, 97);		--[血刀老祖]：小子，够狠！这把血刀就给你了。
		instruct_2(44,1);   --  2(2):得到物品[血刀][1]
		instruct_0();   --  0(0)::空语句(清屏)
		
		if hasHZ(55) == false then
		Talk(CC.LTalk84, 0);	--[主角]：天下宝物，能者居之。
		Talk(CC.LTalk85, 97);		--[血刀老祖]：好一个“能者居之”，小子，你真有种。
		DrawStrBoxWaitKey(CC.LTalk86, C_ORANGE, CC.DefaultFont);		--(系统提示：血刀老祖突然偷袭）
		instruct_0();   --  0(0)::空语句(清屏)
		
		Talk(CC.LTalk87, 37);		--[狄云]：大哥，小心！
		Talk(CC.LTalk52, 97);		--[血刀老祖]：啊~~~
		instruct_2(356,1);
		Talk(CC.LTalk53, 37);		--[狄云]：呼呼~~~
		Talk(CC.LTalk54, 0);		--[主角]：狄兄弟，你没事吧
		Talk(CC.LTalk55, 37);	--[狄云]：没事，刚才在命悬一刻的时候，突然感觉精神力勃然而兴，才得以踹死这老恶僧。丁大哥说得没错，这神照功果然是武功第一奇功。
		QZXS(CC.LTalk56);		--(系统提示：狄云攻防轻能力各提升三十点）
		AddPersonAttrib(37, "攻击力", 30)
		AddPersonAttrib(37, "防御力", 30)
		AddPersonAttrib(37, "轻功", 30)
	
		QZXS(CC.LTalk57);		--(系统提示：狄云五系兵器值各提升十点）
		AddPersonAttrib(37, "拳掌功夫", 10)
	    AddPersonAttrib(37, "御剑能力", 10)
	    AddPersonAttrib(37, "耍刀技巧", 10)
	    AddPersonAttrib(37, "特殊兵器", 10)
		AddPersonAttrib(37, "暗器技巧", 10)
	    
	    SetS(86, 8, 10, 5, 1);		--判断狄云是否激发神照经
	    instruct_3(-2,80,1,0,8003,0,0,9228,9228,9228,0,0,0);		--新增事件8003，重新加入狄云
        end
		
		if GetS(113, 0, 0, 0) == 0 then
	say("原来这就是血刀啊，看起来很不给力啊",0)
	say("等等，这刀柄似乎有点松动",0)
	say("要不要把刀拧开看看",0)
				  if DrawStrBoxYesNo(-1, -1, "是否拆开血刀？", C_WHITE, 30) ==true  then
				  instruct_0();   --  0(0)::空语句(清屏)
                  instruct_13();   --  13(D):重新显示场景
				  say("等等，好像有一张人皮",0)
				  say("原来是这样啊，这才是真正的血刀大法吧",0)
				  	 QZXS("领悟血煞刀意！")
	                 instruct_0();
	                 setLW1(63)
					 say("呼，这把刀还能用",0)
					 say("恐怕这死秃驴也不会这个吧，看来我还真有主角光环啊",0)
				  else
				     say("算了，怕把刀弄坏了",0) 
				  end
    end
		
		
		instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
		instruct_0();   --  0(0)::空语句(清屏)
    end

end

--重写使用唐诗选集的事件
OEVENTLUA[45] = function()

  if instruct_4(206,0,331) ==true then    --  4(4):是否使用物品[唐诗选集]？否则跳转到:Label0
  
  		Talk(CC.LTalk61, 0);		--[主角]：咦，有字显示出来了
		--[[
  		if not inteam(37) then
  			Talk(CC.LTalk62, 0);	--[主角]：似乎只有狄兄弟才能理解这其中的意思
  			return;
  		end]]
		
  		Talk(CC.LTalk63, 0);		--[狄云]：连城诀……天宁寺大佛后……
  		Talk(CC.LTalk64, 0);		--[主角]：终于有天书的下落了，我们赶紧过去看看吧
		
		if inteam(37) then
			Talk(CC.LTalk65, 0);		--[主角]：似乎还有一个类似剑谱的东西
				
			Cls();
			local x = CC.ScreenW/2;
			local y = CC.ScreenH/2;
			local color = C_GOLD;
			local size = CC.Fontbig;
			local offx = (#CC.LTalk67 - #CC.LTalk66)*size/4;
			
			DrawString(x+offx,y,CC.LTalk66,color,size);  --静夜思
			ShowScreen();
			lib.Delay(1000);
			DrawString(x,y+30,CC.LTalk67,color,size);  --床前明月光，疑是地上霜
			ShowScreen();
			lib.Delay(1000);
			DrawString(x,y+60,CC.LTalk68,color,size);  --举头望明月，低头思故乡
			ShowScreen();
			lib.Delay(2000);
			
			
			Talk(CC.LTalk69, 37);		--[狄云]：是连城剑诀，没想到竟然在这唐诗之中
			instruct_35(37,1,114,0);		--狄云第二武功洗为连城剑法
			DrawStrBoxWaitKey(string.format("%s 学会武功 %s", JY.Person[37]["姓名"], JY.Wugong[114]["名称"]), C_ORANGE, CC.DefaultFont)
			instruct_2(237,1);		--得到连城剑诀
		end
  		
      instruct_3(3,5,1,0,644,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[有间客栈]:场景事件编号 [5]
      instruct_3(3,6,1,0,644,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[有间客栈]:场景事件编号 [6]
      instruct_3(3,8,1,0,644,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[有间客栈]:场景事件编号 [8]
      instruct_3(-2,5,1,0,44,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [5]
      instruct_3(63,17,0,0,0,0,48,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [17]
      instruct_3(-2,-2,1,0,47,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
      instruct_32(206,-1);   --  32(20):物品[唐诗选集]+[-1]
      instruct_3(63,1,0,0,0,0,0,6768,6768,6768,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [1]
      instruct_3(63,2,0,0,0,0,0,6768,6768,6768,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [2]
      instruct_3(63,3,0,0,0,0,0,6766,6766,6766,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [3]
      instruct_3(63,4,0,0,0,0,0,6766,6766,6766,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [4]
      instruct_3(63,5,0,0,0,0,0,6770,6770,6770,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [5]
      instruct_3(63,6,0,0,0,0,0,6770,6770,6770,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [6]
      instruct_3(63,7,0,0,0,0,0,6772,6772,6772,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [7]
      instruct_3(63,8,0,0,0,0,0,6772,6772,6772,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [8]
      instruct_3(63,9,0,0,0,0,0,6780,6780,6780,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [9]
      instruct_3(63,10,0,0,0,0,0,6780,6780,6780,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [10]
      instruct_3(63,11,0,0,0,0,0,6780,6780,6780,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [11]
      instruct_3(63,12,0,0,0,0,0,5222,5222,5222,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [12]
      instruct_3(63,13,0,0,0,0,0,5222,5222,5222,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [13]
      instruct_3(63,14,0,0,0,0,0,5222,5222,5222,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [14]
      instruct_3(63,15,0,0,0,0,0,5222,5222,5222,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [15]
      instruct_3(63,16,0,0,0,0,0,6768,6768,6768,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [16]
      instruct_3(63,18,1,0,49,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[天宁寺]:场景事件编号 [18]
      do return; end
  end    --:Label0

  instruct_0();   --  0(0)::空语句(清屏)
end

--重新修改获取连城诀事件
OEVENTLUA[49] = function()
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
    instruct_2(146,1);   --  2(2):得到物品[连城诀][1]
    instruct_3(3,5,1,0,645,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[有间客栈]:场景事件编号 [5]
    instruct_3(3,6,1,0,645,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[有间客栈]:场景事件编号 [6]
    instruct_3(3,8,1,0,645,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[有间客栈]:场景事件编号 [8]
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_16(37,2,0) ==false then    --  16(10):队伍是否有[狄云]是则跳转到:Label0
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0


    if instruct_28(0,80,100,2,0) ==false then    --  28(1C):判断AAA品德80-100是则跳转到:Label1
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label1

    instruct_37(1);   --  37(25):增加道德1
    instruct_1(233,37,0);   --  1(1):[狄云]说: 连城诀终于找到了，丁大哥*也可以安息了。这是丁大哥*的遗物，就送给你吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_2(71,1);   --  2(2):得到物品[神照经][1]
    instruct_0();   --  0(0)::空语句(清屏)
    
    instruct_3(-2,80,1,0,0,0,0,9230,9230,9230,0,0,0);			--戚长发贴图
    instruct_3(-2,81,0,0,0,0,8004,0,0,0,0,0,0);		--路过触发
end

--重写4MM离队事件

OEVENTLUA[198] = function()
    say("你先回小村，有需要时，我再去找你帮忙。")
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_21(92);   --  21(15):[4MM]离队
  if GX(92) then --武骧金星：图像多样化
	instruct_3(70, 1, 1, 0, 199, 0, 0, 4602*2, 4602*2, 4602*2, -2, -2, -2)
  elseif LWS(92) then
	instruct_3(70, 1, 1, 0, 199, 0, 0, 4606*2, 4606*2, 4606*2, -2, -2, -2)
  elseif MRL(92) then
	instruct_3(70, 1, 1, 0, 199, 0, 0, 4414*2, 4414*2, 4414*2, -2, -2, -2)	
  elseif JY.Person[92]["性别"] == 1 then
	instruct_3(70, 1, 1, 0, 199, 0, 0, 7266, 7266, 7266, -2, -2, -2)
  else
	instruct_3(70, 1, 1, 0, 199, 0, 0, 2522*2, 2522*2, 2522*2, -2, -2, -2)
  end	
end


--重写4MM入队事件
OEVENTLUA[199] = function()
    TalkEx("有需要我帮忙的地方吗？", 92);
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_9(0,29) ==true then    --  9(9):是否要求加入?否则跳转到:Label0

        if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label1
            instruct_10(92);   --  10(A):加入人物
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
        end    --:Label1
				TalkEx("你的队伍已满，我无法加入。", 92);
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0

end

--重写阿珂入队事件
OEVENTLUA[187] = function()
    if instruct_16(87) == true then
    TalkEx("我的老婆岂能全给你当打手！？阿珂你给我老老实实呆在小村里！", 664);
    instruct_0();   --  0(0)::空语句(清屏)
    do return; end
    end
     if instruct_9(0,29) ==true then    --  9(9):是否要求加入?否则跳转到:Label0

        if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label1
            instruct_10(86);   --  10(A):加入人物
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
        end    --:Label1
				TalkEx("你的队伍已满，我无法加入。", 86);
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0

end

--重写苏荃入队事件
OEVENTLUA[189] = function()
    if instruct_16(86) == true then
    TalkEx("我的老婆岂能全给你当打手！？小苏苏你给我老老实实呆在小村里！", 664);
    instruct_0();   --  0(0)::空语句(清屏)
    do return; end
    end

    if instruct_9(0,29) ==true then    --  9(9):是否要求加入?否则跳转到:Label0

        if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label1
            instruct_10(87);   --  10(A):加入人物
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
        end    --:Label1
				TalkEx("你的队伍已满，我无法加入。", 87);
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0

end

--重写打铁匠的事件，改成卖东西
OEVENTLUA[847] = function()

	local x1 = CC.ScreenW/2 - 180 ;
	local y1 = 50;
	DrawStrBox(x1, y1+40, "装备名称    需银两",C_WHITE, CC.DefaultFont);
	local tids = {53,42,62,46,39,45,48,50,55,56,57};
	--local name = {"判官笔","白虹剑","佛心甲","绿波香露刀","白龙剑","冷月宝刀","伏魔杵","神山剑","玄铁菜刀","犽月"}
	local prices = {300,300,400,400,500,500,600,600,2000,2000,2000};
	for i = 1, #tids do
		prices[i] = JY.Thing[tids[i]]["价钱"]
	end
	
	local menu = {};
	for i=1, #tids do
		menu[i] = {string.format("%-12s %5d",JY.Thing[tids[i]]["名称"],prices[i]), nil, 1};
	end
	
	local n = 3;
	
	menu[9][3] = 0;		--玄铁菜刀 默认不显示
	menu[10][3] = 0;		--神山剑 默认不显示
	menu[11][3] = 0;	--犽月 默认不显示
	if JY.Person[0]["武功1"] == 110 then			--洗神山剑法
		menu[9][3] = 1
		n = n - 1
	elseif JY.Person[0]["武功1"] == 111 then		--洗西瓜刀法
		menu[10][3] = 1
		n = n - 1
	elseif JY.Person[0]["武功1"] == 112 then		--洗犽月流空
		menu[11][3] = 1
		n = n - 1
	end
	
	
	for i=1, #tids do			--已经有了的不显示
		for j=1, CC.MyThingNum do
			if JY.Base["物品" .. j] == tids[i] then
				menu[i][3] = 0;
				n = n+1;
			end
		end
	end
	
	if n == #tids then
		DrawStrBoxWaitKey("对不起，东西已经卖完啦!", C_WHITE, 30)
	end
		
	local numItem = table.getn(menu);
	local r = ShowMenu(menu,numItem,0,x1,y1+80,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
	
	if r > 0 then
		if JY.GOLD >= prices[r] then
			instruct_2(tids[r],1)
			instruct_2(174, -prices[r]);
		else
			DrawStrBoxWaitKey("对不起，你的银两不足!", C_WHITE, 30)
		end
	end
end--重写打铁匠的事件

OEVENTLUA[848] = function()

end--修复华山论剑存档跳出的BUG
OEVENTLUA[2006] = function()
  PlayMIDI(31)
  say(CC.EVB157, 1000, 0, CC.EVB164)
  say(CC.EVB158, 1000, 0, CC.EVB164)
  if DrawStrBoxYesNo(-1, -1, CC.EVB165, C_GOLD, 30) then
    say(CC.EVB160, 1000, 0, CC.EVB164)
    say(CC.EVB161, 1000, 0, CC.EVB164)
    say(CC.EVB162, 1000, 0, CC.EVB164)
    say(CC.EVB163, 1000, 0, CC.EVB164)
    PlayMIDI(100)
    PlayWavAtk(43)
    if WarMain(238) then
      say(CC.EVB196, 1000, 0, CC.EVB164)
      JY.Person[zj()]["实战"] = 500
      AddPersonAttrib(zj(), "攻击力", 30)
      AddPersonAttrib(zj(), "防御力", 30)
      AddPersonAttrib(zj(), "轻功", 30)
      QZXS(JY.Person[zj()]["姓名"] .. CC.EVB197)
      SetS(10, 0, 21, 0, 1)
    else
      say(CC.EVB198, 1000, 0, CC.EVB164)
      AddPersonAttrib(0, "实战", 100)
      QZXS(CC.EVB199)
    end
    QZXS("武学常识提高50点")
    --华山论剑之后，武学常识提高50点
    AddPersonAttrib(0, "武学常识", 50);
  else
    say(CC.EVB159, 1000, 0, CC.EVB164)
  end
  instruct_3(80, 101, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2)
end--开局搜刮事件
OEVENTLUA[4100] = function() 

	local picid = 566;
	
	instruct_0();
	
	if JY.Base["物品2"] == 234 then
		say("你手里还有介绍信，赶紧先去入门",picid,1,"开局助手");
		
	else
		local title = "是否搜刮减道德的箱子";
		local str = "是：搜刮之后道德为46*否：不搜刮减道德箱子*放弃：不使用自动搜刮功能";
		local btn = {"是","否","放弃"};
		local num = #btn;
		local r = JYMsgBox(title,str,btn,num);
		
		if r == 3 then
			return;
		end
	
	--胡斐居(代码0）：食材10，好逑汤1，小还丹10，白云熊胆丸10
		if GetD(0,1,2) > 0 then
			instruct_2(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(0,1,0,0,0,0,0,0,0,0,0,0,0);
		end
	
		if GetD(0,2,2) > 0 then
			instruct_32(0,10);   --  2(2):得到物品[小还丹][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(0,2,0,0,0,0,0,2468,2468,2468,-2,-2,-2); 
		end
		
		if GetD(0,3,2) > 0 then
			instruct_32(3,10);   --  2(2):得到物品[白云熊胆丸][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(0,3,0,0,0,0,0,2468,2468,2468,-2,-2,-2); 
		end
	
		if GetD(0,5,2) > 0 then
			instruct_32(19,1);   --  2(2):得到物品[好逑汤][1]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(0,5,0,0,0,0,0,2468,2468,2468,-2,-2,-2);
		end
		
	--成昆居(代码9）：食材10，药材50，小还丹10，白云熊胆丸10 
		if GetD(9,8,2) > 0 then
			instruct_3(9,8,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(9,5,2) > 0 then
			instruct_3(9,5,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(209,50);   --  2(2):得到物品[药材][50]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(9,7,2) > 0 then
			instruct_32(0,10);   --  2(2):得到物品[小还丹][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(9,7,0,0,0,0,0,2468,2468,2468,-2,-2,-2);
		end
	
		if GetD(9,6,2) > 0 then
			instruct_32(3,10);   --  2(2):得到物品[白云熊胆丸][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(9,6,0,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--古墓(代码18）：天罗地网掌
		if GetD(18,4,2) > 0 then
			instruct_3(18,4,1,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(264,1);   --  2(2):得到物品[天罗地网掌][1]
			instruct_32(243,1);   --掌套
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--百花谷(代码20）：食材10 
		if GetD(20,15,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(20,15,0,0,0,0,0,0,0,0,0,0,0);
		end
	
	--黑龙潭(代码21）：食材10，呕血谱
		if GetD(21,13,2) > 0 then
			instruct_3(21,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(21,12,2) > 0 then
			instruct_3(21,12,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(213,1);   --  2(2):得到物品[刘仲甫呕血棋谱][1]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--绝情谷(代码22）：银两200，食材10×2，药材50，牛黄血歇丹5，阴阳倒乱刃，九转熊蛇丸1，断肠草
		if GetD(22,1,2) > 0 then
			instruct_3(22,1,1,0,0,0,0,2612,2612,2612,-2,-2,-2); 
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(209,50);   --  2(2):得到物品[药材][50]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(174,200);   --  2(2):得到物品[银两][200]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(22,2,2) > 0 then
			instruct_3(22,2,1,0,0,0,0,2612,2612,2612,-2,-2,-2);   
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(176,1);   --  2(2):得到物品[阴阳倒乱刃][1]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(22,3,2) > 0 then
			instruct_3(22,3,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(10,5);   --  2(2):得到物品[牛黄血蝎丹][5]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(22,4,2) > 0 then
			instruct_3(22,4,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(6,1);   --  2(2):得到物品[九转熊蛇丸][1]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(22,6,2) > 0 then
			instruct_3(22,6,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(22,0,2) > 0 then
			instruct_3(22,0,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(201,1);   --  2(2):得到物品[断肠草][1]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--洪七公居(代码23）：食材10×4，叫花鸡2
		if GetD(23,2,2) > 0 then
			instruct_3(23,2,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(23,3,2) > 0 then
			instruct_3(23,3,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(23,4,2) > 0 then
			instruct_3(23,4,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(23,5,2) > 0 then
			instruct_3(23,5,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(23,9,2) > 0 then
			instruct_3(23,9,1,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(18,2);   --  2(2):得到物品[叫化鸡][2]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--苗人凤居(代码24）：食材10，小还丹10
		if GetD(24,10,2) > 0 then
			instruct_32(0,10);   --  2(2):得到物品[小还丹][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(24,10,0,0,0,0,0,2468,2468,2468,-2,-2,-2);
		end
	
		if GetD(24,13,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(24,13,0,0,0,0,0,0,0,0,0,0,0);
		end
	
	--少林寺(代码28），在厨房有食材25(10+15）
		if GetD(28,84,2) > 0 then
			instruct_3(28,84,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(28,18,2) > 0 and r == 1 then
			instruct_3(28,18,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(210,15);   --  2(2):得到物品[食材][15]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_37(-1);   --  37(25):增加道德-1
		end
	
	--平一指居(代码30）：药材50，食材10，小还丹10，天香续命膏5，白云熊胆丸10，田七鲨胆散5，黄连解毒丸10，牛黄血歇丹5，无常丹3 
		if GetD(30,1,2) > 0 then
			instruct_3(30,1,1,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(7,3);   --  2(2):得到物品[无常丹][3]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(209,50);   --  2(2):得到物品[药材][50]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(30,2,2) > 0 then
			instruct_3(30,2,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(9,10);   --  2(2):得到物品[黄连解毒丸][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(10,5);   --  2(2):得到物品[牛黄血蝎丹][5]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(30,3,2) > 0 then
			instruct_3(30,3,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(3,10);   --  2(2):得到物品[白云熊胆丸][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(4,5);   --  2(2):得到物品[田七鲨胆散][5]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(30,4,2) > 0 then
			instruct_3(30,4,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(0,10);   --  2(2):得到物品[小还丹][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(1,5);   --  2(2):得到物品[天香续命膏][5]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(30,5,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(30,5,0,0,0,0,0,0,0,0,0,0,0);
		end
	
	--牛家村(代码32）：食材10
		if GetD(32,4,2) > 0 then
			instruct_3(32,4,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--峨嵋派(代码33）：食材10
		if GetD(33,28,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(33,28,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--星宿海(代码35）：食材10 ，牛黄血蝎丹5
		if GetD(35,11,2) > 0 then
			instruct_3(35,11,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(10,5);   --  2(2):得到物品[牛黄血蝎丹][5]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--青城派(代码36）：银两200,天香续命膏2 
		if GetD(36,6,2) > 0 and r == 1 then
			instruct_3(36,6,1,0,0,0,0,2608,2608,2608,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(174,200);   --  2(2):得到物品[银两][200]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(1,2);   --  2(2):得到物品[天香续命膏][2]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_37(-1);   --  37(25):增加道德-1
		end
	
	--五毒教(代码37）：食材10，白云熊胆丸10
		if GetD(37,9,2) > 0 then
			instruct_32(3,10);   --  2(2):得到物品[白云熊胆丸][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(37,9,0,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(37,11,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(37,11,0,0,0,0,0,0,0,0,0,0,0);
		end
	
	--恒山山麓(代码38）：大蟠桃1
		if GetD(38,8,2) > 0 then
			instruct_3(38,8,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(15,1);   --  2(2):得到物品[大蟠桃][1]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--洛阳城(代码40）：食材10
		if GetD(40,32,2) > 0 then
			instruct_3(40,32,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--武当派(代码43）：食材10
		if GetD(43,34,2) > 0 then
			instruct_3(43,34,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(43,14,2) > 0 and r == 1 then
			instruct_3(43,14,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_2(8,2);   --  2(2):得到物品[天王保命丹][2]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_37(-1);   --  37(25):增加道德-1
		end
	
	--蝴蝶谷(代码44）：银两200，药材50，食材10，黑玉断续膏2，九转熊蛇丸2
		if GetD(44,3,2) > 0 then
			instruct_3(44,3,1,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(209,50);   --  2(2):得到物品[药材][50]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(174,200);   --  2(2):得到物品[银两][200]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(44,4,2) > 0 then
			instruct_3(44,4,0,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(2,2);   --  2(2):得到物品[黑玉断续膏][2]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(44,5,2) > 0 then
			instruct_3(44,5,0,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(6,2);   --  2(2):得到物品[九转熊蛇丸][2]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(44,6,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(44,6,0,0,0,0,0,0,0,0,0,0,0);
		end
	
	--金蛇山洞(代码46）：银两200，药材50，金蛇锥10
		if GetD(46,8,2) > 0 then
			instruct_3(46,8,1,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(209,50);   --  2(2):得到物品[药材][50]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(174,200);   --  2(2):得到物品[银两][200]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(46,2,2) > 0 then
			instruct_3(46,2,1,0,0,0,0,2608,2608,2608,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(30,10);   --  2(2):得到物品[金蛇锥][10]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--药王庄(代码49）：食材10，药材50，小还丹10，天香续命膏3，黑玉断续膏1，白云熊胆丸10，田七鲨胆散3，九花玉露丸2，九转熊蛇丸1，牛黄血歇丹3 
		if GetD(49,3,2) > 0 then
			instruct_3(49,3,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(0,10);   --  2(2):得到物品[小还丹][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(1,3);   --  2(2):得到物品[天香续命膏][3]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(2,1);   --  2(2):得到物品[黑玉断续膏][1]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(3,10);   --  2(2):得到物品[白云熊胆丸][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(4,3);   --  2(2):得到物品[田七鲨胆散][3]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(5,2);   --  2(2):得到物品[九花玉露丸][2]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(6,1);   --  2(2):得到物品[九转熊蛇丸][1]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(10,3);   --  2(2):得到物品[牛黄血蝎丹][3]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(209,50);   --  2(2):得到物品[药材][50]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(49,4,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(49,4,0,0,0,0,0,0,0,0,0,0,0);
		end
	
	--阎基居(代码50）：食材10，药材20，小还丹15，天香续命膏3，田七鲨胆散3，天王保命丹1
		if GetD(50,2,2) > 0 then
			instruct_3(50,2,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(0,10);   --  2(2):得到物品[小还丹][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(209,20);   --  2(2):得到物品[药材][20]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(50,3,2) > 0 then
			instruct_3(50,3,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(1,3);   --  2(2):得到物品[天香续命膏][3]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(4,3);   --  2(2):得到物品[田七鲨胆散][3]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(50,4,2) > 0 then
			instruct_3(50,4,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(8,1);   --  2(2):得到物品[天王保命丹][1]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(0,5);   --  2(2):得到物品[小还丹][5]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(50,9,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(50,9,0,0,0,0,0,0,0,0,0,0,0);
		end
	
	--聚贤庄(代码54）：食材10×2，药材50，小还丹10，天香续命膏3，黑玉断续膏1，白云熊胆丸10，田七鲨胆散3，九花玉露丸2，九转熊蛇丸1，牛黄血歇丹3
		if GetD(54,1,2) > 0 then
			instruct_3(54,1,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(0,10);   --  2(2):得到物品[小还丹][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(1,3);   --  2(2):得到物品[天香续命膏][3]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(2,1);   --  2(2):得到物品[黑玉断续膏][1]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(3,10);   --  2(2):得到物品[白云熊胆丸][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(4,3);   --  2(2):得到物品[田七鲨胆散][3]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(5,2);   --  2(2):得到物品[九花玉露丸][2]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(6,1);   --  2(2):得到物品[九转熊蛇丸][1]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(10,3);   --  2(2):得到物品[牛黄血蝎丹][3]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(209,50);   --  2(2):得到物品[药材][50]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(54,33,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(54,33,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
		if GetD(54,34,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(54,34,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--福威镖局(代码56）：银两200，小还丹3
		if GetD(56,4,2) > 0 then
			instruct_3(56,4,1,0,0,0,0,2608,2608,2608,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(174,200);   --  2(2):得到物品[银两][200]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(0,3);   --  2(2):得到物品[小还丹][3]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--金龙帮(代码59）：食材10×2
		if GetD(59,31,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(59,31,0,0,0,0,0,0,0,0,0,0,0);
		end 
	
		if GetD(59,32,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(59,32,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--龙门客栈(代码60）：食材10
		if GetD(60,11,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(60,11,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--田伯光居(代码64）：银两100，食材10，飞蝗石10
		if GetD(64,1,2) > 0 then
			instruct_3(64,1,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(174,100);   --  2(2):得到物品[银两][100]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(28,10);   --  2(2):得到物品[飞蝗石][10]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(64,3,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(64,3,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--山洞(代码65）：食材10
		if GetD(65,4,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(65,4,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--昆仑派(代码68）：食材10 
		if GetD(68,30,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(68,30,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--灵蛇岛(代码73）：食材10，小还丹5，黄连解毒丸3 
		if GetD(73,8,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(73,8,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
		if GetD(73,3,2) > 0 then
			instruct_3(73,3,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(0,5);   --  2(2):得到物品[小还丹][5]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(9,3);   --  2(2):得到物品[黄连解毒丸][3]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--桃花岛(代码75）：食神秘籍
		if GetD(75,44,2) > 0 then
			instruct_3(75,44,1,0,0,0,0,2608,2608,2608,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(220,1);   --  2(2):得到物品[食神秘笈][1]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--台湾(代码76）：飞蝗石10，银两500，食材10 ，小还丹10，白云熊胆丸3
		if GetD(76,3,2) > 0 then
			instruct_3(76,3,-2,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(0,10);   --  2(2):得到物品[小还丹][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(3,3);   --  2(2):得到物品[白云熊胆丸][3]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(76,4,2) > 0 and r == 1 then
			instruct_3(76,4,-2,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(28,10);   --  2(2):得到物品[飞蝗石][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(174,500);   --  2(2):得到物品[银两][500]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_37(-1);   --  37(25):增加道德-1
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(76,6,2) > 0 then
			instruct_3(76,6,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--渤泥岛(代码78）：食材10×2
		if GetD(78,1,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(78,1,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
		if GetD(78,2,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(78,2,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--朱府(代码92）：翡翠杯
		if GetD(92,17,2) > 0 then
			instruct_3(92,17,1,0,0,0,0,2608,2608,2608,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(194,1);   --  2(2):得到物品[翡翠杯][1]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--长乐帮(代码94）：食材10×2 
		if GetD(94,12,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(94,12,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
		if GetD(94,13,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(94,13,0,0,0,0,0,0,0,0,0,0,0);
		end 
	
	--大功坊(代码95）：药材100，天山雪莲1
		if GetD(95,15,2) > 0 then
			instruct_3(95,15,1,0,0,0,0,2608,2608,2608,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(17,1);   --  2(2):得到物品[天山雪莲][1]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(209,100);   --  2(2):得到物品[药材][100]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--五仙教(代码96）：食材10
		if GetD(96,14,2) > 0 then
			instruct_32(210,10);   --  2(2):得到物品[食材][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(96,14,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--紫烟岛(代码97）：金乌刀法
		if GetD(97,1,2) > 0 then
			instruct_3(97,1,1,0,0,0,0,3500,3500,3500,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(141,1);   --  2(2):得到物品[金乌刀法][1]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--明霞岛(代码98）：千年灵芝2，小还丹10，白云熊胆丸3，大燕传国玉玺
		if GetD(98,9,2) > 0 then
			instruct_3(98,9,1,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(196,1);   --  2(2):得到物品[大燕传国玉玺][1]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(98,10,2) > 0 then
			instruct_3(98,10,-2,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(0,10);   --  2(2):得到物品[小还丹][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(3,3);   --  2(2):得到物品[白云熊胆丸][3]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		if GetD(98,11,2) > 0 then
			instruct_3(98,11,0,0,0,0,0,2608,2608,2608,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(14,2);   --  2(2):得到物品[千年灵芝][2]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
	--老祖居(代码102）：小还丹10 
		if GetD(102,10,2) > 0 then
			instruct_32(0,10);   --  2(2):得到物品[小还丹][10]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(102,10,0,0,0,0,0,2468,2468,2468,-2,-2,-2);
		end
	
	--药王庙(代码103）：广陵散
		if GetD(103,10,2) > 0 then
			instruct_3(103,10,1,0,0,0,0,6698,6698,6698,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_32(212,1);   --  2(2):得到物品[广陵散琴曲][1]
			instruct_0();   --  0(0)::空语句(清屏)
		end
	
		say("好了，不要再问我话了，我是木头人",picid,1,"开局助手");
		instruct_3(-2,-2,1,0,0,0,0,2568,2568,2568,0,0,0);
	end
end

--破庙103，与宝象的对话事件
OEVENTLUA[8001] = function()
	
	--定义临时宝象数据
	local pid = 9999;				--定义一个临时的心魔人物数据
	JY.Person[pid] = {};
	for i=1, #PSX-8 do
		JY.Person[pid][PSX[i]] = JY.Person[160][PSX[i]];
	end
	JY.Person[pid]["姓名"] = "宝象";
	JY.Person[pid]["生命最大值"] = math.modf(JY.Person[pid]["生命最大值"]/2);
	JY.Person[pid]["生命"] = JY.Person[pid]["生命最大值"];
	JY.Person[pid]["内力最大值"] = math.modf(JY.Person[pid]["内力最大值"]/2);
	JY.Person[pid]["内力"] = JY.Person[pid]["内力最大值"];
	JY.Person[pid]["轻功"] = math.modf(JY.Person[pid]["轻功"]/2);
	JY.Person[pid]["武功1"] = 63;
	
	MyTalk(CC.LTalk1,9999);		--[宝象]：妈巴羔子的，这破地方，甚么都没有，饿死老子了。
	if not inteam(37) then	--如果队伍没有狄云，则直接退出
		return;
	end
	MyTalk(CC.LTalk2,9999);		--[宝象]：你是谁？妈巴羔子的，贼王八蛋！
	Talk(CC.LTalk3,0);		--[主角]：〈这人虽作和尚打扮，但却污言秽语，多半是个凶悍之徒。〉
	Talk(CC.LTalk4,0);		--[主角]：在下只是途经此地，并无恶意。
	MyTalk(CC.LTalk5,9999);	--[宝象]：癞痢头阿三，你去给我找些吃的东西来，大师父重重有赏，有没有肥猪？
	Talk(CC.LTalk6,0);		--[主角]：这破庙荒山野岭没肥猪……〈这和尚，居然还杀生吃肉，定为恶人无疑〉
	MyTalk(CC.LTalk7,9999);	--[宝象]：喂，叫你去找些吃的东西来，嘀咕嘀咕想干甚么。你不听话，瞧佛爷不要了你的狗命？
	Talk(CC.LTalk8,0);		--[主角]：〈欺人太甚，是否教训他〉   
  instruct_0();   --  0(0)::空语句(清屏)

  if instruct_5() ==true then    --  5(5):是否选择战斗？
  
  	SetS(86, 10, 10, 5, 1);		--判断把战斗137的人物编号换成160
  	
  	Talk(CC.LTalk9,0);	--[主角]：你这和尚真是毫不讲理。
  	MyTalk(CC.LTalk10,9999);		--[宝象]：哈哈，好极，好极！老子不仅喜欢不讲理，还喜欢吃人肉。你这肌肉，吃起来一定很美味。
  	Talk(CC.LTalk11,0);		--[主角]：恶和尚，受死！
		
		if WarMain(137) == false then			
			instruct_15();			--战斗失败，死亡
			return;
		end
		
		instruct_3(-2,80,0,0,0,0,0,0,0,0,0,0,0);		--清除宝象的贴图
	
		Talk(CC.LTalk12,0);	--[主角]：这恶僧果然有些门道，难怪敢如此嚣张。但是今日幸遇上我，也算是替天行道。
		Talk(CC.LTalk13,0);	--[主角]：这边似乎还留有一些东西
		instruct_2(174,200);	--获取银两200
		instruct_0();   --  0(0)::空语句(清屏)
		
		Talk(CC.LTalk14,37);	--[狄云]：这衣服怪丢了可惜，比我这身好，还是留给我吧。
		Talk(CC.LTalk15,0);		--[主角]：的确比你这光着身子的好
		Talk(CC.LTalk16,37);	--[狄云]：呵呵。多谢丁大哥。不，不是丁大哥。
		instruct_0();   --  0(0)::空语句(清屏)
		
		
		SetS(86, 10, 10, 5, 0);		--把战斗判断还原
		
		instruct_3(60,80,0,0,0,0,8002,0,0,0,0,0,0);		--修改龙门客栈门口路过事件
		instruct_3(60,81,0,0,0,0,8002,0,0,0,0,0,0);
  end
end

--龙门客栈60，新增路过事件
OEVENTLUA[8002] = function()
	if not inteam(37) then			--队伍中没有狄云，不触发
		return;
	end
	
	instruct_3(-2,82,1,0,0,0,0,9220,9220,9220,0,0,0);			--水笙贴图
	instruct_3(-2,83,1,0,0,0,0,8902,8902,8902,0,0,0);			--汪啸风贴图
	
	Talk(CC.LTalk17,589);	--[水笙]：他……他是西藏青教的……的……血刀恶僧。
	TalkEx(CC.LTalk18,234,0);		--[汪啸风]：不错，血刀淫僧。
	Talk(CC.LTalk19,589);	--[水笙]：恶人，哼，滚你的罢！
	Talk(CC.LTalk20,37);	--[狄云]：姑娘你说甚么？
	Talk(CC.LTalk21,589);	--[水笙]：你……你……你别走近我，滚开。
	Talk(CC.LTalk22,37);	--[狄云]：你……你干么打我？
	Talk(CC.LTalk23,589);	--[水笙]：滚开啊
	Talk(CC.LTalk24,0);		--[主角]：姑娘这其中是不是有什么误会。
	Talk(CC.LTalk25,589);		--[水笙]：哼，和血刀恶僧在一起的也不是什么好人，师兄我们走！
	instruct_0();   --  0(0)::空语句(清屏)
	
	instruct_14();
	instruct_3(-2,82,0,0,0,0,0,0,0,0,0,0,0);			--清除水笙贴图
	instruct_3(-2,83,0,0,0,0,0,0,0,0,0,0,0);			--清除汪啸风贴图
	instruct_13();
	

	
	Talk(CC.LTalk26,0);		--[主角]：好生奇怪的姑娘
	Talk(CC.LTalk27,37);		--[狄云]：我跟他二人无冤无仇，没半点地方得罪了他们，正说得好好地，干么忽然对我如此凶恶？
	Talk(CC.LTalk28,0);		--[主角]：狄兄弟算了吧，或许是这姑娘一时的急性子。
	Talk(CC.LTalk29,37);		--[狄云]：〈我就是这么蠢，倘若丁大哥在世，就算不能助我，也必能给我解说这中间的道理。〉
	instruct_0();   --  0(0)::空语句(清屏)
	
	if JY.Base["人X1"] == 24 then			--两个触发地方的移动方式不一样
		instruct_30(-1,9,0,0);
		instruct_30(-5,1,0,0);
	else
		instruct_30(0,9,0,0);
		instruct_30(-5,1,0,0);
	end
	
	instruct_3(-2,80,0,0,0,0,0,0,0,0,0,0,0);		--修改客栈门口事件
	instruct_3(-2,81,0,0,0,0,0,0,0,0,0,0,0);		--修改客栈门口事件
	
	
		
	instruct_14();
	instruct_3(-2,85,1,0,0,0,0,9222,9222,9222,0,0,0);			--水笙贴图
	instruct_3(-2,86,1,0,0,0,0,8904,8904,8904,0,0,0);			--汪啸风贴图
	instruct_13();
	
	
	instruct_25(4,-15,0,0);		--场景移动
	Talk(CC.LTalk30,589);		--[水笙]：采花淫贼，赶快出来受死
	instruct_25(-4,15,0,0);
	instruct_0();   --  0(0)::空语句(清屏)
	
	Talk(CC.LTalk31,0);		--[主角]：狄兄弟，那姑娘又回来了，不知道想做什么。我们出去看看吧
	Talk(CC.LTalk32,37);	--[狄云]：嗯，若不说个清楚，忌不冤枉？
	instruct_0();   --  0(0)::空语句(清屏)
	
	
	instruct_30(0,-1,0,0);			--走出客栈门口
	instruct_30(5,-11,0,0);
	
	instruct_14();
	instruct_3(-2,84,1,0,0,0,0,9226,9226,9226,0,0,0);			--狄云贴图
	instruct_13();
	
	Talk(CC.LTalk33,589);		--[水笙]：可算出来了，有人指认你奸杀官家小姐，早知道刚才就应该杀了你。原来你……你竟这么坏。
	Talk(CC.LTalk34,37);		--[狄云]：我不是采花淫贼
	TalkEx(CC.LTalk35,234,0);	--[汪啸风]：淫僧，你在两湖做下了这许多案子，还想活命不成！
	Talk(CC.LTalk36,589);		--[水笙]：师兄，杀了这淫贼！
	Talk(CC.LTalk37,37);	--[狄云]：我不是。〈我命中注定要给人冤枉，那也无法可想。〉
	Talk(CC.LTalk38,97);	--[血刀老祖]：手下留人，休得伤他性命。
	instruct_0();   --  0(0)::空语句(清屏)
	
	instruct_14();
	instruct_3(-2,87,1,0,0,0,0,8746,8746,8746,0,0,0);			--血刀老祖贴图
	instruct_13();
	
	Talk(CC.LTalk39,97);	--[血刀老祖]：徒儿退下，让老祖我来会会他。
	Talk(CC.LTalk40,0);		--[主角]：〈这老僧好生厉害〉
	TalkEx(CC.LTalk41,234,0);		--[汪啸风]：表妹，快走！
	Talk(CC.LTalk42,97);	--[血刀老祖]：想走？
	
	instruct_3(-2,85,1,0,0,0,0,0,0,0,0,0,0);			--水笙贴图
	instruct_3(-2,88,1,0,0,0,0,9220,9220,9220,0,0,0);			--水笙贴图
	
	Talk(CC.LTalk43,97);	--[血刀老祖]：好美的姑娘，哈哈！很标致，了不起！老和尚艳福不浅。
	TalkEx(CC.LTalk44,234,0);		--[汪啸风]：表妹，表妹！啊！！
	
	instruct_14();
	instruct_3(-2,88,0,0,0,0,0,0,0,0,0,0,0);			--清除水笙贴图
	instruct_3(-2,86,0,0,0,0,0,0,0,0,0,0,0);			--清除汪啸风贴图
	instruct_3(-2,84,0,0,0,0,0,0,0,0,0,0,0);			--清除狄云贴图
	instruct_3(-2,87,0,0,0,0,0,0,0,0,0,0,0);			--清除血刀老祖贴图
	
	instruct_3(2,81,1,0,0,0,0,9224,9224,9224,0,0,0);		--修改雪山水笙贴图
	instruct_3(2,80,1,0,0,0,0,9228,9228,9228,0,0,0);		--修改雪山狄云贴图
	instruct_13();
	
	Talk(CC.LTalk45,0);		--主角：〈糟糕，狄兄弟也被掳走了。似乎往雪山方向走了〉
	instruct_21(37);		--狄云离队
	instruct_0();   --  0(0)::空语句(清屏)
	
	SetS(86, 9, 10, 5, 1);		--判断触发雪山事件
	
end

--雪山杀老祖之后，狄云加入事件
OEVENTLUA[8003] = function()
	
	if not instruct_9() then	--是否加入
		return;
	end
	
	Talk(CC.LTalk58,0);		--[主角]：狄兄弟，我们走吧。
	if instruct_20() then		--是否满人
		Talk(CC.LTalk60, 37);		--[狄云]：你现在的队伍已经满人了。
		return;
	end
	
	instruct_10(37);		--加入狄云
	Talk(CC.LTalk59,589);	--[水笙]：我也想跟着狄大哥。
	
	instruct_14();
	instruct_3(-2,81,0,0,0,0,0,0,0,0,0,0,0);			--清除水笙贴图
	instruct_3(-2,80,0,0,0,0,0,0,0,0,0,0,0);			--清除狄云贴图
	
	instruct_3(70,80,1,0,8006,0,0,9220,9220,9220,0,0,0);		--水笙暂时没想到用法，先直接回小村
	instruct_13();
	
	
end

--新增遇到戚长发的事件
OEVENTLUA[8004] = function()


	--先把风清扬(140) 代替戚长发，加强能力，武功改成连城剑法
	local pid = 9999;				--定义一个临时的戚长发数据
	JY.Person[pid] = {};
	for i=1, #PSX-8 do
		JY.Person[pid][PSX[i]] = JY.Person[140][PSX[i]];
	end
	JY.Person[pid]["姓名"] = "戚长发";
	JY.Person[pid]["内力最大值"] = JY.Person[pid]["内力最大值"];
	JY.Person[pid]["内力"] = JY.Person[pid]["内力最大值"];
	JY.Person[pid]["轻功"] = 250
	JY.Person[pid]["攻击力"] = 350
	JY.Person[pid]["防御力"] = 300

	JY.Person[pid]["武功1"] = 114;
	JY.Person[pid]["武功等级1"] = 999;
	JY.Person[pid]["武功2"] = 0;
	SetS(86, 10, 10, 5, 2);		--判断把战斗137的人物编号换成9999
	
	instruct_25(2,-5,0,0);

	MyTalk(CC.LTalk70, 9999);		--[戚长发]：不枉我装死，隐姓埋名这么辛苦。连城诀最终还是我的，哈哈哈哈~~~
	TalkEx(CC.LTalk71, 37, 1);		--[狄云]：师父，原来你没有死！
	MyTalk(CC.LTalk72, 9999);		--[戚长发]：云儿，是你。赶紧把连城诀交出来，饶你们不死。
	TalkEx(CC.LTalk73, 37, 1);		--[狄云]：师父，你怎么
	Talk(CC.LTalk74, 0);		--[主角]：这连城诀已经有主人了
	MyTalk(CC.LTalk75, 9999);		--[戚长发]：找死！
	
	if WarMain(137) == false then
		instruct_15();			--战斗失败，死亡
		return;
	end
	
	
	MyTalk(CC.LTalk76, 9999);		--[戚长发]：不！！！*连城诀是我的，是我的！！啊~~~~
	
	instruct_14();
	instruct_3(-2,80,0,0,0,0,0,0,0,0,0,0,0);		--清除戚长发贴图
	instruct_13();
	
	TalkEx(CC.LTalk77, 37, 1);		--[狄云]：师父.......
	Talk(CC.LTalk78, 0);		--[主角]：狄兄弟，算了，你师父已经不是以前的师父......
	
	
	instruct_3(-2,81,0,0,0,0,0,0,0,0,0,0,0);		--清除路过事件
	
	SetS(86, 10, 10, 5, 0);		--把战斗判断还原
		
	
end--水笙离队事件

OEVENTLUA[8005] = function()


    Talk("水姑娘，你先回小村，有需*要时，我再去找你帮忙。",0);

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_21(589);   --  21(15):水笙离队
    instruct_3(70,80,1,0,8006,0,0,9220,9220,9220,0,0,0);		--水笙暂时没想到用法，先直接回小村
end


--水笙入队事件
OEVENTLUA[8006] = function()
		
    MyTalk("有需要我帮忙的地方吗？", 589);
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_9() then    --  9(9):是否要求加入?否则跳转到:Label0

        if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label1
            instruct_10(589);   --  10(A):加入人物水笙
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
        end    --:Label1

				MyTalk("你的队伍已满，我无法加入。", 589);
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0

end


--药炉练药
OEVENTLUA[8008] = function()
	local drupsNum = 0;		--药材数量
	for i = 1, CC.MyThingNum do
		if JY.Base["物品" .. i] == 209 then
			drupsNum = JY.Base["物品数量" .. i];
			break;
		end
	end
	
	local drups = {0,1,2,3,4,5,6,7,9,10,11};--可炼出的药品编号
	local need = {2,8,15,3,8,12,15,13,5,8,12};--需要的药材数量
	local drupsName = {};
	for i=1, #drups do
		drupsName[i] = JY.Thing[drups[i]]["名称"];
	end
	local title = "药炉";
	local str = string.format("当前药材总数量为：%d*点击“炼药”开始选择炼制的药品*点击“炼体”可以增加修为*如果药材数量不足，将无法炼成", drupsNum);
	local btn = {"炼药","炼体","关闭"};
	local num = #btn;
	local r = JYMsgBox(title,str,btn,num);
	if r == 1 then
		local x1 = CC.ScreenW/2 - 180 ;
		local y1 = 50;
		DrawStrBox(x1, y1+40, "药品名称   需药材  药材总量："..drupsNum,C_WHITE, CC.DefaultFont);
		local menu = {}
		for i=1, #drups do 
			menu[i] = {string.format("%-12s %4d",drupsName[i],need[i]),nil,1};
		end
		
		local numItem = table.getn(menu);
		local size = CC.DefaultFont;
		local r = ShowMenu(menu,numItem,0,x1,y1+80,0,0,1,1,size,C_ORANGE,C_WHITE);
		
		if r > 0 then
			Cls();
			local T = {}
	    for a = 0, 1000 do
	      local b = "" .. a
	      T[b] = a
	    end
	    local n = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
	    if T[n] == 0 or n == "" then
	    	return;
	    end
	    if T[n] ~= nil and T[n] > -1 then
	      if T[n] * need[r] <= drupsNum then
					instruct_2(drups[r],T[n]);
					instruct_2(209,-T[n] * need[r]);
				else
					DrawStrBoxWaitKey("对不起，炼制所需的药材超过了药材总量!", C_WHITE, 30)
	      end
	    else
	    	DrawStrBoxWaitKey("对不起，您输入的数量不正确!", C_WHITE, 30)
	    end
		end
	elseif r==2 then
	local pd = 4
	if GetS(111,2,0,0) > pd then
	say("是药三分毒，可要节制！")
			do return end
	end
	local money = 100 --math.random(5) * 19
	local head = math.random(350, 575)
	Cls()
	say("秘制灵丹可增进修为。要"..money.."药材。是否炼体？",head)
	Cls()
	if DrawStrBoxYesNo(-1, -1, "要炼体么？", C_WHITE, 30) == false then	
		say("算了！")	
		do return end
	end
	Cls()
	if drupsNum < money then
		say("药材不够啊！")
		do return end
	end
	Cls()
	say("要得！")	
	instruct_2(209, -money)
	--[[
	Cls()
	QZXS(changeattrib(0, "攻击力", 0))
	Cls()
	QZXS(changeattrib(0, "轻功", 0))
	Cls()
	QZXS(changeattrib(0, "防御力", 0))
	]]
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "要增强什么能力？", C_WHITE, CC.DefaultFont)
	local menu2 = {{"攻击力",nil,1}, {"轻功",nil,2}, {"防御力",nil,3}}
	local r2 = ShowMenu(menu2,#menu2,15,85,55,0,0,1,1,CC.DefaultFont,C_ORANGE, C_WHITE);
	if r2 == 1 then
		JY.Person[0]["攻击力"] = JY.Person[0]["攻击力"] + 15
	elseif r2 == 2 then
		JY.Person[0]["轻功"] = JY.Person[0]["轻功"] + 15
	else
		JY.Person[0]["防御力"] = JY.Person[0]["防御力"] + 15
	end
	QZXS(JY.Person[0]["姓名"].."的"..menu2[r2][1].."增加15点")
	SetS(111,2,0,0,GetS(111,2,0,0)+1)
	end
end--药炉练药
OEVENTLUA[8009] = function()
	local foodNum = 0;		--食材数量
	for i = 1, CC.MyThingNum do
		if JY.Base["物品" .. i] == 210 then
			foodNum = JY.Base["物品数量" .. i];
			break;
		elseif JY.Base["物品" .. i] < 0 then
			break;
		end
	end
	
	local food = {18,19,20,21};		--可做出的菜
	local drink = {22,23,24,25};		--可做出的酒
	local need = {5,10,15,25};			--需要的食材数量，是一样的
	
	local foodName = {};		--菜名称
	for i=1, #food do
		foodName[i] = JY.Thing[food[i]]["名称"];
	end
	
	local drinkName = {};		--酒名称
	for i=1, #drink do
		drinkName[i] = JY.Thing[drink[i]]["名称"];
	end
	
	
	local title = "厨灶";
	local str = string.format("当前食材总数量为：%d*点击“做菜”开始选择做的菜*点击“做酒”开始选择做的酒*如果食材数量不足，将无法做成", foodNum);
	local btn = {"做菜","做酒","关闭"};
	local num = #btn;
	local r = JYMsgBox(title,str,btn,num);


	if r == 1  then		--做菜
		local x1 = CC.ScreenW/2 - 180 ;
		local y1 = 50;
		DrawStrBox(x1, y1+40, "菜名称   需食材  食材总量："..foodNum,C_WHITE, CC.DefaultFont);
		local menu = {}
		for i=1, #food do 
			menu[i] = {string.format("%-12s %4d",foodName[i],need[i]),nil,1};
		end
		
		local numItem = table.getn(menu);
		local size = CC.DefaultFont;
		local r = ShowMenu(menu,numItem,0,x1,y1+80,0,0,1,1,size,C_ORANGE,C_WHITE);
		
		if r > 0 then
			Cls();
			local T = {}
	    for a = 0, 1000 do
	      local b = "" .. a
	      T[b] = a
	    end
	    local n = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
	    if T[n] == 0 or n == "" then
	    	return;
	    end
	    if T[n] ~= nil and T[n] > -1 then
	      if T[n] * need[r] <= foodNum then
					instruct_2(food[r],T[n]);
					instruct_2(210,-T[n] * need[r]);
				else
					DrawStrBoxWaitKey("对不起，做菜所需的食材超过了食材总量!", C_WHITE, 30)
	      end
	    else
	    	DrawStrBoxWaitKey("对不起，您输入的数量不正确!", C_WHITE, 30)
	    end
		end
	elseif r == 2  then		--做酒
		local x1 = CC.ScreenW/2 - 180 ;
		local y1 = 50;
		DrawStrBox(x1, y1+40, "酒名称   需食材  食材总量："..foodNum,C_WHITE, CC.DefaultFont);
		local menu = {}
		for i=1, #drink do 
			menu[i] = {drinkName[i].."    "..need[i].."           ",nil,1};
		end
		
		local numItem = table.getn(menu);
		local size = CC.DefaultFont;
		local r = ShowMenu(menu,numItem,0,x1,y1+80,0,0,1,1,size,C_ORANGE,C_WHITE);
		
		if r > 0 then
			Cls();
			local T = {}
	    for a = 0, 1000 do
	      local b = "" .. a
	      T[b] = a
	    end
	    local n = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
	    if T[n] == 0 or n == "" then
	    	return;
	    end
	    if T[n] ~= nil and T[n] > -1 then
	      if T[n] * need[r] <= foodNum then
					instruct_2(drink[r],T[n]);
					instruct_2(210,-T[n] * need[r]);
				else
					DrawStrBoxWaitKey("对不起，做酒所需的食材超过了食材总量!", C_WHITE, 30)
	      end
	    else
	    	DrawStrBoxWaitKey("对不起，您输入的数量不正确!", C_WHITE, 30)
	    end
		end
	end

end--李文秀离队事件

OEVENTLUA[8650] = function()


    Talk("李姑娘，你先回小村，有需*要时，我再去找你帮忙。",0);

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_21(590);   --  21(15):李文秀离队
    instruct_3(70,86,1,0,8651,0,0,6804,6804,6804,0,0,0);
end

--李文秀入队事件
OEVENTLUA[8651] = function()
		
    MyTalk("有需要我帮忙的地方吗？", 590);
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_9() then    --  9(9):是否要求加入?否则跳转到:Label0

        if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label1
            instruct_10(590);   --  10(A):加入人物李文秀
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
        end    --:Label1

				MyTalk("你的队伍已满，我无法加入。", 590);
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0

end

--小村 百事通
OEVENTLUA[8007] = function()
	if JY.Person[585]["等级"] == 30 and JY.Person[617]["等级"] < 30 then
		say("听说你连曾经天下无双的二宫都敢挑战，果然是非凡人物。", 232, 1, "百事通");
		say("其实在你之前，也有一位少年惊才绝艳，武功盖世，你要不要和他较量较量？。", 232, 1, "百事通");
		if DrawStrBoxYesNo(-1, -1, "是否与之过招？", C_WHITE, 30) == false then
			say("是吗？可惜，可惜。", 232, 1, "百事通");
		else
			CC.DYRW = 0
			CC.DYRW2 = 617
			say("百年往昔神来技，今朝再现绝世姿。怡红公子特来一会"..gettitle(0), 540, 1, "春风醉");
			if WarMain(341) then 
				addHZ(140)
			end
			say("英雄出少年！平生得见如斯盛景，幸甚，幸甚，呵呵呵。", 232, 1, "百事通");
		end
		JY.Person[617]["等级"] = 30
		do return end
	end
	say("别看我这样，其实我年轻的时候也帅。找我什么事，说吧。", 232, 1, "百事通");

	local title = "百事通功能";
	local str = "传送：你想去哪咱送你一程。"
						.."*挑战：惊险刺激的挑战，等着你！"
						.."*说明：查看各种装备，内功和外功的说明。"
						.."*练功：进入练功房，经验是双儿那的两倍哦。"
						.."*任务：接受并完全任务，会有相应奖励。"
						.."*升级：提升人物等级。"
						.."*修炼：提升武功秘籍。"
						.."*放弃：不使用百事通功能"
	local btn = {"传送","挑战","说明","练功","任务","升级","修炼", "放弃"};
	local num = #btn;
	local r = JYMsgBox(title,str,btn,num);

	if r == 1 then
		My_ChuangSong_Ex();
	elseif r == 2 then
		Fight();
	elseif r == 3 then
		--ZBInstruce();
		introduction()
	elseif r == 4 then
		LianGong();
	elseif r == 5 then
		DYRW();
	elseif r == 6 then
        DUIYOUSHENGJI()
	elseif r == 7 then
    for i = 1, CC.TeamNum do                 
        local id = JY.Base["队伍" .. i];
		if id >= 0 then
			JY.Person[id]["修炼点数"] = 30000
			War_PersonTrainBook(id)
			--JY.Person[id]["经验"] = 52000
			--War_AddPersonLVUP(id);		
		end
    end
	end
end

--brolycjw神雕剧情
--古墓
OEVENTLUA[8201] = function()
	Talk(CC.BTalk26,0);
	Talk(CC.BTalk27,58);
	if instruct_16(16)  then
		Talk(CC.BTalk28,16);
		Talk(CC.BTalk29,16);
		Talk(CC.BTalk30,59);
		Talk(CC.BTalk31,16);
		Talk(CC.BTalk32,59);
		Talk(CC.BTalk33,16);
		Talk(CC.BTalk34,0);
		Talk(CC.BTalk35,58);
		Talk(CC.BTalk36,59);
		Talk(CC.BTalk37,58);
		Talk(CC.BTalk38,59);
		Talk(CC.BTalk39,0);
		instruct_14();   --  14(E):场景变黑
		instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		--小龙女死亡
		instruct_2(153,1);   --  2(2):得到物品[神鵰侠侣][1]
		Talk(CC.BTalk40,58);
		Talk(CC.BTalk41,0);
		Talk(CC.BTalk42,58);
		Talk(CC.BTalk43,0);
		Talk(CC.BTalk44,58);
		Talk(CC.BTalk45,0);
		Talk(CC.BTalk46,58);
		Talk(CC.BTalk47,0);
		Talk(CC.BTalk48,58);
		instruct_14();   --  14(E):场景变黑
		SetS(18,44,30,3,10)
		SetS(18,44,31,3,11)
		instruct_3(-2,10,0,0,0,0,8203,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
		instruct_3(-2,11,0,0,0,0,8203,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
		instruct_3(-2,0,1,0,8202,0,0,6188,6188,6188,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
	else
		Talk(CC.BTalk62,0);
		Talk(CC.BTalk63,58);
		Talk(CC.BTalk64,58);
		Talk(CC.BTalk65,0);
		Talk(CC.BTalk66,58);
		Talk(CC.BTalk67,0);
		Talk(CC.BTalk68,59);
		Talk(CC.BTalk69,58);
		Talk(CC.BTalk70,59);
		--杨过死亡
		instruct_14();   --  14(E):场景变黑
		instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		Talk(CC.BTalk71,0);
		Talk(CC.BTalk72,59);
		Talk(CC.BTalk73,0);
		Talk(CC.BTalk74,59);
		Talk(CC.BTalk75,0);
		Talk(CC.BTalk76,59);
		Talk(CC.BTalk77,0);
		Talk(CC.BTalk78,59);
		Talk(CC.BTalk79,0);
		SetS(18,14,17,3,12)
		instruct_3(-2,12,1,0,8207,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
			if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label2
				instruct_10(59);   --  10(A):加入人物[小龙女]
				instruct_14();   --  14(E):场景变黑
				instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
				instruct_3(104,76,1,0,970,0,0,7242,7242,7242,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [76]
				instruct_3(61,14,1,0,8205,0,0,8010,8010,8010,-2,-2,-2);   --  3(3):修改事件定义:场景[高升客栈]:场景事件编号 [61]
				instruct_0();   --  0(0)::空语句(清屏)
				instruct_13();   --  13(D):重新显示场景
				do return; end
			end    --:Label2

			instruct_1(391,59,0);   --  1(1):[小龙女]说: 你的队伍已满，我无法加入。
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_3(-2,1,1,0,8206,0,0,6068,6068,6068,-2,-2,-2);   --  3(3):修改事件定义:场景[古墓]:场景事件编号 [1]
			do return; end
	end
end

OEVENTLUA[8202] = function() --杨过对话
	Talk(CC.BTalk48a,58);
end

OEVENTLUA[8203] = function()
	if instruct_18(84) then
		SetS(18,22,22,3,12)
		SetS(18,22,23,3,13)
		SetS(18,15,20,3,14)
		instruct_3(-2,12,0,0,0,0,8204,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
		instruct_3(-2,13,0,0,0,0,8204,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
		instruct_3(-2,14,0,0,0,0,0,7108,7108,7108,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
		instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
		instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
	end
end

OEVENTLUA[8204] = function() --法王攻击古墓事件
	
	Talk(CC.BTalk49,62);
	Talk(CC.BTalk50,58);
	Talk(CC.BTalk51,62);
	Talk(CC.BTalk52,0);
	--战斗
	if instruct_6(244,4,0,0) ==false then    --  6(6):战斗[74]是则跳转到:Label2
		instruct_15(0);   --  15(F):战斗失败，死亡
		instruct_0();   --  0(0)::空语句(清屏)
		do return; end
	end    
	if GetS(113, 0, 0, 0) == 0 then
		say("嗯？这本是...无上大力杵？",0) 
		say("感觉跟我的武功路子挺合的啊...",0)
		say("势大力沉、简单粗暴，我喜欢！要不要学呢？",0)
		instruct_0();
		if instruct_11(0,188) == true then
			QZXS("领悟无上大力杵真传！")
			instruct_0();
			say("哈哈！原来刚刚那藏人根本没用出精髓来，倒让我获益匪浅！",0) 
			setLW1(83)
			addthing(170)
		else
			say("但变成莽夫形象...还是算了",0) 
		end
	end
		
	--[[ if GetS(113,0,0,0) == 0 and JY.Person[0]["拳掌功夫"] >= 300 then 
	    say("少侠，这是杨某自创的掌法，就用它来抵挡金轮法王的龙象般若功。",58) 
	    instruct_0();
		if instruct_11(0,188) == true then 
	        QZXS("领悟黯然精要！")
			say("多谢杨大哥",0)
	        instruct_0();
	        setLW1(25)
		    dark()
            light()
            instruct_35(0,0,25,10)
		else
			say("既然如此，少侠小心。",58) 
		end	
	end]]
	instruct_14();   --  14(E):场景变黑
	instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
	instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
	instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
	instruct_19(15,17);   --  19(13):主角移动至F-D
	instruct_40(0);
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_13();   --  13(D):重新显示场景	
	Talk(CC.BTalk53,0);
	Talk(CC.BTalk54,58);
	Talk(CC.BTalk55,0);
	Talk(CC.BTalk56,0);
	Talk(CC.BTalk57,58);
	Talk(CC.BTalk58,0);
	Talk(CC.BTalk59,58);
	Talk(CC.BTalk60,0);
	Talk(CC.BTalk61,58);
	instruct_14();   --  14(E):场景变黑
	SetS(86,11,11,5,2)
	instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
	instruct_3(104,68,1,0,969,0,0,6186,6186,6186,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [68]
	instruct_3(70,19,1,0,151,0,0,6188,6188,6188,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [19]
	instruct_3(60,20,1,0,589,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:场景[龙门客栈]:场景事件编号 [20]
	instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
	if GetS(114, 0, 0, 0) == 0 and (inteam(92) or GX(92)) and PersonKF(0,190) then
		bgtalk("郭襄痴痴的望著古墓入口，那是杨过离开古墓，前往小村的方向")
		say("襄儿？襄儿...",0)
		say("...",92)
		say("...",0)
		bgtalk("只见郭襄一步一步的往古墓入口走去，速度越来越快，步若流云、身若翩龙")
		bgtalk("但奇特的是，这样的速度要追上杨过并非难事，然而郭襄的眼前，却始终没有杨过的身影")
		bgtalk("同样运起流云追月身法，跟在后头的你，将这一切尽收眼底")
		say("...呵，没想到竟然是在这种时候",0)
		say("让我看到了真正的「流云追月」啊...",0)
		if DrawStrBoxYesNo(-1, -1, "要进一步观察吗？", C_WHITE, 30) == true then
			QZXS("领悟流云追月身法！")
			instruct_0();
			setLW2(190)
			say("哈，还真是五味杂陈哪（自嘲一笑）",0)
		else
			say("我在想什么呢，快跟上襄儿吧",0)
		end
	end	
end

OEVENTLUA[8205] = function() --杀法王事件
	if instruct_16(59) == true then
		Talk(CC.BTalk80,62);
		Talk(CC.BTalk81,0);
		SetS(86,11,12,5,1)
		--战斗
		if instruct_6(79) ==false then    --  6(6):战斗[74]是则跳转到:Label2
			instruct_15(0);   --  15(F):战斗失败，死亡
			instruct_0();   --  0(0)::空语句(清屏)
			do return; end
		end 
		SetS(86,11,12,5,0)
		if not checkpic(3, 21, 1) or not inteam(92) then
			instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
		end
		instruct_3(60,20,1,0,589,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):修改事件定义:场景[龙门客栈]:场景事件编号 [20]
		instruct_0();   --  0(0)::空语句(清屏)
		--插入郭襄剧情
		if checkpic(3, 21, 1) and inteam(92) then
			say("等一下，大哥，龙姊姊，请看在我的份上放过他吧....", 92)
			say("襄儿？")
			say("他虽然不是好人，可是我毕竟喊过他一声师父....他对我也是关怀备至，嘘寒问暖....", 92)
			say("他现在武功尽失，已经受到报应了....", 92)
			say("龙姑娘....这....")
			say("好吧，反正杀了他过儿也无法复生....既然小妹妹你这样要求，那就让他走吧....", 59)
			say("谢谢龙姊姊！大和尚....师父....你回蒙古去吧。我知道以你的佛法精深，就算失去了武功，也能振兴密宗的....", 92)
			say("唉，罢了....小徒弟，我大弟子早逝，二弟子悟性有限，三弟子却天性凉薄。如今我把衣钵正式传给你，水能载舟亦能覆舟，你好自为之吧。", 62)	
			if PersonKF(0, 103) and GetS(111, 0, 0, 0) == 0 then
			  say("小子...你...也跟着学一学吧...",62) 
			  instruct_0();
			  if instruct_11(0,188) == true then
			     QZXS("领悟龙象之力！")
			     instruct_0();
			     say("多谢..金轮大师。",0) 
			     SetS(111, 0, 0, 0,103)
			  else
			     say("我还是算了吧",0) 
			  end
			end			
			say("师父....", 92)		
			dark()
			instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0)
			light()
			instruct_2(81,1);  
			instruct_2(170,1);  
			if PersonKF(92, 103) == false then
				JY.Person[92]["武功等级2"] = 0
				JY.Person[92]["武功2"] = 103
				tb("郭襄习得龙象般若功，内力硬上限加一千！")
			else
				AddPersonAttrib(92, "攻击力", 20)
				tb("郭襄攻击力上升二十点，内力硬上限加一千！")
			end			
			setJX(92)			
			say("多亏今日有少侠在，我才能替过儿报仇。神雕侠侣这本书就赠给少侠吧。", 59)
			say("谢谢龙姑娘。")
			if GetS(114,0,0,0) == 0 then
			say("此仇一报，我却是意外对本门武学有了些新的看法。", 59)
			say("为感谢少侠恩义，就与少侠分享吧", 59)
			instruct_0();
			      if instruct_11(0,188) == true then
	                 QZXS("领悟天罗地网势！")
	                 instruct_0();
	                 say("多谢龙姑娘。",0) 
	                 SetS(114, 0, 0, 0,119)
					 addthing(242)
				  else
				     say("我还是算了吧",0) 
				  end
			end	  
			instruct_2(153,1)
		else
			Talk(CC.BTalk82,0);
			Talk(CC.BTalk83,59);
			Talk(CC.BTalk84,0);
			Talk(CC.BTalk85,59);
			Talk(CC.BTalk86,0);
			Talk(CC.BTalk87,59);
			Talk(CC.BTalk88,0);
			instruct_2(153,1);   --  2(2):得到物品[神鵰侠侣][1]
			Talk(CC.BTalk90,59);
			instruct_2(87,1);   --  2(2):得到物品[黯然销魂掌][1]
			Talk(CC.BTalk92,0);
		end
	else
		Talk(CC.BTalk89,62);
	end
end

OEVENTLUA[8206] = function() --小龙女加入事件
	Talk(CC.BTalk10,59);
    if instruct_9(0,29) ==true then    --  9(9):是否要求加入?否则跳转到:Label1

        if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label2
            instruct_10(59);   --  10(A):加入人物[小龙女]
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
			instruct_3(104,76,1,0,970,0,0,7242,7242,7242,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [76]
			instruct_3(61,14,1,0,8205,0,0,8010,8010,8010,-2,-2,-2);   --  3(3):修改事件定义:场景[高升客栈]:场景事件编号 [61]
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
        end    --:Label2

        instruct_1(391,59,0);   --  1(1):[小龙女]说: 你的队伍已满，我无法加入。
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label1
end

OEVENTLUA[8207] = function() --玉女事件
	if instruct_16(59) then
	Talk(CC.BTalk93,0);
	Talk(CC.BTalk94,59)
	Talk(CC.BTalk95,0)
	Talk(CC.BTalk96,59)
	Talk(CC.BTalk97,0)
	Talk(CC.BTalk98,59)
	instruct_14();   --  14(E):场景变黑
	instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_13();   --  13(D):重新显示场景
	SetS(86,11,11,5,1)
	Talk(CC.BTalk99,0)
	else
	end
end

OEVENTLUA[153] = function() --小龙女入队事件
    instruct_1(390,59,0);   --  1(1):[小龙女]说: 有需要我帮忙的地方吗？
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_9(0,29) ==true then    --  9(9):是否要求加入?否则跳转到:Label1

        if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label2
            instruct_10(59);   --  10(A):加入人物[小龙女]
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
        end    --:Label2

        instruct_1(391,59,0);   --  1(1):[小龙女]说: 你的队伍已满，我无法加入。
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label1
end	

OEVENTLUA[227] = function()
    instruct_14();   --  14(E):场景变黑
    instruct_26(60,4,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(60,5,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(60,3,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
    instruct_3(-2,1,0,0,0,0,0,6116,6116,6116,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
    instruct_3(-2,2,0,0,0,0,0,6116,6116,6116,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
    instruct_3(-2,3,0,0,0,0,0,6116,6116,6116,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
    instruct_3(-2,10,0,0,0,0,0,6116,6116,6116,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
    instruct_3(-2,11,0,0,0,0,0,6116,6116,6116,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
    instruct_3(-2,12,0,0,0,0,0,6116,6116,6116,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
    instruct_3(-2,13,0,0,0,0,0,6116,6116,6116,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
    instruct_3(-2,22,0,0,0,0,0,6108,6108,6108,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [22]
    instruct_3(-2,23,0,0,0,0,0,6112,6112,6112,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
    instruct_3(-2,18,0,0,0,0,0,8216,8216,8216,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [18]
    instruct_3(-2,19,0,0,0,0,0,6762,6762,6762,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
    instruct_3(-2,20,0,0,0,0,0,6762,6762,6762,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [20]
    instruct_3(-2,21,0,0,0,0,0,8212,8212,8212,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [21]
    instruct_3(-2,14,0,0,0,0,0,6802,6802,6802,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
    instruct_3(-2,15,0,0,0,0,0,5894,5894,5894,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
    instruct_3(-2,17,0,0,0,0,0,6186,6186,6186,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [17]
    instruct_3(-2,16,0,0,0,0,0,6068,6068,6068,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_30(32,49,32,44);   --  30(1E):主角走动32-49--32-44
    instruct_30(32,44,28,44);   --  30(1E):主角走动32-44--29-44
    instruct_30(28,44,28,40);   --  30(1E):主角走动29-44--29-41
    instruct_1(536,0,1);   --  1(1):[AAA]说: 打的这么热闹啊……一堆和*尚老道，围着一对小情人…*…这不是杨兄么？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(537,58,0);   --  1(1):[杨过]说: 正是杨某。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(538,0,1);   --  1(1):[AAA]说: 这位小龙女姑娘，难道就是*你的……姑姑？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(539,58,0);   --  1(1):[杨过]说: 不错，她就是……不，她从*前是我的师父，是我的姑姑*，但是现在，什么师徒名分*，什么名节清白，我通通当*是放屁！通通滚他妈的蛋！*姑姑，不，龙儿，死也罢，*活也罢，咱俩谁也没命苦，*谁也不会孤苦伶仃。从今而*后，你不是我的师父，不是*我的姑姑，是我媳妇！是我*妻子！是我老婆！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(540,59,0);   --  1(1):[小龙女]说: 过儿，这是你的真心话么？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(541,58,0);   --  1(1):[杨过]说: 自然是真心。我断了手臂，*你更加怜惜我；你遇到了什*么灾难，我也更加怜惜你。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(542,59,0);   --  1(1):[小龙女]说: 是啊，世上除了你我两人自*己，原也没旁人怜惜。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(543,128,0);   --  1(1):[???]说: 重阳宫乃清修之地，岂容你*们俩在此胡言乱语。你们杀*了我师侄尹志平，又伤我全*真教众多门人，今日休想全*身而退！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(544,0,1);   --  1(1):[AAA]说: 多好的一对儿呀，你们怎么*忍心下手呢？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(545,62,0);   --  1(1):[金轮法王]说: 嘿嘿，你以为你就不忍心么*？老衲告诉你，你一直想要*的天书《神雕侠侣》，就在*杨过身上！只要杀了他，你*马上就可以得到。老衲倒要*看看你忍不忍心！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(546,0,1);   --  1(1):[AAA]说: 杨兄，这可是真的？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(547,58,0);   --  1(1):[杨过]说: 不错，神雕侠侣就在我身上*。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(548,0,1);   --  1(1):[AAA]说: ＜我该不该硬抢呢？＞
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_5(0,318) ==true then    --  5(5):是否选择战斗？否则跳转到:Label0
		SetS(22, 0, 0, 0, 1) --邪线判定
		setzx(153, 2)
		instruct_3(22,20,0,0,0,0,10015,0,0,0,0,0,0)
        instruct_37(-5);   --  37(25):增加道德-5
        instruct_1(549,0,1);   --  1(1):[AAA]说: 杨兄，咱们也算是老朋友了*，能否将此书让给我？
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(550,58,0);   --  1(1):[杨过]说: 哈哈哈，你想让我用天书换*一条命？你把杨某这条命看*得太值钱了！我的命可算是*你救的，今日便还给你又如*何？想要天书，你就上来吧*，杨某今日就没想活着从这*里走出去！能和龙儿死在一*起，我也算不枉此生。你来*吧。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(551,59,0);   --  1(1):[小龙女]说: 过儿……
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(552,244,1);   --  1(1):[???]说: 如此……得罪了……
        instruct_0();   --  0(0)::空语句(清屏)

        if instruct_6(75,4,0,0) then    --  6(6):战斗[75]是则跳转到:Label1
		end
			instruct_40(2);
			Talk(CC.BTalk1,0);
			Talk(CC.BTalk2,58);
			Talk(CC.BTalk3,62);
			Talk(CC.BTalk4,58);
			instruct_14();   --  14(E):场景变黑
			instruct_3(-2,17,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [17]
			instruct_3(-2,18,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [18]
			SetS(19,29,40,3,40)
			SetS(19,30,40,3,41)
			instruct_3(-2,40,0,0,0,0,0,6190,6190,6190,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [40]
			instruct_3(-2,41,0,0,0,0,0,8216,8216,8216,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [41]
			instruct_40(1);
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_13();   --  13(D):重新显示场景
			Talk(CC.BTalk5,59);
			Talk(CC.BTalk6,0);	
			instruct_1(559,123,0);   --  1(1):[???]说: 重阳宫重地，岂容邪魔外道*撒野！
			if instruct_6(73,4,0,0) ==false then    --  6(6):战斗[73]是则跳转到:Label3
				instruct_0();   --  0(0)::空语句(清屏)
				instruct_15(0);   --  15(F):战斗失败，死亡
				do return; end
			end --Label3
			--杨龙逃离
			instruct_14();   --  14(E):场景变黑
			instruct_3(-2,24,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [24]
			instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
			instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
			instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
			instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
			instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
			instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
			instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
			instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
			instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
			instruct_3(-2,40,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [40]
			instruct_3(18,1,1,0,8201,0,0,6068,6068,6068,-2,-2,-2);   --  3(3):修改事件定义:场景[古墓]:场景事件编号 [1]
			instruct_3(18,0,1,0,8201,0,0,6190,6190,6190,-2,-2,-2);   --  3(3):修改事件定义:场景[古墓]:场景事件编号 [0]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_13();   --  13(D):重新显示场景
			Talk(CC.BTalk7,0);
			Talk(CC.BTalk8,62);
			Talk(CC.BTalk9,0);
			instruct_3(-2,3,0,0,0,0,0,8230,8230,8230,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
			Talk(CC.BTalk19,64);
			Talk(CC.BTalk20,62);
			--金轮逃离
			instruct_14();   --  14(E):场景变黑
			instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
			instruct_3(-2,21,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [21]
			instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [20]
			instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
			instruct_3(-2,41,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [41]
			instruct_3(-2,15,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_13();   --  13(D):重新显示场景
			Talk(CC.BTalk21,0);
			Talk(CC.BTalk22,64);
			Talk(CC.BTalk23,0);
			Talk(CC.BTalk24,64);
			instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
			Talk(CC.BTalk25,0);
    else
	SetS(22, 0, 0, 0, 2) --正线判定
	setzx(153, 1)
	instruct_3(22,20,0,0,0,0,10017,0,0,0,0,0,0)
	instruct_37(3);   --  37(25):增加道德3
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(557,245,1);   --  1(1):[???]说: 你当我是什么人！就算为了*天书，也不能违背做人的原*则。你们想伤害杨兄和龙姑*娘，就要先过我这关！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(558,62,0);   --  1(1):[金轮法王]说: 小子想充当英雄，那就来吧*，试试我的龙象般若功！
    instruct_0();   --  0(0)::空语句(清屏)
    if GetS(113,0,0,0) == 0 and JY.Person[0]["拳掌功夫"] >= 300 then 
	    say("少侠，这是杨某自创的掌法，就用它来抵挡金轮法王的龙象般若功。",58) 
	    instruct_0();
		if instruct_11(0,188) == true then 
	        QZXS("领悟黯然精要！")
			say("多谢杨大哥",0)
	        instruct_0();
	        setLW1(25)
		    dark()
            light()
            instruct_35(0,0,25,10)
		else
			say("既然如此，少侠小心。",58) 
		end	
	end
    if instruct_6(74,4,0,0) ==false then    --  6(6):战斗[74]是则跳转到:Label2
        instruct_15(0);   --  15(F):战斗失败，死亡
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label2

    instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [14]
    instruct_3(-2,21,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [21]
    instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [20]
    instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
    instruct_3(-2,18,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [18]
    instruct_3(-2,15,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(559,123,0);   --  1(1):[???]说: 重阳宫重地，岂容邪魔外道*撒野！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(560,0,1);   --  1(1):[AAA]说: 我是邪魔歪道？？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(561,127,0);   --  1(1):[???]说: 哼，今日休想离开重阳宫！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(562,68,0);   --  1(1):[丘处机]说: 天罡北斗阵！
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(73,4,0,0) ==false then    --  6(6):战斗[73]是则跳转到:Label3
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
    end    --:Label3

    instruct_3(-2,24,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [24]
    instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
    instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
    instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
    instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
    instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
    instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
    instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
    instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(564,0,1);   --  1(1):[AAA]说: 杨大哥，龙姑娘，你们没事*吧？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(563,58,0);   --  1(1):[杨过]说: 现在龙儿身受重伤，我们要*赶紧返回古墓了。大恩不言*谢，少侠有空可到古墓来找*我夫妇。龙儿，我们回家。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
    instruct_3(-2,17,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [17]
    instruct_3(18,1,1,0,231,0,0,6068,6068,6068,-2,-2,-2);   --  3(3):修改事件定义:场景[古墓]:场景事件编号 [1]
    instruct_3(18,0,1,0,231,0,0,6188,6188,6188,-2,-2,-2);   --  3(3):修改事件定义:场景[古墓]:场景事件编号 [0]
    instruct_17(18,1,22,41,0);   --  17(11):修改场景贴图:场景[古墓]层1坐标16-29
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
	end
end		


--brolycjw侠客剧情
OEVENTLUA[372] = function()		--侠客行龙门客栈
    if instruct_4(203,2,0) ==false then    --  4(4):是否使用物品[玄冰碧火酒]？是则跳转到:Label0
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label0

    instruct_26(61,19,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(61,18,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_1(1388,238,0);   --  1(1):[???]说: 哇，得手啦，太好了。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1389,0,1);   --  1(1):[AAA]说: 拿去吧，快去救你的天哥吧*。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1390,238,0);   --  1(1):[???]说: ……*能不能再麻烦你一次？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1391,0,1);   --  1(1):[AAA]说: 怎么了？救人也要我替你去*？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1392,238,0);   --  1(1):[???]说: 天哥现在在长乐帮，我……*我不方便过去，你帮我送过*去吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1393,246,1);   --  1(1):[???]说: 奇奇怪怪的，你的天哥到底*是谁啊？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1394,238,0);   --  1(1):[???]说: 他叫石破天，是长乐帮的帮*主。他手下有个姓贝的，是*个大夫，知道这酒的作用，*你去找他就行。我，我……*我还是不要露面的好。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1395,0,0);   --  1(1):[AAA]说: 喂，感觉你在遛我啊，什么*好处也没有，我为啥要替你*跑腿啊。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1396,238,0);   --  1(1):[???]说: 这是我四爷爷的家传鞭法，*送给你，这总行了吧。你不*要罗嗦了，快去啊。*我的天哥……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
    instruct_3(94,1,1,0,377,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[长乐帮]:场景事件编号 [1]
    instruct_3(94,0,1,0,377,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[长乐帮]:场景事件编号 [0]
    instruct_3(94,2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[长乐帮]:场景事件编号 [2]
    instruct_3(94,9,1,0,374,375,0,7028,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[长乐帮]:场景事件编号 [9]
    instruct_17(94,2,37,19,5156);   --  17(11):修改场景贴图:场景[长乐帮]层2坐标25-13
    instruct_17(94,2,34,21,4866);   --  17(11):修改场景贴图:场景[长乐帮]层2坐标22-15
    instruct_3(94,14,1,0,380,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[长乐帮]:场景事件编号 [14]	
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_2(185,1);   --  2(2):得到物品[毒龙鞭法][1]
	--JY.Person[38]["携带物品1"] = 72
    instruct_0();   --  0(0)::空语句(清屏)
end

OEVENTLUA[375] = function()
    if instruct_4(203,2,0) == false then
	    do return; end
    end 
	instruct_26(61,19,1,0,0)
	instruct_26(61,18,1,0,0)
	instruct_32(203,-1,0)
	instruct_3(-2,-2,1,0,376,0,0,-2,-2,-2,-2,-2,-2);
	instruct_1(1400,85,0) --[85贝海石]:这，这不是玄冰碧火酒吗？*阁下是……
	instruct_0()
	instruct_1(1401,0,1)--[0资]:我受一位姑娘所托，将此物*送与贵帮帮主石破天。
	instruct_0()
	instruct_1(1402,85,0)--[85贝海石]:太好了，太好了，*敝帮上下感激阁下的救命之*恩。*长乐帮有救了。*……。*帮主，你快把这酒喝下去…*…
	instruct_0()
	instruct_14() --
	instruct_17(94,2,37,19,0)--
	instruct_3(-2,3,1,0,0,0,0,5152,5152,5152,-2,-2,-2);
	instruct_0()
	instruct_13()
	instruct_1(1403,38,0) --[38石破天]:啊……
	instruct_0()
	instruct_1(1404,85,0)--[85贝海石]:帮主，你感觉怎么样？
	instruct_0()
	instruct_1(1405,38,0)--[38石破天]:你是谁啊？什么帮主？
	instruct_0()
	instruct_1(150,85,0) --[85贝海石]:.......
	instruct_0()
	instruct_1(150,0,1) --[0资]:…………
	instruct_0()
	instruct_1(1406,38,0) --[38石破天]:老伯伯呢？他说要教我练捉*麻雀的本事，却没跟我说练*完会忽冷忽热，难过死了。*你们是谁？这是在哪里？
	instruct_0()
	instruct_1(1407,0,1) --[0资]:他真的是你们帮主？
	instruct_0()
	instruct_1(1408,85,0) --[85贝海石]:这个……恩……帮主受了重*伤……这个……
	instruct_0()
	instruct_1(1409,196,0) --[196嵩山弟子]:贝先生，不好了，关东四大*门派前来本帮闹事。
	instruct_0()
	instruct_1(1410,85,0)--[85贝海石]:帮主你好好休息。*少侠，我们出去看看。
	instruct_0()
	instruct_1(1411,38,0)--[38石破天]:难道我真是你们帮主？
	instruct_0()
	instruct_14()
	instruct_3(-2,4,1,0,0,0,0,7070,7070,7070,-2,-2,-2);
	instruct_3(-2,5,0,0,0,0,0,5178,5178,5178,-2,-2,-2);
	instruct_3(-2,6,0,0,0,0,0,5416,5416,5416,-2,-2,-2);
	instruct_3(-2,7,0,0,0,0,0,5222,5222,5222,-2,-2,-2);
	instruct_3(-2,8,0,0,0,0,0,5402,5402,5402,-2,-2,-2);
	instruct_19(24,29)
	instruct_40(3)
	instruct_25(24,29,24,29)
	instruct_0()
	instruct_13()
	instruct_1(1412,203,0) --[203泰山弟子]:贵帮司徒帮主，和我们可说*是过命的交情。这颗千年人*参，是送给司徒大哥的。
	instruct_0()
	instruct_1(1413,0,1)--[0资]:＜怎么另外还有一位司徒帮*主？＞
	instruct_0()
	instruct_1(1414,85,0) --[85贝海石]:司徒大哥……他老人家……*咳咳……入山隐居，久已不*闻江湖消息，帮中老兄弟都*牵挂得紧。各位得厚礼，要*交到他老人家手上，倒是不*大容易了。
	instruct_0()
	instruct_1(1415,195,0)--[195嵩山弟子]:我们听一位好朋友说道，司*徒大哥是……是……是遭长*乐帮奸人所害，死的不明不*白。这帮主之位，落到了一*个年轻后生身上，我们今日*来，就是要为司徒帮主讨个*公道！
	instruct_0()
	instruct_1(1416,0,1)--[0资]:＜长乐帮的事，我最好还是*不要插手……＞
	instruct_0()
	instruct_1(1417,191,0) --[191嵩山弟子]:这位想必就是新任帮主了吧*？毛头小子，说，你们把司*徒大哥怎么了？
	instruct_0()
	instruct_1(1418,0,1)--[0资]:我？我不是……
	instruct_0()
	instruct_1(1419,192,0)--[192嵩山弟子]:对，你不是长乐帮帮主，真*正的帮主是司徒大哥，小子*，我们今日要为司徒大哥讨*个公道，拿命来吧！
	instruct_0()
	instruct_1(1420,0,1)--[0资]:＜我还没说完呢……＞
	instruct_0()
	
	    if instruct_6(167,4,0,0) == false then
		   instruct_15(0)
			do return; end
        end 
		
	instruct_3(-2,5,0,0,0,0,0,0,0,0,0,0,0);
	instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);
	instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);
	instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);
	instruct_0()
	instruct_13()
	instruct_2(16,1)--得到物品[16千年人参]1个
	instruct_0()
	instruct_1(1421,85,0)--[85贝海石]:多谢少侠助我帮击退强敌。
	instruct_0()
	instruct_1(1422,0,1)--[0资]:简直莫名其妙，这到底是怎*么回事？到底谁是长乐帮帮*主？
	instruct_0()
	instruct_1(1423,85,0)--[85贝海石]:少侠可知道赏善罚恶令的事*？
	instruct_0()
	instruct_1(1424,0,1)--[0资]:愿闻其详。
	instruct_0()
	instruct_1(1425,85,0)--[85贝海石]:每隔十年，侠客岛的赏善罚*恶二使就会来到中原，向武*林中的各大门派的掌门人发*赏善罚恶令。凡接到此令者*，务必去侠客岛。
	instruct_0()
	instruct_1(1426,0,1)--[0资]:去了侠客岛，又如何？
	instruct_0()
	instruct_1(1427,85,0)--[85贝海石]:这个……武林中无人知晓…*…因为所有去过侠客岛的人*，至今无一生还。
	instruct_0()
	instruct_1(1428,0,1)--[0资]:这么说，这赏善罚恶令是接*不得的了？
	instruct_0()
	instruct_1(1429,85,0)--[85贝海石]:掌门人如果不接，那么整个*门派会在几天之内被全部消*灭。
	instruct_0()
	instruct_1(1430,0,1)--[0资]:好厉害！*难道……今年正好是赏善罚*恶二使出现的时候*？
	instruct_0()
	instruct_1(1431,85,0)--[85贝海石]:不错。本帮这些年来十分兴*旺，可是帮主快马司徒横却*很胆小，不敢接这赏善罚恶*令，如此……本帮将面临灭*顶之灾。
	instruct_0()
	instruct_1(1432,0,1)--[0资]:哦，所以你们就害死了司徒*帮主，又找了个替死鬼做帮*主！
	instruct_0()
	instruct_1(1433,85,0)--[85贝海石]:少侠此言差矣。石帮主虽然*年少，但敢作敢当。他当面*斥责司徒帮主不为大伙着想*，司徒帮主恼羞成怒，于是*二人便动起手来。石帮主武*艺精湛，司徒帮主战败后就*离开了本帮。大伙都知道他*是没脸再回来了，于是便拥*立了石帮主。石帮主也慷慨*答允，若是赏善罚恶二使到*来，他便主动接了这赏善罚*恶令，为大伙挡去这一场灾*难。
	instruct_0()
	instruct_1(1434,0,1)--[0]:＜哼，说来说去，还不是要*这姓石的去送死。＞可是，*我看石帮主似乎并不知道自*己是帮主……
	instruct_0()
	instruct_1(1435,85,0)--[85贝海石]:这个……咳咳……石帮主生*病后……咳咳……有很多事*情都记不太清楚……
	instruct_0()
	instruct_1(1436,0,1)--[246雪山弟子]:＜我看这姓贝的心里一定有*鬼……＞
	instruct_0()
	instruct_1(1437,238,0)--:啊，不好了——
	instruct_0()
	instruct_1(1438,85,0)--快去看看。
	instruct_0()
	instruct_14()
	instruct_3(-2,4,0,0,0,0,0,0,0,0,-2,-2,-2);
	instruct_3(-2,11,1,0,0,0,0,6376,6376,6376,-2,-2,-2);
	instruct_3(-2,3,0,0,0,0,0,0,0,0,-2,-2,-2);
	instruct_19(35,21)
	instruct_40(1)
	instruct_25(35,21,35,21)
	instruct_0()
	instruct_13()
	instruct_1(1439,85,0)--[85贝海石]:石帮主呢？
	instruct_0()
	instruct_1(1440,0,1)--[0资]:叮当？你怎么来了，你不是*说你不方便……
	instruct_0()
	instruct_1(1441,238,0)--[238日月教徒]:哎呀，都什么时候了，你还*管这些。天哥被雪山派的白*万剑抓走了，快，快去救他*！
	instruct_0()
	instruct_1(1442,85,0)--[85贝海石]:不好，石帮主曾经说过，他*和雪山派……咳咳……有些*过节，恐怕凶多吉少啊。
	instruct_0()
	instruct_1(1443,238,0)--[238日月教徒]:那还等什么，我们赶紧去踏*平雪山派，把天哥救出来！
	instruct_0()
	instruct_1(1444,0,1)--[0资]:这就要荡平雪山派，太狠了*吧。
	instruct_0()
	instruct_1(1445,238,0)--[238日月教徒]:要救人，当然要杀人！你怎*么这么婆婆妈妈，我们快走*吧！
	instruct_0()
	instruct_1(1446,0,1)--[0资]:＜我应该去灭了雪山派么？*＞
	instruct_0()
	
	     if instruct_11(0,188) == true then
		    instruct_1(1447,0,1)--[245雪山弟子]:＜反正也要找天书，说不定*雪山就有……＞，好，咱们*这就走。
			instruct_0()
			instruct_1(1448,196,0)--[196嵩山弟子]:贝先生、贝先生……
			instruct_0()
			instruct_1(1449,85,0)--[85贝海石]:什么事这么惊惶？
			instruct_0()
			instruct_1(1450,196,0)--[196嵩山弟子]:贝先生，我们找到帮主的下*落了
			instruct_0()
			instruct_1(1451,85,0)--[85贝海石]:你说什么？
			instruct_0()
			instruct_1(1452,196,0)--[196嵩山弟子]:我们在丽春院看到了帮主了*。
			instruct_0()
			instruct_1(1453,0,1)--[0资]:你们帮主不是刚刚被白万剑*抓到雪山派了吗？怎么会在*丽春院？
			instruct_0()
			instruct_1(1454,85,0)--[85贝海石]:就是，你们看清楚了吗？
			instruct_0()
			instruct_1(1455,196,0)--[196嵩山弟子]:看清楚了，千真万确，我们*绝不会看错的。
			instruct_0()
			instruct_1(1456,85,0)--[85贝海石]:这……这是怎么回事？
			instruct_0()
			instruct_1(1457,238,0)--刚才明明看见白万剑抓走天*哥的。不过，丽春院倒是很*像天哥去的地方……
			instruct_0()
			instruct_1(1458,0,1)--[0资]:这样吧，反正丽春院离此不*远，我们先去看个究竟，然*后再上雪山派。
			instruct_0()
			instruct_1(1459,85,0)--[85贝海石]:如此最好，那就拜托少侠了*。
			instruct_0()
			instruct_1(1460,238,0)--[238日月教徒]:丽春院……我还是在暗处跟*着好了……
			instruct_0()
			instruct_14()
			instruct_3(-2,11,0,0,0,0,0,0,0,0,-2,-2,-2);
			instruct_3(-2,9,1,0,376,0,0,-2,-2,-2,-2,-2,-2);
			instruct_3(69,13,0,0,0,0,0,0,0,0,0,0,0);
			instruct_3(69,14,0,0,0,0,0,0,0,0,0,0,0);
			instruct_3(69,16,0,0,0,0,0,5152,5152,5152,-2,-2,-2);
			instruct_3(69,27,0,0,0,0,0,5150,5150,5150,-2,-2,-2);
			instruct_3(69,26,0,0,0,0,0,5144,5144,5144,-2,-2,-2);
			instruct_3(69,25,0,0,0,0,422,0,0,0,-2,-2,-2);
			instruct_0()
			instruct_13()
			do return; end
         end
		 
	instruct_37(1)
    instruct_1(1461,0,1)--[0资]:就算是要救人，也不能随便*杀人呀。我们还是先去打听*一下消息吧。
	instruct_0()
	instruct_1(1462,196,0)--[196嵩山弟子]:贝先生、贝先生……
	instruct_0()
	instruct_1(1463,85,0)--[85贝海石]:什么事？
	instruct_0()
	instruct_1(1464,196,0)--[196嵩山弟子]:我们刚才一直跟踪雪山派的*白万剑，看到他带着我们帮*主坐船出海了。
	instruct_0()
	instruct_1(1465,85,0)--[85贝海石]:出海了？那会去哪呢？
	instruct_0()
	instruct_1(1466,238,0)--我四爷爷住在海外紫烟岛，*我去找他帮忙。
	instruct_0()
	instruct_14()
	instruct_3(-2,11,1,0,0,0,0,0,0,0,-2,-2,-2);
	instruct_3(-2,9,1,0,376,0,0,-2,-2,-2,-2,-2,-2);
	instruct_3(97,8,0,0,0,0,0,7072,7072,7072,-2,-2,-2);
	instruct_3(97,7,0,0,0,0,0,7072,7072,7072,-2,-2,-2);
	instruct_3(97,9,0,0,0,0,0,6376,6376,6376,-2,-2,-2);
	instruct_3(97,2,0,0,0,0,0,5272,5272,5272,-2,-2,-2);
	instruct_3(97,3,0,0,0,0,0,5264,5264,5264,-2,-2,-2);
	instruct_3(97,4,0,0,0,0,0,5264,5264,5264,-2,-2,-2);
	instruct_3(97,5,0,0,0,0,0,5264,5264,5264,-2,-2,-2);
	instruct_3(97,6,0,0,0,0,0,5152,5152,5152,-2,-2,-2);
	instruct_3(97,0,0,0,0,0,379,0,0,0,-2,-2,-2);
	instruct_0()
	instruct_13()
	instruct_1(1467,85,0)--[85贝海石]:我这里暂时走不开，还要麻*烦少侠帮我们寻找帮主。我*们长乐帮会加强人手，搜寻*帮主下落。
	instruct_0()
	instruct_1(1468,0,1)--[0资]:好吧，反正我也要到处找东*西，正好顺便帮你们打听一*下。
	instruct_0()
	instruct_1(1469,85,0)--[85贝海石]:如此最好，那就拜托少侠了*。
	instruct_0()
end

OEVENTLUA[422] = function()	--中邪线丽春院事件
    instruct_26(61,19,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(61,18,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
    instruct_25(20,14,15,11);   --  25(19):场景移动20-14--15-11
    instruct_1(1603,41,0);   --  1(1):[张三]说: 侠客岛使者拜会长乐帮石帮*主。请接赏善罚恶令。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1604,307,0);   --  1(1):[石破天]说: 我……我……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1605,238,0);   --  1(1):[???]说: 果然是天哥，快救人
    instruct_0();   --  0(0)::空语句(清屏)
	if instruct_5(0,254) ==true then    --  5(5):是否选择战斗？否则跳转到:Label0
		if instruct_6(169,4,0,0) ==false then    --  6(6):战斗[169]是则跳转到:Label0
			instruct_15(0);   --  15(F):战斗失败，死亡
			do return; end
			instruct_0();   --  0(0)::空语句(清屏)
		end    --:Label0
		addHZ(58)
		instruct_3(-2,27,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
		instruct_3(-2,26,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
		instruct_3(-2,15,0,0,0,0,0,6374,6374,6374,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
		instruct_19(15,13);   --  19(13):主角移动至F-D
		instruct_40(0);   --  40(28):改变主角站立方向0
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		instruct_1(1606,307,0);   --  1(1):[石破天]说: 丁丁当当，你来啦，我想死*你了。
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1607,238,0);   --  1(1):[???]说: 呸，还以为你生病之后转了*性，原来还是没半句正经。
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1608,307,0);   --  1(1):[石破天]说: 生病？什么病？……
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1609,164,0);   --  1(1):[???]说: 你这狗杂种，总算让我找到*你了。
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_14();   --  14(E):场景变黑
		instruct_3(-2,23,0,0,0,0,0,8238,8238,8238,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		instruct_1(1610,164,0);   --  1(1):[???]说: 狗杂种，有什么事要求我？
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1611,307,0);   --  1(1):[石破天]说: 你，你，你是什么人？
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1612,164,0);   --  1(1):[???]说: 你居然装作不认识我谢烟客*？岂有此理！
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1613,307,0);   --  1(1):[石破天]说: ＜哇，他的内功好厉害，我*还是敷衍一下算了＞
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1614,164,0);   --  1(1):[???]说: 快说，你有什么事要求我办*？
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1615,307,0);   --  1(1):[石破天]说: 求你？啊，啊，对，求你去*灭了雪山派！
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1616,164,0);   --  1(1):[???]说: 好小子，想给老子出难题，*好，咱们这就走！
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1617,307,0);   --  1(1):[石破天]说: 啊，怎么还抓着我啊
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1618,238,0);   --  1(1):[???]说: 天哥——
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_14();   --  14(E):场景变黑
		instruct_3(-2,15,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
		instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
		instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
		instruct_3(39,10,0,0,0,0,0,7074,7074,7074,-2,-2,-2);   --  3(3):修改事件定义:场景[凌霄城]:场景事件编号 [10]
		instruct_3(39,18,0,0,0,0,0,7074,7074,7074,-2,-2,-2);   --  3(3):修改事件定义:场景[凌霄城]:场景事件编号 [18]
		instruct_3(39,19,0,0,0,0,0,6374,6374,6374,-2,-2,-2);   --  3(3):修改事件定义:场景[凌霄城]:场景事件编号 [19]
		instruct_3(39,9,1,0,424,0,0,5274,5274,5274,-2,-2,-2);   --  3(3):修改事件定义:场景[凌霄城]:场景事件编号 [9]
		instruct_3(39,11,0,0,0,0,0,8238,8238,8238,-2,-2,-2);   --  3(3):修改事件定义:场景[凌霄城]:场景事件编号 [11]
		instruct_3(39,12,0,0,0,0,423,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[凌霄城]:场景事件编号 [12]
		instruct_3(39,13,0,0,0,0,423,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[凌霄城]:场景事件编号 [13]
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		instruct_1(1619,0,1);   --  1(1):[AAA]说: 他怎么又被抓上雪山派了？
		instruct_0();   --  0(0)::空语句(清屏)
	else
		Talk(CC.BTalk201,0);
		TalkEx(CC.BTalk202,238,1);
		instruct_14();	--  14(E):场景变黑
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景	
		Talk(CC.BTalk203,41);
		Talk(CC.BTalk204,0);
		instruct_14();	--  14(E):场景变黑
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_3(-2,27,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
		instruct_3(-2,26,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
		instruct_3(-2,15,0,0,0,0,0,6374,6374,6374,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
		instruct_19(15,13);   --  19(13):主角移动至F-D
		instruct_40(0);   --  40(28):改变主角站立方向0
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		instruct_1(1606,307,0);   --  1(1):[石破天]说: 丁丁当当，你来啦，我想死*你了。
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1607,238,0);   --  1(1):[???]说: 呸，还以为你生病之后转了*性，原来还是没半句正经。
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1608,307,0);   --  1(1):[石破天]说: 生病？什么病？……
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1609,164,0);   --  1(1):[???]说: 你这狗杂种，总算让我找到*你了。
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_14();   --  14(E):场景变黑
		instruct_3(-2,23,0,0,0,0,0,9020,9020,9020,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		instruct_1(1610,164,0);   --  1(1):[???]说: 狗杂种，有什么事要求我？
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1611,307,0);   --  1(1):[石破天]说: 你，你，你是什么人？
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1612,164,0);   --  1(1):[???]说: 你居然装作不认识我谢烟客*？岂有此理！
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1613,307,0);   --  1(1):[石破天]说: ＜哇，他的内功好厉害，我*还是敷衍一下算了＞
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1614,164,0);   --  1(1):[???]说: 快说，你有什么事要求我办*？
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1615,307,0);   --  1(1):[石破天]说: 求你？啊，啊，对，求你去*灭了雪山派！
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1616,164,0);   --  1(1):[???]说: 好小子，想给老子出难题，*好，咱们这就走！
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1617,307,0);   --  1(1):[石破天]说: 啊，怎么还抓着我啊
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1618,238,0);   --  1(1):[???]说: 天哥——
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_14();   --  14(E):场景变黑
		SetS(86,20,20,5,1)
		instruct_3(-2,15,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [15]
		instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [23]
		instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [16]
		instruct_3(39,10,0,0,0,0,0,9234,9234,9234,-2,-2,-2);   --  3(3):修改事件定义:场景[凌霄城]:场景事件编号 [10]
		instruct_3(39,18,0,0,0,0,0,7074,7074,7074,-2,-2,-2);   --  3(3):修改事件定义:场景[凌霄城]:场景事件编号 [18]
		instruct_3(39,9,1,0,424,0,0,5274,5274,5274,-2,-2,-2);   --  3(3):修改事件定义:场景[凌霄城]:场景事件编号 [9]
		instruct_3(39,11,0,0,0,0,0,9020,9020,9020,-2,-2,-2);   --  3(3):修改事件定义:场景[凌霄城]:场景事件编号 [11]
		instruct_3(39,12,0,0,0,0,423,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[凌霄城]:场景事件编号 [12]
		instruct_3(39,13,0,0,0,0,423,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[凌霄城]:场景事件编号 [13]
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		instruct_1(1619,0,1);   --  1(1):[AAA]说: 他怎么又被抓上雪山派了？
		instruct_0();   --  0(0)::空语句(清屏)
	end
end


OEVENTLUA[423] = function()	--中邪线雪山派事件
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [13]
    instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [12]
    instruct_13();   --  13(D):重新显示场景
    instruct_25(29,24,29,17);   --  25(19):场景移动29-24--29-17
    instruct_1(1620,0,1);   --  1(1):[AAA]说: 咦？怎么两个石破天？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1621,38,0);   --  1(1):[石破天]说: 老伯伯，你也来啦
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1622,164,0);   --  1(1):[???]说: 你，你，你们俩……哈哈，*居然是两个长得一摸一样的*小子！怪不得我觉得这个狗*杂种怪怪的，原来是骗我，*看我怎么收拾你！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1623,38,0);   --  1(1):[石破天]说: 不可！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1624,164,0);   --  1(1):[???]说: 你说什么？你是不是求我不*要杀他？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1625,38,0);   --  1(1):[石破天]说: 我知道老伯伯为人最好了，*我想求老伯伯把这个人带在*身边，教他学好。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1628,164,0);   --  1(1):[???]说: 我……好，就这么定了，小*子，跟我走，我好好教教你*！
    instruct_0();   --  0(0)::空语句(清屏)
	if GetS(86,20,20,5) == 1 then
		instruct_19(29,24);   --  19(13):主角移动至F-D
		instruct_30(29,24,29,19);   --  30(1E):主角走动29-24--29-19
		Talk(CC.BTalk205,0);
		Talk(CC.BTalk206,164);
		Talk(CC.BTalk207,0);
		if instruct_6(170,3,0,0) ==false then    --  6(6):战斗[170]是则跳转到:Label0
			instruct_15(0);   --  15(F):战斗失败，死亡
			do return; end
		end    --:Label0
		SetS(86,20,20,5,2)
		Talk(CC.BTalk208,38);
		Talk(CC.BTalk209,164);
		Talk(CC.BTalk210,0);
		Talk(CC.BTalk211,164);
		Talk(CC.BTalk212,43);
		if instruct_6(59,3,0,0) ==false then    --  6(6):战斗[59]是则跳转到:Label0
			instruct_15(0);   --  15(F):战斗失败，死亡
			do return; end
		end    --:Label0
		Talk(CC.BTalk213,0);
		instruct_14();   --  14(E):场景变黑
		instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
		instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
		instruct_3(-2,18,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
		instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
		SetS(39,26,39,3,20)
		instruct_19(27,39);   --  19(13):主角移动至F-D
		instruct_40(2); 
		instruct_3(-2,20,0,0,0,0,0,9234,9234,9234,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [20]
		instruct_13();   --  13(D):重新显示场景
		Talk(CC.BTalk214,591);
		Talk(CC.BTalk215,0);
		Talk(CC.BTalk216,591);
		Talk(CC.BTalk217,0);
		addHZ(111)
		if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label2
			instruct_10(591);   --  10(A):加入人物[石中玉]
			instruct_14();   --  14(E):场景变黑
			instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_13();   --  13(D):重新显示场景
		else
			instruct_1(12,591,0);   --  1(1):][石中玉说: 你的队伍已满，我就直接去小村吧。
			instruct_14();   --  14(E):场景变黑
			instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [20]
			instruct_3(70,47,1,0,8301,0,0,9234,9234,9234,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [47]
			instruct_0();   --  0(0)::空语句(清屏)
			instruct_13();   --  13(D):重新显示场景
		end    --:Label2
		instruct_2(198,1);	--  2(2):得到物品[赏善罚恶令][1]
		instruct_3(-2,0,0,0,0,0,8302,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
		instruct_3(-2,1,0,0,0,0,8302,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
		instruct_3(-2,2,0,0,0,0,8302,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
		instruct_3(74,0,-2,0,-2,427,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[侠客岛]:场景事件编号 [0]
	else
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_14();   --  14(E):场景变黑
		instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
		instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
		instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		instruct_1(1630,38,0);   --  1(1):[石破天]说: 白师父，我不是要有意抢你*的掌门的，你别生气。侠客*岛的两位使者大哥约我去喝*粥，还说有什么书可以看，*我要走了。
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1631,0,1);   --  1(1):[AAA]说: ＜侠客岛有书？我应该去侠*客岛看看，不知道哪里还能*弄到赏善罚恶令呢？＞
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_14();   --  14(E):场景变黑
		instruct_3(-2,18,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [18]
		instruct_3(94,9,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:场景[长乐帮]:场景事件编号 [9]
		instruct_3(94,2,1,0,425,0,0,7070,7070,7070,-2,-2,-2);   --  3(3):修改事件定义:场景[长乐帮]:场景事件编号 [2]
		instruct_25(29,24,29,24);   --  25(19):场景移动29-24--29-24
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
	end
end


OEVENTLUA[427] = function()	--中邪线侠客岛门口
    if instruct_4(198,2,0) ==false then    --  4(4):是否使用物品[赏善罚恶令]？是则跳转到:Label0
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0

    instruct_1(1643,41,0);   --  1(1):[张三]说: 少侠里边请。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [7]
    instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [11]
    instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [10]
    instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [9]
    instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [8]
    instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [1]
    instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
    instruct_3(-2,2,1,0,428,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
	instruct_3(-2,19,1,0,0,0,0,5152,5152,5152,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
    instruct_3(-2,3,1,0,428,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
end


OEVENTLUA[428] = function()	--中邪线侠客岛事件
	if GetS(86,20,20,5) == 2 then
		instruct_26(61,19,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
		instruct_26(61,18,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
		instruct_1(1644,39,0);   --  1(1):[龙岛主]说: 太玄神功已被石兄弟破解，*此处没有来的必要了，少侠*请回吧。
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1645,0,1);   --  1(1):[AAA]说: 什么是太玄神功我不知道。*我来此只是想问一下，这里*有没有十四天书的下落。
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1646,40,0);   --  1(1):[木岛主]说: 有！
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1647,0,1);   --  1(1):[AAA]说: 哦？
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1648,39,0);   --  1(1):[龙岛主]说: 《侠客行》一书，就在侠客*岛！
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1649,0,1);   --  1(1):[AAA]说: 那，能不能把这本书送给我*？
		instruct_0();   --  0(0)::空语句(清屏)
		Talk(CC.BTalk218,40);
		Talk(CC.BTalk219,39);
		Talk(CC.BTalk220,0);
		instruct_35(38,2,102,900);   --  35(23):设置石破天武功1:太玄神功攻击力900

		if instruct_6(170,3,0,0) ==false then    --  6(6):战斗[170]是则跳转到:Label0
			instruct_15(0);   --  15(F):战斗失败，死亡
			do return; end
		end    --:Label0
		addHZ(44)
		instruct_14();   --  14(E):场景变黑
		SetS(86,20,20,5,0)
		instruct_3(-2,19,1,0,8303,0,0,5152,5152,5152,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
		instruct_3(-2,2,1,0,417,0,0,5132,5132,5132,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
		instruct_3(-2,3,1,0,418,0,0,5136,5136,5136,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		Talk(CC.BTalk221,39);
		Talk(CC.BTalk222,0);
		instruct_2(154,1);   --  2(2):得到物品[侠客行][1]
		instruct_2(80,1);   --  2(2):得到物品[太玄经][1]
		instruct_0();   --  0(0)::空语句(清屏)		
	else
		instruct_26(61,19,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
		instruct_26(61,18,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
		instruct_1(1644,39,0);   --  1(1):[龙岛主]说: 太玄神功已被石兄弟破解，*此处没有来的必要了，少侠*请回吧。
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1645,0,1);   --  1(1):[AAA]说: 什么是太玄神功我不知道。*我来此只是想问一下，这里*有没有十四天书的下落。
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1646,40,0);   --  1(1):[木岛主]说: 有！
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1647,0,1);   --  1(1):[AAA]说: 哦？
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1648,39,0);   --  1(1):[龙岛主]说: 《侠客行》一书，就在侠客*岛！
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_1(1649,0,1);   --  1(1):[AAA]说: 那，能不能把这本书送给我*？
		instruct_0();   --  0(0)::空语句(清屏)
		Talk(CC.BTalk235,40);
		instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
		instruct_3(-2,3,1,0,8306,0,0,5136,5136,5136,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
		instruct_3(-2,2,1,0,8306,0,0,5132,5132,5132,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		instruct_2(154,1);   --  2(2):得到物品[侠客行][1]
		instruct_0();   --  0(0)::空语句(清屏)
	end
end


OEVENTLUA[8301] = function()	--中线石中玉小村入队事件
		MyTalk("有需要我帮忙的地方吗？", 591);
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_9(0,29) ==true then    --  9(9):是否要求加入?否则跳转到:Label1

        if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label2
            instruct_10(591);   --  10(A):加入人物[石中玉]
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
        end    --:Label2

				MyTalk("你的队伍已满，我无法加入。", 591);
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label1
end


OEVENTLUA[8302] = function()	--中线石中玉雪山派离队事件
    if instruct_16(591,2,0) ==false then    --  16(10):队伍是否有[石中玉]是则跳转到:Label0
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0
    instruct_13();   --  13(D):重新显示场景
    Talk(CC.BTalk230,591);
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_21(591);   --  21(15):[石中玉]离队
	instruct_14();   --  14(E):场景变黑
    instruct_3(70,47,1,0,8301,0,0,9234,9234,9234,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [47]
	instruct_13();   --  13(D):重新显示场景
end


OEVENTLUA[8303] = function()	--中线石破天侠客岛入队事件
	if instruct_16(591,2,0) ==false then    --  16(10):队伍是否有[石中玉]是则跳转到:Label0
		Talk(CC.BTalk223,38);
		instruct_0();   --  0(0)::空语句(清屏)
		do return; end
    end    --:Label0

	 if instruct_9(0,95) ==true then    --  9(9):是否要求加入?否则跳转到:Label0
		--[[JY.Person[38]["武功等级1"] = 900; 
		JY.Person[38]["武功等级2"] = 900; 	
		JY.Person[38]["武功等级3"] = 900; 
		JY.Person[38]["攻击力"] = 220;   
		JY.Person[38]["轻功"] = 160;   
		JY.Person[38]["防御力"] = 220;  
		JY.Person[38]["等级"] = 15;  		
		local pid = 38			
		local extra = (7 + math.modf((JY.Person[pid]["资质"]) / 20)) * (JY.Person[pid]["等级"] - 1)
				
		  while extra ~= 0 do
			  local sanwei=math.random(3)
			  if sanwei==1 then
				AddPersonAttrib(pid, "攻击力", 1)
			  elseif sanwei==2 then
				AddPersonAttrib(pid, "防御力", 1)
			  else
				AddPersonAttrib(pid, "轻功", 1)	  
			  end	  
			  extra = extra - 1
		  end			]]
		Talk(CC.BTalk223,38);
		Talk(CC.BTalk224,591);
		Talk(CC.BTalk225,0);
		Talk(CC.BTalk226,38);
		Talk(CC.BTalk227,591);
		Talk(CC.BTalk228,0);
		Talk(CC.BTalk229,591);
		if cxzj() == 38 then 
		    instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13(); 
			for i = 1,HHH_GAME_SETTING["WG_COUNT_MAX"] do
			JY.Person[zj()]["武功"..i] = JY.Person[38]["武功"..i]
			end
			do return; end
        else 
		--instruct_2(72,1);		--得到十八泥偶
        if instruct_20(20,0) ==false then    --  20(14):队伍是否满？是则跳转到:Label1
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            instruct_10(38);   --  10(A):加入人物[石破天]
            do return; end
        end    --:Label1
        instruct_1(12,38,0);   --  1(1):[石破天]说: 你的队伍已满，我就直接去*小村吧。
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
        instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
        instruct_3(70,16,1,0,127,0,0,6410,6410,6410,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [16]
        instruct_3(70,58,1,0,127,0,0,6412,6412,6412,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [58]
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景
        do return; end
	end	
    end    --:Label0
end


OEVENTLUA[8304] = function()	--正线侠客岛战欧阳锋鸠摩智
	Talk(CC.BTalk231,60);
	Talk(CC.BTalk232,0);
	Talk(CC.BTalk233,103);
    if instruct_6(168,4,0,0) ==false then    --  6(6):战斗[168]是则跳转到:Label0
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label0
	Talk(CC.BTalk234,0);
	instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:当前场景事件编号
	
	SetS(86,20,20,5,0)		--蓝烟清：侠客行后没有还原数据，家里木桩变成欧阳锋鸠摩智
end


OEVENTLUA[8305] = function()	--石中玉离队事件
    Talk("石兄弟，你先回小村，有需*要时，我再去找你帮忙。",0);
    instruct_21(591);   --  21(15):[石中玉]离队
    instruct_3(70,47,1,0,8301,0,0,9234,9234,9234,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [47]
end

OEVENTLUA[8652] = function()	--韦小宝离队事件
    Talk("我的小宝哥，你先回小村，有需*要时，我再去找你帮忙哈。",0);
    instruct_21(664);   --  21(15):[韦小宝]离队
    instruct_3(70,48,1,0,869,870,0,8256,8256,8256,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [48]
end

OEVENTLUA[8306] = function()	--邪线侠客岛战侠客群众
	Talk(CC.BTalk236,0);
	instruct_1(1650,40,0);   --  1(1):[木岛主]说: 不可！
	instruct_0();   --  0(0)::空语句(清屏)
	instruct_1(1651,39,0);   --  1(1):[龙岛主]说: 此书对侠客岛意义重大，只*要我兄弟二人还在，就绝不*允许别人拿走。
	instruct_0();   --  0(0)::空语句(清屏)
	if instruct_5(0,254) ==true then    --  5(5):是否选择战斗？否则跳转到:Label0
		instruct_37(-5);       --道德-5
		instruct_1(1652,0,1);   --  1(1):[AAA]说: 哦，这么说只要灭了你们俩*就行了。
		instruct_0();   --  0(0)::空语句(清屏)
		if instruct_6(170,3,0,0) ==false then    --  6(6):战斗[170]是则跳转到:Label0
			instruct_15(0);   --  15(F):战斗失败，死亡
			do return; end
		end    --:Label0
		instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [19]
		instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
		instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
		instruct_0();   --  0(0)::空语句(清屏)
		instruct_13();   --  13(D):重新显示场景
		instruct_2(80,1);   --  2(2):得到物品[太玄经][1]
		instruct_0();   --  0(0)::空语句(清屏)
		if T5BCF(0) and zj() == 0 then
			Talk("白首太玄......嘿！好一个白首太玄！",0);
			JY.Person[0]["武功2"]=102
			JY.Person[0]["武功等级2"]=0
			QZXS("白愁飞领悟太玄神功！");
		else
			Talk(CC.BTalk237,0);
		end
	else
		Talk(CC.BTalk238,0);
		do return; end
	end
end

--brolycjw修改冰糖恋 白马剧情 --武骧金星：修正说话人变成雪山弟子的BUG
OEVENTLUA[8601] = function()    --破庙剧情
	 if GetS(86,40,40,5) == 1 then		--判断事件是否已经触发过
	 	 return;
	 end
	instruct_3(-2,4,0,0,0,0,0,9238,9238,9238,0,0,0);  
   instruct_26(3,3,1,0,0);   
   instruct_26(3,2,1,0,0);   
   instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);  
   instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);  
   instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0);  
   TalkEx(CC.TTalk1,0,1);  
   instruct_0();
   instruct_25(44,25,36,25);   
   instruct_0();   
   TalkEx(CC.TTalk2,137,0);  
   instruct_0();
   TalkEx(CC.TTalk3,590,4);  
   instruct_0();
   instruct_25(36,25,44,25);   
   instruct_0();   
   TalkEx(CC.TTalk4,0,1);  
   instruct_0();

   local zx=DrawStrBoxYesNo(-1,-1,"我是否应该挺身而出呢？",C_ORANGE,CC.DefaultFont);
   
   if zx==true and JY.Person[0]["性别"] ~= 2 then            --正邪分支
          TalkEx(CC.TTalk5,0,1);  
          instruct_0();
          instruct_25(44,25,36,25);   
          instruct_0();   
          instruct_30(44,25,40,25);  
          instruct_0();
          TalkEx(CC.TTalk6,0,1);  
          instruct_0();
          instruct_3(-2,5,0,0,0,0,0,5926,5926,5926,-2,-2,-2);
          TalkEx(CC.TTalk7,137,0);  
          instruct_0();
          TalkEx(CC.TTalk8,0,1);  
          instruct_0();
          TalkEx(CC.TTalk9,137,0);  
          instruct_0();
          TalkEx(CC.TTalk10,0,1);  
          instruct_0();
          TalkEx(CC.TTalk11,137,0);  
          instruct_0();
          TalkEx(CC.TTalk12,0,1);  
          instruct_0();
          if WarMain(92,1)==true then    --群战陈达海
	     instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);
             instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);
             instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);
             instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);
             instruct_3(-2,5,0,0,0,0,0,5926,5926,5926,-2,-2,-2);
             instruct_0();
             instruct_13();
             TalkEx(CC.TTalk13,137,0); 
             instruct_0();            
             TalkEx(CC.TTalk14,0,1); 
             instruct_0();
             TalkEx(CC.TTalk15,137,0); 
             instruct_0();
             instruct_14();
             instruct_3(-2,5,0,0,0,0,0,0,0,0,0,0,0);
             instruct_0();
             instruct_13();
             TalkEx(CC.TTalk16,590,1); 
             instruct_0();
             instruct_30(40,25,37,25);  
             instruct_0();
             TalkEx(CC.TTalk17,0,1); 
             instruct_0();
             TalkEx(CC.TTalk18,590,0); 
             instruct_0();
             instruct_1(256,0,1);   
             instruct_0();
             instruct_1(257,0,2);  
             instruct_0();
             instruct_14();   
             instruct_3(-2,3,0,0,0,0,0,6796,6796,6796,-2,-2,-2); 
             instruct_0(); 
             instruct_13();   
             instruct_1(258,138,0);   
             instruct_0();   
             instruct_1(259,0,1);  
             instruct_0();  
             instruct_1(260,138,0);  
             instruct_0(); 
             instruct_2(327,1);   
             instruct_0();  
             instruct_1(261,246,1);   
             instruct_0(); 
             instruct_1(262,138,0);  
             instruct_0();   
             instruct_14();   
             instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   
             instruct_0();  
             instruct_13();
             TalkEx(CC.TTalk19,590,0); 
             instruct_0();            
             TalkEx(string.format(CC.TTalk20, JY.Person[zj()]["姓名"]),0,1); 
             instruct_0();
             TalkEx(string.format(CC.TTalk21, JY.Person[zj()]["姓名"]),590,0); 
             instruct_0();            
             TalkEx(CC.TTalk22,0,1); 
             instruct_0();
             instruct_1(264,590,0);  
             instruct_0();   
             instruct_1(265,0,1);  
             instruct_0(); 
             TalkEx(CC.TTalk23,590,0); 
             instruct_0();
             if instruct_20() then
             	TalkEx("你的队伍已满，我先回小村吧。",590,0);
             	instruct_3(70,86,1,0,8651,0,0,6804,6804,6804,0,0,0);
             else
             	instruct_10(590);      --加入队友，590号文秀
             	
             end
             
             instruct_14();
	     instruct_3(70,3,0,0,0,0,0,0,0,0,0,0,0);
	     instruct_3(70,4,0,0,0,0,0,0,0,0,0,0,0);
	     instruct_3(70,61,1,0,8602,0,0,5098,5098,5098,0,-2,-2);  --南贤剧情
	     instruct_3(70,62,1,0,8603,0,0,8250,8250,8250,0,-2,-2);  --北丑剧情
             instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);
             instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);
             instruct_0();
             instruct_13();
             instruct_2(230,1);       --得到白马
             instruct_0();
             instruct_37(2);       --道德+2
             instruct_0();
             TalkEx(CC.TTalk24,0,1); 
             instruct_0(); 
          else
             instruct_15(0);   
             instruct_0();
          end
   else
          TalkEx(CC.TTalk25,0,1);  
          instruct_0();
          instruct_25(44,25,36,25);   
          instruct_0();   
          TalkEx(CC.TTalk26,137,0);  
          instruct_0();
          instruct_14();
	  instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);
          instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);
          instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);
          instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);
          instruct_0();
          instruct_13();
          TalkEx(CC.TTalk27,137,0);  
          instruct_0();
          TalkEx(CC.TTalk28,0,2);  
          instruct_0();
          TalkEx(CC.TTalk29,137,0);  
          instruct_0();
          TalkEx(CC.TTalk30,590,4); 
          instruct_0();
          instruct_14();
	  instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);
          instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);
          instruct_0();
          instruct_13();
          instruct_25(36,25,44,25);   
          instruct_0();  
          TalkEx(CC.TTalk31,0,1);  
          instruct_0();
          instruct_25(44,25,36,25);   
          instruct_0();   
          instruct_30(44,25,40,25);  
          instruct_0();
          instruct_3(-2,5,0,0,0,0,0,5926,5926,5926,-2,-2,-2);
          TalkEx(CC.TTalk32,137,0);  
          instruct_0();
          TalkEx(CC.TTalk33,0,1);  
          instruct_0();
          SetS(87,31,33,5,1);   --单挑陈达海战斗数据
          if WarMain(92,1)==true then  --单挑陈达海
             instruct_39(15);          --打开废墟地图
             instruct_3(15,0,0,0,0,0,8610,0,0,0,0,0,0); 
             instruct_13();
             TalkEx(CC.TTalk34,137,0);  
             instruct_0();
             TalkEx(CC.TTalk35,0,1);  
             instruct_0();
             TalkEx(CC.TTalk36,137,0);  
             instruct_0();
             instruct_2(222,1);
             instruct_0(); 
             --[[ 
             instruct_10(92);    --加入队友，92号暂替陈达海
             instruct_0();
             --]]
             instruct_37(-2);       --道德-2
             instruct_0();
             instruct_14();
	     instruct_3(-2,5,0,0,0,0,0,0,0,0,0,0,0);
             instruct_0();
             instruct_13();
             TalkEx(CC.TTalk37,0,1);  
             instruct_0();
             instruct_2(230,1);       --得到白马
             instruct_0();
             instruct_37(-1);       --道德-1
             instruct_0();
          else
             instruct_15(0);   
             instruct_0();
          end
          SetS(87,31,33,5,0);   --单挑陈达海战斗数据还原
   end 
   
   SetS(86,40,40,5,1);  --避免重复触发
end


OEVENTLUA[8602] = function()    --正线南贤剧情
if instruct_28(0,80,100)==false then
   TalkEx(CC.TTalk38,255,0);  
   instruct_0();
   TalkEx(CC.TTalk39,0,1);  
   instruct_0();
else
   TalkEx(CC.TTalk40,255,0);  
   instruct_0();
   TalkEx(CC.TTalk41,0,1);  
   instruct_0();
   TalkEx(CC.TTalk42,255,0);  
   instruct_0();
   instruct_14();
   instruct_39(15);       --打开废墟地图
   instruct_3(-2,61,0,0,0,0,0,0,0,0,0,0,0); 
   instruct_3(-2,62,0,0,0,0,0,0,0,0,0,0,0);
   instruct_3(-2,3,1,0,692,0,0,5098,5098,5098,0,-2,-2);  
   instruct_3(-2,4,1,0,695,0,0,8250,8250,8250,0,-2,-2);  
   instruct_3(15,0,0,0,0,0,8605,0,0,0,0,0,0); 
   instruct_13();
   instruct_2(222,1);
   instruct_0(); 
   TalkEx(CC.TTalk43,255,0);  
   instruct_0();
end
end


OEVENTLUA[8603] = function()    --正线北丑剧情
TalkEx(CC.TTalk44,0,1);  
instruct_0();
TalkEx(CC.TTalk45,256,0);  
instruct_0();
instruct_3(70,62,1,0,8604,0,0,8250,8250,8250,0,-2,-2);
end


OEVENTLUA[8604] = function()    
TalkEx(CC.TTalk49,256,0);  
instruct_0();

local btl=DrawStrBoxYesNo(-1,-1,"是否要给他五宝花蜜酒？",C_ORANGE,CC.DefaultFont);
if btl==true then
   if instruct_18(25)==false then
      TalkEx(CC.TTalk50,256,0);   
      instruct_0();   
   else
      instruct_32(25,-1);
      instruct_0();
      TalkEx(CC.TTalk46,256,0);  
      instruct_0();
      instruct_14();
      instruct_39(15);       --打开废墟地图
      instruct_3(-2,61,0,0,0,0,0,0,0,0,0,0,0); 
      instruct_3(-2,62,0,0,0,0,0,0,0,0,0,0,0);
      instruct_3(-2,3,1,0,692,0,0,5098,5098,5098,0,-2,-2);  
      instruct_3(-2,4,1,0,695,0,0,8250,8250,8250,0,-2,-2); 
      instruct_3(15,0,0,0,0,0,8605,0,0,0,0,0,0);  
      instruct_13();
      instruct_2(222,1);
      instruct_0(); 
      TalkEx(CC.TTalk47,0,1);  
      instruct_0();
      TalkEx(CC.TTalk48,256,0);  
      instruct_0();
   end
else
   instruct_0();   
   return;
end
end


OEVENTLUA[8605] = function()    --正线沙漠剧情
if instruct_16(590)==false then        --590李文秀
   instruct_0();   
   instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);    
else
   instruct_14();  
   instruct_26(3,3,1,0,0);   
   instruct_26(3,2,1,0,0);  
   instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   
   instruct_3(-2,11,0,0,0,0,0,6796,6796,6796,-2,-2,-2);   
   instruct_0();   
   instruct_13();  
   instruct_25(35,26,26,26); 
   instruct_30(35,26,27,26);  
   instruct_0();  
   instruct_1(267,138,0);   
   instruct_0();
   TalkEx(CC.TTalk51,590,0);  
   instruct_0();  
   TalkEx(CC.TTalk52,138,4);  
   instruct_0();
   TalkEx(CC.TTalk53,0,1);  
   instruct_0();  
   TalkEx(CC.TTalk54,590,0);  
   instruct_0();  
   TalkEx(CC.TTalk55,0,1);  
   instruct_0();
   SetS(87,31,34,5,1);  --单挑瓦尔拉齐数据判定

   if instruct_6(91,4,0,0) ==false then    --单挑瓦尔拉齐
      instruct_15(0);   
      instruct_0();
   else 
      instruct_3(-2,11,0,0,0,0,0,5430,5430,5430,-2,-2,-2);
      instruct_0();
      instruct_13();
      TalkEx(CC.TTalk56,0,1);  
      instruct_0();
      instruct_14();  
      instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);    
      instruct_0();      
      instruct_13(); 
      TalkEx(CC.TTalk57,0,1);  
      instruct_0();
      instruct_14();
      instruct_0();   
      instruct_13();
      TalkEx(CC.TTalk58,590,0);  
      instruct_0();
      instruct_3(-2,1,0,0,54,0,0,0,0,0,0,0,0);
      instruct_3(14,3,1,0,8606,0,0,-2,-2,-2,0,0,0);
   end
   SetS(87,31,34,5,0);  --单挑瓦尔拉齐数据还原
end
end

OEVENTLUA[8606] = function() 
TalkEx(CC.TTalk59,269,0);  
instruct_0();
instruct_3(-2,3,1,0,8607,0,0,-2,-2,-2,-2,-2,-2);
end

OEVENTLUA[8607] = function()          --正线智诀剧情
local title = "第一关：智诀";
local str = "请问苍炎的作者是谁？";
local btn = {"SYP","零二七"};
local num = #btn;
local pic = 269;
local r = JYMsgBox(title,str,btn,#btn,pic);

if r==1 then
TalkEx(CC.TTalk60,269,0);  
instruct_0();
instruct_3(-2,3,1,0,8608,0,0,-2,-2,-2,-2,-2,-2);
else
TalkEx(CC.TTalk61,269,0);  
instruct_0();
end
end

OEVENTLUA[8608] = function()  --正线勇心剧情
TalkEx(CC.TTalk62,269,0);  
instruct_0();
SetS(87,31,31,5,1)     --邪15大战斗判定
if WarMain(133,1)==true then    --20时序不败邪15大
   TalkEx(CC.TTalk63,269,0);  
   instruct_0();
   instruct_3(-2,3,1,0,8609,0,0,-2,-2,-2,-2,-2,-2);
else
   instruct_15(0);   
   instruct_0();
end
SetS(87,31,31,5,0)     --邪15大战斗还原
end

OEVENTLUA[8609] = function()         --正线情殇剧情
if instruct_16(590)==false then
   TalkEx(CC.TTalk65,269,0);  
   instruct_0();
else
   TalkEx(CC.TTalk64,269,0);  
   instruct_0();
   local title = "第三关：情殇";
   local str = "请留下一个人的生命作为开门的血祭";
   local btn = {JY.Person[zj()]["姓名"],"李文秀"};
   local num = #btn;
   local pic = 269;
   local r = JYMsgBox(title,str,btn,#btn,pic);

if r==1 then
	local pid = 9999;				--定义一个临时的心魔人物数据
	JY.Person[pid] = {};
	for i=1, #PSX-8 do
		JY.Person[pid][PSX[i]] = JY.Person[zj()][PSX[i]];
	end
	
	JY.Person[pid]["生命最大值"] = math.modf(JY.Person[pid]["生命最大值"]/1);
	JY.Person[pid]["生命"] = JY.Person[pid]["生命最大值"];
	JY.Person[pid]["内力最大值"] = math.modf(JY.Person[pid]["内力最大值"]/1);
	JY.Person[pid]["内力"] = JY.Person[pid]["内力最大值"];
	JY.Person[pid]["体力"] = 100;		
	JY.Person[pid]["医疗能力"] = math.modf(JY.Person[pid]["医疗能力"]/2);
	
	JY.Person[pid]["攻击力"] = math.modf(JY.Person[pid]["攻击力"]/2);
	JY.Person[pid]["防御力"] = math.modf(JY.Person[pid]["防御力"]/2);
	JY.Person[pid]["轻功"] = math.modf(JY.Person[pid]["轻功"]/2);
	
	
	JY.Person[pid]["姓名"] = JY.Person[zj()]["姓名"];
   instruct_37(1);       --道德+1
   instruct_0();
   TalkEx(CC.TTalk66,0,1);  
   instruct_0(); 
   TalkEx(CC.TTalk67,590,0);  
   instruct_0();   
   TalkEx(CC.TTalk68,0,1);  
   instruct_0(); 
   TalkEx(CC.TTalk69,590,0);  
   instruct_0();   
   if putong() == 7 and instruct_43(8)==true then
      TalkEx(CC.TTalk70,590,0);  
      instruct_0();
      instruct_14();
      instruct_13();
      TalkEx(CC.TTalk71,0,1);  
      instruct_0(); 
      TalkEx(CC.TTalk72,0,1);  
      instruct_0(); 
      SetS(87,31,35,5,1)           --心魔战判定
      if WarMain(20) then    --主角挑战心魔
         TalkEx(CC.TTalk88,0,1);  
         instruct_0();
         TalkEx(CC.TTalk89,590,0);  
         instruct_0();  
         TalkEx(CC.TTalk90,0,1);  
         instruct_0();
         TalkEx(CC.TTalk91,590,0);  
         instruct_0(); 
         TalkEx(CC.TTalk92,0,1);  
         instruct_0();
         TalkEx(CC.TTalk93,590,0);  
         instruct_0(); 
         TalkEx(CC.TTalk94,0,1);  
         instruct_0();
         TalkEx(CC.TTalk85,269,0);  
         instruct_0(); 
         TalkEx(CC.TTalk86,0,1);  
         instruct_0();
         instruct_32(8,-1);
         instruct_0();
      else
         instruct_15(0);   
         instruct_0();
         return;
      end
      SetS(87,31,35,5,0)           --心魔战还原
   else
      if instruct_28(0,90,100)==true and instruct_43(8)==true then
         TalkEx(CC.TTalk70,590,0);  
         instruct_0();
         instruct_14();
         instruct_13();
         TalkEx(CC.TTalk71,0,1);  
         instruct_0(); 
         TalkEx(CC.TTalk72,0,1);  
         instruct_0(); 
         SetS(87,31,35,5,1)           --心魔战判定
         if WarMain(20) then   --主角挑战心魔
            TalkEx(CC.TTalk88,0,1);  
            instruct_0();
            TalkEx(CC.TTalk89,590,0);  
            instruct_0();  
            TalkEx(CC.TTalk90,0,1);  
            instruct_0();
            TalkEx(CC.TTalk91,590,0);  
            instruct_0(); 
            TalkEx(CC.TTalk92,0,1);  
            instruct_0();
            TalkEx(CC.TTalk93,590,0);  
            instruct_0(); 
            TalkEx(CC.TTalk94,0,1);  
            instruct_0();
            TalkEx(CC.TTalk85,269,0);  
            instruct_0(); 
            TalkEx(CC.TTalk86,0,1);  
            instruct_0();
            instruct_32(8,-1);
            instruct_0();
         else
            instruct_15(0);   
            instruct_0();
         end
         SetS(87,31,35,5,0)           --心魔战还原
      else
         instruct_15(0);   
         instruct_0();
         return;
      end
   end
else
   instruct_37(-5);       --道德-5
   instruct_0();
   TalkEx(CC.TTalk77,590,0);  
   instruct_0();  
   TalkEx(CC.TTalk78,0,1);  
   instruct_0();
   TalkEx(CC.TTalk79,590,0);  
   instruct_0();   
   if putong() == 7 and instruct_43(8)==true then
      TalkEx(CC.TTalk80,0,1);  
      instruct_0();
      instruct_14(); 
      instruct_0(); 
      instruct_13();
      TalkEx(CC.TTalk81,0,1);  
      instruct_0();
      TalkEx(CC.TTalk82,590,0);  
      instruct_0(); 
      TalkEx(CC.TTalk83,0,1);  
      instruct_0();
      TalkEx(CC.TTalk84,590,0);  
      instruct_0(); 
      TalkEx(CC.TTalk85,269,0);  
      instruct_0(); 
      TalkEx(CC.TTalk86,0,1);  
      instruct_0();
      instruct_32(8,-1);
      instruct_0();
   else
      if instruct_43(8)==true then
         TalkEx(CC.TTalk80,0,1);  
         instruct_0();
         instruct_14(); 
         instruct_0(); 
         instruct_13();
         TalkEx(CC.TTalk81,0,1);  
         instruct_0();
         TalkEx(CC.TTalk82,590,0);  
         instruct_0(); 
         TalkEx(CC.TTalk83,0,1);  
         instruct_0();
         TalkEx(CC.TTalk84,590,0);  
         instruct_0(); 
         TalkEx(CC.TTalk85,269,0);  
         instruct_0(); 
         TalkEx(CC.TTalk86,0,1);  
         instruct_0();
         instruct_32(8,-1);
         instruct_0();
         AddPersonAttrib(0, "内力最大值", -5000);
         instruct_22();
      else
         instruct_21(92)   
         instruct_0();
         TalkEx(CC.TTalk87,0,1);  
         instruct_0();
      end
   end
end
TalkEx(CC.TTalk73,0,1);  
instruct_0(); 
instruct_57();
instruct_3(-2,2,1,1,0,0,0,7746,7746,7746,-2,-2,-2);   
instruct_3(-2,3,0,0,0,0,0,7804,7804,7804,-2,-2,-2);   
instruct_3(-2,4,1,0,0,0,0,7862,7862,7862,-2,-2,-2);   
end
end

OEVENTLUA[8610] = function()  --邪线沙漠剧情
instruct_14();   
instruct_26(3,3,1,0,0);  
instruct_26(3,2,1,0,0);   
instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);  
instruct_3(-2,2,0,0,0,0,0,5218,5218,5218,-2,-2,-2); 
instruct_3(-2,3,0,0,0,0,0,5220,5220,5220,-2,-2,-2);  
instruct_3(-2,4,0,0,0,0,0,5220,5220,5220,-2,-2,-2);  
instruct_3(-2,5,0,0,0,0,0,6766,6766,6766,-2,-2,-2);  
instruct_3(-2,6,0,0,0,0,0,6766,6766,6766,-2,-2,-2);   
instruct_3(-2,7,0,0,0,0,0,6768,6768,6768,-2,-2,-2);  
instruct_3(-2,8,0,0,0,0,0,6768,6768,6768,-2,-2,-2);   
instruct_3(-2,9,0,0,0,0,0,6768,6768,6768,-2,-2,-2);   
instruct_3(-2,10,0,0,0,0,0,6770,6770,6770,-2,-2,-2);  
instruct_3(-2,11,0,0,0,0,0,6772,6772,6772,-2,-2,-2);  
instruct_3(-2,12,0,0,0,0,0,6772,6772,6772,-2,-2,-2);  
instruct_3(-2,13,0,0,0,0,0,6774,6774,6774,-2,-2,-2);  
instruct_0();  
instruct_13();   
instruct_25(35,26,26,26);  
instruct_1(267,138,0);   
instruct_0();   

if instruct_6(91,4,0,0) ==false then    --群战瓦尔拉齐
   instruct_15(0);   
   instruct_0();   
else
    instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   
    instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   
    instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);  
    instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);   
    instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   
    instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   
    instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);   
    instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);   
    instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);   
    instruct_3(-2,6,0,0,0,0,0,0,0,0,0,0,0);   
    instruct_3(-2,5,0,0,0,0,0,0,0,0,0,0,0);   
    instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);   
    instruct_0();   
    instruct_13();
    instruct_3(14,3,1,0,8611,0,0,-2,-2,-2,0,0,0);
end
end

OEVENTLUA[8611] = function()   
TalkEx(CC.TTalk59,269,0);  
instruct_0();
instruct_3(-2,3,1,0,8612,0,0,-2,-2,-2,-2,-2,-2);
end

OEVENTLUA[8612] = function()     --邪线仁德剧情
local title = "第一关：智诀";
local str = "请问如果有一个人同时被15个人打，你会不会帮他？";
local btn = {"会","不会"};
local num = #btn;
local pic = 269;
local r = JYMsgBox(title,str,btn,#btn,pic);

if r==2 then
	TalkEx(CC.TTalk60,269,0);  
	instruct_0();
	TalkEx(CC.TTalk101,269,0);  
	instruct_0();
	SetS(87,31,32,5,1)     --正15大战斗判定
	if WarMain(134,1)==true then   --20时序不败正15大
	   TalkEx(CC.TTalk63,269,0);  
	   instruct_0();
	   instruct_3(-2,3,1,0,8614,0,0,-2,-2,-2,-2,-2,-2);
	else
	   instruct_15(0);   
	   instruct_0();
	end
	SetS(87,31,32,5,0)     --正15大战斗还原
else
TalkEx(CC.TTalk61,269,0);  
instruct_0();
end
end



OEVENTLUA[8614] = function()  --邪线情殇剧情
	if instruct_16(92)==false and JY.Person[0]["性别"] == 0 and not T8LXY(0) then
	   TalkEx(CC.TTalk65,269,0);  
	   instruct_0(); 
	else  
	   TalkEx(CC.TTalk64,269,0);  
	   instruct_0();
	   local title = "第三关：情殇";
	   local str = "过此门必须拿最心爱的女人的性命作为*血祭，或放弃所有情欲，从此绝子绝孙。";
	   local btn = {"小鸡鸡",JY.Person[92]["姓名"]};
	   local num = #btn;
	   local pic = 269;
	   local r = JYMsgBox(title,str,btn,#btn,pic);
		if (T8LXY(0) or T4WXS(0) or T5BCF(0) or T6XQS(0)) and zj() == 0 then
			instruct_0()
			say("嘿，什么东西在此装神弄鬼！本少爷偏偏全都不选！咄！")
			local pid = 9999;				--定义一个临时的心魔人物数据
			JY.Person[pid] = {};
			for i=1, #PSX-8 do
				JY.Person[pid][PSX[i]] = JY.Person[0][PSX[i]];
			end
			
			JY.Person[pid]["生命最大值"] = math.modf(JY.Person[pid]["生命最大值"]/1);
			JY.Person[pid]["生命"] = JY.Person[pid]["生命最大值"];
			JY.Person[pid]["内力最大值"] = math.modf(JY.Person[pid]["内力最大值"]/1);
			JY.Person[pid]["内力"] = JY.Person[pid]["内力最大值"];
			JY.Person[pid]["医疗能力"] = 0
			JY.Person[pid]["攻击力"] = math.modf(JY.Person[pid]["攻击力"]/2);
			JY.Person[pid]["防御力"] = math.modf(JY.Person[pid]["防御力"]/2);
			JY.Person[pid]["轻功"] = math.modf(JY.Person[pid]["轻功"]/2);
			JY.Person[pid]["姓名"] = JY.Person[0]["姓名"];
		   instruct_37(1);       --道德+1
		   instruct_0(); 
		   instruct_0();
			  SetS(87,31,35,5,1)           --心魔战判定
			  if WarMain(20,1)==true then   --主角挑战心魔
				 instruct_0();
			  else
				 instruct_15(0);   
				 instruct_0();
				 return;
			  end
			  SetS(87,31,35,5,0)           --心魔战还原		
		elseif JY.Person[0]["性别"] == 1 and zj() == 0 then
			instruct_0()
			say("嘿，什么东西在此装神弄鬼！本姑娘偏偏全都不选！咄！")
			local pid = 9999;				--定义一个临时的心魔人物数据
			JY.Person[pid] = {};
			for i=1, #PSX-8 do
				JY.Person[pid][PSX[i]] = JY.Person[0][PSX[i]];
			end
			
			JY.Person[pid]["生命最大值"] = math.modf(JY.Person[pid]["生命最大值"]/1);
			JY.Person[pid]["生命"] = JY.Person[pid]["生命最大值"];
			JY.Person[pid]["内力最大值"] = math.modf(JY.Person[pid]["内力最大值"]/1);
			JY.Person[pid]["内力"] = JY.Person[pid]["内力最大值"];
			JY.Person[pid]["医疗能力"] = 0
			JY.Person[pid]["攻击力"] = math.modf(JY.Person[pid]["攻击力"]/2);
			JY.Person[pid]["防御力"] = math.modf(JY.Person[pid]["防御力"]/2);
			JY.Person[pid]["轻功"] = math.modf(JY.Person[pid]["轻功"]/2);
			JY.Person[pid]["姓名"] = JY.Person[0]["姓名"];
		   instruct_37(1);       --道德+1
		   instruct_0(); 
		   instruct_0();
			  SetS(87,31,35,5,1)           --心魔战判定
			  if WarMain(20,1)==true then   --主角挑战心魔
				 instruct_0();
			  else
				 instruct_15(0);   
				 instruct_0();
				 return;
			  end
			  SetS(87,31,35,5,0)           --心魔战还原		
		elseif JY.Person[0]["性别"] == 2 and zj() == 0 then
			instruct_0()
			say("嘿，什么东西在此装神弄鬼！杂家偏偏全都不选！咄！")
			local pid = 9999;				--定义一个临时的心魔人物数据
			JY.Person[pid] = {};
			for i=1, #PSX-8 do
				JY.Person[pid][PSX[i]] = JY.Person[0][PSX[i]];
			end
			
			JY.Person[pid]["生命最大值"] = math.modf(JY.Person[pid]["生命最大值"]/1);
			JY.Person[pid]["生命"] = JY.Person[pid]["生命最大值"];
			JY.Person[pid]["内力最大值"] = math.modf(JY.Person[pid]["内力最大值"]/1);
			JY.Person[pid]["内力"] = JY.Person[pid]["内力最大值"];
			JY.Person[pid]["医疗能力"] = 0
			JY.Person[pid]["攻击力"] = math.modf(JY.Person[pid]["攻击力"]/2);
			JY.Person[pid]["防御力"] = math.modf(JY.Person[pid]["防御力"]/2);
			JY.Person[pid]["轻功"] = math.modf(JY.Person[pid]["轻功"]/2);
			JY.Person[pid]["姓名"] = JY.Person[0]["姓名"];
		   instruct_37(1);       --道德+1
		   instruct_0(); 
		   instruct_0();
			  SetS(87,31,35,5,1)           --心魔战判定
			  if WarMain(20,1)==true then   --主角挑战心魔
				 instruct_0();
			  else
				 instruct_15(0);   
				 instruct_0();
				 return;
			  end
			  SetS(87,31,35,5,0)           --心魔战还原			  
		else
		if r==1 then
			local pid = 9999;				--定义一个临时的心魔人物数据
			JY.Person[pid] = {};
			for i=1, #PSX-8 do
				JY.Person[pid][PSX[i]] = JY.Person[zj()][PSX[i]];
			end
			
			JY.Person[pid]["生命最大值"] = math.modf(JY.Person[pid]["生命最大值"]/1);
			JY.Person[pid]["生命"] = JY.Person[pid]["生命最大值"];
			JY.Person[pid]["内力最大值"] = math.modf(JY.Person[pid]["内力最大值"]/1);
			JY.Person[pid]["内力"] = JY.Person[pid]["内力最大值"];
			JY.Person[pid]["医疗能力"] = 0
			JY.Person[pid]["攻击力"] = math.modf(JY.Person[pid]["攻击力"]/1);
			JY.Person[pid]["防御力"] = math.modf(JY.Person[pid]["防御力"]/1);
			JY.Person[pid]["轻功"] = math.modf(JY.Person[pid]["轻功"]/1);
			JY.Person[pid]["姓名"] = JY.Person[zj()]["姓名"];
		   instruct_37(1);       --道德+1
		   instruct_0();
		   TalkEx(CC.TTalk102,0,1);  
		   instruct_0();
			  SetS(87,31,35,5,1)           --心魔战判定
			  if WarMain(20,1)==true then   --主角挑战心魔
				 instruct_0();
			  else
				 instruct_15(0);   
				 instruct_0();
				 return;
			  end
			  SetS(87,31,35,5,0)           --心魔战还原
			  			lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_RED, 128)
			ShowScreen()
			lib.Delay(80)
			lib.ShowSlow(15, 1)
			Cls()
			lib.ShowSlow(100, 0)
			JY.Person[zj()]["性别"] = 2
			SetS(86,15,15,5,1)
			local add, str = AddPersonAttrib(zj(), "攻击力", -20)
			DrawStrBoxWaitKey(JY.Person[zj()]["姓名"] .. str, C_ORANGE, CC.DefaultFont)
			add, str = AddPersonAttrib(zj(), "防御力", -30)
			DrawStrBoxWaitKey(JY.Person[zj()]["姓名"] .. str, C_ORANGE, CC.DefaultFont)
			Talk(CC.TTalk104,92); 
			Talk(CC.TTalk105,0); 
			Talk(CC.TTalk106,92);
		else
		   Talk(CC.TTalk74,0); 	--主角战女主
		   SetS(87,31,35,5,2)
			if instruct_6(20,4,0,0) ==false then    --  6(6):战斗[74]是则跳转到:Label2
				instruct_15(0);   --  15(F):战斗失败，死亡
				instruct_0();   --  0(0)::空语句(清屏)
				do return; end
			end  
			SetS(87,31,35,5,0) --女主战还原
		   	lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_RED, 128)
			ShowScreen()
			lib.Delay(80)
			lib.ShowSlow(15, 1)
			Cls()
			lib.ShowSlow(100, 0)
		   Talk(CC.TTalk75,92);
         instruct_14(); 
         instruct_0(); 
         instruct_13();
		   instruct_37(-10);       
		   instruct_0();  
		   instruct_21(92);   
		   instruct_0();   
		end
		end
		TalkEx(CC.TTalk73,0,1);  
		instruct_0(); 
		instruct_57();
		instruct_3(-2,2,1,1,0,0,0,7746,7746,7746,-2,-2,-2);   
		instruct_3(-2,3,0,0,0,0,0,7804,7804,7804,-2,-2,-2);   
		instruct_3(-2,4,1,0,0,0,0,7862,7862,7862,-2,-2,-2); 
	end
end



OEVENTLUA[8615] = function()

end

--重写挑战十八铜人
--两个选择，一：单挑，挺过800时序   二：群战，500时序内战胜
OEVENTLUA[712] = function()
		
	local title = "挑战十八铜人";
	local str = "少林铜人巷，每个人只有一次机率*请选择挑战的方式*单挑，胜利条件：挺过800时序*群战，胜利条件：500时序内战胜*"
	local btn = {"单挑","群战","放弃"};
	local num = #btn;
	local r = JYMsgBox(title,str,btn,num);
	
	if r == 3 then
		return;
	end
	
	--单挑
	if r == 1 then
		SetS(86,1,2,5,1);		--判断单挑十八铜人
	end
	
	--群战
	if r == 2 then
		SetS(86,1,2,5,2);		--判断单挑十八铜人
	end

  instruct_1(2881,210,0);   --  1(1):[???]说: 好，施主里边请！
  instruct_0();   --  0(0)::空语句(清屏)
  instruct_19(41,14);   --  19(13):主角移动至29-E
  instruct_0();   --  0(0)::空语句(清屏)

	if instruct_6(217,0,7,1) ==true then    --  6(6):战斗[217]否则跳转到:Label3
	  instruct_19(41,7);   --  19(13):主角移动至29-7
	  instruct_0();   --  0(0)::空语句(清屏)
	  instruct_13();   --  13(D):重新显示场景
	  instruct_0();   --  0(0)::空语句(清屏)
	  do return; end
	end    --:Label3

  instruct_19(42,17);   --  19(13):主角移动至2A-11
  instruct_0();   --  0(0)::空语句(清屏)
  instruct_13();   --  13(D):重新显示场景
  instruct_3(-2,-2,1,0,709,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
end



--未收狄云前，丁典坟墓前对话
OEVENTLUA[8011] = function()
	QZXS(CC.LTalk92);	--丁典之墓
	Talk(CC.LTalk93,0);
end

--收狄后，药王庙触发事件
OEVENTLUA[8012] = function()
	Talk(CC.LTalk94, 37);
	Talk(CC.LTalk95, 0);
	instruct_3(103,-2,1,0,8011,0,0,-2,-2,-2,-2,-2,-2);		--修改药王庙事件
	instruct_3(103,80,1,0,8001,0,0,8818,8818,8818,0,0,0);		--修改药王庙事件
end

--第一次见到，独孤求败
OEVENTLUA[8013] = function()
	MyTalk(CC.LTalk96, 592);		--武学之道在于变而不在于招*剑学之道不在于剑而在于心*有心万物皆为剑
	MyTalk(CC.LTalk97, 592);		--生平求一敌手而不可得，诚寂寥难堪也
	
	if instruct_5(2,0) then
		Talk(CC.LTalk98, 0);		--久仰独孤前辈大名，在下今日特来向前辈请教
		MyTalk(CC.LTalk99, 592);	--哈哈~~果然是后生可畏~~请~~"
		
		if WarMain(239) then
			say("好，痛快！吾此生无憾已！",592) 
	        if PersonKF(0, 47) and GetS(111, 0, 0, 0) == 0 then
	           say("观汝招式有吾几分神采，承吾衣钵何如？",592) 
			   instruct_0();
			   say("（这都啥年代了，讲话咋这酸捏。。）",0) 
	           instruct_0();
			   if instruct_11(0,188) == true then
	               QZXS("领悟独孤精髓！")
	               instruct_0();
	               say("多谢前辈",0) 
	               SetS(111, 0, 0, 0,592)
			   else
				   say("如此，吾亦不强求。然日后江湖大战，莫忘唤吾前来，哈",592) 
			   end 
			   instruct_3(-2,-2,-2,-2,8014,-2,-2,-2,-2,-2,-2,-2,-2);
               do return; end
            end
			instruct_3(-2,-2,-2,-2,8014,-2,-2,-2,-2,-2,-2,-2,-2);
			do return; end
		end
		MyTalk(CC.LTalk101, 592);
		instruct_3(-2,-2,-2,-2,8015,-2,-2,-2,-2,-2,-2,-2,-2);
	end
end

--战胜，独孤求败
OEVENTLUA[8014] = function()
	MyTalk(CC.LTalk100, 592);
	addHZ(12)
	addHZ(145)
	--打胜后可召唤到战场
	SetS(86,10,20,5,1);
end

--战败，独孤求败
OEVENTLUA[8015] = function()
	MyTalk(CC.LTalk97, 592);		--生平求一敌手而不可得，诚寂寥难堪也
	
	if instruct_5(2,0) then
		MyTalk(CC.LTalk99, 592);	--哈哈~~果然是后生可畏~~请~~"
		
		if WarMain(239) then
			say("好，痛快！吾此生无憾已！",592) 
	        if PersonKF(0, 47) and GetS(111, 0, 0, 0) == 0 then
	           say("观汝招式有吾几分神采，承吾衣钵何如？",592) 
			   instruct_0();
			   say("（这都啥年代了，讲话咋这酸捏。。）",0) 			   
	           instruct_0();
			   if instruct_11(0,188) == true then
	              QZXS("领悟独孤精髓！")
	              instruct_0();
	              say("多谢前辈",0) 
	              SetS(111, 0, 0, 0,592)
			   else
			      say("如此，吾亦不强求。然日后江湖大战，莫忘唤吾前来，哈",592) 
			   end 
			   instruct_3(-2,-2,-2,-2,8014,-2,-2,-2,-2,-2,-2,-2,-2);
               do return; end
            end
			instruct_3(-2,-2,-2,-2,8014,-2,-2,-2,-2,-2,-2,-2,-2);
			do return; end
		end
		MyTalk(CC.LTalk101, 592);		--武学造诣很好，只可惜太过冒进。先去江湖历练一番吧。
	end
end

--蓝烟清：田伯光，高升客栈调戏小琳戏事件
OEVENTLUA[8016] = function()
	if inteam(29) and GetS(86,10,11,5) == 0 and GetD(1,15,4) <= 0 then
	
		instruct_3(-2,34,0,0,0,0,0,0,0,0,0,0,0);			--清除贴图
		instruct_3(-2,35,0,0,0,0,0,0,0,0,0,0,0);			--
	
		instruct_3(-2,37,1,0,0,0,0,2598*2,2598*2,2598*2,0,0,0);			--仪琳贴图
		instruct_25(0, 4, 0, 0);
		Talk(CC.LTalk102, 29);		--哎，贤弟，你看那边，那小妮子长得好生俊俏呀。虽是个小尼姑，但也别有一番风味哦。
		Talk(CC.LTalk103, 0);		--哦，是吗？咦，她长得倒真是挺俊美呀，可她是个小尼姑哦！田兄，莫非连这类型的也感兴趣？
		Talk(CC.LTalk104, 29);	--哎呀，贤弟，我管她小尼姑还是小蘑菇，只要是年轻俊美的女人，我“采花大盗“田大侠就绝不会放过，哈哈哈，要不贤弟，你我一起去风流风流？哈哈…..
		Talk(CC.LTalk105, 0);		--……
		
		instruct_14();
		instruct_3(-2,36,1,0,0,0,0,3615*2,3615*2,3615*2,0,0,0);			--田伯光贴图
		JY.Base["人X1"] = 21
		JY.Base["人Y1"] = 22
		instruct_40(1);		--主角位置变化
		instruct_3(-2,37,1,0,0,0,0,2600*2,2600*2,2600*2,0,0,0);			--仪琳贴图
		instruct_13();
		
		
		Talk(CC.LTalk106, 29);	--哈哈，小美人，你这小脸蛋长得可真好看呀，看的我田大爷是心花怒放啊，真是越看越喜欢呀。来，陪我田大爷玩玩吧。就你这花容月貌的姿色，做小尼姑，实在太可惜啦。
		say3(CC.LTalk107, 346, "仪琳");--啊，你这色胆包天的淫贼，光天化日之下竟敢这样轻薄于人？
		Talk(CC.LTalk108, 29);	
		say3(CC.LTalk109, 346, "仪琳");
		
		instruct_14();
		instruct_3(-2,39,1,0,0,0,0,3574*2,3574*2,3574*2,0,0,0);			--令狐冲贴图
		instruct_13();
		
		Talk(CC.LTalk110, 35);		--好大胆的淫贼
		
		--战胜，田伯光全属性+10
		if WarMain(241) then
			AddPersonAttrib(29, "攻击力", 10);
			AddPersonAttrib(29, "防御力", 10);
			AddPersonAttrib(29, "轻功", 10);
                                                AddPersonAttrib(29, "御剑能力", 10)
			QZXS("田伯光攻防轻,御剑能力各上升十点");
		end
		
		Talk(CC.LTalk111, 35);
		
		instruct_14();
		instruct_3(-2,37,0,0,0,0,0,0,0,0,0,0,0);			--清除贴图
		instruct_3(-2,39,0,0,0,0,0,0,0,0,0,0,0);			--令狐冲贴图
		instruct_13();
		
		Talk(CC.LTalk112, 29);
		
		instruct_14();
		instruct_3(-2,36,0,0,0,0,0,0,0,0,0,0,0);			
		instruct_13();
		
		instruct_37(-1);	--道德-1
		SetS(86,10,11,5,1);
	end
	
end
--设置简易线笑傲江湖
OEVENTLUA[752] = function()
	if DrawStrBoxYesNo(-1, -1, "是否进入简易线剧情？", C_WHITE, 30) == true then
		dark()
		for i = 0 ,28 do
			if i < 7 or i > 14 then
			null(57,i)
			end
		end
		null(30,0)
		instruct_17(55, 1, 30, 47, 0)
		addevent(40, 23, 1, 774, 1)
		addevent(37,5,1,1053,1,6804)
		instruct_3(70, 15, 1, 0, 121, 0, 0, 5722, 5748, 5722, -2, -2, -2)
		instruct_3(70, 29, 1, 0, 115, 0, 0, 5904, 5904, 5904, -2, -2, -2)
		JY.Person[0]["实战"] = (JY.Person[0]["实战"] or 0) + 50
		instruct_35(35,0,47,700)
		null(-2,0)
		light()
		addthing(54)
		addthing(67)
		addthing(180)
		addthing(187)
		addthing(358)
		bgtalk("请先回小村收令狐")
		bgtalk("再至梅庄进行后续剧情")
	else
		addevent(-2, 2, 1, 753, 1, 5896)
		--addevent(sid, pid, pass, event, etype, pic, x, y)
		dark()
		addevent(-2, 2, 1, 753, 1, 5896)
		addevent(-2, 3, 1, 754, 1, 7624)
		instruct_35(35,0,47,700)
		instruct_47(35,50)
		null(-2,0)
		light()
		walkme(19,37)
		instruct_40(2)
		Cls()
		say("令狐兄，好久不见了，这位老前辈是？",0)
		say("不要问我的姓名，也不要和任何人提起你们见过我。",140)
		say("那在下就不多问了。令狐兄，一向可好？",0)
		say("还好。上次下山犯了门规，被师父罚到此处面壁思过。正好巧遇老前辈，受益匪浅啊",35)
		say("只是好久不见小师妹了，有些想念。她好久没来了，是生病了吗？",35)
		say("岳姑娘？令狐兄不必挂怀，岳姑娘很好，和林兄弟处得很开心。",0)
		say("你是说……？哦……唉……林师弟和他年纪相当……",35)
		say("冲儿，我刚教你得剑法，和*这位少侠过招试试吧。",140)
		say("是，太师叔！少侠，你准备*一下，咱们比试比试！",35)
		Cls()
	end
		--[[14(E):场景从明亮渐变为暗淡
   3(3):修改事件定义:当前场景场景事件编号[2]
   3(3):修改事件定义:当前场景场景事件编号[3]
   3(3):修改事件定义:当前场景当前场景事件编号
   35(23):设置[35令狐冲]武功[0]为[47独孤九剑]经验为700
   47(2F):[35令狐冲]增加武功50
   13(D):场景重新显示
   30(1E):主角走动48-36--19-37
   40(28):主角站立方向2
   0(0):空指令(清屏)
   1(1):[0资]:
   0(0):空指令(清屏)
   1(1):[249雪山弟子]:
   0(0):空指令(清屏)
   1(1):[0资]:
   0(0):空指令(清屏)
   1(1):[35令狐冲]:。
   0(0):空指令(清屏)
   1(1):[0资]:
   0(0):空指令(清屏)
   1(1):[35令狐冲]:
   0(0):空指令(清屏)
   1(1):[249雪山弟子]:
   0(0):空指令(清屏)
   1(1):[35令狐冲]:
   0(0):空指令(清屏)
   -1(FFFF):事件结束
	end]]
end
--重写多次单挑令狐冲事件
OEVENTLUA[754] = function()

    if instruct_5(0,693) ==true then    --  5(5):是否选择战斗？否则跳转到:Label0
        instruct_0();   --  0(0)::空语句(清屏)
				
				--如果田伯光在队
				if inteam(29) and GetS(86,10,11,5) == 1 then
					Talk(CC.LTalk113, 29);
					Talk(CC.LTalk114, 35);
					
					while instruct_29(35,150,9999,0,332) == false do
						if WarMain(241) then
							instruct_1(2998,249,0);   --  1(1):[???]说: 冲儿，进步不小，我再教你*几招，再和他比过！
        			instruct_0();   --  0(0)::空语句(清屏)
        			instruct_47(35,20);   --  47(2F):令狐冲增加攻击力20
        			instruct_48(35,50);   --  48(30):令狐冲增加生命50
        		else
        			break;
						end
					end
					
					Talk(CC.LTalk128, 29);
					--田伯光轻功增加20点
					AddPersonAttrib(29, "轻功", 20);
					QZXS("田伯光轻功增加20点");
					
					instruct_3(31,7,1,0,8017, 0, 0, 2597*2, 2597*2, 2597*2, 0,0,0);		--仪琳出现在恒山派
					SetS(86,10,11,5,2);
					
					instruct_1(3000,195,0);   --  1(1):[???]说: 大师兄，大师兄～～
          instruct_0();   --  0(0)::空语句(清屏)
          instruct_1(3001,249,0);   --  1(1):[???]说: 有华山派的人来了，我要走*了，记住，你们不许跟任何*人提起我！
          instruct_0();   --  0(0)::空语句(清屏)
          instruct_14();   --  14(E):场景变黑
          instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
          instruct_3(-2,4,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
          instruct_3(57,17,1,0,0,0,0,7018,7018,7018,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [17]
          instruct_3(57,19,1,0,0,0,0,7150,7150,7150,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [19]
          instruct_3(57,20,1,0,0,0,0,7158,7158,7158,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [20]
          instruct_3(57,18,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [18]
          instruct_3(57,23,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [23]
          instruct_3(57,21,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [21]
          instruct_3(57,22,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [22]
          instruct_3(57,24,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [24]
          instruct_3(57,28,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [28]
          instruct_3(57,27,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [27]
          instruct_3(57,26,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [26]
          instruct_3(57,25,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [25]
          instruct_3(57,6,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [6]
          instruct_3(57,5,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [5]
          instruct_3(57,2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [2]
          instruct_3(57,15,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [15]
          instruct_3(57,29,0,0,0,0,755,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [29]
          instruct_0();   --  0(0)::空语句(清屏)
          instruct_13();   --  13(D):重新显示场景
			                                AddPersonAttrib(35, "御剑能力", 30);
					QZXS("令狐冲被风清扬调教几天后御剑能力增加30点");
          instruct_1(3002,35,0);   --  1(1):[令狐冲]说: 六猴，什么事，慌慌张张的。
          instruct_0();   --  0(0)::空语句(清屏)
          instruct_1(3003,195,0);   --  1(1):[???]说: 大师兄，不好了，成不忧拿*着左盟主的五岳令旗，要逼*师父让出掌门之位。
          instruct_0();   --  0(0)::空语句(清屏)
          instruct_1(3004,35,0);   --  1(1):[令狐冲]说: 什么！*走，马上去看看！
          instruct_0();   --  0(0)::空语句(清屏)
          instruct_14();   --  14(E):场景变黑
          instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
          instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
          instruct_0();   --  0(0)::空语句(清屏)
          instruct_13();   --  13(D):重新显示场景
          instruct_0();   --  0(0)::空语句(清屏)
					return ;
				end

        if instruct_6(204,333,0,1) ==false then    --  6(6):战斗[204]是则跳转到:Label1
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            instruct_1(2999,0,1);   --  1(1):[AAA]说: 令狐兄的剑法出神入化，在*下佩服佩服！
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_1(3000,195,0);   --  1(1):[???]说: 大师兄，大师兄～～
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_1(3001,249,0);   --  1(1):[???]说: 有华山派的人来了，我要走*了，记住，你们不许跟任何*人提起我！
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
            instruct_3(-2,4,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
            instruct_3(57,17,1,0,0,0,0,7018,7018,7018,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [17]
            instruct_3(57,19,1,0,0,0,0,7150,7150,7150,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [19]
            instruct_3(57,20,1,0,0,0,0,7158,7158,7158,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [20]
            instruct_3(57,18,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [18]
            instruct_3(57,23,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [23]
            instruct_3(57,21,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [21]
            instruct_3(57,22,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [22]
            instruct_3(57,24,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [24]
            instruct_3(57,28,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [28]
            instruct_3(57,27,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [27]
            instruct_3(57,26,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [26]
            instruct_3(57,25,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [25]
            instruct_3(57,6,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [6]
            instruct_3(57,5,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [5]
            instruct_3(57,2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [2]
            instruct_3(57,15,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [15]
            instruct_3(57,29,0,0,0,0,755,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [29]
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
			                                AddPersonAttrib(35, "御剑能力", 30);
					QZXS("令狐冲被风清扬调教几天后御剑能力增加30点");
            instruct_1(3002,35,0);   --  1(1):[令狐冲]说: 六猴，什么事，慌慌张张的。
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_1(3003,195,0);   --  1(1):[???]说: 大师兄，不好了，成不忧拿*着左盟主的五岳令旗，要逼*师父让出掌门之位。
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_1(3004,35,0);   --  1(1):[令狐冲]说: 什么！*走，马上去看看！
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
            instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
        end    --:Label1

        instruct_0();   --  0(0)::空语句(清屏)
        instruct_13();   --  13(D):重新显示场景

        if instruct_29(35,150,9999,0,332) ==true then    --  29(1D):判断令狐冲武力150-9999否则跳转到:Label2
            instruct_1(2999,0,1);   --  1(1):[AAA]说: 令狐兄的剑法出神入化，在*下佩服佩服！
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_1(3000,195,0);   --  1(1):[???]说: 大师兄，大师兄～～
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_1(3001,249,0);   --  1(1):[???]说: 有华山派的人来了，我要走*了，记住，你们不许跟任何*人提起我！
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [2]
            instruct_3(-2,4,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
            instruct_3(57,17,1,0,0,0,0,7018,7018,7018,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [17]
            instruct_3(57,19,1,0,0,0,0,7150,7150,7150,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [19]
            instruct_3(57,20,1,0,0,0,0,7158,7158,7158,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [20]
            instruct_3(57,18,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [18]
            instruct_3(57,23,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [23]
            instruct_3(57,21,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [21]
            instruct_3(57,22,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [22]
            instruct_3(57,24,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [24]
            instruct_3(57,28,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [28]
            instruct_3(57,27,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [27]
            instruct_3(57,26,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [26]
            instruct_3(57,25,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [25]
            instruct_3(57,6,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [6]
            instruct_3(57,5,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [5]
            instruct_3(57,2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [2]
            instruct_3(57,15,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [15]
            instruct_3(57,29,0,0,0,0,755,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[华山派]:场景事件编号 [29]
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
			                                AddPersonAttrib(35, "御剑能力", 30);
					QZXS("令狐冲被风清扬调教几天后御剑能力增加30点");
            instruct_1(3002,35,0);   --  1(1):[令狐冲]说: 六猴，什么事，慌慌张张的。
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_1(3003,195,0);   --  1(1):[???]说: 大师兄，不好了，成不忧拿*着左盟主的五岳令旗，要逼*师父让出掌门之位。
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_1(3004,35,0);   --  1(1):[令狐冲]说: 什么！*走，马上去看看！
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_14();   --  14(E):场景变黑
            instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [4]
            instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
            instruct_0();   --  0(0)::空语句(清屏)
            instruct_13();   --  13(D):重新显示场景
            do return; end
            instruct_0();   --  0(0)::空语句(清屏)
        end    --:Label2

        instruct_1(2998,249,0);   --  1(1):[???]说: 冲儿，进步不小，我再教你*几招，再和他比过！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_14();   --  14(E):场景变黑
        instruct_47(35,20);   --  47(2F):令狐冲增加攻击力20
        instruct_48(35,50);   --  48(30):令狐冲增加生命50
        instruct_13();   --  13(D):重新显示场景
        do return; end
    end    --:Label0

    instruct_0();   --  0(0)::空语句(清屏)
end


--蓝烟清：田伯光，恒山派再遇仪琳小师妹
OEVENTLUA[8017] = function()
	if inteam(29) and GetS(86,10,11,5) == 2 then
		Talk(CC.LTalk115, 29);
		say3(CC.LTalk116, 346, "仪琳");
		Talk(CC.LTalk117, 29);
		
		instruct_3(-2, 40, 1, 0, 0, 0, 0, 2968*2, 2968*2, 2968*2, 0, 0, 0);
		instruct_3(-2, 41, 1, 0, 0, 0, 0, 5196, 5196, 5196, 0, 0, 0);
		instruct_3(-2, 42, 1, 0, 0, 0, 0, 5196, 5196, 5196, 0, 0, 0);
		
		Talk(CC.LTalk118, 21);
		
		if WarMain(242) == false then			--战定闲，失败死亡
			instruct_15();
			return;
		end
		
		Talk(CC.LTalk119, 29);
		Talk(CC.LTalk120, 21);
		Talk(CC.LTalk121, 29);
		
		instruct_3(-2, 43, 1, 0, 0, 0, 0, 4412*2, 4412*2, 4412*2, 0, 0, 0);
		MyTalk(CC.LTalk122, 593);		--
		
		if WarMain(243) then		--战不戒和尚
			Talk(CC.LTalk123, 0);
			Talk(CC.LTalk124, 29);
			Talk(CC.LTalk125, 0);
			
			
			QZXS(JY.Person[29]["姓名"] .. " 学会指令浪荡");
      GRTS[29] = "浪荡"
      GRTSSAY[29] = "效果：本次攻击有机率打出浪荡招式*条件：体力大于50 内力大于500*消耗：体力12点 内力500点"
			
			SetS(86,10,12,5,1);		--不被阉割
		else	--战败
			MyTalk(CC.LTalk126, 593);
			lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_RED, 128)
      ShowScreen()
      lib.Delay(80)
      lib.ShowSlow(15, 1)
      Cls()
      lib.ShowSlow(100, 0)
      
      Talk(CC.LTalk127, 29);			--啊。。。。你这个万恶狠毒的秃驴。
      JY.Person[29]["性别"] = 2
      local add, str = AddPersonAttrib(29, "攻击力", -15)
      DrawStrBoxWaitKey(JY.Person[29]["姓名"] .. str, C_ORANGE, CC.DefaultFont)
      add, str = AddPersonAttrib(29, "防御力", -15)
      DrawStrBoxWaitKey(JY.Person[29]["姓名"] .. str, C_ORANGE, CC.DefaultFont)
      
      QZXS(JY.Person[29]["姓名"] .. " 学会指令戒色");
      GRTS[29] = "戒色"
      GRTSSAY[29] = "效果：本回合气防和集气速度提高，受到伤害减少*条件：体力大于50 内力大于500*消耗：体力10点 内力500点"
      
      SetS(86,10,12,5,2);		--被阉割
        
        
		end
		
		instruct_14();
		instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);			--清除贴图
		instruct_3(-2,38,0,0,0,0,0,0,0,0,0,0,0);			--清除贴图
		instruct_3(-2,39,0,0,0,0,0,0,0,0,0,0,0);			--清除贴图
		instruct_3(-2,40,0,0,0,0,0,0,0,0,0,0,0);			--清除贴图
		instruct_3(-2,41,0,0,0,0,0,0,0,0,0,0,0);			--清除贴图
		instruct_3(-2,42,0,0,0,0,0,0,0,0,0,0,0);			--清除贴图
		instruct_3(-2,43,0,0,0,0,0,0,0,0,0,0,0);			--清除贴图
		instruct_13();
	end
end

--重写天宁寺功德箱事件
OEVENTLUA[50] = function()

	local title = "功德箱";
	local str = "旁边有个功德箱，想要做些什么呢*捐赠：100两增加1点道德*慈悲：有多少捐多少*偷窃：减少5点道德得100两*抢劫：全拿了不多说";
	local btn = {"捐赠","慈悲","偷窃","抢劫", "路过"};
	local num = #btn;
	local r = JYMsgBox(title,str,btn,num);
	
	--捐赠，道德最大是80
	if r == 1 then
		--instruct_1(236,0,1);			--银子太多了也没啥用，拿出*100两做慈善事业吧。
		Talk("银子太多了也没啥用，拿出*100两做慈善事业吧",0);
		instruct_0();
		if instruct_31(100) then			--有没有超过100两
			instruct_2(174,-100);		--物品[银两]+[-100]
			if JY.Person[0]["品德"] < 65 then
	      instruct_37(1)
	    end
	  else
			instruct_1(237, 0, 1);
			instruct_0();
		end
	elseif r ==  2 then		--慈悲：道德为最大80
		Talk("银子用在该花的地方也是一件乐事",0);
		local gold = 0;
		for i=JY.Person[0]["品德"]+1, 65 do
			if JY.GOLD - gold >= 100 then			--有没有超过100两
				gold = gold + 100;
				JY.Person[0]["品德"] = i;
			end
		end
		instruct_2(174,-gold);
	elseif r == 3 then		--偷窃：减少5点道德得100两
		if instruct_28(0, 5, 999, 6, 0) == false then
	    instruct_1(235, 0, 1)
	    return 
	    instruct_0()
	  end
	  instruct_1(234, 0, 1)
	  instruct_0()
	  if instruct_11(0, 8) == true then
	    instruct_0()
	    if putong() ~= 6 then		--仁者没有钱得
	    	instruct_2(174, 100)
	    end
	    instruct_0()
	    instruct_37(-5)
	    return 
	  end
		
	elseif r == 4 then			--抢劫：根据道德判断，每次减5点
		if instruct_28(0, 5, 999, 6, 0) == false then
	    instruct_1(235, 0, 1)
	    return 
	    instruct_0()
	  end
		Talk("这谁的银子！没人应我拿了啊。",0);
		local gold = 0;
		for i=JY.Person[0]["品德"]-5, 0, -5 do
			if putong() ~= 6 then		--仁者没有钱得
	    	gold = gold + 100;
	    end
	    JY.Person[0]["品德"] = i;
		end
		if gold > 0 then
			instruct_2(174, gold);
		end
	end
	
end

OEVENTLUA[484] = function()		--郭靖加入得九阴

    if instruct_28(0,80,999,11,0) ==false then    --  28(1C):判断AAA品德80-999是则跳转到:Label0
        instruct_1(1940,55,0);   --  1(1):[郭靖]说: 侠之大者，为国为民！
        instruct_0();   --  0(0)::空语句(清屏)
        instruct_1(1941,56,0);   --  1(1):[黄蓉]说: 靖哥哥，说得好！
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0

    instruct_37(1);   --  37(25):增加道德1
    instruct_1(1936,55,0);   --  1(1):[郭靖]说: 兄弟，你来啦，最近是否顺*利？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1937,244,1);   --  1(1):[???]说: 唉，说实话，真是遇到了不*少困难啊。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1938,56,0);   --  1(1):[黄蓉]说: 靖哥哥，咱们去帮帮他吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1939,55,0);   --  1(1):[郭靖]说: 好，我正有此意。兄弟不必*担心，我二人这就去小村，*助你一臂之力。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
    instruct_3(104,45,1,0,967,0,0,7238,7238,7238,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [45]
    instruct_3(104,52,1,0,968,0,0,7240,7240,7240,-2,-2,-2);   --  3(3):修改事件定义:场景[钓鱼岛]:场景事件编号 [52]
    instruct_3(-2,42,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [42]
    instruct_3(-2,41,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [41]
    instruct_3(70,13,1,0,147,0,0,6088,6088,6088,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [13]
    instruct_3(70,14,1,0,149,0,0,6090,6090,6090,-2,-2,-2);   --  3(3):修改事件定义:场景[小村]:场景事件编号 [14]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
	instruct_2(84,1);   --  2(2):得到物品[九阴真经][1]
	instruct_2(354,1)
end

OEVENTLUA[499] = function()		--正中线王重阳
    instruct_1(2141,68,0);   --  1(1):[丘处机]说: 行走江湖，最重要的就是使*自己保持在正道之上。
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_28(0,90,999,2,0) ==false then    --  28(1C):判断AAA品德90-999是则跳转到:Label0
        do return; end
        instruct_0();   --  0(0)::空语句(清屏)
    end    --:Label0

    instruct_14();   --  14(E):场景变黑
    instruct_3(-2,27,1,0,0,0,0,7102,7102,7102,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_30(38,25,39,25);   --  30(1E):主角走动38-25--39-25
    instruct_30(39,25,39,22);   --  30(1E):主角走动39-25--39-22
    instruct_1(1995,0,1);   --  1(1):[AAA]说: 晚辈参见重阳真人
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1996,129,0);   --  1(1):[???]说: 不必多礼。你在江湖上的事*迹我早有耳闻，我今日到这*里来，就是要寻找合适的传*人
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1997,0,1);   --  1(1):[AAA]说: 前辈的意思是……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(1998,129,0);   --  1(1):[???]说: 你的所作所为，堪称大侠，*我这先天功，就传授给你吧*！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_2(77,1);   --  2(2):得到物品[先天功秘笈][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(-2,27,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
    instruct_3(-2,0,1,0,497,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
    instruct_0();   --  0(0)::空语句(清屏)
end

OEVENTLUA[505] = function()	 --欧阳克设置在这里
    instruct_26(61,0,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(61,8,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(61,17,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(61,16,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_1(2075,0,1);   --  1(1):[AAA]说: 晚辈参见裘帮主
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2076,67,0);   --  1(1):[裘千仞]说: 你是谁，来此何干？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2077,0,1);   --  1(1):[AAA]说: 是西域白驼山主人欧阳先生*叫我来的，他说来了您自然*知道。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2078,67,0);   --  1(1):[裘千仞]说: 哦，是欧阳先生啊，我知道*我知道。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2079,0,1);   --  1(1):[AAA]说: ＜他的表情怎么这么奇怪？*＞
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2080,67,0);   --  1(1):[裘千仞]说: ＜欧阳锋和我约好，找一个*能承受住我铁掌的人，打伤*之后让他去找段皇爷治伤，*耗损其功力，以便趁机除掉*段皇爷。不过前几日我已打*伤黄蓉，段皇爷应该已经出*手治伤了，这个小子……＞
    instruct_0();   --  0(0)::空语句(清屏) 
	TalkEx("欧阳先生大赞裘帮主的铁掌天下无双，轻功了得...＜拍马屁中...＞说前辈会指点晚辈，不知……",0,1)	
	instruct_0();
    instruct_1(2082,67,0);   --  1(1):[裘千仞]说: ＜可怜的小子，被欧阳锋卖*了还不知道。不过，假他的*手除掉段皇爷也好……＞你*说什么？铁掌？呵呵，自然*有用。你可知道南帝段皇爷*？
    instruct_0();   --  0(0)::空语句(清屏)
	TalkEx("天下五绝，如雷贯耳。<除了挂掉的王重阳，就他没见过了>",0,1)
    instruct_0();   --  0(0)::空语句(清屏)
	say("我指点你一番，你去帮我杀了段皇爷",67,0,"裘千仞") 	
    instruct_0(); 
	TalkEx("啊？这个，晚辈如何是段皇爷的对手？<我打得过早就把黄老邪和欧阳峰干翻了>",0,1)
    instruct_0();   --  0(0)::空语句(清屏)
	say("放心，他现在应该已经内力全失了，你只要能打发了他的几个护卫就行了。",67,0,"裘千仞") 	
    instruct_0(); 	
	TalkEx("＜哦哦哦，成名的机会，不过他们一个二个都想忽悠老子，当我不知道？＞",0,1)
    instruct_0();   --  0(0)::空语句(清屏)	
	AddPersonAttrib(zj(), "轻功", 5)	
	QZXS(JY.Person[zj()]["姓名"].."轻功增加5。")	
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2088,67,0);   --  1(1):[裘千仞]说: 段皇爷现在出家了，就在前*边的村子里，法号叫一灯。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(-2,-2,1,0,506,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
    instruct_3(47,13,0,0,0,0,507,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:场景[一灯居]:场景事件编号 [13]
    instruct_3(47,5,1,0,482,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:场景[一灯居]:场景事件编号 [5]
    instruct_3(47,8,0,0,0,0,0,8002,8002,8002,-2,-2,-2);   --  3(3):修改事件定义:场景[一灯居]:场景事件编号 [8]
    instruct_3(47,7,0,0,0,0,0,8004,8004,8004,-2,-2,-2);   --  3(3):修改事件定义:场景[一灯居]:场景事件编号 [7]
	SetS(40,17,35,3,99)
	JY.Person[60]["声望"] = 104
JY.Person[60]["武功5"] = 104
JY.Person[60]["武功等级5"] = 999
JY.Person[620]["声望"] = 104
JY.Person[620]["武功5"] = 104
JY.Person[620]["武功等级5"] = 999	
end

OEVENTLUA[510] = function()		--射雕邪重阳宫
	instruct_14();
	instruct_13();
    instruct_37(-3);   --  37(25):增加道德-3
    instruct_26(61,0,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(61,8,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(61,17,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
    instruct_26(61,16,1,0,0);   --  26(1A):增加场景事件编号的三个触发事件编号
	instruct_30(41,31,41,26);
	Talk(CC.BTalk303,0);
	instruct_14();
	instruct_3(-2,27,0,0,0,0,0,7102,7102,7102,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
    instruct_0();   --  0(0)::空语句(清屏)
	instruct_13();
    instruct_1(2125,129,0);   --  1(1):[???]说: 何人敢在我重阳宫中撒野！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2126,123,0);   --  1(1):[???]说: 师父，您还活着？
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2127,64,0);   --  1(1):[周伯通]说: 师兄，真的是你，太好了……
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2128,57,0);   --  1(1):[黄药师]说: 重阳真人，久违了
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2129,69,0);   --  1(1):[洪七公]说: 重阳真人，你可是连老叫化*都瞒过啦
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(2130,129,0);   --  1(1):[???]说: 贫道诈死，让各位担心了。*现在我们大家联手，对付这*恶贼！
    instruct_0();   --  0(0)::空语句(清屏)

    if instruct_6(185,3,0,0) ==false then    --  6(6):战斗[185]是则跳转到:Label3
        instruct_15(0);   --  15(F):战斗失败，死亡
        do return; end
	end    --:Label3

    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_1(2131,129,0);   --  1(1):[???]说: 真是长江后浪推前浪，看来*我们真是老了！
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_14();   --  14(E):场景变黑
	instruct_3(-2,25,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [25]
	instruct_3(-2,31,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [31]
	instruct_3(-2,26,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [26]
    instruct_3(-2,27,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [27]
    instruct_3(-2,28,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [28]
    instruct_3(-2,29,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [29]
    instruct_3(-2,30,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [30]
	instruct_3(-2,32,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [32]
	instruct_3(-2,33,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [33]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_13();   --  13(D):重新显示场景
    instruct_2(148,1);   --  2(2):得到物品[射鵰英雄传][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_2(84,1);   --  2(2):得到物品[九阴真经][1]
	if GetS(111,0,0,0) == 0 then 
	    say("王重阳藏得够深的，居然有这好东西。",0) 
	    instruct_0();
			    if DrawStrBoxYesNo(-1, -1, "是否领悟九阴精要？", C_WHITE, 30) == true then 
	                 QZXS("领悟九阴精要！")
	                 instruct_0();
	                 SetS(111, 0, 0, 0,107)
				else
				     say("我已经天下无敌，何须区区九阴。",0) 
					 instruct_0()
				end	
	end
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(-2,0,1,0,228,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:场景事件编号 [0]
	SetS(2, 0, 0, 0, 1) --射雕邪线判定
end

OEVENTLUA[494] = function() --
    if instruct_16(63,6,0) ==false then    --  改程英
        instruct_1(1968,122,0);   --  1(1):[???]说: “娇棠初露朦胧月，疑是箫*声笼雨声”，打一人物。*如果你猜出来，就把此人带*来见我。
        instruct_0();   --  0(0)::空语句(清屏)
        do return; end
    end    --:Label0

    instruct_1(1969,122,0);   --  1(1):[???]说: 哈哈哈，不错不错。这是我*将一阳指武功和书法结合起*来的的独门秘笈，就赠与少*侠吧。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_2(172,1);   --  2(2):得到物品[一阳指书][1]
    instruct_0();   --  0(0)::空语句(清屏)
	if instruct_16(81) then
		say("为什么我觉得你看起来这么面熟？",81,0,"朱九真") 
		instruct_0();   --  0(0)::空语句(清屏)
		say("说不定几世之前我们是亲戚呢，哈哈！",122,0,"读") 
		instruct_0();   --  0(0)::空语句(清屏)
		say("姑娘眉间似有煞气，幸好悬崖勒马，也算得上是我辈中人。这打穴的手法，看在我们如此投缘的份上，就传授给你了。",122,0,"读") 
		instruct_0();   --  0(0)::空语句(清屏)
		say("谢谢....",81,0,"朱九真") 
		instruct_0();   --  0(0)::空语句(清屏)
		--JY.Person[81]["攻击力"] = JY.Person[81]["攻击力"]+50
		JY.Person[81]["特殊兵器"] = JY.Person[81]["特殊兵器"]+40
		JY.Person[81]["拳掌功夫"] = JY.Person[81]["拳掌功夫"]+20	
        instruct_35(81,1,81,0)
		JY.Person[81]["武功等级1"] = 900;
		QZXS("朱九真拳掌和特系值增加！")
		QZXS("朱九真学会了一阳指书！")		
		instruct_0();   --  0(0)::空语句(清屏)
	end
    instruct_3(-2,-2,1,0,495,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):修改事件定义:当前场景:当前场景事件编号
end

OEVENTLUA[17] = function()
    instruct_1(155,3,0);   --  1(1):[苗人凤]说: 小兄弟，行走江湖记得多行*侠仗义。
    instruct_0();   --  0(0)::空语句(清屏)
end


OEVENTLUA[487] = function()
    instruct_1(1958,69,0);   --  1(1):[洪七公]说: 其实乞丐也是个很有前途的*职业，如果你喜欢，不妨去*丐帮报名。
    instruct_0();   --  0(0)::空语句(清屏)
end

OEVENTLUA[842] = function()
    instruct_14();   --14(E):场景变黑
    instruct_13();   --  13(D):重新显示场景
    instruct_25(25,42,31,36);   --  25(19):场景移动25-42--31-36
    instruct_1(3350,161,0);   --  1(1):[161李莫愁]:一个死丫头，还有个瘸铁匠*，嘿嘿，黄老邪果然尽捡些*脓包来做弟子，到世上丢人*现眼。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3351,236,0);   --  1(1):[236日月教徒]:请你莫说我恩师坏话。
    instruct_0();   --  0(0):空语句(清屏)
    instruct_1(3352,161,0);   --  1(1):[161李莫愁]:人家早不要你做弟子了，你*还恩师长、恩师短的，也不*怕人笑掉了牙齿。
    instruct_0();   --  0(0)::空语句(清屏)
    if inteam(78) and inteam(92) and LWS(92) then
       say("今天我就让你见识见识真正的桃花岛武功!",78,0,"梅超风") 
       say("算我一个! 李莫愁! 还我爹娘命来!",92,0,"陆无双") 
       instruct_0();   --  0(0)::空语句(清屏)
       if instruct_6(52,5,0,0) == false then   --   6(6):战斗[52程英居战李莫愁] 胜则跳转Label1
       instruct_0();   --  0(0)::空语句(清屏)
       instruct_15()  --死亡
       do return end  --无条件结束事件
    end
    AddPersonAttrib(78, "拳掌功夫", 16)
    AddPersonAttrib(78, "御剑能力", 16)
    AddPersonAttrib(78, "耍刀技巧", 16)
    AddPersonAttrib(78, "特殊兵器", 16)
    AddPersonAttrib(78, "暗器技巧", 16)
    AddPersonAttrib(78, "攻击力", 40)	
    AddPersonAttrib(78, "防御力", 40)	
    AddPersonAttrib(78, "轻功", 40)	
    QZXS("梅超风五维兵器各值增加16, 攻防轻各增加40.")	
    AddPersonAttrib(92, "拳掌功夫", 16)
    AddPersonAttrib(92, "御剑能力", 16)
    AddPersonAttrib(92, "耍刀技巧", 16)
    AddPersonAttrib(92, "特殊兵器", 16)
    AddPersonAttrib(92, "暗器技巧", 16)
    AddPersonAttrib(92, "攻击力", 40)	
    AddPersonAttrib(92, "防御力", 40)	
    AddPersonAttrib(92, "轻功", 40)
    QZXS("陆无双五维兵器值各增加16, 攻防轻各增加40.")
    AddPersonAttrib(63, "拳掌功夫", 3)
    AddPersonAttrib(63, "御剑能力", 3)
    AddPersonAttrib(63, "耍刀技巧", 3)
    AddPersonAttrib(63, "特殊兵器", 3)
    AddPersonAttrib(63, "暗器技巧", 3)
    AddPersonAttrib(63, "攻击力", 8)	
    AddPersonAttrib(63, "防御力", 8)	
    AddPersonAttrib(63, "轻功", 8)
    QZXS("程英五维兵器值各增加3, 攻防轻各增加8.")
    addthing(330, 1)    --拿到冰魄银针秘籍  
    addthing(282, 1)    --拿到云帚拂尘功秘籍
    elseif instruct_16(78,0,8) == true then       -- 16(10):判断队伍是否有[78梅超风]?否则跳转Label0
       instruct_1(3353,78,0);   --1(1):[78梅超风]:谁敢说我恩师？即使他不认*我们做徒弟，我们也永远认*他做恩师！
       instruct_0();   --  0(0)::空语句(清屏)
       say("今天我就让你见识见识真正的桃花岛武功!",78,0,"梅超风") 
       instruct_0();   --  0(0)::空语句(清屏)
       say("梅大姐我来助你!") 
       if instruct_6(52,5,0,0) == false then   --   6(6):战斗[52程英居战李莫愁] 胜则跳转Label1
       instruct_0();   --  0(0)::空语句(清屏)
       instruct_15()  --死亡
       do return end  --无条件结束事件
    end
    AddPersonAttrib(78, "拳掌功夫", 10)
    AddPersonAttrib(78, "御剑能力", 10)
    AddPersonAttrib(78, "耍刀技巧", 10)
    AddPersonAttrib(78, "特殊兵器", 10)
    AddPersonAttrib(78, "暗器技巧", 10)
    QZXS(JY.Person[78]["姓名"].."五维兵器值各增加10.")
    say("师傅! 徒儿知错了! 咱桃花的武功不比九阴真经差, 徒儿这就废去身上所有九阴真经的武功!",78,0,"梅超风") 
    QZXS("梅超风自废九阴白骨爪!");
    JY.Person[78]["武功1"] = 0
    JY.Person[78]["武功等级1"] = 0 
    elseif inteam(92) and LWS(92) then    --:Label0
       instruct_0();   --  0(0)::空语句(清屏)
       say("李莫愁! 还我爹娘命来!",92,0,"陆无双") 
       say("小双双我来助你!") 
       if instruct_6(52,5,0,0) == false then   --   6(6):战斗[52程英居战李莫愁] 胜则跳转Label1
       instruct_0();   --  0(0)::空语句(清屏)
       instruct_15()  --死亡
       do return end  --无条件结束事件
    end
    AddPersonAttrib(92, "拳掌功夫", 10)
    AddPersonAttrib(92, "御剑能力", 10)
    AddPersonAttrib(92, "耍刀技巧", 10)
    AddPersonAttrib(92, "特殊兵器", 10)
    AddPersonAttrib(92, "暗器技巧", 10)
    QZXS("陆无双五维兵器值各增加10.")
    say("原来这个大魔头只有在逃跑的时候才肯露两手咱古墓的天罗地网啊, 哈哈!",92,0,"陆无双") 
    QZXS("陆无双领悟古墓轻功天罗地网");
    instruct_35(92,0,119,0)	
    else
    instruct_1(3354,245,1);   --   1(1):[主角]:东邪黄药师，天下闻名，你*这道姑真是不知天高地厚！
    instruct_0();   --  0(0)::空语句(清屏) 
    instruct_1(3355,161,0);  --   1(1):[161李莫愁]:哼，又来个不知所谓的小子*，去死吧！
    instruct_0();   --  0(0)::空语句(清屏) 
    if instruct_6(52,5,0,0) == false then   --   6(6):战斗[52程英居战李莫愁] 胜则跳转Label1
       instruct_0();   --  0(0)::空语句(清屏)
       instruct_15()  --死亡
       do return end  --无条件结束事件
    end
    end
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_19(30,37);   --  19(13):主角移动至30-37
    instruct_40(1);   --  40(28):改变主角站立方向1
    instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):修改事件定义:当前场景:场景事件编号 [3]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_1(3356,247,1);   --   1(1):[主角]:咦？她好像掉了一本书……*哈哈，这李莫愁临走了居然*还送我礼物，也不是传说中*的那么坏嘛。
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_2(110,1);   --  2(2):得到物品[五毒秘传][1]
    instruct_0();   --  0(0)::空语句(清屏)
    instruct_3(-2,2,0,0,0,0,846,0,0,0,-2,-2,-2);   --  3(3):修改事件定义:当前场景场景事件编号[2]
    say("哈哈！赚到了赚到了！")
    end                       --1(FFFF):事件结束
	
--无酒不欢：龙门改成可败
OEVENTLUA[369] = function()
	instruct_37(1)  --增加品德
	say("什么人！", 199, 0,"丁氏门人")  --对话
	Cls()  --清屏
	say("啊，是我。", 0, 1)  --对话
	Cls()  --清屏
	say("你是谁？想干什么！", 199, 0,"丁氏门人")  --对话
	Cls()  --清屏
	say("这个，我想借一下那个什么\"玄冰碧火酒\"。", 0, 1)  --对话
	Cls()  --清屏
	say("原来是来偷酒的，小子，着家伙！", 199, 0,"丁氏门人")  --对话
	Cls()  --清屏
	if WarMain(166, 0) == false then  --战斗开始
		instruct_0();   --  0(0)::空语句(清屏)
	end
	instruct_3(-2, 22,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
	instruct_3(-2, 23,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
	instruct_3(-2, 24,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
	Cls()  --清屏
	instruct_13()  --场景变亮
	TalkEx("唉，何必逼我动手呢？何必呢？何——必——呢——？", 0, 1)  --对话
	Cls()  --清屏
	do return end
end

OEVENTLUA[511] = function()
	say("一灯大师、黄岛主、洪帮主*、各位道长，在下有礼了", 0,1)  --对话
	Cls()  --清屏
	say("你来啦。我知道你要找《射*雕英雄传》一书，而此书就*在重阳宫中。", 65,0)  --对话
	Cls()  --清屏
	say("啊？", 0,1)  --对话
	Cls()  --清屏
	say("既然你已经改邪归正，此书*本当送你。", 69,0)  --对话
	Cls()  --清屏
	say("不过在赠送之前，我们还要*考教考教你的武功。", 57,0)  --对话
	Cls()  --清屏
	say("你准备好了吗？", 65, 0)  --对话
	Cls()  --清屏
	if instruct_5(2,0) == true then
		say("有架打，怎能少的了我！？", 64, 0)  --对话
		Cls()  --清屏
		if WarMain(186) == false then
			say("看来少侠还需努力一番才是", 65, 0)  --对话
			Cls()
		else
			say("少侠武功高强，佩服佩服。*望少侠今后能走在正途。", 65, 0)
			Cls()
			addthing(148,1)
			if (MPPD(0) == 2 or JY.Person[0]["品德"] >= 95) and PersonKF(0,197) then
				say("老叫花最欣赏的就是像你这样迷途知返的人了，好样的", 69,0)  --对话
				Cls()  --清屏
				say("洪帮主谬赞了", 0,1)  --对话
				Cls()  --清屏
				say("不骄不衿，哈哈哈，很好很好", 69,0)  --对话
				Cls()  --清屏
				say("老叫花子莫不是想收徒弟了？", 57,0)  --对话
				Cls()  --清屏
				say("别，我可不想扯进天书这潭浑水", 69,0)  --对话
				Cls()  --清屏
				say("但这不妨碍老叫花教他两手啊，嘿嘿", 69,0)  --对话
				Cls()  --清屏
				say("老叫花就跟你好好讲讲「逍遥游」的身法诀窍吧", 69,0)  --对话
				Cls()  --清屏
				if DrawStrBoxYesNo(-1, -1, "是否详细听讲？", C_WHITE, 30) == true then 
	                 QZXS("领悟逍遥游身法！")
	                 instruct_0();
	                 setLW2(197)
					 addthing(111,1)
					 say("多谢洪帮主！", 0,1)
				else
				    say("在下志不在此，希望洪帮主海涵！", 0,1)
					Cls()  --清屏
					say("哈哈，无妨无妨", 69,0)  --对话
					Cls()  --清屏
				end	
			end
			instruct_26(61,16,1,0,0)
			instruct_26(61,0,1,0,0)
			instruct_26(61,8,1,0,0)
			instruct_26(61,17,1,0,0)
			instruct_3(-2, 0,1,0,499,0,0,-2,-2,-2,-2,-2,-2)  --修改场景事件
			instruct_3(-2, 30,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
			instruct_3(-2, 29,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
			instruct_3(-2, 28,0,0,0,0,0,0,0,0,0,0,0)  --修改场景事件
			instruct_3(23, 0,1,0,487,0,0,6122,6122,6122,-2,-2,-2)  --修改场景事件
		end	
	end	
end
