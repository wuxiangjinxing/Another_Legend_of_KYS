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
		"�鿴NPC",
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
				menu1[#menu1 + 1] = {i .. JY.Person[i]["����"], i, menu1callback}
			end
			diymenu(menu1)
		end
	},
	{
		"�鿴�书",
		nil,
		function()
			local menu1 = {}
			for i,v in pairs(JY.Wugong) do
				menu1[#menu1 + 1] = {i .. JY.Wugong[i]["����"], i}
			end
			diymenu(menu1)
		end
	},
	{
		"�����Ʒ",
		nil,
		function()
			local menu1 = {}
			local menu1callback = function(selected, value)
				instruct_32(value)
				QZXS("���"..JY.Thing[value]["����"])	
			end
			for i = 0, JY.ThingNum - 1 do
				menu1[#menu1 + 1] = {i .. JY.Thing[i]["����"], i, menu1callback}
			end
			diymenu(menu1)
		end
	},
	{
		"���ӡ��",
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
		"ȫ�����Ե���",
		nil,
		function()
			local menu1 = {
				{"����"}, 
				{"���ܵ�"}, 
				{"��Ŀ"},
				{"����"}
			}
			local tr = diymenu(menu1)
			--local tr = JYMsgBox("ȫ�����Ե���", "��ѡ�������", {"����", "���ܵ�", "��Ŀ"}, 3, 0)
			if tr > 0 then
				DrawStrBoxWaitKey("���������õ���ֵ", C_WHITE, CC.DefaultFont, 1)
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
								if JY.Base["��Ʒ" .. i] == 174 then     
									JY.Base["��Ʒ����" .. i] = dj
									break
								end
							end
							JY.GOLD = dj
						elseif tr == 2 then
							CC.SKpoint = dj
						elseif tr == 3 then
							JY.Thing[203][WZ6] = dj
						elseif tr == 4 then
							JY.Person[0]["Ʒ��"] = dj
						end
					else
						DrawStrBoxWaitKey("�������", C_WHITE, 30)
					end
				end
			end
		end
	},
	{
		"ϴ�书",
		nil,
		function()
			local menu1 = {}
			local menu1callback = function(selected1, personid)
				local menu2 = {}
				local menu2callback = function(selected2, wgid)
					if DrawStrBoxYesNo(-1,-1,"�Ƿ�����Ϊ�����书��",C_WHITE,CC.DefaultFont) then
						local menu3 = {}
						local menu3callback = function(selected3, replace_wgid)
							JY.Person[personid]["�书" .. selected2] = replace_wgid
							JY.Person[personid]["�书�ȼ�" .. selected2] = 999
							QZXS(JY.Person[personid]["����"] .. "��" .. JY.Wugong[wgid]["����"].."�Ѿ��滻Ϊ".. JY.Wugong[replace_wgid]["����"])
						end
						local r2 = JYMsgBox("�츳�书", "��ѡ���츳�书������", {"ȭ", "��", "��", "��", "��", "��", "��"}, 7, 0)
						local boxdata1 = {1,2,3,4,6,0,5}
						local leixing = boxdata1[r2]
						if leixing ~= nil then
							for i,v in pairs(JY.Wugong) do
								if JY.Wugong[i]["����"] == leixing then
									menu3[#menu3 + 1] = {i .. JY.Wugong[i]["����"], i, menu3callback}
								end
							end
							diymenu(menu3)
						end
					else
						JY.Person[personid]["�书" .. selected2] = 0
						JY.Person[personid]["�书�ȼ�" .. selected2] = 0
						QZXS(JY.Person[personid]["����"] .. "��" .. JY.Wugong[wgid]["����"].."�Ѿ�����")
					end
				end
				for i = 1, HHH_GAME_SETTING["WG_COUNT_MAX"] do
					local wugong = JY.Person[personid]["�书" .. i]
					if wugong > 0 then
						menu2[#menu2 + 1] = {i .. JY.Wugong[wugong]["����"], wugong, menu2callback}
					else
						menu2[#menu2 + 1] = {i .. "----", wugong, menu2callback}
					end
				end
				diymenu(menu2)
			end
			for i = 1, CC.TeamNum do
				local personid = JY.Base["����" .. i]
				if JY.Base["����" .. i] >= 0 then
					menu1[#menu1 + 1] = {personid .. JY.Person[personid]["����"], personid, menu1callback}
				end 
			end
			diymenu(menu1)
		end
	},
	{
		"�츳�书",
		nil,
		function()
			if cxzj() > 0 then
				QZXS("�ݲ�֧�ֳ�������")
			end
			local r = JYMsgBox("�츳�书", "��ѡ���츳������", {"�ڹ�", "�⹦", "�Ṧ"}, 3, 0)
			
			if r > 0 then
				local leixing
				if r == 1 then
					leixing = 0
				elseif r == 2 then
					local r2 = JYMsgBox("�츳�书", "��ѡ���츳�书������", {"ȭ", "��", "��", "��", "��"}, 5, 0)
					local boxdata1 = {1,2,3,4,6}
					leixing = boxdata1[r2]
				elseif r == 3 then
					leixing = 5
				end
				if leixing ~= nil then
					local menu2 = {}
					local menu2callback = function(selected, value)
						local wg = value
						if JY.Wugong[wg]["����"] == 0 then
							SetS(112,2,0,0,wg)--�ڹ�
						elseif JY.Wugong[wg]["����"] == 1 or JY.Wugong[wg]["����"] == 2 or JY.Wugong[wg]["����"] == 3 or JY.Wugong[wg]["����"] == 4 or JY.Wugong[wg]["����"] == 6 then
							SetS(112,1,0,0,wg)--�⹦
						elseif JY.Wugong[wg]["����"] == 5 then
							SetS(112,3,0,0,wg)--�Ṧ
						end
					end
					for i,v in pairs(JY.Wugong) do
						if JY.Wugong[i]["����"] == leixing then
							menu2[#menu2 + 1] = {i .. JY.Wugong[i]["����"], i, menu2callback}
						end
					end
					diymenu(menu2)
				end
			end
		end
	},
	{
		"�������",
		nil,
		function()
			local menu1 = {}
			local menu1callback = function(selected, value)
				if instruct_20() then
					say("��������")
				else
					instruct_10(value)
				end
			end
			for i,v in pairs(JY.Person) do
				menu1[#menu1 + 1] = {i .. JY.Person[i]["����"], i, menu1callback}
			end
			diymenu(menu1)
		end
	},
	{
		"��������",
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
		"���Ե���",
		nil,
		function()
			local menu1 = {}
			local menu1callback = function(selected, personid)
				local menu2 = {}
				local menu2callback = function(selected2, attrib)
					local dj = -1
					if attrib == "��������" then
						local r = JYMsgBox("���Ե���", "��ѡ����������", {"��", "��", "����", "���"}, 4, 0)
						dj = r - 1
					elseif attrib == "���һ���" then
						local r = JYMsgBox("���Ե���", "��ѡ���Ƿ�ѧ�����һ���", {"��", "��"}, 2, 0)
						dj = r - 1
					elseif attrib == "�Ա�" then
						local r = JYMsgBox("���Ե���", "��ѡ���Ա�", {"��ü", "����", "����"}, 3, 0)
						dj = r - 1
					end
					if dj > -1 then
						JY.Person[personid][attrib] = dj
						return 1
					end
					
					DrawStrBoxWaitKey("���������õ���ֵ", C_WHITE, CC.DefaultFont, 1)
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
							DrawStrBoxWaitKey("�������", C_WHITE, 30)
						end
					end
				end
				local attribList = {
					"������", "������", "�Ṧ",
					"ȭ�ƹ���", "��������", "ˣ������", "�������", "��������",
					"����", "��ѧ��ʶ", "ʵս", "���һ���",
					"�������ֵ", "�������ֵ", "����", "����",
					"ҽ������", "�ö�����", "�ⶾ����",
					"��������", "��������", "Ʒ��", "�Ա�",
					
				}
				for i = 1, #attribList do
					local attrib = attribList[i]
					menu2[#menu2 + 1] = {attrib, attrib, menu2callback}
				end
				diymenu(menu2)
			end
			for i = 1, CC.TeamNum do
				local personid = JY.Base["����" .. i]
				if JY.Base["����" .. i] >= 0 then
					menu1[#menu1 + 1] = {personid .. JY.Person[personid]["����"], personid, menu1callback}
				end 
			end
			diymenu(menu1)
		end
	},
	{
		"�书����",
		nil,
		function()
			local r = JYMsgBox("�书����", "��ѡ�������书������", {"�ڹ�", "�⹦", "�Ṧ", "��ȴ"}, 4, 0)
			
			if r > 0 then
				local leixing
				if r == 1 then
					leixing = 0
				elseif r == 2 then
					local r2 = JYMsgBox("�书����", "��ѡ�������书������", {"ȭ", "��", "��", "��", "��"}, 5, 0)
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
						if JY.Wugong[wg]["����"] == 0 then
						setLW(wg)
						elseif JY.Wugong[wg]["����"] == 1 or JY.Wugong[wg]["����"] == 2 or JY.Wugong[wg]["����"] == 3 or JY.Wugong[wg]["����"] == 4 or JY.Wugong[wg]["����"] == 6 then
						setLW1(wg)--�⹦����
						elseif JY.Wugong[wg]["����"] == 5 then
						setLW2(wg)--�Ṧ����
						end
					end
					for i,v in pairs(JY.Wugong) do
						if JY.Wugong[i]["����"] == leixing then
							menu2[#menu2 + 1] = {i .. JY.Wugong[i]["����"], i, menu2callback}
						end
					end
					diymenu(menu2)
				end
			end
		end
	},
	{
		"�޸���������",
		nil,
		function()
			for i = 1, CC.MyThingNum do
				if JY.Base["��Ʒ" .. i] > 143 and JY.Base["��Ʒ" .. i] < 158 and JY.Base["��Ʒ����" .. i] > 1 then
				  JY.Base["��Ʒ����" .. i] = 1
				end
			end
		end
	},
	{
		"����ս��",
		nil,
		function()
			WarMain(217) --ʮ��ͭ��
		end
	},
	{
		"ȫ��Ʒ",
		nil,
		function()
			for id = 0, JY.ThingNum - 1 do
				if JY.Thing[id]["����"] <= 2 then
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