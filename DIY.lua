local diymenu = function (list)
	local menu = {}
	for i,v in pairs(list) do
		menu[#menu + 1] = {v[1],nil,1}
	end
	local r = ShowMenu(menu,#menu,15,10,10,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE)
  --local r = ShowMenu2(menu, #menu, 0, 10, 10, 0, 0, 1, 1, CC.DefaultFont, C_ORANGE, C_WHITE)
	--local r = ShowMenu3(menu,#menu,3,10,10,-2,-2,1,1,CC.DefaultFont,C_ORANGE,C_WHITE)
	if r > 0 then
		local value = list[r][2]
		local selectedRow = list[r]
		if type(selectedRow[3]) == "function" then
			selectedRow[3](r, value)
		end
	end
	return r
end

local menu = {
	{
		"查看NPC",
		nil,
		function()
			local menu1 = {}
			local menu1callback = function(selected, value)
				local list = {}
				for i,v in pairs(menu1) do
					list[i] = v[2]
				end
				local id = list[selected];
				local page = 1
				while true do
					Cls()
					id = list[selected]
					page = limitX(page, 1, 2)
					--ShowPersonStatus_sub(list[r],page)
					if page == 1 then
						ShowPersonStatus_sub(id, page)
					elseif page == 2 then
						page = NLJS(id, page)
						if page == -1 then
							break
						end
						Cls()
						ShowPersonStatus_sub(id, page)
						ShowScreen()
					else
						ShowPersonStatus_sub(id, page)
					end	
					ShowScreen();
					local keypress = WaitKey()
					if keypress == VK_LEFT then
					  page = page - 1;
					elseif keypress == VK_RIGHT then
					  page = page + 1;
					elseif keypress == VK_UP then
						selected = selected - 1
					elseif keypress == VK_DOWN then
						selected = selected + 1
					elseif keypress == 27 then
						break
					end
					if selected < 1 then
						selected = #list
					end
					if selected > #list then
						selected = 1
					end
				end
			end
			for i,v in pairs(JY.Person) do
				menu1[#menu1 + 1] = {i .. JY.Person[i]["姓名"], i, menu1callback}
			end
			diymenu(menu1)
		end
	},
	{
		"查看武功",
		nil,
		function()
			local menu1 = {}
			for i,v in pairs(JY.Wugong) do
				menu1[#menu1 + 1] = {i .. JY.Wugong[i]["名称"], i}
			end
			diymenu(menu1)
		end
	},
	{
		"获得物品",
		nil,
		function()
			local menu1 = {}
			local menu1callback = function(selected, value)
				instruct_32(value)
				QZXS("获得"..JY.Thing[value]["名称"])	
			end
			for i = 0, JY.ThingNum - 1 do
				menu1[#menu1 + 1] = {i .. JY.Thing[i]["名称"], i, menu1callback}
			end
			diymenu(menu1)
		end
	},
	{
		"获得印信",
		nil,
		function()
			local menu1 = {}
			local menu1callback = function(selected, value)
				addHZ(value)
			end
			for i in pairs(CC.HZ) do
				local tmp = CC.HZ[i]
				local hzid = tmp[1]
				menu1[#menu1 + 1] = {hzid .. tmp[2], hzid, menu1callback}
			end
			diymenu(menu1)
		end
	},
	{
		"全局属性调整",
		nil,
		function()
			local menu1 = {
				{"银两"}, 
				{"技能点"}, 
				{"周目"},
				{"道德"}
			}
			local tr = diymenu(menu1)
			--local tr = JYMsgBox("全局属性调整", "请选择调整项", {"银两", "技能点", "周目"}, 3, 0)
			if tr > 0 then
				DrawStrBoxWaitKey("请输入设置的数值", C_WHITE, CC.DefaultFont, 1)
				local T = {}
				for a = 1, 100000 do
					local b = "" .. a
					T[b] = a
				end
				local dj = -1
				while dj == -1 do
					local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
					if T[r] ~= nil and T[r] >= 0 then
						dj = T[r]
						if tr == 1 then
							for i = 1, CC.MyThingNum do
								if JY.Base["物品" .. i] == 174 then     
									JY.Base["物品数量" .. i] = dj
									break
								end
							end
							JY.GOLD = dj
						elseif tr == 2 then
							CC.SKpoint = dj
						elseif tr == 3 then
							JY.Thing[203][WZ6] = dj
						elseif tr == 4 then
							JY.Person[0]["品德"] = dj
						end
					else
						DrawStrBoxWaitKey("输入错误", C_WHITE, 30)
					end
				end
			end
		end
	},
	{
		"洗武功",
		nil,
		function()
			local menu1 = {}
			local menu1callback = function(selected1, personid)
				local menu2 = {}
				local menu2callback = function(selected2, wgid)
					if DrawStrBoxYesNo(-1,-1,"是否设置为其他武功？",C_WHITE,CC.DefaultFont) then
						local menu3 = {}
						local menu3callback = function(selected3, replace_wgid)
							JY.Person[personid]["武功" .. selected2] = replace_wgid
							JY.Person[personid]["武功等级" .. selected2] = 999
							QZXS(JY.Person[personid]["姓名"] .. "的" .. JY.Wugong[wgid]["名称"].."已经替换为".. JY.Wugong[replace_wgid]["名称"])
						end
						local r2 = JYMsgBox("天赋武功", "请选择天赋武功的类型", {"拳", "剑", "刀", "特", "暗", "内", "轻"}, 7, 0)
						local boxdata1 = {1,2,3,4,6,0,5}
						local leixing = boxdata1[r2]
						if leixing ~= nil then
							for i,v in pairs(JY.Wugong) do
								if JY.Wugong[i]["类型"] == leixing then
									menu3[#menu3 + 1] = {i .. JY.Wugong[i]["名称"], i, menu3callback}
								end
							end
							diymenu(menu3)
						end
					else
						JY.Person[personid]["武功" .. selected2] = 0
						JY.Person[personid]["武功等级" .. selected2] = 0
						QZXS(JY.Person[personid]["姓名"] .. "的" .. JY.Wugong[wgid]["名称"].."已经遗忘")
					end
				end
				for i = 1, HHH_GAME_SETTING["WG_COUNT_MAX"] do
					local wugong = JY.Person[personid]["武功" .. i]
					if wugong > 0 then
						menu2[#menu2 + 1] = {i .. JY.Wugong[wugong]["名称"], wugong, menu2callback}
					else
						menu2[#menu2 + 1] = {i .. "----", wugong, menu2callback}
					end
				end
				diymenu(menu2)
			end
			for i = 1, CC.TeamNum do
				local personid = JY.Base["队伍" .. i]
				if JY.Base["队伍" .. i] >= 0 then
					menu1[#menu1 + 1] = {personid .. JY.Person[personid]["姓名"], personid, menu1callback}
				end 
			end
			diymenu(menu1)
		end
	},
	{
		"天赋武功",
		nil,
		function()
			if cxzj() > 0 then
				QZXS("暂不支持畅想主角")
			end
			local r = JYMsgBox("天赋武功", "请选择天赋的类型", {"内功", "外功", "轻功"}, 3, 0)
			
			if r > 0 then
				local leixing
				if r == 1 then
					leixing = 0
				elseif r == 2 then
					local r2 = JYMsgBox("天赋武功", "请选择天赋武功的类型", {"拳", "剑", "刀", "特", "暗"}, 5, 0)
					local boxdata1 = {1,2,3,4,6}
					leixing = boxdata1[r2]
				elseif r == 3 then
					leixing = 5
				end
				if leixing ~= nil then
					local menu2 = {}
					local menu2callback = function(selected, value)
						local wg = value
						if JY.Wugong[wg]["类型"] == 0 then
							SetS(112,2,0,0,wg)--内功
						elseif JY.Wugong[wg]["类型"] == 1 or JY.Wugong[wg]["类型"] == 2 or JY.Wugong[wg]["类型"] == 3 or JY.Wugong[wg]["类型"] == 4 or JY.Wugong[wg]["类型"] == 6 then
							SetS(112,1,0,0,wg)--外功
						elseif JY.Wugong[wg]["类型"] == 5 then
							SetS(112,3,0,0,wg)--轻功
						end
					end
					for i,v in pairs(JY.Wugong) do
						if JY.Wugong[i]["类型"] == leixing then
							menu2[#menu2 + 1] = {i .. JY.Wugong[i]["名称"], i, menu2callback}
						end
					end
					diymenu(menu2)
				end
			end
		end
	},
	{
		"加入队友",
		nil,
		function()
			local menu1 = {}
			local menu1callback = function(selected, value)
				if instruct_20() then
					say("队伍已满")
				else
					instruct_10(value)
				end
			end
			for i,v in pairs(JY.Person) do
				menu1[#menu1 + 1] = {i .. JY.Person[i]["姓名"], i, menu1callback}
			end
			diymenu(menu1)
		end
	},
	{
		"加入门派",
		nil,
		function()
			local menu1 = {}
			local menu1callback = function(selected, value)
				local mpid = value
				local menu2 = {}
				local menu2callback = function(selected, value)
					JoinMP(0,mpid,value)
				end
				for i,v in pairs(CC.MPDJ[value]) do
					menu2[#menu2 + 1] = {i .. v, i, menu2callback}
				end
				diymenu(menu2)
			end
			for i,v in pairs(CC.MP) do
				menu1[#menu1 + 1] = {i .. v[1], i, menu1callback}
			end
			diymenu(menu1)
		end
	},
	{
		"属性调整",
		nil,
		function()
			local menu1 = {}
			local menu1callback = function(selected, personid)
				local menu2 = {}
				local menu2callback = function(selected2, attrib)
					local dj = -1
					if attrib == "内力性质" then
						local r = JYMsgBox("属性调整", "请选择内力性质", {"阴", "阳", "调和", "天罡"}, 4, 0)
						dj = r - 1
					elseif attrib == "左右互搏" then
						local r = JYMsgBox("属性调整", "请选择是否学会左右互博", {"否", "是"}, 2, 0)
						dj = r - 1
					elseif attrib == "性别" then
						local r = JYMsgBox("属性调整", "请选择性别", {"须眉", "巾帼", "？？"}, 3, 0)
						dj = r - 1
					end
					if dj > -1 then
						JY.Person[personid][attrib] = dj
						return 1
					end
					
					DrawStrBoxWaitKey("请输入设置的数值", C_WHITE, CC.DefaultFont, 1)
					local T = {}
					for a = 1, 10000 do
						local b = "" .. a
						T[b] = a
					end
					while dj == -1 do
						local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
						if T[r] ~= nil and T[r] >= 0 then
							dj = T[r]
							JY.Person[personid][attrib] = dj
						else
							DrawStrBoxWaitKey("输入错误", C_WHITE, 30)
						end
					end
				end
				local attribList = {
					"攻击力", "防御力", "轻功",
					"拳掌功夫", "御剑能力", "耍刀技巧", "特殊兵器", "暗器技巧",
					"资质", "武学常识", "实战", "左右互搏",
					"内力最大值", "生命最大值", "内力", "生命",
					"医疗能力", "用毒能力", "解毒能力",
					"生命增长", "内力性质", "品德", "性别",
					
				}
				for i = 1, #attribList do
					local attrib = attribList[i]
					menu2[#menu2 + 1] = {attrib, attrib, menu2callback}
				end
				diymenu(menu2)
			end
			for i = 1, CC.TeamNum do
				local personid = JY.Base["队伍" .. i]
				if JY.Base["队伍" .. i] >= 0 then
					menu1[#menu1 + 1] = {personid .. JY.Person[personid]["姓名"], personid, menu1callback}
				end 
			end
			diymenu(menu1)
		end
	},
	{
		"武功领悟",
		nil,
		function()
			local r = JYMsgBox("武功领悟", "请选择领悟武功的类型", {"内功", "外功", "轻功", "忘却"}, 4, 0)
			
			if r > 0 then
				local leixing
				if r == 1 then
					leixing = 0
				elseif r == 2 then
					local r2 = JYMsgBox("武功领悟", "请选择领悟武功的类型", {"拳", "剑", "刀", "特", "暗"}, 5, 0)
					local boxdata1 = {1,2,3,4,6}
					leixing = boxdata1[r2]
				elseif r == 3 then
					leixing = 5
				elseif r == 4 then
				setLW(0)
				setLW1(0)
				setLW2(0)
				end
				if leixing ~= nil then
					local menu2 = {}
					local menu2callback = function(selected, value)
						local wg = value
						if JY.Wugong[wg]["类型"] == 0 then
						setLW(wg)
						elseif JY.Wugong[wg]["类型"] == 1 or JY.Wugong[wg]["类型"] == 2 or JY.Wugong[wg]["类型"] == 3 or JY.Wugong[wg]["类型"] == 4 or JY.Wugong[wg]["类型"] == 6 then
						setLW1(wg)--外功领悟
						elseif JY.Wugong[wg]["类型"] == 5 then
						setLW2(wg)--轻功领悟
						end
					end
					for i,v in pairs(JY.Wugong) do
						if JY.Wugong[i]["类型"] == leixing then
							menu2[#menu2 + 1] = {i .. JY.Wugong[i]["名称"], i, menu2callback}
						end
					end
					diymenu(menu2)
				end
			end
		end
	},
	{
		"修复天书数量",
		nil,
		function()
			for i = 1, CC.MyThingNum do
				if JY.Base["物品" .. i] > 143 and JY.Base["物品" .. i] < 158 and JY.Base["物品数量" .. i] > 1 then
				  JY.Base["物品数量" .. i] = 1
				end
			end
		end
	},
	{
		"测试战斗",
		nil,
		function()
			WarMain(217) --十八铜人
		end
	},
	{
		"全物品",
		nil,
		function()
			for id = 0, JY.ThingNum - 1 do
				if JY.Thing[id]["类型"] <= 2 then
					instruct_32(id)
				end
			end

			for i = 1, CC.HZNum do
				addHZ(i);
			end
		end
	}
}

diymenu(menu)