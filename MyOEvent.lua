
--���͵�ַ�б�
function My_ChuangSong_List()
	local menu = {};
	for i=0, JY.SceneNum-1 do
		menu[i+1] = {i..JY.Scene[i]["����"], nil, 1};
	end
	
	local r = ShowMenu(menu,JY.SceneNum,15,250,20,0,0,1,1,CC.DefaultFont,C_ORANGE, C_WHITE);
	
	if r == 0 then
		return 0;
	end
	
	if r > 0 then	
		
		local sid = r-1;
		
		if JY.Scene[sid]["��������"] == 0 and sid ~= 84 and sid ~= 83  and sid ~= 82 and  sid ~= 13 then
				My_Enter_SubScene(sid,-1,-1,-1);
			else
				say("��Ŀǰ���ڲ��ܽ���˳���", 232, 1, "����ͨ");
				return 1;
			end

	end
	
	return 1;
end

--��ǿ�洫�͵�ַ�˵�
function My_ChuangSong_Ex()     
	local title = "����ͨ���͹���";
	local str = "����һ���ܷ����������ϵͳ*��ѡ������Ҫ�Ĵ��ͷ�ʽ";
	local btn = {"�б�ѡ��","�������", "����"};
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
			 
			if JY.Scene[n]["��������"] == 0 and n ~= 84 and n ~= 83 and n ~= 82 and n ~= 13 then
				My_Enter_SubScene(n,-1,-1,-1);
			else
				say("��Ŀǰ���ڲ��ܽ���˳���", 232, 1, "����ͨ");
				return 1;
			end
		
			
		end
	end
end

--��ս����
function Fight()
	say("����ɲ�����ô���ǵģ���ɵ�С����", 232, 1, "����ͨ");
	SetS(86, 1, 9, 5, 1);
	
	for i=1, 15 do --�������ǣ���ս����
		if GetS(86, 2, i, 5) == 0 then
			SetS(86, 2, i, 5, 2);
		end
	end
	local x1 = CC.ScreenW/2 - 200 ;
	local y1 = 0;
	DrawStrBox(x1, y1, "��ѡ����ս����",C_WHITE, CC.DefaultFont);
	local menu = {
		{"��������Ƿ�",nil,GetS(86, 2, 1, 5)-1},
		{"������Ͷ�������",nil,GetS(86, 2, 2, 5)-1},
		{"�������ɨ����ɮ",nil,GetS(86, 2, 3, 5)-1},
		{"�Ƿ�Ͷ�������",nil,GetS(86, 2, 4, 5)-1},
		{"�Ƿ��ɨ����ɮ",nil,GetS(86, 2, 5, 5)-1},
		{"�������ܺ�ɨ����ɮ",nil,GetS(86, 2, 6, 5)-1},
		{"������",nil,GetS(86, 2, 7, 5)-1},
		{"�������ֵ�",nil,GetS(86, 2, 8, 5)-1},
		{"���������",nil,GetS(86, 2, 9, 5)-1},
		{"������",nil,GetS(86, 2, 10, 5)-1},
		{"��ʦ��",nil,GetS(86, 2, 11, 5)-1}, --��ʦ��
		{"��������",nil,GetS(86, 2, 12, 5)-1}, --�������ǣ���ս����
		{"��ң����",nil,GetS(86, 2, 13, 5)-1}, --�������ǣ���ң����
		{"������˵",nil,GetS(86, 2, 14, 5)-1}, --�������ǣ�������˵
	    {"ɽկ����",nil,GetS(86, 2, 15, 5)-1}, --�������ǣ���ս����
	};
	
	local numItem = table.getn(menu);
	local size = CC.DefaultFont;
	local r = ShowMenu(menu,numItem,0,x1,y1+40,0,0,1,1,size,C_ORANGE,C_WHITE);
	if r > 0 then
		Cls();
		SetS(86, 2, r, 5, 3);
		if WarMain(226) then
			SetS(86, 2, r, 5, 1);
			say("���������ְ���", 232, 1, "����ͨ");
			QZXS("ȫ�����ʵս����50��");
			for i=1, CC.TeamNum do
				if JY.Base["����"..i] >= 0 then
					AddPersonAttrib(JY.Base["����"..i], "ʵս", 50)
				end
			end
			if r == 1 then --��������Ƿ�
				addHZ(46) 
				CC.SKpoint = CC.SKpoint + 700
				QZXS("���ܵ��700��")
			end	
			if r == 2 then --������Ͷ�������
				addHZ(64) 
				CC.SKpoint = CC.SKpoint + 700
				QZXS("���ܵ��700��")
			end 	
			if r == 3 then 
				addHZ(67) --�������ɨ����ɮ
				CC.SKpoint = CC.SKpoint + 700
				QZXS("���ܵ��700��")
			end 		
			if r == 4 then --�Ƿ�Ͷ�������
				addHZ(83)
				CC.SKpoint = CC.SKpoint + 700
				QZXS("���ܵ��700��")
			end 	 
			if r == 5 then 
				addHZ(123) --�Ƿ��ɨ����ɮ
				CC.SKpoint = CC.SKpoint + 700
				QZXS("���ܵ��700��")
			end 	
			if r == 6 then --�������ܺ�ɨ����ɮ
				addHZ(126)
				CC.SKpoint = CC.SKpoint + 700
				QZXS("���ܵ��700��")
			end 	
			if r == 7 then --�����
				addHZ(135) 
				CC.SKpoint = CC.SKpoint + 900
				QZXS("���ܵ��900��")
			end 	
			if r == 8 then --�������ֵ�
				addHZ(136) 
				CC.SKpoint = CC.SKpoint + 1500
				QZXS("���ܵ��1500��")
			end 	
			if r == 9 then --���������
				for i = 0, JY.ThingNum - 1 do
					if JY.Thing[i]["����"] == 2 then
						instruct_2(i, 1)
					end
				end	
				CC.SKpoint = CC.SKpoint + 2000
				QZXS("���ܵ��2000��")
			end 	
			if r == 10 then --������
				if GetS(111, 0, 0, 0) == 0 then  
	                say("��������ȥ�úò��꣡",455)		
	                   instruct_0();
	                if instruct_11(0,188) == true then 
	                   QZXS("���������湦��")
		               instruct_0();
	                   say("��лǰ��",0)
	                   SetS(111, 0, 0, 0,181)
		               addthing(341)
		               instruct_35(0,3,181,0)
                       instruct_35(0,3,181,0)
	                else
		               say("��־����",455) 
	                end	
                end
			end
			if r == 11 then  --��ʦ��
				for i=1, CC.TeamNum do
				if JY.Base["����"..i] >= 0 then
					AddPersonAttrib(JY.Base["����"..i], "��ѧ��ʶ", 100)
				end
				addHZ(150)
			                     end	
				QZXS("ȫ������䳣����100��");
				if GetS(111,0,0,0) == 0 then 
                if yesno("Ҫ�������޼���") then
                   SetS(111,0,0,0,99)
				   addthing(76)
                end
                end
				if GetS(111,0,0,0) == 0 then 
                if yesno("Ҫ���������غף�") then
                   SetS(111,0,0,0,178)
				   addthing(338)
                end
                end
				if GetS(111,0,0,0) == 0 then 
                if yesno("Ҫ�������һ�����") then
                   SetS(111,0,0,0,999)
				   addthing(235)
                end
                end
				if GetS(111,0,0,0) == 0 then 
                if yesno("Ҫ��������������") then
                   SetS(111,0,0,0,100)
				   addthing(77)
                end
                end
				if GetS(111,0,0,0) == 0 then 
                if yesno("Ҫ����ʥ�����У�") then
                   SetS(111,0,0,0,93)
				   addthing(70)
                end
                end
				if GetS(111,0,0,0) == 0 then 
                if yesno("Ҫ����������壿") then
                   SetS(111,0,0,0,107)
				   addthing(84)
                end
                end
				if GetS(111,0,0,0) == 0 then 
                if yesno("Ҫ������Ů�ľ���") then
                   SetS(111,0,0,0,121)
				   instruct_35(0,2,121,0)
				   addthing(254)
                end
                end
				CC.SKpoint = CC.SKpoint + 1600
				QZXS("���ܵ��1600��")
			end
			if r == 12 then --��������
				if PersonKF(0,196) and PersonKF(0,105) and GetS(114,0,0,0) == 0 then
					say("ࡣ����ֲ����",27)
					say("�ٶ�Ҳ�ͱ������˰����ѣ�",27)
					say("������Ľ��������Ҿͷ����ȱ��ɣ���ȥ��",27)
					if DrawStrBoxYesNo(-1, -1, "Ҫ������", C_WHITE, 30) == true then
						setLW2(196)
						QZXS("��������Ӱ����")
						say("лл����������",0)
					else
						say("��Ǹ���ҵ���ѧ־�򲢲��ڴˣ�",0)
						say("��ѽѽ�������Ҹ�ӡ��������ء���а��һЦ��",27)
					end					
				end
				for i=1, CC.TeamNum do
					if JY.Base["����"..i] >= 0 then
						AddPersonAttrib(JY.Base["����"..i], "��ѧ��ʶ", 40)
					end
                end
				QZXS("ȫ������䳣����40��");
				addHZ(140)
				addHZ(141)
				CC.SKpoint = CC.SKpoint + 1200
				QZXS("���ܵ��1200��")
            end
			if r == 13 then --��ң����
			    CC.SKpoint = CC.SKpoint + 800
				QZXS("���ܵ��800��"); 
			end
			if r == 14 then  --������˵
				for i=1, CC.TeamNum do
				if JY.Base["����"..i] >= 0 then
					AddPersonAttrib(JY.Base["����"..i], "��ѧ��ʶ", 100)
				end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("Ҫ�����׽��") then
                   SetS(111,0,0,0,108)
				   addthing(85)
                end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("Ҫ����ϴ�辭��") then
                   SetS(111,0,0,0,183)
				   addthing(344)
                end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("Ҫ�����޺���ħ����") then
                   SetS(111,0,0,0,96)
				   addthing(72)
                end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("Ҫ�����ղ����񹦣�") then
                   SetS(111,0,0,0,151)
				   addthing(288)
                end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("Ҫ����������������") then
                   SetS(111,0,0,0,152)
				   addthing(299)
                end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("Ҫ����С���๦��") then
                   SetS(111,0,0,0,98)
				   addthing(75)
                end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("Ҫ����˻����Ϲ�����") then
                   SetS(111,0,0,0,101)
				   addthing(79)
                end
				end 
				if GetS(111,0,0,0) == 0 then 
                if yesno("Ҫ����ڤ�񹦣�") then
                   SetS(111,0,0,0,85)
				   addthing(64)
                end
			    end
				for i=1, CC.TeamNum do
				if JY.Base["����"..i] >= 0 then
					AddPersonAttrib(JY.Base["����"..i], "��ѧ��ʶ", 100)
				end
			    end	
				QZXS("ȫ������䳣����100��");
				CC.SKpoint = CC.SKpoint + 1800
				QZXS("���ܵ��1800��")
			end 	
			if r == 15 then  --������
				say("��ϲ��ͻ��������", 576, 0, "��ĸ��")
				say("������λ������Ϊɽկ������ש���ߣ���֦ɢҶ��", 576, 0, "��ĸ��")
				say("�����е�������ֵ׵ľ��У����������ǵ���Ѫ��", 576, 0, "��ĸ��")
				say("ɽկ�����ǿ�Դ��Ϸ�����ǻ�ӭ�κ��������������ͬ�á�", 576, 0, "��ĸ��")
				say("�㣬�벻���Ϊ���������һλ��Ա�أ�", 576, 0, "��ĸ��")
				say("��������л��������߶�⼸�䣬������Щ�ö����ɡ�", 576, 0, "��ĸ��")
			    for i=1,#CC.TFlist do
                    addHZ(i)              
                end				
				CC.SKpoint = CC.SKpoint + 5000
				QZXS("���ܵ��5000��")
			end
			
		else
			SetS(86, 2, r, 5, 2);
			say("�ܿ�ϧ��������������������", 232, 1, "����ͨ");	
		end
	end
	
	SetS(86, 1, 9, 5, 0);
end

--��������
function LianGong()
	JY.Person[445]["�ȼ�"] = 30 * 350 --�������ǣ�������
  JY.Person[446]["�ȼ�"] = JY.Person[445]["�ȼ�"]
  JY.Person[445]["ͷ�����"] = math.random(190)
  JY.Person[446]["ͷ�����"] = math.random(190)
  --JY.Person[445]["�������ֵ"] = 1
  --JY.Person[446]["�������ֵ"] = 1
  JY.Person[445]["����"] = 1 --JY.Person[445]["�������ֵ"]
  JY.Person[446]["����"] = 1 --JY.Person[446]["�������ֵ"]
  instruct_6(226, 8, 0, 1)
  JY.Person[445]["�ȼ�"] = 10
  JY.Person[446]["�ȼ�"] = 10
  JY.Person[445]["ͷ�����"] = 208
  JY.Person[446]["ͷ�����"] = 208
	return 1;
end

function introduction()
	local menu = {
		{"�������",nil,1,CC.SB},
		{"�������",nil,1,CC.GT},
		{"�书���",nil,1,CC.WG},
		{"״̬��˵",nil,1,CC.STATUS},		
		{"��ѧָ��",nil,1,CC.WXZL},		
	}
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "Ҫ�鿴ʲô", C_WHITE, CC.DefaultFont)
	local r = ShowMenu(menu,#menu,0,CC.MainSubMenuX,CC.MainSubMenuY+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
	if r <= 0 then
		do return end
	end
	if r == 2 then
		local zgt = {
			{1, "�������ʱɱŭ��%d��"},
			{2, "�������ʱ�����˺�%d��"},
			{3, "�������ʱ�˺����Ӱٷ�֮%d"},
			{4, "�ض��������ٷ�֮%d����������"},
			{5, "������ָ�����%d"},
			{6, "�������ʱɱ����%d��"},
			{7, "�ض�����"},
			{8, "�����������İٷ�֮%d"},
			{9, "�������ʱɱ���������ٷ�֮%d"},
			{10, "��Ѩ�������Ӱٷ�֮%d"},
			{11, "�����书����%d��"},
			{12, "�ض��϶�%d��"},
			{13, "�������ʱ׷�ӵ����ж�ֵ�ٷ�֮%d���˺�"},
			{14, "�������ʱ׷�ӵ�������ֵ�ٷ�֮%d���˺�"},
		}

		local GT = {}
		local t = {CC.ZGT1, CC.ZGT2, CC.ZGT3, CC.ZGT4, CC.ZGT5, CC.ZGT6, CC.ZGT7, CC.ZGT8, CC.ZGT9, CC.ZGT10, CC.ZGT11, CC.ZGT12, CC.ZGT13, CC.ZGT14}
		for i = 1, JY.WugongNum - 1 do
			if i ~= 91 and i ~= 122 and (yongnei(i) or yongqing(i)) then
				GT[#GT + 1] = {JY.Wugong[i]["����"]}
				GT[#GT][0] = i
			end
		end

		for a = 1, #GT do
				for i = 1, #CC.ZGTATK do
					if CC.ZGTATK[i][1] == GT[a][0] then
						GT[a][#GT[a] + 1] = "����ֵ��"..CC.ZGTATK[i][2].."��"..CC.ZGTATK[i][3]		
						break
					end
				end
				for i = 1, #CC.ZGTDEF do
					if CC.ZGTDEF[i][1] == GT[a][0] then
						GT[a][#GT[a]] = string.format("%-22s%s", GT[a][#GT[a]], "����ֵ��"..CC.ZGTDEF[i][2].."��"..CC.ZGTDEF[i][3])
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
						GT[a][#GT[a] + 1] = JY.Wugong[t[i][j][1]]["����"].." "..string.format(zgt[i][2], t[i][j][3])	
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
		say("���˷�Ѩ����Ѫ���ٻ������⣬���յȳ���״̬�⣬����һЩ����״̬��Ҫע�⡣", 232, 1, "����ͨ");
		sidetoside(menu[r][4], 1)
	end
end

--װ��˵��
function ZBInstruce()
	local flag = false
	repeat
		local x1 = CC.ScreenW/2 - 180 ;
		local y1 = 150;
		DrawStrBox(x1, y1, "��ѡ����Ҫ�鿴��װ��",C_WHITE, CC.DefaultFont);
		local menu = {
			{"���佣",nil,1},
			{"����",nil,1},
			{"������",nil,1},
			{"���콣",nil,1},
			{"������",nil,1},
			{"���o��",nil,1}
		};
		
		local numItem = table.getn(menu);
		local size = CC.DefaultFont;
		local r = ShowMenu(menu,numItem,0,x1+80,y1+40,0,0,1,1,size,C_ORANGE,C_WHITE);
		if r == 0 then
			flag = true;
		elseif r == 1 then
			say("���佣��ʹ��̫������������", 232, 1, "����ͨ");
		elseif r == 2 then
			say("�������������㼯���ٶ�", 232, 1, "����ͨ");	
		elseif r == 3 then
			say("��������������������ر������������������߱�����", 232, 1, "����ͨ");	
		elseif r == 4 then
			say("���콣����������Ѫ������һ�����ʷ�Ѩ", 232, 1, "����ͨ");	
		elseif r == 5 then
			say("��������ʹ�õȼ�Ϊ���ĵ�����߰ٷ�֮��ʮ�����ʣ�������������аٷ�֮��ʮ���ʴ����ɱ���������������Ѫ��ɱ���������书�����й�", 232, 1, "����ͨ");	
		elseif r == 6 then
			say("���o�ף��ܵ�ȭϵ�书����ʱ����һ�����˺����ܵ���ȭϵ�书����ʱ�����˺�", 232, 1, "����ͨ");	
		end
	until flag
end

--brolycjw: ������ս
function DYRW()
	local x1 = CC.MainSubMenuX
	local y1 = CC.MainSubMenuY + CC.SingleLineHeight
	CC.DYRW = -1
	CC.DYRW2 = -1
	DrawStrBox(x1, y1, "��ѡ����ս����",C_WHITE, CC.DefaultFont);
	local menu = {}
	local menu2 = {}
	local id = -1
	for i = 1, CC.TeamNum do
		menu[i] = {"", nil, 0}
		id = JY.Base["����" .. i]	
		if id >= 0 and duiyou(id) then
			menu[i] = { JY.Person[id]["����"], nil, 1}
		end
	end
	local numItem = table.getn(menu);
	local size = CC.DefaultFont;
	local r = ShowMenu(menu,numItem,0,x1,y1+40,0,0,1,1,size,C_ORANGE,C_WHITE);	
	if r > 0 then
		id = JY.Base["����" .. r]
		CC.DYRW = id
		DrawStrBox(x1, y1, "��ѡ����ս�Ѷ�",C_WHITE, CC.DefaultFont)
		menu = {			
			{"����",nil,0}, --3
			{"����",nil,0}, --4
			{"�м�",nil,0}, --5
			{"�߼�",nil,0}, --6
			{"��",nil,0}, --7
		}		
		if JY.Person[id]["��ս"] + 1 > #menu then
			say("�Ѿ�û����ս�����ˡ�", 232, 1, "����ͨ");
			do return end
		end
		menu[JY.Person[id]["��ս"] + 1][3] = 1
		numItem = table.getn(menu);
		local rr = ShowMenu(menu,numItem,0,x1,y1+40,0,0,1,1,size,C_ORANGE,C_WHITE);		
		if rr > 0 then
			local ds = {}
			for i = 0, JY.PersonNum - 1 do
				if not duiyou(i) and JY.Person[i]["����"] - 2 == rr and JY.Person[i]["��ս"] ~= 999 then
					ds[#ds + 1] = i
				end
			end
			if #ds < 1 then
				for i = 0, JY.PersonNum - 1 do
					if not duiyou(i) and JY.Person[i]["����"] - 2 == rr then
						ds[#ds + 1] = i
					end
				end				
			end
			if #ds < 1 then
				say("�Ѿ�û����ս�����ˡ�", 232, 1, "����ͨ");
				do return end
			end
			say("��ѡ����ս���֡�", 232, 1, "����ͨ");
			local dxp = {}
			local num = 1
			for i = 1, #ds do
				dxp[num] = {}
				dxp[num][1] = JY.Person[ds[i]]["����"] 
				dxp[num][2] = nil
				dxp[num][3] = 1
				dxp[num][4] = i
				num = num + 1			
			end
			local dsxz = ShowMenu(dxp, num - 1, 15, CC.MainMenuX, CC.MainMenuY + 45, 0, 0, 1, 0, CC.DefaultFont, C_RED, C_GOLD)
			CC.DYRW2 = ds[dxp[dsxz][4]] --ds[math.random(#ds)]
			if CC.DYRW2 == 116 and math.random(3) == 1 and JY.Person[618]["����13"] == 1000 then 
				CC.DYRW2 = 618 
				JY.Person[618]["�书5"] = 124
				JY.Person[618]["�书6"] = 104
				JY.Person[618]["�书7"] = 105
				JY.Person[618]["�书8"] = 106
				JY.Person[618]["�书9"] = 107
				JY.Person[618]["�书10"] = 108
				for i = 4, 10 do
					JY.Person[618]["�书�ȼ�"..i] = JY.Person[618]["�书�ȼ�3"]
				end
			end
			if WarMain(341) then
				JY.Person[id]["��ս"] = JY.Person[id]["��ս"] + 1
				JY.Person[CC.DYRW2]["��ս"] = 999
				say("���Ǻ����ְ���", 232, 1, "����ͨ");
				QZXS(string.format("%s ʵս����%s��",JY.Person[id]["����"],rr*12));
				QZXS(string.format("%s ����������%s��",JY.Person[id]["����"],rr*3));			
				AddPersonAttrib(id, "ʵս", rr * 12)
				AddPersonAttrib(id, "������", rr*3);
				AddPersonAttrib(id, "������", rr*3);
				AddPersonAttrib(id, "�Ṧ", rr*3);

				if CC.DYRW2 == 64 then addHZ(1) end				
				if CC.DYRW2 == 50 then addHZ(7) end
				if CC.DYRW2 == 15 then addHZ(8) end
				if CC.DYRW2 == 102 then addHZ(10) end
				if CC.DYRW2 == 98 then addHZ(13) end
				if CC.DYRW2 == 118 then 
					addHZ(14)
					if id == 0 and GetS(114, 0, 0, 0) == 0 then
						say("��С�Ӳ��������Ҳ��������������������������ɡ�",118)
						say("��...лл�����⣬����������ұ��ؼ��ͺ��ˣ�����...",0)
						say("��������ɵ�ӡ�(��ĿһƳ)���ðɣ��ǽ�����һ�ײ�����",118)	
	                    instruct_0();
	                    if instruct_11(0,188) == true then
	                        QZXS("�����貨΢����")
							say("лл���",0) 
							instruct_0();
							SetS(114,0,0,0,179)
							--addthing(339)
				        else
				            say("���������ã�������ˮû��Ҫ�������ûȤ��",118)
							say("������",118)		
				        end
					    do return; end
                    end
					--addHZ(14)
				end				
				if CC.DYRW2 == 67 then addHZ(15) end
				if CC.DYRW2 == 27 then 
					addHZ(16)
					if id == 0 and GetS(114, 0, 0, 0) == 0 and PersonKF(id,196) and PersonKF(id,105) and GetS(111, 0, 0, 0) ~= 105 then
						say("�٣����򲻴�������������������",27)
						say("������Ӱ�����ó��������治�¶���",27)
						say("�����úá���������һ���ɣ�",27)
						if DrawStrBoxYesNo(-1, -1, "Ҫ���ܽ������˽�����", C_WHITE, 30) == true then
							say("��ะ�������������",0)
							say("�������ˣ���������㣡����Ź���������",0)
							say("����������������������������������",27)
							dark()
							light()
							QZXS("��������Ӱ����")
							setLW2(196)
							say("�ǺǺǣ��о���Σ�",27)
							say("�ǳ��ã��ǳ���...���������ᣩ",0)
						else
							say("���������ˣ������ŵ�Ĩ�ͣ�",0)
							say("�����������",27)
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
						say("�����ñ��£�ƶɮ�������ڷ�����ѧ�����о�������ƶɮ���Ʒ��ĵ����������ɺã���",70) 
	                    instruct_0();
			            if instruct_11(0,188) == true then
	                        QZXS("��������ɽ���ƣ�")
						    say("��л���ɣ�",0) 
	                        instruct_0();
	                        SetS(113, 0, 0, 0,24)
				        else
				            say("�Ǻǣ�Ե��δ��������˳����Ȼ�ɣ�",70) 
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
						say("�����ñ��£��ϵ��ⴿ���޼���Ҳ�����з��ˡ�",5) 
	                    instruct_0();
			            if instruct_11(0,188) == true then
	                        QZXS("�������޼���")
						    say("��л������",0) 
	                        instruct_0();
	                        SetS(111, 0, 0, 0,99)
				        else
				            say("����������������������Ϊ��",5) 
				        end
				        --addHZ(53) 
					    do return; end
                    end
				end
				if CC.DYRW2 == 69 then 
					if id == 0 and GetS(111, 0, 0, 0) == 0 then
						say("����������������Ϊ����Ҫ��Ҫ���Ͻл�ѧ���֣�",69) 
	                    instruct_0();
			            if instruct_11(0,188) == true then
	                        QZXS("������������")
						    say("��л����ǰ��",0) 
	                        instruct_0();
	                        SetS(111, 0, 0, 0,178)
						    addthing(338)
				        else
				            say("�����������Ͻл��������ˡ�",69) 
				        end
					    do return; end
                    end
				end
				if CC.DYRW2 == 129 then
					if id == 0 and GetS(114,0,0,0) == 0 and PersonKF(id,192) then
						say("�����������²�����С�崫�ˣ�",129)
						say("������",0)
						say("���¹�ǫ�ˣ�",129)
						say("��˵�ҷ��ָ����ƺ���ѧ���ŵ��Ṧ���㹦��",129)
						say("�ǣ���ȫ������ֿ������",0)
						say("��������Ȼ��ˣ��ϵ��������˵��˵����",129)
						if DrawStrBoxYesNo(-1, -1, "Ҫ�����������۵���", C_WHITE, 30) == true then
							QZXS("������㹦��")
							setLW2(192)
							say("��л��������ָ�̣�������������",0)
							say("��˵��˵",129)
						else
							say("���²���ѧǳ��ȴ�ǲ��Ҵ������������",0)
							say("�޷�������������ۣ�����̸Ҳ�ɡ�",129)
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
						say("�ҿ����м��ֱ��£��պ����������һ֮ʱף��һ��֮�����ұ㽫�⺮��������������Σ�",22) 
	                    instruct_0();
			            if instruct_11(0,188) == true then
	                        QZXS("���򺮱�������")
	                        instruct_0();
	                        SetS(111, 0, 0, 0,124)
						    addthing(261)
				        else
				            say("��ʶ̧�٣�",22) 
				        end
				            addHZ(110) 
					    do return; end
                    end
				end
				if CC.DYRW2 == 19 then
					if id == 0 and GetS(111, 0, 0, 0) == 0 then
						say("����������Ȥ���һ�ɽ���ˣ�",19) 
	                    instruct_0();
			            if instruct_11(0,188) == true then
	                        QZXS("������ϼ������")
	                        instruct_0();
	                        SetS(111, 0, 0, 0,89)
				        else
				            say("���ǿ�ϧ�ˣ�",19) 
				        end
					    do return; end
                    end
				end
				if CC.DYRW2 == 114 then
					addHZ(115)
	                if PersonKF(0, 108) and GetS(111, 0, 0, 0) == 0 then
	                    say("�����书���������������һ��������",114) 
	                    instruct_0();
			            if instruct_11(0,188) == true then
	                        local T = {}
			                for a = 1, 1000 do
				                local b = "" .. a
					                T[b] = a
							end
			                DrawStrBoxWaitKey(CC.EVB124, C_WHITE, 30)
			                JY.Person[0]["����"] = -1
			                while JY.Person[0]["����"] == -1 do
								local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
								if T[r] ~= nil and T[r] > -1 and T[r] < 101 then
									JY.Person[0]["����"] = T[r]
								else
									DrawStrBoxWaitKey(CC.EVB125, C_WHITE, 30)
								end
							end
							SetS(111, 0, 0, 0,108)
						else
							say("����ͦ�õġ�",0) 
						end
					end
					if GetS(114, 0, 0, 0) == 0 and PersonKF(0,143) then
						say("��...һέ�ɽ��Ṧ��Ҳ�ᣬ����������ɮ����...",0)
						say("���ֲ�Ⱦ����쳾����Ȼ�Զɵ�����...",0)
						say("�������������ˣ�",0)	
	                    instruct_0();
	                    QZXS("����һέ�ɽ����裡") 
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
						say("����ң��С���๦��ģ��������ѧ����ȴ��δ��ѧ��������������������Σ�",618) 
	                    instruct_0();
			            if instruct_11(0,188) == true then
	                        QZXS("��������û���")
	                        instruct_0();
	                        SetS(111, 0, 0, 0,98)
				        else
				            say("���Ҳ�ա�",618) 
				        end
					    do return; end
                    end
					say("�������Ҳ����Ǵ�������������˰ɣ�",CC.DYRW)
					if CC.DYRW > 0 then JY.Person[618]["����13"] = CC.DYRW end
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
				say("�ܿ�ϧ��������������������", 232, 1, "����ͨ")
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
	DrawStrBox(x1, y1, "��ѡ����Ҫ�����Ķ���",C_WHITE, CC.DefaultFont);
	local menu = {}
	local menu2 = {}
	local id = -1
	for i = 1, CC.TeamNum do
		menu[i] = {"", nil, 0}
		id = JY.Base["����" .. i]	
		if id >= 0 and duiyou(id) then
			menu[i] = { JY.Person[id]["����"], nil, 1}
		end
	end
	menu[CC.TeamNum + 1] = {'ȫ��', nil, 1}
	local numItem = table.getn(menu);
	local size = CC.DefaultFont;
	local r = ShowMenu(menu,numItem,0,x1,y1+40,0,0,1,1,size,C_ORANGE,C_WHITE);	
	if r > 0 and r <= CC.TeamNum then
		id = JY.Base["����" .. r]
		--CC.DYRW = id
		JY.Person[id]["����"] = 55000
		War_AddPersonLVUP(id);
	elseif r > CC.TeamNum then
		for i = 1, CC.TeamNum do                 
			local id = JY.Base["����" .. i];
			if id >= 0 then
				JY.Person[id]["����"] = 55000
				War_AddPersonLVUP(id);		
			end
		end		
	end
end


--�޸�ԭ39�¼�������ɱ����
--nino�����ƿ�ɱ������а��
OEVENTLUA[39] = function()
    --instruct_3(-2,-2,-2,0,40,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
    instruct_1(179,0,1);   --  1(1):[AAA]˵: ����˭��������ʲô��
    instruct_0();   --  0(0)::�����(����)
    instruct_1(180,37,0);   --  1(1):[����]˵: �����ҽе��ƣ��Ǹ�����֮*�ˡ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(181,0,1);   --  1(1):[AAA]˵: ��Ҫ��Щ�飬��㵽���ɽ*����������
    instruct_0();   --  0(0)::�����(����)
    instruct_1(182,37,0);   --  1(1):[����]˵: �㻹����Щ��ȥ�ĺã����*�����������֮�����ۡ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(183,0,1);   --  1(1):[AAA]˵: �㵽�׷�����ʲô�£�˵��*������
    instruct_0();   --  0(0)::�����(����)
    instruct_1(184,37,0);   --  1(1):[����]˵: ����ǰ������ʦ����ʦ�õ�*����ȥΪ������ɽ��ʦ��ף*�٣�������ȴ��ʦ��������*���ҹ�����ˣ�͵�������*�Ľ����鱦������ͼ����С*ʦ�*���ظ�����Ҳû���������*�Ͱ��ҹ���������**������˵��ʦ�����ˣ���ʦ*�á�����ʦ��������������*���޸�����ʦ�֡�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(185,0,1);   --  1(1):[AAA]˵: ��ܰ���ʦ�ã�����
    instruct_0();   --  0(0)::�����(����)
    instruct_1(186,37,0);   --  1(1):[����]˵: ��ʦ�����ܡ�������*���ܼ޸��Ǹ�����ġ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(187,0,1);   --  1(1):[AAA]˵: ���������ô�뿪�Ǿ��ݴ�*�Σ�����ô�������
    instruct_0();   --  0(0)::�����(����)
    instruct_1(188,37,0);   --  1(1):[����]˵: �����еļ��꣬ͬ�εĶ���*��������������཭����*���£�Ҳ������"���վ�"��*����
    instruct_0();   --  0(0)::�����(����)
    instruct_1(189,0,1);   --  1(1):[AAA]˵: ���վ�������������������*�ӡ���
    instruct_0();   --  0(0)::�����(����)
    instruct_1(190,37,0);   --  1(1):[����]˵: ͻȻ��һ�죬����������*����˵Ҫȥ��һλ���ѡ���*�벻���Ƕ����ĺ��֪��*���ˣ��������ף�Ҳ���Ǿ�*�ݸ�������Ȼ����Ů���Ĺ�*ľ���¶���Ϊ�ľ���Ҫ����*����磬�����������ж�*���ˡ����������ˣ�������*�ص���������ɽ������*�Һ�ʦ����ǰ��ʱ�������*�ط���
    instruct_0();   --  0(0)::�����(����)
	
	if PDReq(0, "Ʒ��", 0, 30) then
		if DrawStrBoxYesNo(-1, -1, "Ҫ�͵���ս����", C_WHITE, 30) == true then	
			Cls()
			say("������ô��ϻ��������վ���������")
			Cls()
			say("���У����Ƕ��������",37,0,"����")	
			Cls()
			say("������")		
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

    if instruct_9(0,93) ==true then    --  9(9):�Ƿ�Ҫ�����?������ת��:Label0
        instruct_1(191,0,1);   --  1(1):[AAA]˵: ����Ҳ�޼ҿɹ飬����һ��*�߰ɣ�·��Ҳ�и���Ӧ��
        instruct_0();   --  0(0)::�����(����)

        if instruct_28(0,0,100,0,76) ==true then    --  28(1C):�ж�AAAƷ��0-100������ת��:Label1

          if instruct_20(32,0) ==false then    --  20(14):�����Ƿ�����������ת��:Label2
		          instruct_37(2);   --  37(25):���ӵ���2
		          instruct_1(192,37,0);   --  1(1):[����]˵: �ðɣ�����㲻�±������*����֮�����۵Ļ���
							Talk(CC.LTalk91, 37);	--[��˵]���þ�û��ȥ���ݶ�����ˣ�����ȥҩ����һ����
          
              instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
              instruct_3(104,81,1,0,956,0,0,7232,7232,7232,-2,-2,-2);   --  3(3):�޸��¼�����:����[���㵺]:�����¼���� [81]
              instruct_10(37);   --  10(A):��������[����]
              instruct_0();   --  0(0)::�����(����)
              
              instruct_3(103,81,1,0,0,0,0,6700,6700,6700,0,0,0);		--�޸�ҩ�����¼�
							instruct_3(103,82,1,0,8012,0,0,6696,6696,6696,0,0,0);		--�޸�ҩ�����¼�
              return
          end    --:Label2

            --instruct_1(12,37,0);   --  1(1):[����]˵: ��Ķ����������Ҿ�ֱ��ȥ*С��ɡ�
            Talk(CC.LTalk90, 37);
            
            
            return
        end    --:Label1

        instruct_1(193,37,0);   --  1(1):[����]˵: ���ˣ����������֮�˻���*���˵ĺá�
        instruct_0();   --  0(0)::�����(����)
    end    --:Label0



end

--�����޸�ѩɽ�¼�
OEVENTLUA[41] = function()
		
		--���ſ�ջ�¼���δ����ǰ���ɽ���
		if GetS(86, 9, 10, 5) ~= 1 then
			Talk(CC.LTalk46,0);		--[����]����ط����䣬���ǳ�ȥ�ɡ�
			JY.Base["��X1"] = JY.Scene[JY.SubScene]["����X1"];
			JY.Base["��Y1"] = JY.Scene[JY.SubScene]["����Y1"];
			return;
		end

		
    instruct_3(3,5,1,0,643,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:����[�м��ջ]:�����¼���� [5]
    instruct_3(3,6,1,0,643,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:����[�м��ջ]:�����¼���� [6]
    instruct_3(3,8,1,0,643,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:����[�м��ջ]:�����¼���� [8]
    instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [0]
    instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [1]
    instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [2]
    instruct_30(27,49,27,34);   --  30(1E):�����߶�27-49--27-34
    instruct_25(27,34,27,30);   --  25(19):�����ƶ�27-34--27-30
    instruct_1(197,0,2);   --  1(1):[AAA]˵: "��~��~��~ˮ~"
    instruct_0();   --  0(0)::�����(����)
    instruct_1(198,0,1);   --  1(1):[AAA]˵: ������ô��ô���֣�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(199,94,0);   --  1(1):[???]˵: �ߣ�аħ��������˵ö���*֮��
    instruct_0();   --  0(0)::�����(����)
    instruct_1(200,95,0);   --  1(1):[???]˵: Ѫ�����棬���Ѿ���Ͷ��·*�ˣ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(201,96,0);   --  1(1):[???]˵: �������ˣ����վ�����Ѫ*ծѪ����
    instruct_0();   --  0(0)::�����(����)
    instruct_1(202,52,0);   --  1(1):[������]˵: Ѫ�����棬��ǹ��
    instruct_0();   --  0(0)::�����(����)
    Talk(CC.LTalk47,96);		--[ˮ�]�������Ů�����ˣ�������������ֵܶ���������������
    instruct_0();   --  0(0)::�����(����)
    instruct_1(203,97,0);   --  1(1):[???]˵: С�ӣ�����ң������ĸ���*����һ����
    instruct_0();   --  0(0)::�����(����)
    instruct_1(204,246,1);   --  1(1):[???]˵: ���������˵�������ǻ���*����
    instruct_0();   --  0(0)::�����(����)
    instruct_1(205,97,0);   --  1(1):[???]˵: С�ӣ����������Ѿ�������*��������ң��Ҿ�����һ��*���飡
    instruct_0();   --  0(0)::�����(����)
    instruct_1(206,0,1);   --  1(1):[AAA]˵: ���飿�ѵ������飿��
    instruct_0();   --  0(0)::�����(����)
    instruct_1(207,96,0);   --  1(1):[???]˵: ��λ������Ҫ������Ϊ����*��
    instruct_0();   --  0(0)::�����(����)
    Talk(CC.LTalk48,0);	--[����]������ô�죬���ֵܻ���Ѫ������������Ҫ��~~�仨��ˮ~~Ϊ��ô��

    if instruct_5(0,198) ==true then    --  5(5):�Ƿ�ѡ��ս����������ת��:Label0
        instruct_37(-2);   --  37(25):���ӵ���-2
        instruct_1(208,244,1);   --  1(1):[???]˵: Ϊ�����飬ֻ������ˣ�
        instruct_0();   --  0(0)::�����(����)

        if instruct_6(42,4,0,0) ==false then    --  6(6):ս��[42]������ת��:Label1
            instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
            instruct_0();   --  0(0)::�����(����)
            do return; end
        end    --:Label1
		addHZ(112)
        instruct_17(-2,1,24,31,0);   --  17(11):�޸ĳ�����ͼ:��ǰ������1����18-1F
        instruct_17(-2,1,27,27,0);   --  17(11):�޸ĳ�����ͼ:��ǰ������1����1B-1B
        instruct_17(-2,1,30,34,0);   --  17(11):�޸ĳ�����ͼ:��ǰ������1����1E-22
        instruct_0();   --  0(0)::�����(����)
        instruct_13();   --  13(D):������ʾ����
        instruct_1(209,52,0);   --  1(1):[������]˵: ����������������������
        instruct_0();   --  0(0)::�����(����)
        instruct_1(210,0,1);   --  1(1):[AAA]˵: ι����ղŻ�������Ȼ�ģ�*������ô�ˣ�
        instruct_0();   --  0(0)::�����(����)
        instruct_1(211,52,0);   --  1(1):[������]˵: С�����۲�ʶ̩ɽ��������*����Ϊ�а�
        instruct_0();   --  0(0)::�����(����)

        if instruct_9(0,105) ==true then    --  9(9):�Ƿ�Ҫ�����?������ת��:Label2
            instruct_37(-1);   --  37(25):���ӵ���-1
            instruct_1(212,247,1);   --  1(1):[???]˵: �����������㻹ͦʶ��ģ�*�Ժ�͸����Ұɡ�
            instruct_0();   --  0(0)::�����(����)
            instruct_1(213,52,0);   --  1(1):[������]˵: ��л������ɱ֮����������*ԸΪ����ǣ��׹�롣
            instruct_0();   --  0(0)::�����(����)
            instruct_3(104,87,1,0,964,0,0,7236,7236,7236,-2,-2,-2);   --  3(3):�޸��¼�����:����[���㵺]:�����¼���� [87]

            if instruct_20(30,0) ==false then    --  20(14):�����Ƿ�����������ת��:Label3
                instruct_10(52);   --  10(A):��������[������]
                instruct_0();   --  0(0)::�����(����)
                instruct_17(-2,1,25,29,0);   --  17(11):�޸ĳ�����ͼ:��ǰ������1����19-1D
                instruct_0();   --  0(0)::�����(����)
                instruct_1(214,97,0);   --  1(1):[???]˵: С�ӣ��㻹�����������*Ѫ���Űɣ�
                instruct_0();   --  0(0)::�����(����)
                instruct_1(215,0,1);   --  1(1):[AAA]˵: �ϻ���˵�������ģ�
                instruct_0();   --  0(0)::�����(����)
                instruct_1(216,97,0);   --  1(1):[???]˵: ��ˬ�죬��ȥ��
                instruct_0();   --  0(0)::�����(����)
                instruct_2(139,1);   --  2(2):�õ���Ʒ[Ѫ����][1]
                instruct_0();   --  0(0)::�����(����)
                do return; end
            end    --:Label3

            instruct_1(12,52,0);   --  1(1):[������]˵: ��Ķ����������Ҿ�ֱ��ȥ*С��ɡ�
            instruct_0();   --  0(0)::�����(����)
            instruct_3(70,41,1,0,141,0,0,7014,7014,7014,-2,-2,-2);   --  3(3):�޸��¼�����:����[С��]:�����¼���� [41]
            instruct_17(-2,1,25,29,0);   --  17(11):�޸ĳ�����ͼ:��ǰ������1����19-1D
            instruct_0();   --  0(0)::�����(����)
            instruct_1(214,97,0);   --  1(1):[???]˵: С�ӣ��㻹�����������*Ѫ���Űɣ�
            instruct_0();   --  0(0)::�����(����)
            instruct_1(215,0,1);   --  1(1):[AAA]˵: �ϻ���˵�������ģ�
            instruct_0();   --  0(0)::�����(����)
            instruct_1(216,97,0);   --  1(1):[???]˵: ��ˬ�죬��ȥ��
            instruct_0();   --  0(0)::�����(����)
            instruct_2(139,1);   --  2(2):�õ���Ʒ[Ѫ����][1]
            instruct_0();   --  0(0)::�����(����)
            do return; end
        end    --:Label2

        instruct_1(217,245,1);   --  1(1):[???]˵: �ߣ�����ƽ�����ľ���*�������ˡ������ɣ�
        instruct_0();   --  0(0)::�����(����)
        instruct_1(176,52,0);   --  1(1):[������]˵: ������
        instruct_0();   --  0(0)::�����(����)
        instruct_14();   --  14(E):�������
        instruct_17(-2,1,25,29,0);   --  17(11):�޸ĳ�����ͼ:��ǰ������1����19-1D
        instruct_0();   --  0(0)::�����(����)
        instruct_13();   --  13(D):������ʾ����
        instruct_1(214,97,0);   --  1(1):[???]˵: С�ӣ��㻹�����������*Ѫ���Űɣ�
        instruct_0();   --  0(0)::�����(����)
        instruct_1(215,0,1);   --  1(1):[AAA]˵: �ϻ���˵�������ģ�
        instruct_0();   --  0(0)::�����(����)
        instruct_1(216,97,0);   --  1(1):[???]˵: ��ˬ�죬��ȥ��
        instruct_0();   --  0(0)::�����(����)
        instruct_2(139,1);   --  2(2):�õ���Ʒ[Ѫ����][1]
        instruct_0();   --  0(0)::�����(����)
        do return; end
    end    --:Label0

    instruct_1(218,245,1);   --  1(1):[???]˵: ����Ϊ�����飬��Ҳ������*Υ������֮�£�Ѫ�����棬*�����ɣ�
    instruct_0();   --  0(0)::�����(����)
    instruct_37(2);   --  37(25):���ӵ���2

    if instruct_6(7,5,0,0) ==false then    --  6(6):ս��[7]������ת��:Label4
        instruct_0();   --  0(0)::�����(����)
        instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
        do return; end
        instruct_0();   --  0(0)::�����(����)
    end    --:Label4

	instruct_3(-2,3,1,0,0,0,0,8744,8744,8744,0,0,0);			--Ѫ��������ͼ �任
	if hasthing(71) == false then		
	Talk(CC.LTalk49, 97);		--[Ѫ������]��ͽ�������Ȼ���Ұ��¶��֣��Ҿ������㣬������
	Talk(CC.LTalk50, 37);		--[����]�������Ҵ�磬�Ҹ���ƴ�ˣ�����
	DrawStrBoxWaitKey(CC.LTalk51, C_ORANGE, CC.DefaultFont);	--(ϵͳ��ʾ��ƴ���е����񾭹�������..........��
	instruct_0();   --  0(0)::�����(����)
	
	Talk(CC.LTalk52, 97);		--[Ѫ������]����~~~
	instruct_2(356,1);
	Talk(CC.LTalk53, 37);		--[����]������~~~
	Talk(CC.LTalk54,0);		--[����]�����ֵܣ���û�°�
	Talk(CC.LTalk55, 37);	--[����]��û�£��ղ�������һ�̵�ʱ��ͻȻ�о���������Ȼ���ˣ��ŵ����������϶�ɮ�������˵��û�������չ���Ȼ���书��һ�湦��
	
	QZXS(CC.LTalk56);		--(ϵͳ��ʾ�����ƹ�����������������ʮ�㣩
	AddPersonAttrib(37, "������", 30)
	AddPersonAttrib(37, "������", 30)
	AddPersonAttrib(37, "�Ṧ", 30)

	QZXS(CC.LTalk57);		--(ϵͳ��ʾ��������ϵ����ֵ������ʮ�㣩
	AddPersonAttrib(37, "ȭ�ƹ���", 10)
    AddPersonAttrib(37, "��������", 10)
    AddPersonAttrib(37, "ˣ������", 10)
    AddPersonAttrib(37, "�������", 10)
	AddPersonAttrib(37, "��������", 10)
    
    SetS(86, 8, 10, 5, 1);		--�жϵ����Ƿ񼤷����վ�
    
    instruct_3(-2,80,1,0,8003,0,0,9228,9228,9228,0,0,0);		--�����¼�8003�����¼������
	end	
		
    instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [3]
    instruct_0();   --  0(0)::�����(����)
    instruct_13();   --  13(D):������ʾ����
    instruct_1(219,94,0);   --  1(1):[???]˵: �ҵ������Ѿ��������ã���*��������ʱ�ϵ���
    instruct_0();   --  0(0)::�����(����)
    instruct_1(220,95,0);   --  1(1):[???]˵: �ǰ�����������������Ѫ��*����Ĵ�Ӣ�۰�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(221,52,0);   --  1(1):[������]˵: �ص���ԭ������һ��Ϊ��*����������
    instruct_0();   --  0(0)::�����(����)
    instruct_1(222,96,0);   --  1(1):[???]˵: ��������л��ľ���֮����*�Ȿ��������ȥ�ɣ������*�ڡ�
    instruct_0();   --  0(0)::�����(����)
    instruct_2(164,1);   --  2(2):�õ���Ʒ[��ͷ����][1]
    instruct_0();   --  0(0)::�����(����)
    instruct_14();   --  14(E):�������
    instruct_17(-2,1,24,31,0);   --  17(11):�޸ĳ�����ͼ:��ǰ������1����18-1F
    instruct_17(-2,1,27,27,0);   --  17(11):�޸ĳ�����ͼ:��ǰ������1����1B-1B
    instruct_17(-2,1,30,34,0);   --  17(11):�޸ĳ�����ͼ:��ǰ������1����1E-22
    instruct_17(-2,1,25,29,0);   --  17(11):�޸ĳ�����ͼ:��ǰ������1����19-1D
    instruct_0();   --  0(0)::�����(����)
    instruct_13();   --  13(D):������ʾ����
end


--����а��֮��ɱ������Ѫ���¼�
OEVENTLUA[42] = function()

	Talk(CC.LTalk79, 0);		--[����]���˸Ͻ������ˡ�
	Talk(CC.LTalk80, 97);		--[Ѫ������]��С�ӣ���Ƣ��ͦ������θ�ڣ�����Ѫ���Űɡ�
	Talk(CC.LTalk81, 0);		--[����]��Ѫ������ʲô�������ҵ��Ǿ�����������ѵ�������ô����Ҳһ���͸��Ұɡ�
	Talk(CC.LTalk82, 97);		--[Ѫ������]���ٺ٣�С�ӣ������������Ѫ���������ҵ������������б�����͹����ðɡ�
	if instruct_5(0,38) then    --  5(5):�Ƿ�ѡ��ս����������ת��:Label0
		if instruct_6(7,4,0,0) == false then   
			instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
			instruct_0();   --  0(0)::�����(����)
			return;
		end
        
		Talk(CC.LTalk83, 97);		--[Ѫ������]��С�ӣ����ݣ����Ѫ���͸����ˡ�
		instruct_2(44,1);   --  2(2):�õ���Ʒ[Ѫ��][1]
		instruct_0();   --  0(0)::�����(����)
		
		if hasHZ(55) == false then
		Talk(CC.LTalk84, 0);	--[����]�����±�����߾�֮��
		Talk(CC.LTalk85, 97);		--[Ѫ������]����һ�������߾�֮����С�ӣ��������֡�
		DrawStrBoxWaitKey(CC.LTalk86, C_ORANGE, CC.DefaultFont);		--(ϵͳ��ʾ��Ѫ������ͻȻ͵Ϯ��
		instruct_0();   --  0(0)::�����(����)
		
		Talk(CC.LTalk87, 37);		--[����]����磬С�ģ�
		Talk(CC.LTalk52, 97);		--[Ѫ������]����~~~
		instruct_2(356,1);
		Talk(CC.LTalk53, 37);		--[����]������~~~
		Talk(CC.LTalk54, 0);		--[����]�����ֵܣ���û�°�
		Talk(CC.LTalk55, 37);	--[����]��û�£��ղ�������һ�̵�ʱ��ͻȻ�о���������Ȼ���ˣ��ŵ����������϶�ɮ�������˵��û�������չ���Ȼ���书��һ�湦��
		QZXS(CC.LTalk56);		--(ϵͳ��ʾ�����ƹ�����������������ʮ�㣩
		AddPersonAttrib(37, "������", 30)
		AddPersonAttrib(37, "������", 30)
		AddPersonAttrib(37, "�Ṧ", 30)
	
		QZXS(CC.LTalk57);		--(ϵͳ��ʾ��������ϵ����ֵ������ʮ�㣩
		AddPersonAttrib(37, "ȭ�ƹ���", 10)
	    AddPersonAttrib(37, "��������", 10)
	    AddPersonAttrib(37, "ˣ������", 10)
	    AddPersonAttrib(37, "�������", 10)
		AddPersonAttrib(37, "��������", 10)
	    
	    SetS(86, 8, 10, 5, 1);		--�жϵ����Ƿ񼤷����վ�
	    instruct_3(-2,80,1,0,8003,0,0,9228,9228,9228,0,0,0);		--�����¼�8003�����¼������
        end
		
		if GetS(113, 0, 0, 0) == 0 then
	say("ԭ�������Ѫ�������������ܲ�������",0)
	say("�ȵȣ��⵶���ƺ��е��ɶ�",0)
	say("Ҫ��Ҫ�ѵ�š������",0)
				  if DrawStrBoxYesNo(-1, -1, "�Ƿ��Ѫ����", C_WHITE, 30) ==true  then
				  instruct_0();   --  0(0)::�����(����)
                  instruct_13();   --  13(D):������ʾ����
				  say("�ȵȣ�������һ����Ƥ",0)
				  say("ԭ�����������������������Ѫ���󷨰�",0)
				  	 QZXS("����Ѫɷ���⣡")
	                 instruct_0();
	                 setLW1(63)
					 say("������ѵ�������",0)
					 say("��������ͺ¿Ҳ��������ɣ������һ��������ǹ⻷��",0)
				  else
				     say("���ˣ��°ѵ�Ū����",0) 
				  end
    end
		
		
		instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
		instruct_0();   --  0(0)::�����(����)
    end

end

--��дʹ����ʫѡ�����¼�
OEVENTLUA[45] = function()

  if instruct_4(206,0,331) ==true then    --  4(4):�Ƿ�ʹ����Ʒ[��ʫѡ��]��������ת��:Label0
  
  		Talk(CC.LTalk61, 0);		--[����]���ף�������ʾ������
		--[[
  		if not inteam(37) then
  			Talk(CC.LTalk62, 0);	--[����]���ƺ�ֻ�е��ֵܲ�����������е���˼
  			return;
  		end]]
		
  		Talk(CC.LTalk63, 0);		--[����]�����Ǿ����������´��󡭡�
  		Talk(CC.LTalk64, 0);		--[����]������������������ˣ����ǸϽ���ȥ������
		
		if inteam(37) then
			Talk(CC.LTalk65, 0);		--[����]���ƺ�����һ�����ƽ��׵Ķ���
				
			Cls();
			local x = CC.ScreenW/2;
			local y = CC.ScreenH/2;
			local color = C_GOLD;
			local size = CC.Fontbig;
			local offx = (#CC.LTalk67 - #CC.LTalk66)*size/4;
			
			DrawString(x+offx,y,CC.LTalk66,color,size);  --��ҹ˼
			ShowScreen();
			lib.Delay(1000);
			DrawString(x,y+30,CC.LTalk67,color,size);  --��ǰ���¹⣬���ǵ���˪
			ShowScreen();
			lib.Delay(1000);
			DrawString(x,y+60,CC.LTalk68,color,size);  --��ͷ�����£���ͷ˼����
			ShowScreen();
			lib.Delay(2000);
			
			
			Talk(CC.LTalk69, 37);		--[����]�������ǽ�����û�뵽��Ȼ������ʫ֮��
			instruct_35(37,1,114,0);		--���Ƶڶ��书ϴΪ���ǽ���
			DrawStrBoxWaitKey(string.format("%s ѧ���书 %s", JY.Person[37]["����"], JY.Wugong[114]["����"]), C_ORANGE, CC.DefaultFont)
			instruct_2(237,1);		--�õ����ǽ���
		end
  		
      instruct_3(3,5,1,0,644,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:����[�м��ջ]:�����¼���� [5]
      instruct_3(3,6,1,0,644,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:����[�м��ջ]:�����¼���� [6]
      instruct_3(3,8,1,0,644,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:����[�м��ջ]:�����¼���� [8]
      instruct_3(-2,5,1,0,44,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [5]
      instruct_3(63,17,0,0,0,0,48,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [17]
      instruct_3(-2,-2,1,0,47,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
      instruct_32(206,-1);   --  32(20):��Ʒ[��ʫѡ��]+[-1]
      instruct_3(63,1,0,0,0,0,0,6768,6768,6768,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [1]
      instruct_3(63,2,0,0,0,0,0,6768,6768,6768,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [2]
      instruct_3(63,3,0,0,0,0,0,6766,6766,6766,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [3]
      instruct_3(63,4,0,0,0,0,0,6766,6766,6766,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [4]
      instruct_3(63,5,0,0,0,0,0,6770,6770,6770,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [5]
      instruct_3(63,6,0,0,0,0,0,6770,6770,6770,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [6]
      instruct_3(63,7,0,0,0,0,0,6772,6772,6772,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [7]
      instruct_3(63,8,0,0,0,0,0,6772,6772,6772,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [8]
      instruct_3(63,9,0,0,0,0,0,6780,6780,6780,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [9]
      instruct_3(63,10,0,0,0,0,0,6780,6780,6780,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [10]
      instruct_3(63,11,0,0,0,0,0,6780,6780,6780,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [11]
      instruct_3(63,12,0,0,0,0,0,5222,5222,5222,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [12]
      instruct_3(63,13,0,0,0,0,0,5222,5222,5222,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [13]
      instruct_3(63,14,0,0,0,0,0,5222,5222,5222,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [14]
      instruct_3(63,15,0,0,0,0,0,5222,5222,5222,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [15]
      instruct_3(63,16,0,0,0,0,0,6768,6768,6768,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [16]
      instruct_3(63,18,1,0,49,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [18]
      do return; end
  end    --:Label0

  instruct_0();   --  0(0)::�����(����)
end

--�����޸Ļ�ȡ���Ǿ��¼�
OEVENTLUA[49] = function()
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
    instruct_2(146,1);   --  2(2):�õ���Ʒ[���Ǿ�][1]
    instruct_3(3,5,1,0,645,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:����[�м��ջ]:�����¼���� [5]
    instruct_3(3,6,1,0,645,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:����[�м��ջ]:�����¼���� [6]
    instruct_3(3,8,1,0,645,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:����[�м��ջ]:�����¼���� [8]
    instruct_0();   --  0(0)::�����(����)

    if instruct_16(37,2,0) ==false then    --  16(10):�����Ƿ���[����]������ת��:Label0
        instruct_0();   --  0(0)::�����(����)
        do return; end
    end    --:Label0


    if instruct_28(0,80,100,2,0) ==false then    --  28(1C):�ж�AAAƷ��80-100������ת��:Label1
        do return; end
        instruct_0();   --  0(0)::�����(����)
    end    --:Label1

    instruct_37(1);   --  37(25):���ӵ���1
    instruct_1(233,37,0);   --  1(1):[����]˵: ���Ǿ������ҵ��ˣ������*Ҳ���԰�Ϣ�ˡ����Ƕ����*��������͸���ɡ�
    instruct_0();   --  0(0)::�����(����)
    instruct_2(71,1);   --  2(2):�õ���Ʒ[���վ�][1]
    instruct_0();   --  0(0)::�����(����)
    
    instruct_3(-2,80,1,0,0,0,0,9230,9230,9230,0,0,0);			--�ݳ�����ͼ
    instruct_3(-2,81,0,0,0,0,8004,0,0,0,0,0,0);		--·������
end

--��д4MM����¼�

OEVENTLUA[198] = function()
    say("���Ȼ�С�壬����Ҫʱ������ȥ�����æ��")
    instruct_0();   --  0(0)::�����(����)
    instruct_21(92);   --  21(15):[4MM]���
  if GX(92) then --�������ǣ�ͼ�������
	instruct_3(70, 1, 1, 0, 199, 0, 0, 4602*2, 4602*2, 4602*2, -2, -2, -2)
  elseif LWS(92) then
	instruct_3(70, 1, 1, 0, 199, 0, 0, 4606*2, 4606*2, 4606*2, -2, -2, -2)
  elseif MRL(92) then
	instruct_3(70, 1, 1, 0, 199, 0, 0, 4414*2, 4414*2, 4414*2, -2, -2, -2)	
  elseif JY.Person[92]["�Ա�"] == 1 then
	instruct_3(70, 1, 1, 0, 199, 0, 0, 7266, 7266, 7266, -2, -2, -2)
  else
	instruct_3(70, 1, 1, 0, 199, 0, 0, 2522*2, 2522*2, 2522*2, -2, -2, -2)
  end	
end


--��д4MM����¼�
OEVENTLUA[199] = function()
    TalkEx("����Ҫ�Ұ�æ�ĵط���", 92);
    instruct_0();   --  0(0)::�����(����)

    if instruct_9(0,29) ==true then    --  9(9):�Ƿ�Ҫ�����?������ת��:Label0

        if instruct_20(20,0) ==false then    --  20(14):�����Ƿ�����������ת��:Label1
            instruct_10(92);   --  10(A):��������
            instruct_14();   --  14(E):�������
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
            instruct_0();   --  0(0)::�����(����)
            instruct_13();   --  13(D):������ʾ����
            do return; end
        end    --:Label1
				TalkEx("��Ķ������������޷����롣", 92);
        instruct_0();   --  0(0)::�����(����)
        do return; end
    end    --:Label0

end

--��д��������¼�
OEVENTLUA[187] = function()
    if instruct_16(87) == true then
    TalkEx("�ҵ���������ȫ���㵱���֣����������������ʵʵ����С���", 664);
    instruct_0();   --  0(0)::�����(����)
    do return; end
    end
     if instruct_9(0,29) ==true then    --  9(9):�Ƿ�Ҫ�����?������ת��:Label0

        if instruct_20(20,0) ==false then    --  20(14):�����Ƿ�����������ת��:Label1
            instruct_10(86);   --  10(A):��������
            instruct_14();   --  14(E):�������
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
            instruct_0();   --  0(0)::�����(����)
            instruct_13();   --  13(D):������ʾ����
            do return; end
        end    --:Label1
				TalkEx("��Ķ������������޷����롣", 86);
        instruct_0();   --  0(0)::�����(����)
        do return; end
    end    --:Label0

end

--��д��������¼�
OEVENTLUA[189] = function()
    if instruct_16(86) == true then
    TalkEx("�ҵ���������ȫ���㵱���֣���С�������������ʵʵ����С���", 664);
    instruct_0();   --  0(0)::�����(����)
    do return; end
    end

    if instruct_9(0,29) ==true then    --  9(9):�Ƿ�Ҫ�����?������ת��:Label0

        if instruct_20(20,0) ==false then    --  20(14):�����Ƿ�����������ת��:Label1
            instruct_10(87);   --  10(A):��������
            instruct_14();   --  14(E):�������
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
            instruct_0();   --  0(0)::�����(����)
            instruct_13();   --  13(D):������ʾ����
            do return; end
        end    --:Label1
				TalkEx("��Ķ������������޷����롣", 87);
        instruct_0();   --  0(0)::�����(����)
        do return; end
    end    --:Label0

end

--��д���������¼����ĳ�������
OEVENTLUA[847] = function()

	local x1 = CC.ScreenW/2 - 180 ;
	local y1 = 50;
	DrawStrBox(x1, y1+40, "װ������    ������",C_WHITE, CC.DefaultFont);
	local tids = {53,42,62,46,39,45,48,50,55,56,57};
	--local name = {"�йٱ�","�׺罣","���ļ�","�̲���¶��","������","���±���","��ħ��","��ɽ��","�����˵�","����"}
	local prices = {300,300,400,400,500,500,600,600,2000,2000,2000};
	for i = 1, #tids do
		prices[i] = JY.Thing[tids[i]]["��Ǯ"]
	end
	
	local menu = {};
	for i=1, #tids do
		menu[i] = {string.format("%-12s %5d",JY.Thing[tids[i]]["����"],prices[i]), nil, 1};
	end
	
	local n = 3;
	
	menu[9][3] = 0;		--�����˵� Ĭ�ϲ���ʾ
	menu[10][3] = 0;		--��ɽ�� Ĭ�ϲ���ʾ
	menu[11][3] = 0;	--���� Ĭ�ϲ���ʾ
	if JY.Person[0]["�书1"] == 110 then			--ϴ��ɽ����
		menu[9][3] = 1
		n = n - 1
	elseif JY.Person[0]["�书1"] == 111 then		--ϴ���ϵ���
		menu[10][3] = 1
		n = n - 1
	elseif JY.Person[0]["�书1"] == 112 then		--ϴ��������
		menu[11][3] = 1
		n = n - 1
	end
	
	
	for i=1, #tids do			--�Ѿ����˵Ĳ���ʾ
		for j=1, CC.MyThingNum do
			if JY.Base["��Ʒ" .. j] == tids[i] then
				menu[i][3] = 0;
				n = n+1;
			end
		end
	end
	
	if n == #tids then
		DrawStrBoxWaitKey("�Բ��𣬶����Ѿ�������!", C_WHITE, 30)
	end
		
	local numItem = table.getn(menu);
	local r = ShowMenu(menu,numItem,0,x1,y1+80,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
	
	if r > 0 then
		if JY.GOLD >= prices[r] then
			instruct_2(tids[r],1)
			instruct_2(174, -prices[r]);
		else
			DrawStrBoxWaitKey("�Բ��������������!", C_WHITE, 30)
		end
	end
end--��д���������¼�

OEVENTLUA[848] = function()

end--�޸���ɽ�۽��浵������BUG
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
      JY.Person[zj()]["ʵս"] = 500
      AddPersonAttrib(zj(), "������", 30)
      AddPersonAttrib(zj(), "������", 30)
      AddPersonAttrib(zj(), "�Ṧ", 30)
      QZXS(JY.Person[zj()]["����"] .. CC.EVB197)
      SetS(10, 0, 21, 0, 1)
    else
      say(CC.EVB198, 1000, 0, CC.EVB164)
      AddPersonAttrib(0, "ʵս", 100)
      QZXS(CC.EVB199)
    end
    QZXS("��ѧ��ʶ���50��")
    --��ɽ�۽�֮����ѧ��ʶ���50��
    AddPersonAttrib(0, "��ѧ��ʶ", 50);
  else
    say(CC.EVB159, 1000, 0, CC.EVB164)
  end
  instruct_3(80, 101, 0, 0, 0, 0, 0, 0, 0, 0, 0, -2, -2)
end--�����ѹ��¼�
OEVENTLUA[4100] = function() 

	local picid = 566;
	
	instruct_0();
	
	if JY.Base["��Ʒ2"] == 234 then
		say("�����ﻹ�н����ţ��Ͻ���ȥ����",picid,1,"��������");
		
	else
		local title = "�Ƿ��ѹμ����µ�����";
		local str = "�ǣ��ѹ�֮�����Ϊ46*�񣺲��ѹμ���������*��������ʹ���Զ��ѹι���";
		local btn = {"��","��","����"};
		local num = #btn;
		local r = JYMsgBox(title,str,btn,num);
		
		if r == 3 then
			return;
		end
	
	--��쳾�(����0����ʳ��10��������1��С����10�������ܵ���10
		if GetD(0,1,2) > 0 then
			instruct_2(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(0,1,0,0,0,0,0,0,0,0,0,0,0);
		end
	
		if GetD(0,2,2) > 0 then
			instruct_32(0,10);   --  2(2):�õ���Ʒ[С����][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(0,2,0,0,0,0,0,2468,2468,2468,-2,-2,-2); 
		end
		
		if GetD(0,3,2) > 0 then
			instruct_32(3,10);   --  2(2):�õ���Ʒ[�����ܵ���][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(0,3,0,0,0,0,0,2468,2468,2468,-2,-2,-2); 
		end
	
		if GetD(0,5,2) > 0 then
			instruct_32(19,1);   --  2(2):�õ���Ʒ[������][1]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(0,5,0,0,0,0,0,2468,2468,2468,-2,-2,-2);
		end
		
	--������(����9����ʳ��10��ҩ��50��С����10�������ܵ���10 
		if GetD(9,8,2) > 0 then
			instruct_3(9,8,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(9,5,2) > 0 then
			instruct_3(9,5,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(209,50);   --  2(2):�õ���Ʒ[ҩ��][50]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(9,7,2) > 0 then
			instruct_32(0,10);   --  2(2):�õ���Ʒ[С����][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(9,7,0,0,0,0,0,2468,2468,2468,-2,-2,-2);
		end
	
		if GetD(9,6,2) > 0 then
			instruct_32(3,10);   --  2(2):�õ���Ʒ[�����ܵ���][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(9,6,0,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
		end
	
	--��Ĺ(����18�������޵�����
		if GetD(18,4,2) > 0 then
			instruct_3(18,4,1,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(264,1);   --  2(2):�õ���Ʒ[���޵�����][1]
			instruct_32(243,1);   --����
			instruct_0();   --  0(0)::�����(����)
		end
	
	--�ٻ���(����20����ʳ��10 
		if GetD(20,15,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(20,15,0,0,0,0,0,0,0,0,0,0,0);
		end
	
	--����̶(����21����ʳ��10��ŻѪ��
		if GetD(21,13,2) > 0 then
			instruct_3(21,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(21,12,2) > 0 then
			instruct_3(21,12,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(213,1);   --  2(2):�õ���Ʒ[���ٸ�ŻѪ����][1]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--�����(����22��������200��ʳ��10��2��ҩ��50��ţ��ѪЪ��5�����������У���ת������1���ϳ���
		if GetD(22,1,2) > 0 then
			instruct_3(22,1,1,0,0,0,0,2612,2612,2612,-2,-2,-2); 
			instruct_0();   --  0(0)::�����(����)
			instruct_32(209,50);   --  2(2):�õ���Ʒ[ҩ��][50]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(174,200);   --  2(2):�õ���Ʒ[����][200]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(22,2,2) > 0 then
			instruct_3(22,2,1,0,0,0,0,2612,2612,2612,-2,-2,-2);   
			instruct_0();   --  0(0)::�����(����)
			instruct_32(176,1);   --  2(2):�õ���Ʒ[����������][1]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(22,3,2) > 0 then
			instruct_3(22,3,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(10,5);   --  2(2):�õ���Ʒ[ţ��ѪЫ��][5]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(22,4,2) > 0 then
			instruct_3(22,4,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(6,1);   --  2(2):�õ���Ʒ[��ת������][1]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(22,6,2) > 0 then
			instruct_3(22,6,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(22,0,2) > 0 then
			instruct_3(22,0,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(201,1);   --  2(2):�õ���Ʒ[�ϳ���][1]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--���߹���(����23����ʳ��10��4���л���2
		if GetD(23,2,2) > 0 then
			instruct_3(23,2,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(23,3,2) > 0 then
			instruct_3(23,3,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(23,4,2) > 0 then
			instruct_3(23,4,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(23,5,2) > 0 then
			instruct_3(23,5,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(23,9,2) > 0 then
			instruct_3(23,9,1,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(18,2);   --  2(2):�õ���Ʒ[�л���][2]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--���˷��(����24����ʳ��10��С����10
		if GetD(24,10,2) > 0 then
			instruct_32(0,10);   --  2(2):�õ���Ʒ[С����][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(24,10,0,0,0,0,0,2468,2468,2468,-2,-2,-2);
		end
	
		if GetD(24,13,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(24,13,0,0,0,0,0,0,0,0,0,0,0);
		end
	
	--������(����28�����ڳ�����ʳ��25(10+15��
		if GetD(28,84,2) > 0 then
			instruct_3(28,84,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(28,18,2) > 0 and r == 1 then
			instruct_3(28,18,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(210,15);   --  2(2):�õ���Ʒ[ʳ��][15]
			instruct_0();   --  0(0)::�����(����)
			instruct_37(-1);   --  37(25):���ӵ���-1
		end
	
	--ƽһָ��(����30����ҩ��50��ʳ��10��С����10������������5�������ܵ���10�������赨ɢ5�������ⶾ��10��ţ��ѪЪ��5���޳���3 
		if GetD(30,1,2) > 0 then
			instruct_3(30,1,1,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(7,3);   --  2(2):�õ���Ʒ[�޳���][3]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(209,50);   --  2(2):�õ���Ʒ[ҩ��][50]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(30,2,2) > 0 then
			instruct_3(30,2,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(9,10);   --  2(2):�õ���Ʒ[�����ⶾ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(10,5);   --  2(2):�õ���Ʒ[ţ��ѪЫ��][5]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(30,3,2) > 0 then
			instruct_3(30,3,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(3,10);   --  2(2):�õ���Ʒ[�����ܵ���][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(4,5);   --  2(2):�õ���Ʒ[�����赨ɢ][5]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(30,4,2) > 0 then
			instruct_3(30,4,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(0,10);   --  2(2):�õ���Ʒ[С����][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(1,5);   --  2(2):�õ���Ʒ[����������][5]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(30,5,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(30,5,0,0,0,0,0,0,0,0,0,0,0);
		end
	
	--ţ�Ҵ�(����32����ʳ��10
		if GetD(32,4,2) > 0 then
			instruct_3(32,4,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--������(����33����ʳ��10
		if GetD(33,28,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(33,28,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--���޺�(����35����ʳ��10 ��ţ��ѪЫ��5
		if GetD(35,11,2) > 0 then
			instruct_3(35,11,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(10,5);   --  2(2):�õ���Ʒ[ţ��ѪЫ��][5]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--�����(����36��������200,����������2 
		if GetD(36,6,2) > 0 and r == 1 then
			instruct_3(36,6,1,0,0,0,0,2608,2608,2608,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(174,200);   --  2(2):�õ���Ʒ[����][200]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(1,2);   --  2(2):�õ���Ʒ[����������][2]
			instruct_0();   --  0(0)::�����(����)
			instruct_37(-1);   --  37(25):���ӵ���-1
		end
	
	--�嶾��(����37����ʳ��10�������ܵ���10
		if GetD(37,9,2) > 0 then
			instruct_32(3,10);   --  2(2):�õ���Ʒ[�����ܵ���][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(37,9,0,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(37,11,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(37,11,0,0,0,0,0,0,0,0,0,0,0);
		end
	
	--��ɽɽ´(����38���������1
		if GetD(38,8,2) > 0 then
			instruct_3(38,8,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(15,1);   --  2(2):�õ���Ʒ[�����][1]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--������(����40����ʳ��10
		if GetD(40,32,2) > 0 then
			instruct_3(40,32,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--�䵱��(����43����ʳ��10
		if GetD(43,34,2) > 0 then
			instruct_3(43,34,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(43,14,2) > 0 and r == 1 then
			instruct_3(43,14,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_2(8,2);   --  2(2):�õ���Ʒ[����������][2]
			instruct_0();   --  0(0)::�����(����)
			instruct_37(-1);   --  37(25):���ӵ���-1
		end
	
	--������(����44��������200��ҩ��50��ʳ��10�����������2����ת������2
		if GetD(44,3,2) > 0 then
			instruct_3(44,3,1,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(209,50);   --  2(2):�õ���Ʒ[ҩ��][50]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(174,200);   --  2(2):�õ���Ʒ[����][200]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(44,4,2) > 0 then
			instruct_3(44,4,0,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(2,2);   --  2(2):�õ���Ʒ[���������][2]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(44,5,2) > 0 then
			instruct_3(44,5,0,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(6,2);   --  2(2):�õ���Ʒ[��ת������][2]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(44,6,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(44,6,0,0,0,0,0,0,0,0,0,0,0);
		end
	
	--����ɽ��(����46��������200��ҩ��50������׶10
		if GetD(46,8,2) > 0 then
			instruct_3(46,8,1,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(209,50);   --  2(2):�õ���Ʒ[ҩ��][50]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(174,200);   --  2(2):�õ���Ʒ[����][200]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(46,2,2) > 0 then
			instruct_3(46,2,1,0,0,0,0,2608,2608,2608,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(30,10);   --  2(2):�õ���Ʒ[����׶][10]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--ҩ��ׯ(����49����ʳ��10��ҩ��50��С����10������������3�����������1�������ܵ���10�������赨ɢ3���Ż���¶��2����ת������1��ţ��ѪЪ��3 
		if GetD(49,3,2) > 0 then
			instruct_3(49,3,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(0,10);   --  2(2):�õ���Ʒ[С����][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(1,3);   --  2(2):�õ���Ʒ[����������][3]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(2,1);   --  2(2):�õ���Ʒ[���������][1]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(3,10);   --  2(2):�õ���Ʒ[�����ܵ���][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(4,3);   --  2(2):�õ���Ʒ[�����赨ɢ][3]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(5,2);   --  2(2):�õ���Ʒ[�Ż���¶��][2]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(6,1);   --  2(2):�õ���Ʒ[��ת������][1]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(10,3);   --  2(2):�õ���Ʒ[ţ��ѪЫ��][3]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(209,50);   --  2(2):�õ���Ʒ[ҩ��][50]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(49,4,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(49,4,0,0,0,0,0,0,0,0,0,0,0);
		end
	
	--�ֻ���(����50����ʳ��10��ҩ��20��С����15������������3�������赨ɢ3������������1
		if GetD(50,2,2) > 0 then
			instruct_3(50,2,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(0,10);   --  2(2):�õ���Ʒ[С����][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(209,20);   --  2(2):�õ���Ʒ[ҩ��][20]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(50,3,2) > 0 then
			instruct_3(50,3,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(1,3);   --  2(2):�õ���Ʒ[����������][3]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(4,3);   --  2(2):�õ���Ʒ[�����赨ɢ][3]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(50,4,2) > 0 then
			instruct_3(50,4,1,0,0,0,0,2468,2468,2468,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(8,1);   --  2(2):�õ���Ʒ[����������][1]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(0,5);   --  2(2):�õ���Ʒ[С����][5]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(50,9,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(50,9,0,0,0,0,0,0,0,0,0,0,0);
		end
	
	--����ׯ(����54����ʳ��10��2��ҩ��50��С����10������������3�����������1�������ܵ���10�������赨ɢ3���Ż���¶��2����ת������1��ţ��ѪЪ��3
		if GetD(54,1,2) > 0 then
			instruct_3(54,1,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(0,10);   --  2(2):�õ���Ʒ[С����][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(1,3);   --  2(2):�õ���Ʒ[����������][3]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(2,1);   --  2(2):�õ���Ʒ[���������][1]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(3,10);   --  2(2):�õ���Ʒ[�����ܵ���][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(4,3);   --  2(2):�õ���Ʒ[�����赨ɢ][3]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(5,2);   --  2(2):�õ���Ʒ[�Ż���¶��][2]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(6,1);   --  2(2):�õ���Ʒ[��ת������][1]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(10,3);   --  2(2):�õ���Ʒ[ţ��ѪЫ��][3]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(209,50);   --  2(2):�õ���Ʒ[ҩ��][50]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(54,33,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(54,33,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
		if GetD(54,34,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(54,34,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--�����ھ�(����56��������200��С����3
		if GetD(56,4,2) > 0 then
			instruct_3(56,4,1,0,0,0,0,2608,2608,2608,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(174,200);   --  2(2):�õ���Ʒ[����][200]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(0,3);   --  2(2):�õ���Ʒ[С����][3]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--������(����59����ʳ��10��2
		if GetD(59,31,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(59,31,0,0,0,0,0,0,0,0,0,0,0);
		end 
	
		if GetD(59,32,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(59,32,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--���ſ�ջ(����60����ʳ��10
		if GetD(60,11,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(60,11,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--�ﲮ���(����64��������100��ʳ��10���ɻ�ʯ10
		if GetD(64,1,2) > 0 then
			instruct_3(64,1,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(174,100);   --  2(2):�õ���Ʒ[����][100]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(28,10);   --  2(2):�õ���Ʒ[�ɻ�ʯ][10]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(64,3,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(64,3,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--ɽ��(����65����ʳ��10
		if GetD(65,4,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(65,4,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--������(����68����ʳ��10 
		if GetD(68,30,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(68,30,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--���ߵ�(����73����ʳ��10��С����5�������ⶾ��3 
		if GetD(73,8,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(73,8,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
		if GetD(73,3,2) > 0 then
			instruct_3(73,3,1,0,0,0,0,2492,2492,2492,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(0,5);   --  2(2):�õ���Ʒ[С����][5]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(9,3);   --  2(2):�õ���Ʒ[�����ⶾ��][3]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--�һ���(����75����ʳ���ؼ�
		if GetD(75,44,2) > 0 then
			instruct_3(75,44,1,0,0,0,0,2608,2608,2608,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(220,1);   --  2(2):�õ���Ʒ[ʳ������][1]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--̨��(����76�����ɻ�ʯ10������500��ʳ��10 ��С����10�������ܵ���3
		if GetD(76,3,2) > 0 then
			instruct_3(76,3,-2,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(0,10);   --  2(2):�õ���Ʒ[С����][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(3,3);   --  2(2):�õ���Ʒ[�����ܵ���][3]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(76,4,2) > 0 and r == 1 then
			instruct_3(76,4,-2,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(28,10);   --  2(2):�õ���Ʒ[�ɻ�ʯ][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(174,500);   --  2(2):�õ���Ʒ[����][500]
			instruct_0();   --  0(0)::�����(����)
			instruct_37(-1);   --  37(25):���ӵ���-1
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(76,6,2) > 0 then
			instruct_3(76,6,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--���ൺ(����78����ʳ��10��2
		if GetD(78,1,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(78,1,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
		if GetD(78,2,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(78,2,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--�츮(����92������䱭
		if GetD(92,17,2) > 0 then
			instruct_3(92,17,1,0,0,0,0,2608,2608,2608,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(194,1);   --  2(2):�õ���Ʒ[��䱭][1]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--���ְ�(����94����ʳ��10��2 
		if GetD(94,12,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(94,12,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
		if GetD(94,13,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(94,13,0,0,0,0,0,0,0,0,0,0,0);
		end 
	
	--�󹦷�(����95����ҩ��100����ɽѩ��1
		if GetD(95,15,2) > 0 then
			instruct_3(95,15,1,0,0,0,0,2608,2608,2608,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(17,1);   --  2(2):�õ���Ʒ[��ɽѩ��][1]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(209,100);   --  2(2):�õ���Ʒ[ҩ��][100]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--���ɽ�(����96����ʳ��10
		if GetD(96,14,2) > 0 then
			instruct_32(210,10);   --  2(2):�õ���Ʒ[ʳ��][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(96,14,0,0,0,0,0,0,0,0,0,0,0); 
		end
	
	--���̵�(����97�������ڵ���
		if GetD(97,1,2) > 0 then
			instruct_3(97,1,1,0,0,0,0,3500,3500,3500,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(141,1);   --  2(2):�õ���Ʒ[���ڵ���][1]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--��ϼ��(����98����ǧ����֥2��С����10�������ܵ���3�����ഫ������
		if GetD(98,9,2) > 0 then
			instruct_3(98,9,1,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(196,1);   --  2(2):�õ���Ʒ[���ഫ������][1]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(98,10,2) > 0 then
			instruct_3(98,10,-2,0,0,0,0,2612,2612,2612,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(0,10);   --  2(2):�õ���Ʒ[С����][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_32(3,3);   --  2(2):�õ���Ʒ[�����ܵ���][3]
			instruct_0();   --  0(0)::�����(����)
		end
	
		if GetD(98,11,2) > 0 then
			instruct_3(98,11,0,0,0,0,0,2608,2608,2608,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(14,2);   --  2(2):�õ���Ʒ[ǧ����֥][2]
			instruct_0();   --  0(0)::�����(����)
		end
	
	--�����(����102����С����10 
		if GetD(102,10,2) > 0 then
			instruct_32(0,10);   --  2(2):�õ���Ʒ[С����][10]
			instruct_0();   --  0(0)::�����(����)
			instruct_3(102,10,0,0,0,0,0,2468,2468,2468,-2,-2,-2);
		end
	
	--ҩ����(����103��������ɢ
		if GetD(103,10,2) > 0 then
			instruct_3(103,10,1,0,0,0,0,6698,6698,6698,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_0();   --  0(0)::�����(����)
			instruct_32(212,1);   --  2(2):�õ���Ʒ[����ɢ����][1]
			instruct_0();   --  0(0)::�����(����)
		end
	
		say("���ˣ���Ҫ�����һ��ˣ�����ľͷ��",picid,1,"��������");
		instruct_3(-2,-2,1,0,0,0,0,2568,2568,2568,0,0,0);
	end
end

--����103���뱦��ĶԻ��¼�
OEVENTLUA[8001] = function()
	
	--������ʱ��������
	local pid = 9999;				--����һ����ʱ����ħ��������
	JY.Person[pid] = {};
	for i=1, #PSX-8 do
		JY.Person[pid][PSX[i]] = JY.Person[160][PSX[i]];
	end
	JY.Person[pid]["����"] = "����";
	JY.Person[pid]["�������ֵ"] = math.modf(JY.Person[pid]["�������ֵ"]/2);
	JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"];
	JY.Person[pid]["�������ֵ"] = math.modf(JY.Person[pid]["�������ֵ"]/2);
	JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"];
	JY.Person[pid]["�Ṧ"] = math.modf(JY.Person[pid]["�Ṧ"]/2);
	JY.Person[pid]["�书1"] = 63;
	
	MyTalk(CC.LTalk1,9999);		--[����]����͸��ӵģ����Ƶط�����ô��û�У����������ˡ�
	if not inteam(37) then	--�������û�е��ƣ���ֱ���˳�
		return;
	end
	MyTalk(CC.LTalk2,9999);		--[����]������˭����͸��ӵģ������˵���
	Talk(CC.LTalk3,0);		--[����]���������������д�磬��ȴ���Ի������Ǹ��׺�֮ͽ����
	Talk(CC.LTalk4,0);		--[����]������ֻ��;���˵أ����޶��⡣
	MyTalk(CC.LTalk5,9999);	--[����]�����ͷ��������ȥ������Щ�ԵĶ���������ʦ���������ͣ���û�з���
	Talk(CC.LTalk6,0);		--[����]���������ɽҰ��û������������У���Ȼ��ɱ�����⣬��Ϊ�������ɡ�
	MyTalk(CC.LTalk7,9999);	--[����]��ι������ȥ��Щ�ԵĶ��������ֹ��ֹ������ô���㲻�������Ʒ�ү��Ҫ����Ĺ�����
	Talk(CC.LTalk8,0);		--[����]��������̫�����Ƿ��ѵ����   
  instruct_0();   --  0(0)::�����(����)

  if instruct_5() ==true then    --  5(5):�Ƿ�ѡ��ս����
  
  	SetS(86, 10, 10, 5, 1);		--�жϰ�ս��137�������Ż���160
  	
  	Talk(CC.LTalk9,0);	--[����]������������Ǻ�������
  	MyTalk(CC.LTalk10,9999);		--[����]���������ü����ü������Ӳ���ϲ����������ϲ�������⡣���⼡�⣬������һ������ζ��
  	Talk(CC.LTalk11,0);		--[����]������У�������
		
		if WarMain(137) == false then			
			instruct_15();			--ս��ʧ�ܣ�����
			return;
		end
		
		instruct_3(-2,80,0,0,0,0,0,0,0,0,0,0,0);		--����������ͼ
	
		Talk(CC.LTalk12,0);	--[����]�����ɮ��Ȼ��Щ�ŵ����ѹָ�������š����ǽ����������ң�Ҳ���������е���
		Talk(CC.LTalk13,0);	--[����]������ƺ�������һЩ����
		instruct_2(174,200);	--��ȡ����200
		instruct_0();   --  0(0)::�����(����)
		
		Talk(CC.LTalk14,37);	--[����]�����·��ֶ��˿�ϧ����������ã����������Ұɡ�
		Talk(CC.LTalk15,0);		--[����]����ȷ������������ӵĺ�
		Talk(CC.LTalk16,37);	--[����]���Ǻǡ���л����硣�������Ƕ���硣
		instruct_0();   --  0(0)::�����(����)
		
		
		SetS(86, 10, 10, 5, 0);		--��ս���жϻ�ԭ
		
		instruct_3(60,80,0,0,0,0,8002,0,0,0,0,0,0);		--�޸����ſ�ջ�ſ�·���¼�
		instruct_3(60,81,0,0,0,0,8002,0,0,0,0,0,0);
  end
end

--���ſ�ջ60������·���¼�
OEVENTLUA[8002] = function()
	if not inteam(37) then			--������û�е��ƣ�������
		return;
	end
	
	instruct_3(-2,82,1,0,0,0,0,9220,9220,9220,0,0,0);			--ˮ����ͼ
	instruct_3(-2,83,1,0,0,0,0,8902,8902,8902,0,0,0);			--��Х����ͼ
	
	Talk(CC.LTalk17,589);	--[ˮ��]������������������̵ġ����ġ���Ѫ����ɮ��
	TalkEx(CC.LTalk18,234,0);		--[��Х��]������Ѫ����ɮ��
	Talk(CC.LTalk19,589);	--[ˮ��]�����ˣ��ߣ�����İգ�
	Talk(CC.LTalk20,37);	--[����]��������˵��ô��
	Talk(CC.LTalk21,589);	--[ˮ��]���㡭���㡭������߽��ң�������
	Talk(CC.LTalk22,37);	--[����]���㡭�����ô���ң�
	Talk(CC.LTalk23,589);	--[ˮ��]��������
	Talk(CC.LTalk24,0);		--[����]�������������ǲ�����ʲô��ᡣ
	Talk(CC.LTalk25,589);		--[ˮ��]���ߣ���Ѫ����ɮ��һ���Ҳ����ʲô���ˣ�ʦ�������ߣ�
	instruct_0();   --  0(0)::�����(����)
	
	instruct_14();
	instruct_3(-2,82,0,0,0,0,0,0,0,0,0,0,0);			--���ˮ����ͼ
	instruct_3(-2,83,0,0,0,0,0,0,0,0,0,0,0);			--�����Х����ͼ
	instruct_13();
	

	
	Talk(CC.LTalk26,0);		--[����]��������ֵĹ���
	Talk(CC.LTalk27,37);		--[����]���Ҹ���������ԩ�޳�û���ط����������ǣ���˵�úúõأ���ô��Ȼ��������׶�
	Talk(CC.LTalk28,0);		--[����]�����ֵ����˰ɣ������������һʱ�ļ����ӡ�
	Talk(CC.LTalk29,37);		--[����]�����Ҿ�����ô����������������������㲻�����ң�Ҳ���ܸ��ҽ�˵���м�ĵ�����
	instruct_0();   --  0(0)::�����(����)
	
	if JY.Base["��X1"] == 24 then			--���������ط����ƶ���ʽ��һ��
		instruct_30(-1,9,0,0);
		instruct_30(-5,1,0,0);
	else
		instruct_30(0,9,0,0);
		instruct_30(-5,1,0,0);
	end
	
	instruct_3(-2,80,0,0,0,0,0,0,0,0,0,0,0);		--�޸Ŀ�ջ�ſ��¼�
	instruct_3(-2,81,0,0,0,0,0,0,0,0,0,0,0);		--�޸Ŀ�ջ�ſ��¼�
	
	
		
	instruct_14();
	instruct_3(-2,85,1,0,0,0,0,9222,9222,9222,0,0,0);			--ˮ����ͼ
	instruct_3(-2,86,1,0,0,0,0,8904,8904,8904,0,0,0);			--��Х����ͼ
	instruct_13();
	
	
	instruct_25(4,-15,0,0);		--�����ƶ�
	Talk(CC.LTalk30,589);		--[ˮ��]���ɻ��������Ͽ��������
	instruct_25(-4,15,0,0);
	instruct_0();   --  0(0)::�����(����)
	
	Talk(CC.LTalk31,0);		--[����]�����ֵܣ��ǹ����ֻ����ˣ���֪������ʲô�����ǳ�ȥ������
	Talk(CC.LTalk32,37);	--[����]���ţ�����˵��������ɲ�ԩ����
	instruct_0();   --  0(0)::�����(����)
	
	
	instruct_30(0,-1,0,0);			--�߳���ջ�ſ�
	instruct_30(5,-11,0,0);
	
	instruct_14();
	instruct_3(-2,84,1,0,0,0,0,9226,9226,9226,0,0,0);			--������ͼ
	instruct_13();
	
	Talk(CC.LTalk33,589);		--[ˮ��]����������ˣ�����ָ�����ɱ�ټ�С�㣬��֪���ղž�Ӧ��ɱ���㡣ԭ���㡭���㾹��ô����
	Talk(CC.LTalk34,37);		--[����]���Ҳ��ǲɻ�����
	TalkEx(CC.LTalk35,234,0);	--[��Х��]����ɮ��������������������స�ӣ�����������ɣ�
	Talk(CC.LTalk36,589);		--[ˮ��]��ʦ�֣�ɱ����������
	Talk(CC.LTalk37,37);	--[����]���Ҳ��ǡ���������ע��Ҫ����ԩ������Ҳ�޷����롣��
	Talk(CC.LTalk38,97);	--[Ѫ������]���������ˣ��ݵ�����������
	instruct_0();   --  0(0)::�����(����)
	
	instruct_14();
	instruct_3(-2,87,1,0,0,0,0,8746,8746,8746,0,0,0);			--Ѫ��������ͼ
	instruct_13();
	
	Talk(CC.LTalk39,97);	--[Ѫ������]��ͽ�����£������������������
	Talk(CC.LTalk40,0);		--[����]��������ɮ����������
	TalkEx(CC.LTalk41,234,0);		--[��Х��]�����ã����ߣ�
	Talk(CC.LTalk42,97);	--[Ѫ������]�����ߣ�
	
	instruct_3(-2,85,1,0,0,0,0,0,0,0,0,0,0);			--ˮ����ͼ
	instruct_3(-2,88,1,0,0,0,0,9220,9220,9220,0,0,0);			--ˮ����ͼ
	
	Talk(CC.LTalk43,97);	--[Ѫ������]�������Ĺ���������ܱ��£��˲����Ϻ����޸���ǳ��
	TalkEx(CC.LTalk44,234,0);		--[��Х��]�����ã����ã�������
	
	instruct_14();
	instruct_3(-2,88,0,0,0,0,0,0,0,0,0,0,0);			--���ˮ����ͼ
	instruct_3(-2,86,0,0,0,0,0,0,0,0,0,0,0);			--�����Х����ͼ
	instruct_3(-2,84,0,0,0,0,0,0,0,0,0,0,0);			--���������ͼ
	instruct_3(-2,87,0,0,0,0,0,0,0,0,0,0,0);			--���Ѫ��������ͼ
	
	instruct_3(2,81,1,0,0,0,0,9224,9224,9224,0,0,0);		--�޸�ѩɽˮ����ͼ
	instruct_3(2,80,1,0,0,0,0,9228,9228,9228,0,0,0);		--�޸�ѩɽ������ͼ
	instruct_13();
	
	Talk(CC.LTalk45,0);		--���ǣ�����⣬���ֵ�Ҳ��°���ˡ��ƺ���ѩɽ�������ˡ�
	instruct_21(37);		--�������
	instruct_0();   --  0(0)::�����(����)
	
	SetS(86, 9, 10, 5, 1);		--�жϴ���ѩɽ�¼�
	
end

--ѩɽɱ����֮�󣬵��Ƽ����¼�
OEVENTLUA[8003] = function()
	
	if not instruct_9() then	--�Ƿ����
		return;
	end
	
	Talk(CC.LTalk58,0);		--[����]�����ֵܣ������߰ɡ�
	if instruct_20() then		--�Ƿ�����
		Talk(CC.LTalk60, 37);		--[����]�������ڵĶ����Ѿ������ˡ�
		return;
	end
	
	instruct_10(37);		--�������
	Talk(CC.LTalk59,589);	--[ˮ��]����Ҳ����ŵҴ�硣
	
	instruct_14();
	instruct_3(-2,81,0,0,0,0,0,0,0,0,0,0,0);			--���ˮ����ͼ
	instruct_3(-2,80,0,0,0,0,0,0,0,0,0,0,0);			--���������ͼ
	
	instruct_3(70,80,1,0,8006,0,0,9220,9220,9220,0,0,0);		--ˮ����ʱû�뵽�÷�����ֱ�ӻ�С��
	instruct_13();
	
	
end

--���������ݳ������¼�
OEVENTLUA[8004] = function()


	--�Ȱѷ�����(140) �����ݳ�������ǿ�������书�ĳ����ǽ���
	local pid = 9999;				--����һ����ʱ���ݳ�������
	JY.Person[pid] = {};
	for i=1, #PSX-8 do
		JY.Person[pid][PSX[i]] = JY.Person[140][PSX[i]];
	end
	JY.Person[pid]["����"] = "�ݳ���";
	JY.Person[pid]["�������ֵ"] = JY.Person[pid]["�������ֵ"];
	JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"];
	JY.Person[pid]["�Ṧ"] = 250
	JY.Person[pid]["������"] = 350
	JY.Person[pid]["������"] = 300

	JY.Person[pid]["�书1"] = 114;
	JY.Person[pid]["�书�ȼ�1"] = 999;
	JY.Person[pid]["�书2"] = 0;
	SetS(86, 10, 10, 5, 2);		--�жϰ�ս��137�������Ż���9999
	
	instruct_25(2,-5,0,0);

	MyTalk(CC.LTalk70, 9999);		--[�ݳ���]��������װ��������������ô���ࡣ���Ǿ����ջ����ҵģ���������~~~
	TalkEx(CC.LTalk71, 37, 1);		--[����]��ʦ����ԭ����û������
	MyTalk(CC.LTalk72, 9999);		--[�ݳ���]���ƶ������㡣�Ͻ������Ǿ��������������ǲ�����
	TalkEx(CC.LTalk73, 37, 1);		--[����]��ʦ��������ô
	Talk(CC.LTalk74, 0);		--[����]�������Ǿ��Ѿ���������
	MyTalk(CC.LTalk75, 9999);		--[�ݳ���]��������
	
	if WarMain(137) == false then
		instruct_15();			--ս��ʧ�ܣ�����
		return;
	end
	
	
	MyTalk(CC.LTalk76, 9999);		--[�ݳ���]����������*���Ǿ����ҵģ����ҵģ�����~~~~
	
	instruct_14();
	instruct_3(-2,80,0,0,0,0,0,0,0,0,0,0,0);		--����ݳ�����ͼ
	instruct_13();
	
	TalkEx(CC.LTalk77, 37, 1);		--[����]��ʦ��.......
	Talk(CC.LTalk78, 0);		--[����]�����ֵܣ����ˣ���ʦ���Ѿ�������ǰ��ʦ��......
	
	
	instruct_3(-2,81,0,0,0,0,0,0,0,0,0,0,0);		--���·���¼�
	
	SetS(86, 10, 10, 5, 0);		--��ս���жϻ�ԭ
		
	
end--ˮ������¼�

OEVENTLUA[8005] = function()


    Talk("ˮ������Ȼ�С�壬����*Ҫʱ������ȥ�����æ��",0);

    instruct_0();   --  0(0)::�����(����)
    instruct_21(589);   --  21(15):ˮ�����
    instruct_3(70,80,1,0,8006,0,0,9220,9220,9220,0,0,0);		--ˮ����ʱû�뵽�÷�����ֱ�ӻ�С��
end


--ˮ������¼�
OEVENTLUA[8006] = function()
		
    MyTalk("����Ҫ�Ұ�æ�ĵط���", 589);
    instruct_0();   --  0(0)::�����(����)

    if instruct_9() then    --  9(9):�Ƿ�Ҫ�����?������ת��:Label0

        if instruct_20(20,0) ==false then    --  20(14):�����Ƿ�����������ת��:Label1
            instruct_10(589);   --  10(A):��������ˮ��
            instruct_14();   --  14(E):�������
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
            instruct_0();   --  0(0)::�����(����)
            instruct_13();   --  13(D):������ʾ����
            do return; end
        end    --:Label1

				MyTalk("��Ķ������������޷����롣", 589);
        instruct_0();   --  0(0)::�����(����)
        do return; end
    end    --:Label0

end


--ҩ¯��ҩ
OEVENTLUA[8008] = function()
	local drupsNum = 0;		--ҩ������
	for i = 1, CC.MyThingNum do
		if JY.Base["��Ʒ" .. i] == 209 then
			drupsNum = JY.Base["��Ʒ����" .. i];
			break;
		end
	end
	
	local drups = {0,1,2,3,4,5,6,7,9,10,11};--��������ҩƷ���
	local need = {2,8,15,3,8,12,15,13,5,8,12};--��Ҫ��ҩ������
	local drupsName = {};
	for i=1, #drups do
		drupsName[i] = JY.Thing[drups[i]]["����"];
	end
	local title = "ҩ¯";
	local str = string.format("��ǰҩ��������Ϊ��%d*�������ҩ����ʼѡ�����Ƶ�ҩƷ*��������塱����������Ϊ*���ҩ���������㣬���޷�����", drupsNum);
	local btn = {"��ҩ","����","�ر�"};
	local num = #btn;
	local r = JYMsgBox(title,str,btn,num);
	if r == 1 then
		local x1 = CC.ScreenW/2 - 180 ;
		local y1 = 50;
		DrawStrBox(x1, y1+40, "ҩƷ����   ��ҩ��  ҩ��������"..drupsNum,C_WHITE, CC.DefaultFont);
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
					DrawStrBoxWaitKey("�Բ������������ҩ�ĳ�����ҩ������!", C_WHITE, 30)
	      end
	    else
	    	DrawStrBoxWaitKey("�Բ������������������ȷ!", C_WHITE, 30)
	    end
		end
	elseif r==2 then
	local pd = 4
	if GetS(111,2,0,0) > pd then
	say("��ҩ���ֶ�����Ҫ���ƣ�")
			do return end
	end
	local money = 100 --math.random(5) * 19
	local head = math.random(350, 575)
	Cls()
	say("�����鵤��������Ϊ��Ҫ"..money.."ҩ�ġ��Ƿ����壿",head)
	Cls()
	if DrawStrBoxYesNo(-1, -1, "Ҫ����ô��", C_WHITE, 30) == false then	
		say("���ˣ�")	
		do return end
	end
	Cls()
	if drupsNum < money then
		say("ҩ�Ĳ�������")
		do return end
	end
	Cls()
	say("Ҫ�ã�")	
	instruct_2(209, -money)
	--[[
	Cls()
	QZXS(changeattrib(0, "������", 0))
	Cls()
	QZXS(changeattrib(0, "�Ṧ", 0))
	Cls()
	QZXS(changeattrib(0, "������", 0))
	]]
	DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "Ҫ��ǿʲô������", C_WHITE, CC.DefaultFont)
	local menu2 = {{"������",nil,1}, {"�Ṧ",nil,2}, {"������",nil,3}}
	local r2 = ShowMenu(menu2,#menu2,15,85,55,0,0,1,1,CC.DefaultFont,C_ORANGE, C_WHITE);
	if r2 == 1 then
		JY.Person[0]["������"] = JY.Person[0]["������"] + 15
	elseif r2 == 2 then
		JY.Person[0]["�Ṧ"] = JY.Person[0]["�Ṧ"] + 15
	else
		JY.Person[0]["������"] = JY.Person[0]["������"] + 15
	end
	QZXS(JY.Person[0]["����"].."��"..menu2[r2][1].."����15��")
	SetS(111,2,0,0,GetS(111,2,0,0)+1)
	end
end--ҩ¯��ҩ
OEVENTLUA[8009] = function()
	local foodNum = 0;		--ʳ������
	for i = 1, CC.MyThingNum do
		if JY.Base["��Ʒ" .. i] == 210 then
			foodNum = JY.Base["��Ʒ����" .. i];
			break;
		elseif JY.Base["��Ʒ" .. i] < 0 then
			break;
		end
	end
	
	local food = {18,19,20,21};		--�������Ĳ�
	local drink = {22,23,24,25};		--�������ľ�
	local need = {5,10,15,25};			--��Ҫ��ʳ����������һ����
	
	local foodName = {};		--������
	for i=1, #food do
		foodName[i] = JY.Thing[food[i]]["����"];
	end
	
	local drinkName = {};		--������
	for i=1, #drink do
		drinkName[i] = JY.Thing[drink[i]]["����"];
	end
	
	
	local title = "����";
	local str = string.format("��ǰʳ��������Ϊ��%d*��������ˡ���ʼѡ�����Ĳ�*��������ơ���ʼѡ�����ľ�*���ʳ���������㣬���޷�����", foodNum);
	local btn = {"����","����","�ر�"};
	local num = #btn;
	local r = JYMsgBox(title,str,btn,num);


	if r == 1  then		--����
		local x1 = CC.ScreenW/2 - 180 ;
		local y1 = 50;
		DrawStrBox(x1, y1+40, "������   ��ʳ��  ʳ��������"..foodNum,C_WHITE, CC.DefaultFont);
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
					DrawStrBoxWaitKey("�Բ������������ʳ�ĳ�����ʳ������!", C_WHITE, 30)
	      end
	    else
	    	DrawStrBoxWaitKey("�Բ������������������ȷ!", C_WHITE, 30)
	    end
		end
	elseif r == 2  then		--����
		local x1 = CC.ScreenW/2 - 180 ;
		local y1 = 50;
		DrawStrBox(x1, y1+40, "������   ��ʳ��  ʳ��������"..foodNum,C_WHITE, CC.DefaultFont);
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
					DrawStrBoxWaitKey("�Բ������������ʳ�ĳ�����ʳ������!", C_WHITE, 30)
	      end
	    else
	    	DrawStrBoxWaitKey("�Բ������������������ȷ!", C_WHITE, 30)
	    end
		end
	end

end--����������¼�

OEVENTLUA[8650] = function()


    Talk("�������Ȼ�С�壬����*Ҫʱ������ȥ�����æ��",0);

    instruct_0();   --  0(0)::�����(����)
    instruct_21(590);   --  21(15):���������
    instruct_3(70,86,1,0,8651,0,0,6804,6804,6804,0,0,0);
end

--����������¼�
OEVENTLUA[8651] = function()
		
    MyTalk("����Ҫ�Ұ�æ�ĵط���", 590);
    instruct_0();   --  0(0)::�����(����)

    if instruct_9() then    --  9(9):�Ƿ�Ҫ�����?������ת��:Label0

        if instruct_20(20,0) ==false then    --  20(14):�����Ƿ�����������ת��:Label1
            instruct_10(590);   --  10(A):��������������
            instruct_14();   --  14(E):�������
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
            instruct_0();   --  0(0)::�����(����)
            instruct_13();   --  13(D):������ʾ����
            do return; end
        end    --:Label1

				MyTalk("��Ķ������������޷����롣", 590);
        instruct_0();   --  0(0)::�����(����)
        do return; end
    end    --:Label0

end

--С�� ����ͨ
OEVENTLUA[8007] = function()
	if JY.Person[585]["�ȼ�"] == 30 and JY.Person[617]["�ȼ�"] < 30 then
		say("��˵��������������˫�Ķ���������ս����Ȼ�ǷǷ����", 232, 1, "����ͨ");
		say("��ʵ����֮ǰ��Ҳ��һλ���꾪�ž��ޣ��书��������Ҫ��Ҫ����������������", 232, 1, "����ͨ");
		if DrawStrBoxYesNo(-1, -1, "�Ƿ���֮���У�", C_WHITE, 30) == false then
			say("���𣿿�ϧ����ϧ��", 232, 1, "����ͨ");
		else
			CC.DYRW = 0
			CC.DYRW2 = 617
			say("���������������������־����ˡ����칫������һ��"..gettitle(0), 540, 1, "������");
			if WarMain(341) then 
				addHZ(140)
			end
			say("Ӣ�۳����꣡ƽ���ü���˹ʢ�����������������ǺǺǡ�", 232, 1, "����ͨ");
		end
		JY.Person[617]["�ȼ�"] = 30
		do return end
	end
	say("������������ʵ�������ʱ��Ҳ˧������ʲô�£�˵�ɡ�", 232, 1, "����ͨ");

	local title = "����ͨ����";
	local str = "���ͣ�����ȥ��������һ�̡�"
						.."*��ս�����մ̼�����ս�������㣡"
						.."*˵�����鿴����װ�����ڹ����⹦��˵����"
						.."*������������������������˫���ǵ�����Ŷ��"
						.."*���񣺽��ܲ���ȫ���񣬻�����Ӧ������"
						.."*��������������ȼ���"
						.."*�����������书�ؼ���"
						.."*��������ʹ�ð���ͨ����"
	local btn = {"����","��ս","˵��","����","����","����","����", "����"};
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
        local id = JY.Base["����" .. i];
		if id >= 0 then
			JY.Person[id]["��������"] = 30000
			War_PersonTrainBook(id)
			--JY.Person[id]["����"] = 52000
			--War_AddPersonLVUP(id);		
		end
    end
	end
end

--brolycjw������
--��Ĺ
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
		instruct_14();   --  14(E):�������
		instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [1]
		instruct_0();   --  0(0)::�����(����)
		instruct_13();   --  13(D):������ʾ����
		--С��Ů����
		instruct_2(153,1);   --  2(2):�õ���Ʒ[���m����][1]
		Talk(CC.BTalk40,58);
		Talk(CC.BTalk41,0);
		Talk(CC.BTalk42,58);
		Talk(CC.BTalk43,0);
		Talk(CC.BTalk44,58);
		Talk(CC.BTalk45,0);
		Talk(CC.BTalk46,58);
		Talk(CC.BTalk47,0);
		Talk(CC.BTalk48,58);
		instruct_14();   --  14(E):�������
		SetS(18,44,30,3,10)
		SetS(18,44,31,3,11)
		instruct_3(-2,10,0,0,0,0,8203,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [10]
		instruct_3(-2,11,0,0,0,0,8203,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [11]
		instruct_3(-2,0,1,0,8202,0,0,6188,6188,6188,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [0]
		instruct_0();   --  0(0)::�����(����)
		instruct_13();   --  13(D):������ʾ����
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
		--�������
		instruct_14();   --  14(E):�������
		instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [0]
		instruct_0();   --  0(0)::�����(����)
		instruct_13();   --  13(D):������ʾ����
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
		instruct_3(-2,12,1,0,8207,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [12]
			if instruct_20(20,0) ==false then    --  20(14):�����Ƿ�����������ת��:Label2
				instruct_10(59);   --  10(A):��������[С��Ů]
				instruct_14();   --  14(E):�������
				instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [1]
				instruct_3(104,76,1,0,970,0,0,7242,7242,7242,-2,-2,-2);   --  3(3):�޸��¼�����:����[���㵺]:�����¼���� [76]
				instruct_3(61,14,1,0,8205,0,0,8010,8010,8010,-2,-2,-2);   --  3(3):�޸��¼�����:����[������ջ]:�����¼���� [61]
				instruct_0();   --  0(0)::�����(����)
				instruct_13();   --  13(D):������ʾ����
				do return; end
			end    --:Label2

			instruct_1(391,59,0);   --  1(1):[С��Ů]˵: ��Ķ������������޷����롣
			instruct_0();   --  0(0)::�����(����)
			instruct_3(-2,1,1,0,8206,0,0,6068,6068,6068,-2,-2,-2);   --  3(3):�޸��¼�����:����[��Ĺ]:�����¼���� [1]
			do return; end
	end
end

OEVENTLUA[8202] = function() --����Ի�
	Talk(CC.BTalk48a,58);
end

OEVENTLUA[8203] = function()
	if instruct_18(84) then
		SetS(18,22,22,3,12)
		SetS(18,22,23,3,13)
		SetS(18,15,20,3,14)
		instruct_3(-2,12,0,0,0,0,8204,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [12]
		instruct_3(-2,13,0,0,0,0,8204,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [13]
		instruct_3(-2,14,0,0,0,0,0,7108,7108,7108,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [14]
		instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [10]
		instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [11]
	end
end

OEVENTLUA[8204] = function() --����������Ĺ�¼�
	
	Talk(CC.BTalk49,62);
	Talk(CC.BTalk50,58);
	Talk(CC.BTalk51,62);
	Talk(CC.BTalk52,0);
	--ս��
	if instruct_6(244,4,0,0) ==false then    --  6(6):ս��[74]������ת��:Label2
		instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
		instruct_0();   --  0(0)::�����(����)
		do return; end
	end    
	if GetS(113, 0, 0, 0) == 0 then
		say("�ţ��Ȿ��...���ϴ����ƣ�",0) 
		say("�о����ҵ��书·��ͦ�ϵİ�...",0)
		say("�ƴ��������򵥴ֱ�����ϲ����Ҫ��Ҫѧ�أ�",0)
		instruct_0();
		if instruct_11(0,188) == true then
			QZXS("�������ϴ������洫��")
			instruct_0();
			say("������ԭ���ո��ǲ��˸���û�ó��������������һ����ǳ��",0) 
			setLW1(83)
			addthing(170)
		else
			say("�����ç������...��������",0) 
		end
	end
		
	--[[ if GetS(113,0,0,0) == 0 and JY.Person[0]["ȭ�ƹ���"] >= 300 then 
	    say("������������ĳ�Դ����Ʒ������������ֵ����ַ����������������",58) 
	    instruct_0();
		if instruct_11(0,188) == true then 
	        QZXS("������Ȼ��Ҫ��")
			say("��л����",0)
	        instruct_0();
	        setLW1(25)
		    dark()
            light()
            instruct_35(0,0,25,10)
		else
			say("��Ȼ��ˣ�����С�ġ�",58) 
		end	
	end]]
	instruct_14();   --  14(E):�������
	instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [12]
	instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [13]
	instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [14]
	instruct_19(15,17);   --  19(13):�����ƶ���F-D
	instruct_40(0);
	instruct_0();   --  0(0)::�����(����)
	instruct_13();   --  13(D):������ʾ����	
	Talk(CC.BTalk53,0);
	Talk(CC.BTalk54,58);
	Talk(CC.BTalk55,0);
	Talk(CC.BTalk56,0);
	Talk(CC.BTalk57,58);
	Talk(CC.BTalk58,0);
	Talk(CC.BTalk59,58);
	Talk(CC.BTalk60,0);
	Talk(CC.BTalk61,58);
	instruct_14();   --  14(E):�������
	SetS(86,11,11,5,2)
	instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [0]
	instruct_3(104,68,1,0,969,0,0,6186,6186,6186,-2,-2,-2);   --  3(3):�޸��¼�����:����[���㵺]:�����¼���� [68]
	instruct_3(70,19,1,0,151,0,0,6188,6188,6188,-2,-2,-2);   --  3(3):�޸��¼�����:����[С��]:�����¼���� [19]
	instruct_3(60,20,1,0,589,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):�޸��¼�����:����[���ſ�ջ]:�����¼���� [20]
	instruct_0();   --  0(0)::�����(����)
    instruct_13();   --  13(D):������ʾ����
	if GetS(114, 0, 0, 0) == 0 and (inteam(92) or GX(92)) and PersonKF(0,190) then
		bgtalk("����ճյ�������Ĺ��ڣ���������뿪��Ĺ��ǰ��С��ķ���")
		say("��������...",0)
		say("...",92)
		say("...",0)
		bgtalk("ֻ������һ��һ��������Ĺ�����ȥ���ٶ�Խ��Խ�죬�������ơ���������")
		bgtalk("�����ص��ǣ��������ٶ�Ҫ׷������������£�Ȼ���������ǰ��ȴʼ��û���������Ӱ")
		bgtalk("ͬ����������׷���������ں�ͷ���㣬����һ�о����۵�")
		say("...�ǣ�û�뵽��Ȼ��������ʱ��",0)
		say("���ҿ����������ġ�����׷�¡���...",0)
		if DrawStrBoxYesNo(-1, -1, "Ҫ��һ���۲���", C_WHITE, 30) == true then
			QZXS("��������׷������")
			instruct_0();
			setLW2(190)
			say("������������ζ�ӳ��ģ��Գ�һЦ��",0)
		else
			say("������ʲô�أ�����������",0)
		end
	end	
end

OEVENTLUA[8205] = function() --ɱ�����¼�
	if instruct_16(59) == true then
		Talk(CC.BTalk80,62);
		Talk(CC.BTalk81,0);
		SetS(86,11,12,5,1)
		--ս��
		if instruct_6(79) ==false then    --  6(6):ս��[74]������ת��:Label2
			instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
			instruct_0();   --  0(0)::�����(����)
			do return; end
		end 
		SetS(86,11,12,5,0)
		if not checkpic(3, 21, 1) or not inteam(92) then
			instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [14]
		end
		instruct_3(60,20,1,0,589,0,0,6266,6266,6266,-2,-2,-2);   --  3(3):�޸��¼�����:����[���ſ�ջ]:�����¼���� [20]
		instruct_0();   --  0(0)::�����(����)
		--����������
		if checkpic(3, 21, 1) and inteam(92) then
			say("��һ�£���磬���梣��뿴���ҵķ��ϷŹ�����....", 92)
			say("�����")
			say("����Ȼ���Ǻ��ˣ������ұϾ�������һ��ʦ��....������Ҳ�ǹػ��������꺮��ů....", 92)
			say("�������书��ʧ���Ѿ��ܵ���Ӧ��....", 92)
			say("������....��....")
			say("�ðɣ�����ɱ��������Ҳ�޷�����....��ȻС����������Ҫ���Ǿ������߰�....", 59)
			say("лл���梣������....ʦ��....����ɹ�ȥ�ɡ���֪������ķ𷨾������ʧȥ���书��Ҳ���������ڵ�....", 92)
			say("��������....Сͽ�ܣ��Ҵ�������ţ��������������ޣ�������ȴ��������������Ұ��²���ʽ�����㣬ˮ���������ܸ��ۣ������Ϊ֮�ɡ�", 62)	
			if PersonKF(0, 103) and GetS(111, 0, 0, 0) == 0 then
			  say("С��...��...Ҳ����ѧһѧ��...",62) 
			  instruct_0();
			  if instruct_11(0,188) == true then
			     QZXS("��������֮����")
			     instruct_0();
			     say("��л..���ִ�ʦ��",0) 
			     SetS(111, 0, 0, 0,103)
			  else
			     say("�һ������˰�",0) 
			  end
			end			
			say("ʦ��....", 92)		
			dark()
			instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0)
			light()
			instruct_2(81,1);  
			instruct_2(170,1);  
			if PersonKF(92, 103) == false then
				JY.Person[92]["�书�ȼ�2"] = 0
				JY.Person[92]["�书2"] = 103
				tb("����ϰ�����������������Ӳ���޼�һǧ��")
			else
				AddPersonAttrib(92, "������", 20)
				tb("���幥����������ʮ�㣬����Ӳ���޼�һǧ��")
			end			
			setJX(92)			
			say("��������������ڣ��Ҳ��������������������Ȿ������������ɡ�", 59)
			say("лл�����")
			if GetS(114,0,0,0) == 0 then
			say("�˳�һ������ȴ������Ա�����ѧ����Щ�µĿ�����", 59)
			say("Ϊ��л�������壬�������������", 59)
			instruct_0();
			      if instruct_11(0,188) == true then
	                 QZXS("�������޵����ƣ�")
	                 instruct_0();
	                 say("��л�����",0) 
	                 SetS(114, 0, 0, 0,119)
					 addthing(242)
				  else
				     say("�һ������˰�",0) 
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
			instruct_2(153,1);   --  2(2):�õ���Ʒ[���m����][1]
			Talk(CC.BTalk90,59);
			instruct_2(87,1);   --  2(2):�õ���Ʒ[��Ȼ������][1]
			Talk(CC.BTalk92,0);
		end
	else
		Talk(CC.BTalk89,62);
	end
end

OEVENTLUA[8206] = function() --С��Ů�����¼�
	Talk(CC.BTalk10,59);
    if instruct_9(0,29) ==true then    --  9(9):�Ƿ�Ҫ�����?������ת��:Label1

        if instruct_20(20,0) ==false then    --  20(14):�����Ƿ�����������ת��:Label2
            instruct_10(59);   --  10(A):��������[С��Ů]
            instruct_14();   --  14(E):�������
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
			instruct_3(104,76,1,0,970,0,0,7242,7242,7242,-2,-2,-2);   --  3(3):�޸��¼�����:����[���㵺]:�����¼���� [76]
			instruct_3(61,14,1,0,8205,0,0,8010,8010,8010,-2,-2,-2);   --  3(3):�޸��¼�����:����[������ջ]:�����¼���� [61]
            instruct_0();   --  0(0)::�����(����)
            instruct_13();   --  13(D):������ʾ����
            do return; end
        end    --:Label2

        instruct_1(391,59,0);   --  1(1):[С��Ů]˵: ��Ķ������������޷����롣
        instruct_0();   --  0(0)::�����(����)
        do return; end
    end    --:Label1
end

OEVENTLUA[8207] = function() --��Ů�¼�
	if instruct_16(59) then
	Talk(CC.BTalk93,0);
	Talk(CC.BTalk94,59)
	Talk(CC.BTalk95,0)
	Talk(CC.BTalk96,59)
	Talk(CC.BTalk97,0)
	Talk(CC.BTalk98,59)
	instruct_14();   --  14(E):�������
	instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
	instruct_0();   --  0(0)::�����(����)
	instruct_13();   --  13(D):������ʾ����
	SetS(86,11,11,5,1)
	Talk(CC.BTalk99,0)
	else
	end
end

OEVENTLUA[153] = function() --С��Ů����¼�
    instruct_1(390,59,0);   --  1(1):[С��Ů]˵: ����Ҫ�Ұ�æ�ĵط���
    instruct_0();   --  0(0)::�����(����)

    if instruct_9(0,29) ==true then    --  9(9):�Ƿ�Ҫ�����?������ת��:Label1

        if instruct_20(20,0) ==false then    --  20(14):�����Ƿ�����������ת��:Label2
            instruct_10(59);   --  10(A):��������[С��Ů]
            instruct_14();   --  14(E):�������
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
            instruct_0();   --  0(0)::�����(����)
            instruct_13();   --  13(D):������ʾ����
            do return; end
        end    --:Label2

        instruct_1(391,59,0);   --  1(1):[С��Ů]˵: ��Ķ������������޷����롣
        instruct_0();   --  0(0)::�����(����)
        do return; end
    end    --:Label1
end	

OEVENTLUA[227] = function()
    instruct_14();   --  14(E):�������
    instruct_26(60,4,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
    instruct_26(60,5,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
    instruct_26(60,3,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
    instruct_3(-2,1,0,0,0,0,0,6116,6116,6116,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [1]
    instruct_3(-2,2,0,0,0,0,0,6116,6116,6116,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [2]
    instruct_3(-2,3,0,0,0,0,0,6116,6116,6116,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [3]
    instruct_3(-2,10,0,0,0,0,0,6116,6116,6116,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [10]
    instruct_3(-2,11,0,0,0,0,0,6116,6116,6116,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [11]
    instruct_3(-2,12,0,0,0,0,0,6116,6116,6116,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [12]
    instruct_3(-2,13,0,0,0,0,0,6116,6116,6116,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [13]
    instruct_3(-2,22,0,0,0,0,0,6108,6108,6108,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [22]
    instruct_3(-2,23,0,0,0,0,0,6112,6112,6112,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [23]
    instruct_3(-2,18,0,0,0,0,0,8216,8216,8216,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [18]
    instruct_3(-2,19,0,0,0,0,0,6762,6762,6762,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [19]
    instruct_3(-2,20,0,0,0,0,0,6762,6762,6762,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [20]
    instruct_3(-2,21,0,0,0,0,0,8212,8212,8212,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [21]
    instruct_3(-2,14,0,0,0,0,0,6802,6802,6802,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [14]
    instruct_3(-2,15,0,0,0,0,0,5894,5894,5894,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [15]
    instruct_3(-2,17,0,0,0,0,0,6186,6186,6186,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [17]
    instruct_3(-2,16,0,0,0,0,0,6068,6068,6068,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [16]
    instruct_0();   --  0(0)::�����(����)
    instruct_13();   --  13(D):������ʾ����
    instruct_30(32,49,32,44);   --  30(1E):�����߶�32-49--32-44
    instruct_30(32,44,28,44);   --  30(1E):�����߶�32-44--29-44
    instruct_30(28,44,28,40);   --  30(1E):�����߶�29-44--29-41
    instruct_1(536,0,1);   --  1(1):[AAA]˵: �����ô���ְ�����һ�Ѻ�*���ϵ���Χ��һ��С���ˡ�*���ⲻ������ô��
    instruct_0();   --  0(0)::�����(����)
    instruct_1(537,58,0);   --  1(1):[���]˵: ������ĳ��
    instruct_0();   --  0(0)::�����(����)
    instruct_1(538,0,1);   --  1(1):[AAA]˵: ��λС��Ů����ѵ�����*��ġ����ùã�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(539,58,0);   --  1(1):[���]˵: ���������ǡ�����������*ǰ���ҵ�ʦ�������ҵĹù�*���������ڣ�ʲôʦͽ����*��ʲô������ף���ͨͨ��*�Ƿ�ƨ��ͨͨ������ĵ���*�ùã�������������Ҳ�գ�*��Ҳ�գ�����˭Ҳû���࣬*˭Ҳ����¿����ꡣ�ӽ��*���㲻���ҵ�ʦ��������*�ҵĹùã�����ϱ��������*���ӣ��������ţ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(540,59,0);   --  1(1):[С��Ů]˵: ����������������Ļ�ô��
    instruct_0();   --  0(0)::�����(����)
    instruct_1(541,58,0);   --  1(1):[���]˵: ��Ȼ�����ġ��Ҷ����ֱۣ�*�������ϧ�ң���������ʲ*ô���ѣ���Ҳ������ϧ�㡣
    instruct_0();   --  0(0)::�����(����)
    instruct_1(542,59,0);   --  1(1):[С��Ů]˵: �ǰ������ϳ�������������*����ԭҲû������ϧ��
    instruct_0();   --  0(0)::�����(����)
    instruct_1(543,128,0);   --  1(1):[???]˵: ������������֮�أ�������*�����ڴ˺����������ɱ*����ʦֶ��־ƽ��������ȫ*����ڶ����ˣ���������ȫ*����ˣ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(544,0,1);   --  1(1):[AAA]˵: ��õ�һ�Զ�ѽ��������ô*���������أ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(545,62,0);   --  1(1):[���ַ���]˵: �ٺ٣�����Ϊ��Ͳ�����ô*�����ĸ����㣬��һֱ��Ҫ*�����顶������¡�������*������ϣ�ֻҪɱ��������*���ϾͿ��Եõ������ĵ�Ҫ*�������̲����ģ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(546,0,1);   --  1(1):[AAA]˵: ���֣��������ģ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(547,58,0);   --  1(1):[���]˵: ����������¾���������*��
    instruct_0();   --  0(0)::�����(����)
    instruct_1(548,0,1);   --  1(1):[AAA]˵: ���Ҹò���Ӳ���أ���
    instruct_0();   --  0(0)::�����(����)

    if instruct_5(0,318) ==true then    --  5(5):�Ƿ�ѡ��ս����������ת��:Label0
		SetS(22, 0, 0, 0, 1) --а���ж�
		setzx(153, 2)
		instruct_3(22,20,0,0,0,0,10015,0,0,0,0,0,0)
        instruct_37(-5);   --  37(25):���ӵ���-5
        instruct_1(549,0,1);   --  1(1):[AAA]˵: ���֣�����Ҳ������������*���ܷ񽫴����ø��ң�
        instruct_0();   --  0(0)::�����(����)
        instruct_1(550,58,0);   --  1(1):[���]˵: ���������������������黻*һ�����������ĳ��������*��ֵ̫Ǯ�ˣ��ҵ���������*��ȵģ����ձ㻹��������*�Σ���Ҫ���飬���������*����ĳ���վ�û����Ŵ���*���߳�ȥ���ܺ���������һ*����Ҳ�㲻������������*�ɡ�
        instruct_0();   --  0(0)::�����(����)
        instruct_1(551,59,0);   --  1(1):[С��Ů]˵: ��������
        instruct_0();   --  0(0)::�����(����)
        instruct_1(552,244,1);   --  1(1):[???]˵: ��ˡ��������ˡ���
        instruct_0();   --  0(0)::�����(����)

        if instruct_6(75,4,0,0) then    --  6(6):ս��[75]������ת��:Label1
		end
			instruct_40(2);
			Talk(CC.BTalk1,0);
			Talk(CC.BTalk2,58);
			Talk(CC.BTalk3,62);
			Talk(CC.BTalk4,58);
			instruct_14();   --  14(E):�������
			instruct_3(-2,17,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [17]
			instruct_3(-2,18,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [18]
			SetS(19,29,40,3,40)
			SetS(19,30,40,3,41)
			instruct_3(-2,40,0,0,0,0,0,6190,6190,6190,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [40]
			instruct_3(-2,41,0,0,0,0,0,8216,8216,8216,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [41]
			instruct_40(1);
			instruct_0();   --  0(0)::�����(����)
			instruct_13();   --  13(D):������ʾ����
			Talk(CC.BTalk5,59);
			Talk(CC.BTalk6,0);	
			instruct_1(559,123,0);   --  1(1):[???]˵: �������صأ�����аħ���*��Ұ��
			if instruct_6(73,4,0,0) ==false then    --  6(6):ս��[73]������ת��:Label3
				instruct_0();   --  0(0)::�����(����)
				instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
				do return; end
			end --Label3
			--��������
			instruct_14();   --  14(E):�������
			instruct_3(-2,24,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [24]
			instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [23]
			instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [13]
			instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [12]
			instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [11]
			instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [10]
			instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [3]
			instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [2]
			instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [1]
			instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [16]
			instruct_3(-2,40,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [40]
			instruct_3(18,1,1,0,8201,0,0,6068,6068,6068,-2,-2,-2);   --  3(3):�޸��¼�����:����[��Ĺ]:�����¼���� [1]
			instruct_3(18,0,1,0,8201,0,0,6190,6190,6190,-2,-2,-2);   --  3(3):�޸��¼�����:����[��Ĺ]:�����¼���� [0]
			instruct_0();   --  0(0)::�����(����)
			instruct_13();   --  13(D):������ʾ����
			Talk(CC.BTalk7,0);
			Talk(CC.BTalk8,62);
			Talk(CC.BTalk9,0);
			instruct_3(-2,3,0,0,0,0,0,8230,8230,8230,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [3]
			Talk(CC.BTalk19,64);
			Talk(CC.BTalk20,62);
			--��������
			instruct_14();   --  14(E):�������
			instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [14]
			instruct_3(-2,21,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [21]
			instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [20]
			instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [19]
			instruct_3(-2,41,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [41]
			instruct_3(-2,15,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [15]
			instruct_0();   --  0(0)::�����(����)
			instruct_13();   --  13(D):������ʾ����
			Talk(CC.BTalk21,0);
			Talk(CC.BTalk22,64);
			Talk(CC.BTalk23,0);
			Talk(CC.BTalk24,64);
			instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [3]
			Talk(CC.BTalk25,0);
    else
	SetS(22, 0, 0, 0, 2) --�����ж�
	setzx(153, 1)
	instruct_3(22,20,0,0,0,0,10017,0,0,0,0,0,0)
	instruct_37(3);   --  37(25):���ӵ���3
    instruct_0();   --  0(0)::�����(����)
    instruct_1(557,245,1);   --  1(1):[???]˵: �㵱����ʲô�ˣ�����Ϊ��*���飬Ҳ����Υ�����˵�ԭ*���������˺����ֺ�����*���Ҫ�ȹ�����أ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(558,62,0);   --  1(1):[���ַ���]˵: С����䵱Ӣ�ۣ��Ǿ�����*�������ҵ������������
    instruct_0();   --  0(0)::�����(����)
    if GetS(113,0,0,0) == 0 and JY.Person[0]["ȭ�ƹ���"] >= 300 then 
	    say("������������ĳ�Դ����Ʒ������������ֵ����ַ����������������",58) 
	    instruct_0();
		if instruct_11(0,188) == true then 
	        QZXS("������Ȼ��Ҫ��")
			say("��л����",0)
	        instruct_0();
	        setLW1(25)
		    dark()
            light()
            instruct_35(0,0,25,10)
		else
			say("��Ȼ��ˣ�����С�ġ�",58) 
		end	
	end
    if instruct_6(74,4,0,0) ==false then    --  6(6):ս��[74]������ת��:Label2
        instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
        instruct_0();   --  0(0)::�����(����)
        do return; end
    end    --:Label2

    instruct_3(-2,14,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [14]
    instruct_3(-2,21,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [21]
    instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [20]
    instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [19]
    instruct_3(-2,18,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [18]
    instruct_3(-2,15,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [15]
    instruct_0();   --  0(0)::�����(����)
    instruct_13();   --  13(D):������ʾ����
    instruct_1(559,123,0);   --  1(1):[???]˵: �������صأ�����аħ���*��Ұ��
    instruct_0();   --  0(0)::�����(����)
    instruct_1(560,0,1);   --  1(1):[AAA]˵: ����аħ�������
    instruct_0();   --  0(0)::�����(����)
    instruct_1(561,127,0);   --  1(1):[???]˵: �ߣ����������뿪��������
    instruct_0();   --  0(0)::�����(����)
    instruct_1(562,68,0);   --  1(1):[�𴦻�]˵: �������
    instruct_0();   --  0(0)::�����(����)

    if instruct_6(73,4,0,0) ==false then    --  6(6):ս��[73]������ת��:Label3
        instruct_0();   --  0(0)::�����(����)
        instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
        do return; end
    end    --:Label3

    instruct_3(-2,24,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [24]
    instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [23]
    instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [13]
    instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [12]
    instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [11]
    instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [10]
    instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [3]
    instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [2]
    instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [1]
    instruct_0();   --  0(0)::�����(����)
    instruct_13();   --  13(D):������ʾ����
    instruct_1(564,0,1);   --  1(1):[AAA]˵: ���磬���������û��*�ɣ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(563,58,0);   --  1(1):[���]˵: ���������������ˣ�����Ҫ*�Ͻ����ع�Ĺ�ˡ��������*л�������пտɵ���Ĺ����*�ҷ򸾡����������ǻؼҡ�
    instruct_0();   --  0(0)::�����(����)
    instruct_14();   --  14(E):�������
    instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [16]
    instruct_3(-2,17,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [17]
    instruct_3(18,1,1,0,231,0,0,6068,6068,6068,-2,-2,-2);   --  3(3):�޸��¼�����:����[��Ĺ]:�����¼���� [1]
    instruct_3(18,0,1,0,231,0,0,6188,6188,6188,-2,-2,-2);   --  3(3):�޸��¼�����:����[��Ĺ]:�����¼���� [0]
    instruct_17(18,1,22,41,0);   --  17(11):�޸ĳ�����ͼ:����[��Ĺ]��1����16-29
    instruct_0();   --  0(0)::�����(����)
    instruct_13();   --  13(D):������ʾ����
	end
end		


--brolycjw���;���
OEVENTLUA[372] = function()		--���������ſ�ջ
    if instruct_4(203,2,0) ==false then    --  4(4):�Ƿ�ʹ����Ʒ[�����̻��]��������ת��:Label0
        do return; end
        instruct_0();   --  0(0)::�����(����)
    end    --:Label0

    instruct_26(61,19,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
    instruct_26(61,18,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
    instruct_1(1388,238,0);   --  1(1):[???]˵: �ۣ���������̫���ˡ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1389,0,1);   --  1(1):[AAA]˵: ��ȥ�ɣ���ȥ���������*��
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1390,238,0);   --  1(1):[???]˵: ����*�ܲ������鷳��һ�Σ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1391,0,1);   --  1(1):[AAA]˵: ��ô�ˣ�����ҲҪ������ȥ*��
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1392,238,0);   --  1(1):[???]˵: ��������ڳ��ְ�ҡ���*�Ҳ������ȥ��������͹�*ȥ�ɡ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1393,246,1);   --  1(1):[???]˵: ����ֵֹģ������絽��*��˭����
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1394,238,0);   --  1(1):[???]˵: ����ʯ���죬�ǳ��ְ�İ�*�����������и��ձ��ģ���*�����֪����Ƶ����ã�*��ȥ�������С��ң��ҡ���*�һ��ǲ�Ҫ¶��ĺá�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1395,0,0);   --  1(1):[AAA]˵: ι���о��������Ұ���ʲô*�ô�Ҳû�У���ΪɶҪ����*���Ȱ���
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1396,238,0);   --  1(1):[???]˵: ��������үү�ļҴ��޷���*�͸��㣬�������˰ɡ��㲻*Ҫ�����ˣ���ȥ����*�ҵ���硭��
    instruct_0();   --  0(0)::�����(����)
    instruct_14();   --  14(E):�������
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
    instruct_3(94,1,1,0,377,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:����[���ְ�]:�����¼���� [1]
    instruct_3(94,0,1,0,377,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:����[���ְ�]:�����¼���� [0]
    instruct_3(94,2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[���ְ�]:�����¼���� [2]
    instruct_3(94,9,1,0,374,375,0,7028,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[���ְ�]:�����¼���� [9]
    instruct_17(94,2,37,19,5156);   --  17(11):�޸ĳ�����ͼ:����[���ְ�]��2����25-13
    instruct_17(94,2,34,21,4866);   --  17(11):�޸ĳ�����ͼ:����[���ְ�]��2����22-15
    instruct_3(94,14,1,0,380,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:����[���ְ�]:�����¼���� [14]	
    instruct_0();   --  0(0)::�����(����)
    instruct_13();   --  13(D):������ʾ����
    instruct_2(185,1);   --  2(2):�õ���Ʒ[�����޷�][1]
	--JY.Person[38]["Я����Ʒ1"] = 72
    instruct_0();   --  0(0)::�����(����)
end

OEVENTLUA[375] = function()
    if instruct_4(203,2,0) == false then
	    do return; end
    end 
	instruct_26(61,19,1,0,0)
	instruct_26(61,18,1,0,0)
	instruct_32(203,-1,0)
	instruct_3(-2,-2,1,0,376,0,0,-2,-2,-2,-2,-2,-2);
	instruct_1(1400,85,0) --[85����ʯ]:�⣬�ⲻ�������̻����*�����ǡ���
	instruct_0()
	instruct_1(1401,0,1)--[0��]:����һλ�������У�������*���������ʯ���졣
	instruct_0()
	instruct_1(1402,85,0)--[85����ʯ]:̫���ˣ�̫���ˣ�*�ְ����¸м����µľ���֮*����*���ְ��о��ˡ�*������*������������ƺ���ȥ��*��
	instruct_0()
	instruct_14() --
	instruct_17(94,2,37,19,0)--
	instruct_3(-2,3,1,0,0,0,0,5152,5152,5152,-2,-2,-2);
	instruct_0()
	instruct_13()
	instruct_1(1403,38,0) --[38ʯ����]:������
	instruct_0()
	instruct_1(1404,85,0)--[85����ʯ]:��������о���ô����
	instruct_0()
	instruct_1(1405,38,0)--[38ʯ����]:����˭����ʲô������
	instruct_0()
	instruct_1(150,85,0) --[85����ʯ]:.......
	instruct_0()
	instruct_1(150,0,1) --[0��]:��������
	instruct_0()
	instruct_1(1406,38,0) --[38ʯ����]:�ϲ����أ���˵Ҫ������׽*��ȸ�ı��£�ȴû����˵��*��������ȣ��ѹ����ˡ�*������˭�����������
	instruct_0()
	instruct_1(1407,0,1) --[0��]:����������ǰ�����
	instruct_0()
	instruct_1(1408,85,0) --[85����ʯ]:�����������������������*�ˡ����������
	instruct_0()
	instruct_1(1409,196,0) --[196��ɽ����]:�������������ˣ��ض��Ĵ�*����ǰ���������¡�
	instruct_0()
	instruct_1(1410,85,0)--[85����ʯ]:������ú���Ϣ��*���������ǳ�ȥ������
	instruct_0()
	instruct_1(1411,38,0)--[38ʯ����]:�ѵ����������ǰ�����
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
	instruct_1(1412,203,0) --[203̩ɽ����]:���˾ͽ�����������ǿ�˵*�ǹ����Ľ��顣���ǧ����*�Σ����͸�˾ͽ���ġ�
	instruct_0()
	instruct_1(1413,0,1)--[0��]:����ô���⻹��һλ˾ͽ��*������
	instruct_0()
	instruct_1(1414,85,0) --[85����ʯ]:˾ͽ��硭�������˼ҡ���*�ȿȡ�����ɽ���ӣ����Ѳ�*�Ž�����Ϣ���������ֵܶ�*ǣ�ҵý�����λ�ú���Ҫ*���������˼����ϣ����ǲ�*�������ˡ�
	instruct_0()
	instruct_1(1415,195,0)--[195��ɽ����]:������һλ������˵����˾*ͽ����ǡ����ǡ������ⳤ*�ְ�������������Ĳ�����*�ס������֮λ���䵽��һ*������������ϣ����ǽ���*��������ҪΪ˾ͽ�����ָ�*������
	instruct_0()
	instruct_1(1416,0,1)--[0��]:�����ְ���£�����û���*��Ҫ���֡�����
	instruct_0()
	instruct_1(1417,191,0) --[191��ɽ����]:��λ��ؾ������ΰ����˰�*��ëͷС�ӣ�˵�����ǰ�˾*ͽ�����ô�ˣ�
	instruct_0()
	instruct_1(1418,0,1)--[0��]:�ң��Ҳ��ǡ���
	instruct_0()
	instruct_1(1419,192,0)--[192��ɽ����]:�ԣ��㲻�ǳ��ְ��������*���İ�����˾ͽ��磬С��*�����ǽ���ҪΪ˾ͽ�����*���������������ɣ�
	instruct_0()
	instruct_1(1420,0,1)--[0��]:���һ�û˵���ء�����
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
	instruct_2(16,1)--�õ���Ʒ[16ǧ���˲�]1��
	instruct_0()
	instruct_1(1421,85,0)--[85����ʯ]:��л�������Ұ����ǿ�С�
	instruct_0()
	instruct_1(1422,0,1)--[0��]:��ֱĪ������⵽������*ô���£�����˭�ǳ��ְ��*����
	instruct_0()
	instruct_1(1423,85,0)--[85����ʯ]:������֪�����Ʒ��������*��
	instruct_0()
	instruct_1(1424,0,1)--[0��]:Ը�����ꡣ
	instruct_0()
	instruct_1(1425,85,0)--[85����ʯ]:ÿ��ʮ�꣬���͵������Ʒ�*���ʹ�ͻ�������ԭ������*���еĸ������ɵ������˷�*���Ʒ�������ӵ�������*�����ȥ���͵���
	instruct_0()
	instruct_1(1426,0,1)--[0��]:ȥ�����͵�������Σ�
	instruct_0()
	instruct_1(1427,85,0)--[85����ʯ]:�����������������֪����*����Ϊ����ȥ�����͵�����*��������һ������
	instruct_0()
	instruct_1(1428,0,1)--[0��]:��ô˵�������Ʒ������ǽ�*���õ��ˣ�
	instruct_0()
	instruct_1(1429,85,0)--[85����ʯ]:������������ӣ���ô����*���ɻ��ڼ���֮�ڱ�ȫ����*��
	instruct_0()
	instruct_1(1430,0,1)--[0��]:��������*�ѵ������������������Ʒ�*���ʹ���ֵ�ʱ��*��
	instruct_0()
	instruct_1(1431,85,0)--[85����ʯ]:����������Щ����ʮ����*�������ǰ�������˾ͽ��ȴ*�ܵ�С�����ҽ������Ʒ���*���ˡ������ｫ������*��֮�֡�
	instruct_0()
	instruct_1(1432,0,1)--[0��]:Ŷ���������Ǿͺ�����˾ͽ*�����������˸�����������*����
	instruct_0()
	instruct_1(1433,85,0)--[85����ʯ]:�������Բ��ӡ�ʯ������Ȼ*���٣��������ҵ���������*����˾ͽ������Ϊ�������*��˾ͽ�������߳�ŭ������*���˱㶯��������ʯ������*�վ�տ��˾ͽ����ս�ܺ��*�뿪�˱����ﶼ֪����*��û���ٻ����ˣ����Ǳ�ӵ*����ʯ������ʯ����Ҳ����*���ʣ��������Ʒ����ʹ��*���������������������Ʒ�*���Ϊ��ﵲȥ��һ����*�ѡ�
	instruct_0()
	instruct_1(1434,0,1)--[0]:���ߣ�˵��˵ȥ��������Ҫ*����ʯ��ȥ�����������ǣ�*�ҿ�ʯ�����ƺ�����֪����*���ǰ�������
	instruct_0()
	instruct_1(1435,85,0)--[85����ʯ]:��������ȿȡ���ʯ������*���󡭡��ȿȡ����кܶ���*�鶼�ǲ�̫�������
	instruct_0()
	instruct_1(1436,0,1)--[246ѩɽ����]:���ҿ����ձ�������һ����*������
	instruct_0()
	instruct_1(1437,238,0)--:���������ˡ���
	instruct_0()
	instruct_1(1438,85,0)--��ȥ������
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
	instruct_1(1439,85,0)--[85����ʯ]:ʯ�����أ�
	instruct_0()
	instruct_1(1440,0,1)--[0��]:����������ô���ˣ��㲻��*˵�㲻���㡭��
	instruct_0()
	instruct_1(1441,238,0)--[238���½�ͽ]:��ѽ����ʲôʱ���ˣ��㻹*����Щ����类ѩɽ�ɵİ�*��ץ���ˣ��죬��ȥ����*��
	instruct_0()
	instruct_1(1442,85,0)--[85����ʯ]:���ã�ʯ��������˵������*��ѩɽ�ɡ����ȿȡ�����Щ*���ڣ������׶༪�ٰ���
	instruct_0()
	instruct_1(1443,238,0)--[238���½�ͽ]:�ǻ���ʲô�����ǸϽ�ȥ̤*ƽѩɽ�ɣ������ȳ�����
	instruct_0()
	instruct_1(1444,0,1)--[0��]:���Ҫ��ƽѩɽ�ɣ�̫����*�ɡ�
	instruct_0()
	instruct_1(1445,238,0)--[238���½�ͽ]:Ҫ���ˣ���ȻҪɱ�ˣ�����*ô��ô�������裬���ǿ���*�ɣ�
	instruct_0()
	instruct_1(1446,0,1)--[0��]:����Ӧ��ȥ����ѩɽ��ô��*��
	instruct_0()
	
	     if instruct_11(0,188) == true then
		    instruct_1(1447,0,1)--[245ѩɽ����]:������ҲҪ�����飬˵����*ѩɽ���С��������ã�����*����ߡ�
			instruct_0()
			instruct_1(1448,196,0)--[196��ɽ����]:������������������
			instruct_0()
			instruct_1(1449,85,0)--[85����ʯ]:ʲô����ô���̣�
			instruct_0()
			instruct_1(1450,196,0)--[196��ɽ����]:�������������ҵ���������*����
			instruct_0()
			instruct_1(1451,85,0)--[85����ʯ]:��˵ʲô��
			instruct_0()
			instruct_1(1452,196,0)--[196��ɽ����]:����������Ժ�����˰�����*��
			instruct_0()
			instruct_1(1453,0,1)--[0��]:���ǰ������Ǹոձ�����*ץ��ѩɽ��������ô����*����Ժ��
			instruct_0()
			instruct_1(1454,85,0)--[85����ʯ]:���ǣ����ǿ��������
			instruct_0()
			instruct_1(1455,196,0)--[196��ɽ����]:������ˣ�ǧ����ȷ������*�����ῴ��ġ�
			instruct_0()
			instruct_1(1456,85,0)--[85����ʯ]:�⡭��������ô���£�
			instruct_0()
			instruct_1(1457,238,0)--�ղ�������������ץ����*��ġ�����������Ժ���Ǻ�*�����ȥ�ĵط�����
			instruct_0()
			instruct_1(1458,0,1)--[0��]:�����ɣ���������Ժ��˲�*Զ��������ȥ����������Ȼ*������ѩɽ�ɡ�
			instruct_0()
			instruct_1(1459,85,0)--[85����ʯ]:�����ã��ǾͰ���������*��
			instruct_0()
			instruct_1(1460,238,0)--[238���½�ͽ]:����Ժ�����һ����ڰ�����*�ź��ˡ���
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
    instruct_1(1461,0,1)--[0��]:������Ҫ���ˣ�Ҳ�������*ɱ��ѽ�����ǻ�����ȥ����*һ����Ϣ�ɡ�
	instruct_0()
	instruct_1(1462,196,0)--[196��ɽ����]:������������������
	instruct_0()
	instruct_1(1463,85,0)--[85����ʯ]:ʲô�£�
	instruct_0()
	instruct_1(1464,196,0)--[196��ɽ����]:���Ǹղ�һֱ����ѩɽ�ɵ�*���򽣣��������������ǰ�*�����������ˡ�
	instruct_0()
	instruct_1(1465,85,0)--[85����ʯ]:�����ˣ��ǻ�ȥ���أ�
	instruct_0()
	instruct_1(1466,238,0)--����үүס�ں������̵���*��ȥ������æ��
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
	instruct_1(1467,85,0)--[85����ʯ]:��������ʱ�߲�������Ҫ��*������������Ѱ�Ұ�������*�ǳ��ְ���ǿ���֣���Ѱ*�������䡣
	instruct_0()
	instruct_1(1468,0,1)--[0��]:�ðɣ�������ҲҪ�����Ҷ�*��������˳������Ǵ���һ*�¡�
	instruct_0()
	instruct_1(1469,85,0)--[85����ʯ]:�����ã��ǾͰ���������*��
	instruct_0()
end

OEVENTLUA[422] = function()	--��а������Ժ�¼�
    instruct_26(61,19,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
    instruct_26(61,18,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
    instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
    instruct_25(20,14,15,11);   --  25(19):�����ƶ�20-14--15-11
    instruct_1(1603,41,0);   --  1(1):[����]˵: ���͵�ʹ�߰ݻ᳤�ְ�ʯ��*����������Ʒ����
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1604,307,0);   --  1(1):[ʯ����]˵: �ҡ����ҡ���
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1605,238,0);   --  1(1):[???]˵: ��Ȼ����磬�����
    instruct_0();   --  0(0)::�����(����)
	if instruct_5(0,254) ==true then    --  5(5):�Ƿ�ѡ��ս����������ת��:Label0
		if instruct_6(169,4,0,0) ==false then    --  6(6):ս��[169]������ת��:Label0
			instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
			do return; end
			instruct_0();   --  0(0)::�����(����)
		end    --:Label0
		addHZ(58)
		instruct_3(-2,27,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [27]
		instruct_3(-2,26,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [26]
		instruct_3(-2,15,0,0,0,0,0,6374,6374,6374,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [15]
		instruct_19(15,13);   --  19(13):�����ƶ���F-D
		instruct_40(0);   --  40(28):�ı�����վ������0
		instruct_0();   --  0(0)::�����(����)
		instruct_13();   --  13(D):������ʾ����
		instruct_1(1606,307,0);   --  1(1):[ʯ����]˵: ������������������������*���ˡ�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1607,238,0);   --  1(1):[???]˵: �ޣ�����Ϊ������֮��ת��*�ԣ�ԭ������û���������
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1608,307,0);   --  1(1):[ʯ����]˵: ������ʲô��������
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1609,164,0);   --  1(1):[???]˵: ���⹷���֣����������ҵ�*���ˡ�
		instruct_0();   --  0(0)::�����(����)
		instruct_14();   --  14(E):�������
		instruct_3(-2,23,0,0,0,0,0,8238,8238,8238,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [23]
		instruct_0();   --  0(0)::�����(����)
		instruct_13();   --  13(D):������ʾ����
		instruct_1(1610,164,0);   --  1(1):[???]˵: �����֣���ʲô��Ҫ���ң�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1611,307,0);   --  1(1):[ʯ����]˵: �㣬�㣬����ʲô�ˣ�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1612,164,0);   --  1(1):[???]˵: ���Ȼװ������ʶ��л�̿�*�����д���
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1613,307,0);   --  1(1):[ʯ����]˵: ���ۣ������ڹ�����������*���Ƿ���һ�����ˣ�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1614,164,0);   --  1(1):[???]˵: ��˵������ʲô��Ҫ���Ұ�*��
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1615,307,0);   --  1(1):[ʯ����]˵: ���㣿���������ԣ�����ȥ*����ѩɽ�ɣ�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1616,164,0);   --  1(1):[???]˵: ��С�ӣ�������ӳ����⣬*�ã���������ߣ�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1617,307,0);   --  1(1):[ʯ����]˵: ������ô��ץ���Ұ�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1618,238,0);   --  1(1):[???]˵: ��硪��
		instruct_0();   --  0(0)::�����(����)
		instruct_14();   --  14(E):�������
		instruct_3(-2,15,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [15]
		instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [23]
		instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [16]
		instruct_3(39,10,0,0,0,0,0,7074,7074,7074,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [10]
		instruct_3(39,18,0,0,0,0,0,7074,7074,7074,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [18]
		instruct_3(39,19,0,0,0,0,0,6374,6374,6374,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [19]
		instruct_3(39,9,1,0,424,0,0,5274,5274,5274,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [9]
		instruct_3(39,11,0,0,0,0,0,8238,8238,8238,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [11]
		instruct_3(39,12,0,0,0,0,423,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [12]
		instruct_3(39,13,0,0,0,0,423,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [13]
		instruct_0();   --  0(0)::�����(����)
		instruct_13();   --  13(D):������ʾ����
		instruct_1(1619,0,1);   --  1(1):[AAA]˵: ����ô�ֱ�ץ��ѩɽ���ˣ�
		instruct_0();   --  0(0)::�����(����)
	else
		Talk(CC.BTalk201,0);
		TalkEx(CC.BTalk202,238,1);
		instruct_14();	--  14(E):�������
		instruct_0();   --  0(0)::�����(����)
		instruct_13();   --  13(D):������ʾ����	
		Talk(CC.BTalk203,41);
		Talk(CC.BTalk204,0);
		instruct_14();	--  14(E):�������
		instruct_0();   --  0(0)::�����(����)
		instruct_3(-2,27,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [27]
		instruct_3(-2,26,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [26]
		instruct_3(-2,15,0,0,0,0,0,6374,6374,6374,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [15]
		instruct_19(15,13);   --  19(13):�����ƶ���F-D
		instruct_40(0);   --  40(28):�ı�����վ������0
		instruct_0();   --  0(0)::�����(����)
		instruct_13();   --  13(D):������ʾ����
		instruct_1(1606,307,0);   --  1(1):[ʯ����]˵: ������������������������*���ˡ�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1607,238,0);   --  1(1):[???]˵: �ޣ�����Ϊ������֮��ת��*�ԣ�ԭ������û���������
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1608,307,0);   --  1(1):[ʯ����]˵: ������ʲô��������
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1609,164,0);   --  1(1):[???]˵: ���⹷���֣����������ҵ�*���ˡ�
		instruct_0();   --  0(0)::�����(����)
		instruct_14();   --  14(E):�������
		instruct_3(-2,23,0,0,0,0,0,9020,9020,9020,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [23]
		instruct_0();   --  0(0)::�����(����)
		instruct_13();   --  13(D):������ʾ����
		instruct_1(1610,164,0);   --  1(1):[???]˵: �����֣���ʲô��Ҫ���ң�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1611,307,0);   --  1(1):[ʯ����]˵: �㣬�㣬����ʲô�ˣ�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1612,164,0);   --  1(1):[???]˵: ���Ȼװ������ʶ��л�̿�*�����д���
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1613,307,0);   --  1(1):[ʯ����]˵: ���ۣ������ڹ�����������*���Ƿ���һ�����ˣ�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1614,164,0);   --  1(1):[???]˵: ��˵������ʲô��Ҫ���Ұ�*��
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1615,307,0);   --  1(1):[ʯ����]˵: ���㣿���������ԣ�����ȥ*����ѩɽ�ɣ�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1616,164,0);   --  1(1):[???]˵: ��С�ӣ�������ӳ����⣬*�ã���������ߣ�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1617,307,0);   --  1(1):[ʯ����]˵: ������ô��ץ���Ұ�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1618,238,0);   --  1(1):[???]˵: ��硪��
		instruct_0();   --  0(0)::�����(����)
		instruct_14();   --  14(E):�������
		SetS(86,20,20,5,1)
		instruct_3(-2,15,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [15]
		instruct_3(-2,23,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [23]
		instruct_3(-2,16,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [16]
		instruct_3(39,10,0,0,0,0,0,9234,9234,9234,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [10]
		instruct_3(39,18,0,0,0,0,0,7074,7074,7074,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [18]
		instruct_3(39,9,1,0,424,0,0,5274,5274,5274,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [9]
		instruct_3(39,11,0,0,0,0,0,9020,9020,9020,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [11]
		instruct_3(39,12,0,0,0,0,423,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [12]
		instruct_3(39,13,0,0,0,0,423,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[������]:�����¼���� [13]
		instruct_0();   --  0(0)::�����(����)
		instruct_13();   --  13(D):������ʾ����
		instruct_1(1619,0,1);   --  1(1):[AAA]˵: ����ô�ֱ�ץ��ѩɽ���ˣ�
		instruct_0();   --  0(0)::�����(����)
	end
end


OEVENTLUA[423] = function()	--��а��ѩɽ���¼�
    instruct_14();   --  14(E):�������
    instruct_3(-2,13,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [13]
    instruct_3(-2,12,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [12]
    instruct_13();   --  13(D):������ʾ����
    instruct_25(29,24,29,17);   --  25(19):�����ƶ�29-24--29-17
    instruct_1(1620,0,1);   --  1(1):[AAA]˵: �ף���ô����ʯ���죿
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1621,38,0);   --  1(1):[ʯ����]˵: �ϲ�������Ҳ����
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1622,164,0);   --  1(1):[???]˵: �㣬�㣬����������������*��Ȼ����������һ��һ����*С�ӣ��ֲ����Ҿ��������*���ֵֹֹģ�ԭ����ƭ�ң�*������ô��ʰ�㣡
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1623,38,0);   --  1(1):[ʯ����]˵: ���ɣ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1624,164,0);   --  1(1):[???]˵: ��˵ʲô�����ǲ������Ҳ�*Ҫɱ����
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1625,38,0);   --  1(1):[ʯ����]˵: ��֪���ϲ���Ϊ������ˣ�*�������ϲ���������˴���*��ߣ�����ѧ�á�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1628,164,0);   --  1(1):[???]˵: �ҡ����ã�����ô���ˣ�С*�ӣ������ߣ��Һúý̽���*��
    instruct_0();   --  0(0)::�����(����)
	if GetS(86,20,20,5) == 1 then
		instruct_19(29,24);   --  19(13):�����ƶ���F-D
		instruct_30(29,24,29,19);   --  30(1E):�����߶�29-24--29-19
		Talk(CC.BTalk205,0);
		Talk(CC.BTalk206,164);
		Talk(CC.BTalk207,0);
		if instruct_6(170,3,0,0) ==false then    --  6(6):ս��[170]������ת��:Label0
			instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
			do return; end
		end    --:Label0
		SetS(86,20,20,5,2)
		Talk(CC.BTalk208,38);
		Talk(CC.BTalk209,164);
		Talk(CC.BTalk210,0);
		Talk(CC.BTalk211,164);
		Talk(CC.BTalk212,43);
		if instruct_6(59,3,0,0) ==false then    --  6(6):ս��[59]������ת��:Label0
			instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
			do return; end
		end    --:Label0
		Talk(CC.BTalk213,0);
		instruct_14();   --  14(E):�������
		instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [10]
		instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [10]
		instruct_3(-2,18,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [19]
		instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [11]
		SetS(39,26,39,3,20)
		instruct_19(27,39);   --  19(13):�����ƶ���F-D
		instruct_40(2); 
		instruct_3(-2,20,0,0,0,0,0,9234,9234,9234,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [20]
		instruct_13();   --  13(D):������ʾ����
		Talk(CC.BTalk214,591);
		Talk(CC.BTalk215,0);
		Talk(CC.BTalk216,591);
		Talk(CC.BTalk217,0);
		addHZ(111)
		if instruct_20(20,0) ==false then    --  20(14):�����Ƿ�����������ת��:Label2
			instruct_10(591);   --  10(A):��������[ʯ����]
			instruct_14();   --  14(E):�������
			instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [1]
			instruct_0();   --  0(0)::�����(����)
			instruct_13();   --  13(D):������ʾ����
		else
			instruct_1(12,591,0);   --  1(1):][ʯ����˵: ��Ķ����������Ҿ�ֱ��ȥС��ɡ�
			instruct_14();   --  14(E):�������
			instruct_3(-2,20,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [20]
			instruct_3(70,47,1,0,8301,0,0,9234,9234,9234,-2,-2,-2);   --  3(3):�޸��¼�����:����[С��]:�����¼���� [47]
			instruct_0();   --  0(0)::�����(����)
			instruct_13();   --  13(D):������ʾ����
		end    --:Label2
		instruct_2(198,1);	--  2(2):�õ���Ʒ[���Ʒ�����][1]
		instruct_3(-2,0,0,0,0,0,8302,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [0]
		instruct_3(-2,1,0,0,0,0,8302,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [1]
		instruct_3(-2,2,0,0,0,0,8302,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [2]
		instruct_3(74,0,-2,0,-2,427,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:����[���͵�]:�����¼���� [0]
	else
		instruct_0();   --  0(0)::�����(����)
		instruct_14();   --  14(E):�������
		instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [10]
		instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [19]
		instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [11]
		instruct_0();   --  0(0)::�����(����)
		instruct_13();   --  13(D):������ʾ����
		instruct_1(1630,38,0);   --  1(1):[ʯ����]˵: ��ʦ�����Ҳ���Ҫ��������*�����ŵģ��������������*������λʹ�ߴ��Լ��ȥ��*�࣬��˵��ʲô����Կ���*��Ҫ���ˡ�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1631,0,1);   --  1(1):[AAA]˵: �����͵����飿��Ӧ��ȥ��*�͵���������֪�����ﻹ��*Ū�����Ʒ������أ���
		instruct_0();   --  0(0)::�����(����)
		instruct_14();   --  14(E):�������
		instruct_3(-2,18,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [18]
		instruct_3(94,9,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:����[���ְ�]:�����¼���� [9]
		instruct_3(94,2,1,0,425,0,0,7070,7070,7070,-2,-2,-2);   --  3(3):�޸��¼�����:����[���ְ�]:�����¼���� [2]
		instruct_25(29,24,29,24);   --  25(19):�����ƶ�29-24--29-24
		instruct_0();   --  0(0)::�����(����)
		instruct_13();   --  13(D):������ʾ����
	end
end


OEVENTLUA[427] = function()	--��а�����͵��ſ�
    if instruct_4(198,2,0) ==false then    --  4(4):�Ƿ�ʹ����Ʒ[���Ʒ�����]��������ת��:Label0
        instruct_0();   --  0(0)::�����(����)
        do return; end
    end    --:Label0

    instruct_1(1643,41,0);   --  1(1):[����]˵: ��������롣
    instruct_0();   --  0(0)::�����(����)
    instruct_14();   --  14(E):�������
    instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [7]
    instruct_3(-2,11,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [11]
    instruct_3(-2,10,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [10]
    instruct_3(-2,9,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [9]
    instruct_3(-2,8,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [8]
    instruct_3(-2,1,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [1]
    instruct_3(-2,0,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [0]
    instruct_3(-2,2,1,0,428,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [2]
	instruct_3(-2,19,1,0,0,0,0,5152,5152,5152,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [19]
    instruct_3(-2,3,1,0,428,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [3]
    instruct_0();   --  0(0)::�����(����)
    instruct_13();   --  13(D):������ʾ����
end


OEVENTLUA[428] = function()	--��а�����͵��¼�
	if GetS(86,20,20,5) == 2 then
		instruct_26(61,19,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
		instruct_26(61,18,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
		instruct_1(1644,39,0);   --  1(1):[������]˵: ̫�����ѱ�ʯ�ֵ��ƽ⣬*�˴�û�����ı�Ҫ�ˣ�����*��ذɡ�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1645,0,1);   --  1(1):[AAA]˵: ʲô��̫�����Ҳ�֪����*������ֻ������һ�£�����*��û��ʮ����������䡣
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1646,40,0);   --  1(1):[ľ����]˵: �У�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1647,0,1);   --  1(1):[AAA]˵: Ŷ��
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1648,39,0);   --  1(1):[������]˵: �������С�һ�飬��������*����
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1649,0,1);   --  1(1):[AAA]˵: �ǣ��ܲ��ܰ��Ȿ���͸���*��
		instruct_0();   --  0(0)::�����(����)
		Talk(CC.BTalk218,40);
		Talk(CC.BTalk219,39);
		Talk(CC.BTalk220,0);
		instruct_35(38,2,102,900);   --  35(23):����ʯ�����书1:̫���񹦹�����900

		if instruct_6(170,3,0,0) ==false then    --  6(6):ս��[170]������ת��:Label0
			instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
			do return; end
		end    --:Label0
		addHZ(44)
		instruct_14();   --  14(E):�������
		SetS(86,20,20,5,0)
		instruct_3(-2,19,1,0,8303,0,0,5152,5152,5152,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [19]
		instruct_3(-2,2,1,0,417,0,0,5132,5132,5132,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [2]
		instruct_3(-2,3,1,0,418,0,0,5136,5136,5136,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [3]
		instruct_0();   --  0(0)::�����(����)
		instruct_13();   --  13(D):������ʾ����
		Talk(CC.BTalk221,39);
		Talk(CC.BTalk222,0);
		instruct_2(154,1);   --  2(2):�õ���Ʒ[������][1]
		instruct_2(80,1);   --  2(2):�õ���Ʒ[̫����][1]
		instruct_0();   --  0(0)::�����(����)		
	else
		instruct_26(61,19,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
		instruct_26(61,18,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
		instruct_1(1644,39,0);   --  1(1):[������]˵: ̫�����ѱ�ʯ�ֵ��ƽ⣬*�˴�û�����ı�Ҫ�ˣ�����*��ذɡ�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1645,0,1);   --  1(1):[AAA]˵: ʲô��̫�����Ҳ�֪����*������ֻ������һ�£�����*��û��ʮ����������䡣
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1646,40,0);   --  1(1):[ľ����]˵: �У�
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1647,0,1);   --  1(1):[AAA]˵: Ŷ��
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1648,39,0);   --  1(1):[������]˵: �������С�һ�飬��������*����
		instruct_0();   --  0(0)::�����(����)
		instruct_1(1649,0,1);   --  1(1):[AAA]˵: �ǣ��ܲ��ܰ��Ȿ���͸���*��
		instruct_0();   --  0(0)::�����(����)
		Talk(CC.BTalk235,40);
		instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [19]
		instruct_3(-2,3,1,0,8306,0,0,5136,5136,5136,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [3]
		instruct_3(-2,2,1,0,8306,0,0,5132,5132,5132,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [2]
		instruct_0();   --  0(0)::�����(����)
		instruct_13();   --  13(D):������ʾ����
		instruct_2(154,1);   --  2(2):�õ���Ʒ[������][1]
		instruct_0();   --  0(0)::�����(����)
	end
end


OEVENTLUA[8301] = function()	--����ʯ����С������¼�
		MyTalk("����Ҫ�Ұ�æ�ĵط���", 591);
    instruct_0();   --  0(0)::�����(����)

    if instruct_9(0,29) ==true then    --  9(9):�Ƿ�Ҫ�����?������ת��:Label1

        if instruct_20(20,0) ==false then    --  20(14):�����Ƿ�����������ת��:Label2
            instruct_10(591);   --  10(A):��������[ʯ����]
            instruct_14();   --  14(E):�������
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
            instruct_0();   --  0(0)::�����(����)
            instruct_13();   --  13(D):������ʾ����
            do return; end
        end    --:Label2

				MyTalk("��Ķ������������޷����롣", 591);
        instruct_0();   --  0(0)::�����(����)
        do return; end
    end    --:Label1
end


OEVENTLUA[8302] = function()	--����ʯ����ѩɽ������¼�
    if instruct_16(591,2,0) ==false then    --  16(10):�����Ƿ���[ʯ����]������ת��:Label0
        instruct_0();   --  0(0)::�����(����)
        do return; end
    end    --:Label0
    instruct_13();   --  13(D):������ʾ����
    Talk(CC.BTalk230,591);
    instruct_0();   --  0(0)::�����(����)
    instruct_21(591);   --  21(15):[ʯ����]���
	instruct_14();   --  14(E):�������
    instruct_3(70,47,1,0,8301,0,0,9234,9234,9234,-2,-2,-2);   --  3(3):�޸��¼�����:����[С��]:�����¼���� [47]
	instruct_13();   --  13(D):������ʾ����
end


OEVENTLUA[8303] = function()	--����ʯ�������͵�����¼�
	if instruct_16(591,2,0) ==false then    --  16(10):�����Ƿ���[ʯ����]������ת��:Label0
		Talk(CC.BTalk223,38);
		instruct_0();   --  0(0)::�����(����)
		do return; end
    end    --:Label0

	 if instruct_9(0,95) ==true then    --  9(9):�Ƿ�Ҫ�����?������ת��:Label0
		--[[JY.Person[38]["�书�ȼ�1"] = 900; 
		JY.Person[38]["�书�ȼ�2"] = 900; 	
		JY.Person[38]["�书�ȼ�3"] = 900; 
		JY.Person[38]["������"] = 220;   
		JY.Person[38]["�Ṧ"] = 160;   
		JY.Person[38]["������"] = 220;  
		JY.Person[38]["�ȼ�"] = 15;  		
		local pid = 38			
		local extra = (7 + math.modf((JY.Person[pid]["����"]) / 20)) * (JY.Person[pid]["�ȼ�"] - 1)
				
		  while extra ~= 0 do
			  local sanwei=math.random(3)
			  if sanwei==1 then
				AddPersonAttrib(pid, "������", 1)
			  elseif sanwei==2 then
				AddPersonAttrib(pid, "������", 1)
			  else
				AddPersonAttrib(pid, "�Ṧ", 1)	  
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
		    instruct_14();   --  14(E):�������
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
            instruct_0();   --  0(0)::�����(����)
            instruct_13(); 
			for i = 1,HHH_GAME_SETTING["WG_COUNT_MAX"] do
			JY.Person[zj()]["�书"..i] = JY.Person[38]["�书"..i]
			end
			do return; end
        else 
		--instruct_2(72,1);		--�õ�ʮ����ż
        if instruct_20(20,0) ==false then    --  20(14):�����Ƿ�����������ת��:Label1
            instruct_14();   --  14(E):�������
            instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
            instruct_0();   --  0(0)::�����(����)
            instruct_13();   --  13(D):������ʾ����
            instruct_10(38);   --  10(A):��������[ʯ����]
            do return; end
        end    --:Label1
        instruct_1(12,38,0);   --  1(1):[ʯ����]˵: ��Ķ����������Ҿ�ֱ��ȥ*С��ɡ�
        instruct_0();   --  0(0)::�����(����)
        instruct_14();   --  14(E):�������
        instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
        instruct_3(70,16,1,0,127,0,0,6410,6410,6410,-2,-2,-2);   --  3(3):�޸��¼�����:����[С��]:�����¼���� [16]
        instruct_3(70,58,1,0,127,0,0,6412,6412,6412,-2,-2,-2);   --  3(3):�޸��¼�����:����[С��]:�����¼���� [58]
        instruct_0();   --  0(0)::�����(����)
        instruct_13();   --  13(D):������ʾ����
        do return; end
	end	
    end    --:Label0
end


OEVENTLUA[8304] = function()	--�������͵�սŷ�����Ħ��
	Talk(CC.BTalk231,60);
	Talk(CC.BTalk232,0);
	Talk(CC.BTalk233,103);
    if instruct_6(168,4,0,0) ==false then    --  6(6):ս��[168]������ת��:Label0
        instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
        do return; end
        instruct_0();   --  0(0)::�����(����)
    end    --:Label0
	Talk(CC.BTalk234,0);
	instruct_3(-2,-2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
	
	SetS(86,20,20,5,0)		--�����壺�����к�û�л�ԭ���ݣ�����ľ׮���ŷ�����Ħ��
end


OEVENTLUA[8305] = function()	--ʯ��������¼�
    Talk("ʯ�ֵܣ����Ȼ�С�壬����*Ҫʱ������ȥ�����æ��",0);
    instruct_21(591);   --  21(15):[ʯ����]���
    instruct_3(70,47,1,0,8301,0,0,9234,9234,9234,-2,-2,-2);   --  3(3):�޸��¼�����:����[С��]:�����¼���� [47]
end

OEVENTLUA[8652] = function()	--ΤС������¼�
    Talk("�ҵ�С���磬���Ȼ�С�壬����*Ҫʱ������ȥ�����æ����",0);
    instruct_21(664);   --  21(15):[ΤС��]���
    instruct_3(70,48,1,0,869,870,0,8256,8256,8256,-2,-2,-2);   --  3(3):�޸��¼�����:����[С��]:�����¼���� [48]
end

OEVENTLUA[8306] = function()	--а�����͵�ս����Ⱥ��
	Talk(CC.BTalk236,0);
	instruct_1(1650,40,0);   --  1(1):[ľ����]˵: ���ɣ�
	instruct_0();   --  0(0)::�����(����)
	instruct_1(1651,39,0);   --  1(1):[������]˵: ��������͵������ش�ֻ*Ҫ���ֵܶ��˻��ڣ��;���*����������ߡ�
	instruct_0();   --  0(0)::�����(����)
	if instruct_5(0,254) ==true then    --  5(5):�Ƿ�ѡ��ս����������ת��:Label0
		instruct_37(-5);       --����-5
		instruct_1(1652,0,1);   --  1(1):[AAA]˵: Ŷ����ô˵ֻҪ����������*�����ˡ�
		instruct_0();   --  0(0)::�����(����)
		if instruct_6(170,3,0,0) ==false then    --  6(6):ս��[170]������ת��:Label0
			instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
			do return; end
		end    --:Label0
		instruct_3(-2,19,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [19]
		instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [2]
		instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [3]
		instruct_0();   --  0(0)::�����(����)
		instruct_13();   --  13(D):������ʾ����
		instruct_2(80,1);   --  2(2):�õ���Ʒ[̫����][1]
		instruct_0();   --  0(0)::�����(����)
		if T5BCF(0) and zj() == 0 then
			Talk("����̫��......�٣���һ������̫����",0);
			JY.Person[0]["�书2"]=102
			JY.Person[0]["�书�ȼ�2"]=0
			QZXS("�׳������̫���񹦣�");
		else
			Talk(CC.BTalk237,0);
		end
	else
		Talk(CC.BTalk238,0);
		do return; end
	end
end

--brolycjw�޸ı����� ������� --�������ǣ�����˵���˱��ѩɽ���ӵ�BUG
OEVENTLUA[8601] = function()    --�������
	 if GetS(86,40,40,5) == 1 then		--�ж��¼��Ƿ��Ѿ�������
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

   local zx=DrawStrBoxYesNo(-1,-1,"���Ƿ�Ӧ��ͦ������أ�",C_ORANGE,CC.DefaultFont);
   
   if zx==true and JY.Person[0]["�Ա�"] ~= 2 then            --��а��֧
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
          if WarMain(92,1)==true then    --Ⱥս�´ﺣ
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
             TalkEx(string.format(CC.TTalk20, JY.Person[zj()]["����"]),0,1); 
             instruct_0();
             TalkEx(string.format(CC.TTalk21, JY.Person[zj()]["����"]),590,0); 
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
             	TalkEx("��Ķ������������Ȼ�С��ɡ�",590,0);
             	instruct_3(70,86,1,0,8651,0,0,6804,6804,6804,0,0,0);
             else
             	instruct_10(590);      --������ѣ�590������
             	
             end
             
             instruct_14();
	     instruct_3(70,3,0,0,0,0,0,0,0,0,0,0,0);
	     instruct_3(70,4,0,0,0,0,0,0,0,0,0,0,0);
	     instruct_3(70,61,1,0,8602,0,0,5098,5098,5098,0,-2,-2);  --���;���
	     instruct_3(70,62,1,0,8603,0,0,8250,8250,8250,0,-2,-2);  --�������
             instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);
             instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);
             instruct_0();
             instruct_13();
             instruct_2(230,1);       --�õ�����
             instruct_0();
             instruct_37(2);       --����+2
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
          SetS(87,31,33,5,1);   --�����´ﺣս������
          if WarMain(92,1)==true then  --�����´ﺣ
             instruct_39(15);          --�򿪷����ͼ
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
             instruct_10(92);    --������ѣ�92������´ﺣ
             instruct_0();
             --]]
             instruct_37(-2);       --����-2
             instruct_0();
             instruct_14();
	     instruct_3(-2,5,0,0,0,0,0,0,0,0,0,0,0);
             instruct_0();
             instruct_13();
             TalkEx(CC.TTalk37,0,1);  
             instruct_0();
             instruct_2(230,1);       --�õ�����
             instruct_0();
             instruct_37(-1);       --����-1
             instruct_0();
          else
             instruct_15(0);   
             instruct_0();
          end
          SetS(87,31,33,5,0);   --�����´ﺣս�����ݻ�ԭ
   end 
   
   SetS(86,40,40,5,1);  --�����ظ�����
end


OEVENTLUA[8602] = function()    --�������;���
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
   instruct_39(15);       --�򿪷����ͼ
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


OEVENTLUA[8603] = function()    --���߱������
TalkEx(CC.TTalk44,0,1);  
instruct_0();
TalkEx(CC.TTalk45,256,0);  
instruct_0();
instruct_3(70,62,1,0,8604,0,0,8250,8250,8250,0,-2,-2);
end


OEVENTLUA[8604] = function()    
TalkEx(CC.TTalk49,256,0);  
instruct_0();

local btl=DrawStrBoxYesNo(-1,-1,"�Ƿ�Ҫ�����屦���۾ƣ�",C_ORANGE,CC.DefaultFont);
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
      instruct_39(15);       --�򿪷����ͼ
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


OEVENTLUA[8605] = function()    --����ɳĮ����
if instruct_16(590)==false then        --590������
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
   SetS(87,31,34,5,1);  --�����߶����������ж�

   if instruct_6(91,4,0,0) ==false then    --�����߶�����
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
   SetS(87,31,34,5,0);  --�����߶��������ݻ�ԭ
end
end

OEVENTLUA[8606] = function() 
TalkEx(CC.TTalk59,269,0);  
instruct_0();
instruct_3(-2,3,1,0,8607,0,0,-2,-2,-2,-2,-2,-2);
end

OEVENTLUA[8607] = function()          --�����Ǿ�����
local title = "��һ�أ��Ǿ�";
local str = "���ʲ��׵�������˭��";
local btn = {"SYP","�����"};
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

OEVENTLUA[8608] = function()  --�������ľ���
TalkEx(CC.TTalk62,269,0);  
instruct_0();
SetS(87,31,31,5,1)     --а15��ս���ж�
if WarMain(133,1)==true then    --20ʱ�򲻰�а15��
   TalkEx(CC.TTalk63,269,0);  
   instruct_0();
   instruct_3(-2,3,1,0,8609,0,0,-2,-2,-2,-2,-2,-2);
else
   instruct_15(0);   
   instruct_0();
end
SetS(87,31,31,5,0)     --а15��ս����ԭ
end

OEVENTLUA[8609] = function()         --�����������
if instruct_16(590)==false then
   TalkEx(CC.TTalk65,269,0);  
   instruct_0();
else
   TalkEx(CC.TTalk64,269,0);  
   instruct_0();
   local title = "�����أ�����";
   local str = "������һ���˵�������Ϊ���ŵ�Ѫ��";
   local btn = {JY.Person[zj()]["����"],"������"};
   local num = #btn;
   local pic = 269;
   local r = JYMsgBox(title,str,btn,#btn,pic);

if r==1 then
	local pid = 9999;				--����һ����ʱ����ħ��������
	JY.Person[pid] = {};
	for i=1, #PSX-8 do
		JY.Person[pid][PSX[i]] = JY.Person[zj()][PSX[i]];
	end
	
	JY.Person[pid]["�������ֵ"] = math.modf(JY.Person[pid]["�������ֵ"]/1);
	JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"];
	JY.Person[pid]["�������ֵ"] = math.modf(JY.Person[pid]["�������ֵ"]/1);
	JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"];
	JY.Person[pid]["����"] = 100;		
	JY.Person[pid]["ҽ������"] = math.modf(JY.Person[pid]["ҽ������"]/2);
	
	JY.Person[pid]["������"] = math.modf(JY.Person[pid]["������"]/2);
	JY.Person[pid]["������"] = math.modf(JY.Person[pid]["������"]/2);
	JY.Person[pid]["�Ṧ"] = math.modf(JY.Person[pid]["�Ṧ"]/2);
	
	
	JY.Person[pid]["����"] = JY.Person[zj()]["����"];
   instruct_37(1);       --����+1
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
      SetS(87,31,35,5,1)           --��ħս�ж�
      if WarMain(20) then    --������ս��ħ
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
      SetS(87,31,35,5,0)           --��ħս��ԭ
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
         SetS(87,31,35,5,1)           --��ħս�ж�
         if WarMain(20) then   --������ս��ħ
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
         SetS(87,31,35,5,0)           --��ħս��ԭ
      else
         instruct_15(0);   
         instruct_0();
         return;
      end
   end
else
   instruct_37(-5);       --����-5
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
         AddPersonAttrib(0, "�������ֵ", -5000);
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

OEVENTLUA[8610] = function()  --а��ɳĮ����
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

if instruct_6(91,4,0,0) ==false then    --Ⱥս�߶�����
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

OEVENTLUA[8612] = function()     --а���ʵ¾���
local title = "��һ�أ��Ǿ�";
local str = "���������һ����ͬʱ��15���˴���᲻�������";
local btn = {"��","����"};
local num = #btn;
local pic = 269;
local r = JYMsgBox(title,str,btn,#btn,pic);

if r==2 then
	TalkEx(CC.TTalk60,269,0);  
	instruct_0();
	TalkEx(CC.TTalk101,269,0);  
	instruct_0();
	SetS(87,31,32,5,1)     --��15��ս���ж�
	if WarMain(134,1)==true then   --20ʱ�򲻰���15��
	   TalkEx(CC.TTalk63,269,0);  
	   instruct_0();
	   instruct_3(-2,3,1,0,8614,0,0,-2,-2,-2,-2,-2,-2);
	else
	   instruct_15(0);   
	   instruct_0();
	end
	SetS(87,31,32,5,0)     --��15��ս����ԭ
else
TalkEx(CC.TTalk61,269,0);  
instruct_0();
end
end



OEVENTLUA[8614] = function()  --а���������
	if instruct_16(92)==false and JY.Person[0]["�Ա�"] == 0 and not T8LXY(0) then
	   TalkEx(CC.TTalk65,269,0);  
	   instruct_0(); 
	else  
	   TalkEx(CC.TTalk64,269,0);  
	   instruct_0();
	   local title = "�����أ�����";
	   local str = "�����ű��������İ���Ů�˵�������Ϊ*Ѫ��������������������Ӵ˾��Ӿ��";
	   local btn = {"С����",JY.Person[92]["����"]};
	   local num = #btn;
	   local pic = 269;
	   local r = JYMsgBox(title,str,btn,#btn,pic);
		if (T8LXY(0) or T4WXS(0) or T5BCF(0) or T6XQS(0)) and zj() == 0 then
			instruct_0()
			say("�٣�ʲô�����ڴ�װ��Ū������үƫƫȫ����ѡ���ͣ�")
			local pid = 9999;				--����һ����ʱ����ħ��������
			JY.Person[pid] = {};
			for i=1, #PSX-8 do
				JY.Person[pid][PSX[i]] = JY.Person[0][PSX[i]];
			end
			
			JY.Person[pid]["�������ֵ"] = math.modf(JY.Person[pid]["�������ֵ"]/1);
			JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"];
			JY.Person[pid]["�������ֵ"] = math.modf(JY.Person[pid]["�������ֵ"]/1);
			JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"];
			JY.Person[pid]["ҽ������"] = 0
			JY.Person[pid]["������"] = math.modf(JY.Person[pid]["������"]/2);
			JY.Person[pid]["������"] = math.modf(JY.Person[pid]["������"]/2);
			JY.Person[pid]["�Ṧ"] = math.modf(JY.Person[pid]["�Ṧ"]/2);
			JY.Person[pid]["����"] = JY.Person[0]["����"];
		   instruct_37(1);       --����+1
		   instruct_0(); 
		   instruct_0();
			  SetS(87,31,35,5,1)           --��ħս�ж�
			  if WarMain(20,1)==true then   --������ս��ħ
				 instruct_0();
			  else
				 instruct_15(0);   
				 instruct_0();
				 return;
			  end
			  SetS(87,31,35,5,0)           --��ħս��ԭ		
		elseif JY.Person[0]["�Ա�"] == 1 and zj() == 0 then
			instruct_0()
			say("�٣�ʲô�����ڴ�װ��Ū��������ƫƫȫ����ѡ���ͣ�")
			local pid = 9999;				--����һ����ʱ����ħ��������
			JY.Person[pid] = {};
			for i=1, #PSX-8 do
				JY.Person[pid][PSX[i]] = JY.Person[0][PSX[i]];
			end
			
			JY.Person[pid]["�������ֵ"] = math.modf(JY.Person[pid]["�������ֵ"]/1);
			JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"];
			JY.Person[pid]["�������ֵ"] = math.modf(JY.Person[pid]["�������ֵ"]/1);
			JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"];
			JY.Person[pid]["ҽ������"] = 0
			JY.Person[pid]["������"] = math.modf(JY.Person[pid]["������"]/2);
			JY.Person[pid]["������"] = math.modf(JY.Person[pid]["������"]/2);
			JY.Person[pid]["�Ṧ"] = math.modf(JY.Person[pid]["�Ṧ"]/2);
			JY.Person[pid]["����"] = JY.Person[0]["����"];
		   instruct_37(1);       --����+1
		   instruct_0(); 
		   instruct_0();
			  SetS(87,31,35,5,1)           --��ħս�ж�
			  if WarMain(20,1)==true then   --������ս��ħ
				 instruct_0();
			  else
				 instruct_15(0);   
				 instruct_0();
				 return;
			  end
			  SetS(87,31,35,5,0)           --��ħս��ԭ		
		elseif JY.Person[0]["�Ա�"] == 2 and zj() == 0 then
			instruct_0()
			say("�٣�ʲô�����ڴ�װ��Ū���Ӽ�ƫƫȫ����ѡ���ͣ�")
			local pid = 9999;				--����һ����ʱ����ħ��������
			JY.Person[pid] = {};
			for i=1, #PSX-8 do
				JY.Person[pid][PSX[i]] = JY.Person[0][PSX[i]];
			end
			
			JY.Person[pid]["�������ֵ"] = math.modf(JY.Person[pid]["�������ֵ"]/1);
			JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"];
			JY.Person[pid]["�������ֵ"] = math.modf(JY.Person[pid]["�������ֵ"]/1);
			JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"];
			JY.Person[pid]["ҽ������"] = 0
			JY.Person[pid]["������"] = math.modf(JY.Person[pid]["������"]/2);
			JY.Person[pid]["������"] = math.modf(JY.Person[pid]["������"]/2);
			JY.Person[pid]["�Ṧ"] = math.modf(JY.Person[pid]["�Ṧ"]/2);
			JY.Person[pid]["����"] = JY.Person[0]["����"];
		   instruct_37(1);       --����+1
		   instruct_0(); 
		   instruct_0();
			  SetS(87,31,35,5,1)           --��ħս�ж�
			  if WarMain(20,1)==true then   --������ս��ħ
				 instruct_0();
			  else
				 instruct_15(0);   
				 instruct_0();
				 return;
			  end
			  SetS(87,31,35,5,0)           --��ħս��ԭ			  
		else
		if r==1 then
			local pid = 9999;				--����һ����ʱ����ħ��������
			JY.Person[pid] = {};
			for i=1, #PSX-8 do
				JY.Person[pid][PSX[i]] = JY.Person[zj()][PSX[i]];
			end
			
			JY.Person[pid]["�������ֵ"] = math.modf(JY.Person[pid]["�������ֵ"]/1);
			JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"];
			JY.Person[pid]["�������ֵ"] = math.modf(JY.Person[pid]["�������ֵ"]/1);
			JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"];
			JY.Person[pid]["ҽ������"] = 0
			JY.Person[pid]["������"] = math.modf(JY.Person[pid]["������"]/1);
			JY.Person[pid]["������"] = math.modf(JY.Person[pid]["������"]/1);
			JY.Person[pid]["�Ṧ"] = math.modf(JY.Person[pid]["�Ṧ"]/1);
			JY.Person[pid]["����"] = JY.Person[zj()]["����"];
		   instruct_37(1);       --����+1
		   instruct_0();
		   TalkEx(CC.TTalk102,0,1);  
		   instruct_0();
			  SetS(87,31,35,5,1)           --��ħս�ж�
			  if WarMain(20,1)==true then   --������ս��ħ
				 instruct_0();
			  else
				 instruct_15(0);   
				 instruct_0();
				 return;
			  end
			  SetS(87,31,35,5,0)           --��ħս��ԭ
			  			lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_RED, 128)
			ShowScreen()
			lib.Delay(80)
			lib.ShowSlow(15, 1)
			Cls()
			lib.ShowSlow(100, 0)
			JY.Person[zj()]["�Ա�"] = 2
			SetS(86,15,15,5,1)
			local add, str = AddPersonAttrib(zj(), "������", -20)
			DrawStrBoxWaitKey(JY.Person[zj()]["����"] .. str, C_ORANGE, CC.DefaultFont)
			add, str = AddPersonAttrib(zj(), "������", -30)
			DrawStrBoxWaitKey(JY.Person[zj()]["����"] .. str, C_ORANGE, CC.DefaultFont)
			Talk(CC.TTalk104,92); 
			Talk(CC.TTalk105,0); 
			Talk(CC.TTalk106,92);
		else
		   Talk(CC.TTalk74,0); 	--����սŮ��
		   SetS(87,31,35,5,2)
			if instruct_6(20,4,0,0) ==false then    --  6(6):ս��[74]������ת��:Label2
				instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
				instruct_0();   --  0(0)::�����(����)
				do return; end
			end  
			SetS(87,31,35,5,0) --Ů��ս��ԭ
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

--��д��սʮ��ͭ��
--����ѡ��һ��������ͦ��800ʱ��   ����Ⱥս��500ʱ����սʤ
OEVENTLUA[712] = function()
		
	local title = "��սʮ��ͭ��";
	local str = "����ͭ���ÿ����ֻ��һ�λ���*��ѡ����ս�ķ�ʽ*������ʤ��������ͦ��800ʱ��*Ⱥս��ʤ��������500ʱ����սʤ*"
	local btn = {"����","Ⱥս","����"};
	local num = #btn;
	local r = JYMsgBox(title,str,btn,num);
	
	if r == 3 then
		return;
	end
	
	--����
	if r == 1 then
		SetS(86,1,2,5,1);		--�жϵ���ʮ��ͭ��
	end
	
	--Ⱥս
	if r == 2 then
		SetS(86,1,2,5,2);		--�жϵ���ʮ��ͭ��
	end

  instruct_1(2881,210,0);   --  1(1):[???]˵: �ã�ʩ������룡
  instruct_0();   --  0(0)::�����(����)
  instruct_19(41,14);   --  19(13):�����ƶ���29-E
  instruct_0();   --  0(0)::�����(����)

	if instruct_6(217,0,7,1) ==true then    --  6(6):ս��[217]������ת��:Label3
	  instruct_19(41,7);   --  19(13):�����ƶ���29-7
	  instruct_0();   --  0(0)::�����(����)
	  instruct_13();   --  13(D):������ʾ����
	  instruct_0();   --  0(0)::�����(����)
	  do return; end
	end    --:Label3

  instruct_19(42,17);   --  19(13):�����ƶ���2A-11
  instruct_0();   --  0(0)::�����(����)
  instruct_13();   --  13(D):������ʾ����
  instruct_3(-2,-2,1,0,709,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
end



--δ�յ���ǰ�������Ĺǰ�Ի�
OEVENTLUA[8011] = function()
	QZXS(CC.LTalk92);	--����֮Ĺ
	Talk(CC.LTalk93,0);
end

--�յҺ�ҩ�������¼�
OEVENTLUA[8012] = function()
	Talk(CC.LTalk94, 37);
	Talk(CC.LTalk95, 0);
	instruct_3(103,-2,1,0,8011,0,0,-2,-2,-2,-2,-2,-2);		--�޸�ҩ�����¼�
	instruct_3(103,80,1,0,8001,0,0,8818,8818,8818,0,0,0);		--�޸�ҩ�����¼�
end

--��һ�μ������������
OEVENTLUA[8013] = function()
	MyTalk(CC.LTalk96, 592);		--��ѧ֮�����ڱ����������*��ѧ֮�������ڽ���������*���������Ϊ��
	MyTalk(CC.LTalk97, 592);		--��ƽ��һ���ֶ����ɵã��ϼ����ѿ�Ҳ
	
	if instruct_5(2,0) then
		Talk(CC.LTalk98, 0);		--��������ǰ�����������½���������ǰ�����
		MyTalk(CC.LTalk99, 592);	--����~~��Ȼ�Ǻ�����η~~��~~"
		
		if WarMain(239) then
			say("�ã�ʹ�죡������޺��ѣ�",592) 
	        if PersonKF(0, 47) and GetS(111, 0, 0, 0) == 0 then
	           say("������ʽ���Ἰ����ɣ������²����磿",592) 
			   instruct_0();
			   say("���ⶼɶ����ˣ�����զ�����󡣡���",0) 
	           instruct_0();
			   if instruct_11(0,188) == true then
	               QZXS("������¾��裡")
	               instruct_0();
	               say("��лǰ��",0) 
	               SetS(111, 0, 0, 0,592)
			   else
				   say("��ˣ����಻ǿ��Ȼ�պ󽭺���ս��Ī������ǰ������",592) 
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

--սʤ���������
OEVENTLUA[8014] = function()
	MyTalk(CC.LTalk100, 592);
	addHZ(12)
	addHZ(145)
	--��ʤ����ٻ���ս��
	SetS(86,10,20,5,1);
end

--ս�ܣ��������
OEVENTLUA[8015] = function()
	MyTalk(CC.LTalk97, 592);		--��ƽ��һ���ֶ����ɵã��ϼ����ѿ�Ҳ
	
	if instruct_5(2,0) then
		MyTalk(CC.LTalk99, 592);	--����~~��Ȼ�Ǻ�����η~~��~~"
		
		if WarMain(239) then
			say("�ã�ʹ�죡������޺��ѣ�",592) 
	        if PersonKF(0, 47) and GetS(111, 0, 0, 0) == 0 then
	           say("������ʽ���Ἰ����ɣ������²����磿",592) 
			   instruct_0();
			   say("���ⶼɶ����ˣ�����զ�����󡣡���",0) 			   
	           instruct_0();
			   if instruct_11(0,188) == true then
	              QZXS("������¾��裡")
	              instruct_0();
	              say("��лǰ��",0) 
	              SetS(111, 0, 0, 0,592)
			   else
			      say("��ˣ����಻ǿ��Ȼ�պ󽭺���ս��Ī������ǰ������",592) 
			   end 
			   instruct_3(-2,-2,-2,-2,8014,-2,-2,-2,-2,-2,-2,-2,-2);
               do return; end
            end
			instruct_3(-2,-2,-2,-2,8014,-2,-2,-2,-2,-2,-2,-2,-2);
			do return; end
		end
		MyTalk(CC.LTalk101, 592);		--��ѧ����ܺã�ֻ��ϧ̫��ð������ȥ��������һ���ɡ�
	end
end

--�����壺�ﲮ�⣬������ջ��ϷС��Ϸ�¼�
OEVENTLUA[8016] = function()
	if inteam(29) and GetS(86,10,11,5) == 0 and GetD(1,15,4) <= 0 then
	
		instruct_3(-2,34,0,0,0,0,0,0,0,0,0,0,0);			--�����ͼ
		instruct_3(-2,35,0,0,0,0,0,0,0,0,0,0,0);			--
	
		instruct_3(-2,37,1,0,0,0,0,2598*2,2598*2,2598*2,0,0,0);			--������ͼ
		instruct_25(0, 4, 0, 0);
		Talk(CC.LTalk102, 29);		--�����͵ܣ��㿴�Ǳߣ���С���ӳ��ú�������ѽ�����Ǹ�С��ã���Ҳ����һ����ζŶ��
		Talk(CC.LTalk103, 0);		--Ŷ�������ף������õ�����ͦ����ѽ�������Ǹ�С���Ŷ�����֣�Ī���������͵�Ҳ����Ȥ��
		Talk(CC.LTalk104, 29);	--��ѽ���͵ܣ��ҹ���С��û���СĢ����ֻҪ�����ῡ����Ů�ˣ��ҡ��ɻ������������;�����Ź�����������Ҫ���͵ܣ�����һ��ȥ����������������..
		Talk(CC.LTalk105, 0);		--����
		
		instruct_14();
		instruct_3(-2,36,1,0,0,0,0,3615*2,3615*2,3615*2,0,0,0);			--�ﲮ����ͼ
		JY.Base["��X1"] = 21
		JY.Base["��Y1"] = 22
		instruct_40(1);		--����λ�ñ仯
		instruct_3(-2,37,1,0,0,0,0,2600*2,2600*2,2600*2,0,0,0);			--������ͼ
		instruct_13();
		
		
		Talk(CC.LTalk106, 29);	--������С���ˣ�����С�������ÿ���ÿ�ѽ�����������ү���Ļ�ŭ�Ű�������Խ��Խϲ��ѽ�������������ү����ɡ������⻨����ò����ɫ����С��ã�ʵ��̫��ϧ����
		say3(CC.LTalk107, 346, "����");--��������ɫ����������������컯��֮�¾��������ᱡ���ˣ�
		Talk(CC.LTalk108, 29);	
		say3(CC.LTalk109, 346, "����");
		
		instruct_14();
		instruct_3(-2,39,1,0,0,0,0,3574*2,3574*2,3574*2,0,0,0);			--�������ͼ
		instruct_13();
		
		Talk(CC.LTalk110, 35);		--�ô󵨵�����
		
		--սʤ���ﲮ��ȫ����+10
		if WarMain(241) then
			AddPersonAttrib(29, "������", 10);
			AddPersonAttrib(29, "������", 10);
			AddPersonAttrib(29, "�Ṧ", 10);
                                                AddPersonAttrib(29, "��������", 10)
			QZXS("�ﲮ�⹥����,��������������ʮ��");
		end
		
		Talk(CC.LTalk111, 35);
		
		instruct_14();
		instruct_3(-2,37,0,0,0,0,0,0,0,0,0,0,0);			--�����ͼ
		instruct_3(-2,39,0,0,0,0,0,0,0,0,0,0,0);			--�������ͼ
		instruct_13();
		
		Talk(CC.LTalk112, 29);
		
		instruct_14();
		instruct_3(-2,36,0,0,0,0,0,0,0,0,0,0,0);			
		instruct_13();
		
		instruct_37(-1);	--����-1
		SetS(86,10,11,5,1);
	end
	
end
--���ü�����Ц������
OEVENTLUA[752] = function()
	if DrawStrBoxYesNo(-1, -1, "�Ƿ��������߾��飿", C_WHITE, 30) == true then
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
		JY.Person[0]["ʵս"] = (JY.Person[0]["ʵս"] or 0) + 50
		instruct_35(35,0,47,700)
		null(-2,0)
		light()
		addthing(54)
		addthing(67)
		addthing(180)
		addthing(187)
		addthing(358)
		bgtalk("���Ȼ�С�������")
		bgtalk("����÷ׯ���к�������")
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
		say("����֣��þò����ˣ���λ��ǰ���ǣ�",0)
		say("��Ҫ���ҵ�������Ҳ��Ҫ���κ����������Ǽ����ҡ�",140)
		say("�����¾Ͳ������ˡ�����֣�һ��ɺã�",0)
		say("���á��ϴ���ɽ�����Ź棬��ʦ�������˴����˼��������������ǰ���������ǳ��",35)
		say("ֻ�Ǻþò���Сʦ���ˣ���Щ������þ�û���ˣ�����������",35)
		say("���������ֲ��عһ���������ܺã������ֵܴ��úܿ��ġ�",0)
		say("����˵������Ŷ������������ʦ�ܺ�������൱����",35)
		say("������Ҹս���ý�������*��λ�����������԰ɡ�",140)
		say("�ǣ�̫ʦ�壡��������׼��*һ�£����Ǳ��Ա��ԣ�",35)
		Cls()
	end
		--[[14(E):��������������Ϊ����
   3(3):�޸��¼�����:��ǰ���������¼����[2]
   3(3):�޸��¼�����:��ǰ���������¼����[3]
   3(3):�޸��¼�����:��ǰ������ǰ�����¼����
   35(23):����[35�����]�书[0]Ϊ[47���¾Ž�]����Ϊ700
   47(2F):[35�����]�����书50
   13(D):����������ʾ
   30(1E):�����߶�48-36--19-37
   40(28):����վ������2
   0(0):��ָ��(����)
   1(1):[0��]:
   0(0):��ָ��(����)
   1(1):[249ѩɽ����]:
   0(0):��ָ��(����)
   1(1):[0��]:
   0(0):��ָ��(����)
   1(1):[35�����]:��
   0(0):��ָ��(����)
   1(1):[0��]:
   0(0):��ָ��(����)
   1(1):[35�����]:
   0(0):��ָ��(����)
   1(1):[249ѩɽ����]:
   0(0):��ָ��(����)
   1(1):[35�����]:
   0(0):��ָ��(����)
   -1(FFFF):�¼�����
	end]]
end
--��д��ε���������¼�
OEVENTLUA[754] = function()

    if instruct_5(0,693) ==true then    --  5(5):�Ƿ�ѡ��ս����������ת��:Label0
        instruct_0();   --  0(0)::�����(����)
				
				--����ﲮ���ڶ�
				if inteam(29) and GetS(86,10,11,5) == 1 then
					Talk(CC.LTalk113, 29);
					Talk(CC.LTalk114, 35);
					
					while instruct_29(35,150,9999,0,332) == false do
						if WarMain(241) then
							instruct_1(2998,249,0);   --  1(1):[???]˵: �����������С�����ٽ���*���У��ٺ����ȹ���
        			instruct_0();   --  0(0)::�����(����)
        			instruct_47(35,20);   --  47(2F):��������ӹ�����20
        			instruct_48(35,50);   --  48(30):�������������50
        		else
        			break;
						end
					end
					
					Talk(CC.LTalk128, 29);
					--�ﲮ���Ṧ����20��
					AddPersonAttrib(29, "�Ṧ", 20);
					QZXS("�ﲮ���Ṧ����20��");
					
					instruct_3(31,7,1,0,8017, 0, 0, 2597*2, 2597*2, 2597*2, 0,0,0);		--���ճ����ں�ɽ��
					SetS(86,10,11,5,2);
					
					instruct_1(3000,195,0);   --  1(1):[???]˵: ��ʦ�֣���ʦ�֡���
          instruct_0();   --  0(0)::�����(����)
          instruct_1(3001,249,0);   --  1(1):[???]˵: �л�ɽ�ɵ������ˣ���Ҫ��*�ˣ���ס�����ǲ�����κ�*�������ң�
          instruct_0();   --  0(0)::�����(����)
          instruct_14();   --  14(E):�������
          instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [2]
          instruct_3(-2,4,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [4]
          instruct_3(57,17,1,0,0,0,0,7018,7018,7018,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [17]
          instruct_3(57,19,1,0,0,0,0,7150,7150,7150,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [19]
          instruct_3(57,20,1,0,0,0,0,7158,7158,7158,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [20]
          instruct_3(57,18,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [18]
          instruct_3(57,23,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [23]
          instruct_3(57,21,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [21]
          instruct_3(57,22,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [22]
          instruct_3(57,24,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [24]
          instruct_3(57,28,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [28]
          instruct_3(57,27,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [27]
          instruct_3(57,26,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [26]
          instruct_3(57,25,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [25]
          instruct_3(57,6,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [6]
          instruct_3(57,5,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [5]
          instruct_3(57,2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [2]
          instruct_3(57,15,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [15]
          instruct_3(57,29,0,0,0,0,755,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [29]
          instruct_0();   --  0(0)::�����(����)
          instruct_13();   --  13(D):������ʾ����
			                                AddPersonAttrib(35, "��������", 30);
					QZXS("����屻��������̼����������������30��");
          instruct_1(3002,35,0);   --  1(1):[�����]˵: ���ʲô�£��Ż����ŵġ�
          instruct_0();   --  0(0)::�����(����)
          instruct_1(3003,195,0);   --  1(1):[???]˵: ��ʦ�֣������ˣ��ɲ�����*�����������������죬Ҫ��*ʦ���ó�����֮λ��
          instruct_0();   --  0(0)::�����(����)
          instruct_1(3004,35,0);   --  1(1):[�����]˵: ʲô��*�ߣ�����ȥ������
          instruct_0();   --  0(0)::�����(����)
          instruct_14();   --  14(E):�������
          instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [4]
          instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [3]
          instruct_0();   --  0(0)::�����(����)
          instruct_13();   --  13(D):������ʾ����
          instruct_0();   --  0(0)::�����(����)
					return ;
				end

        if instruct_6(204,333,0,1) ==false then    --  6(6):ս��[204]������ת��:Label1
            instruct_0();   --  0(0)::�����(����)
            instruct_13();   --  13(D):������ʾ����
            instruct_1(2999,0,1);   --  1(1):[AAA]˵: ����ֵĽ��������뻯����*����������
            instruct_0();   --  0(0)::�����(����)
            instruct_1(3000,195,0);   --  1(1):[???]˵: ��ʦ�֣���ʦ�֡���
            instruct_0();   --  0(0)::�����(����)
            instruct_1(3001,249,0);   --  1(1):[???]˵: �л�ɽ�ɵ������ˣ���Ҫ��*�ˣ���ס�����ǲ�����κ�*�������ң�
            instruct_0();   --  0(0)::�����(����)
            instruct_14();   --  14(E):�������
            instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [2]
            instruct_3(-2,4,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [4]
            instruct_3(57,17,1,0,0,0,0,7018,7018,7018,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [17]
            instruct_3(57,19,1,0,0,0,0,7150,7150,7150,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [19]
            instruct_3(57,20,1,0,0,0,0,7158,7158,7158,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [20]
            instruct_3(57,18,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [18]
            instruct_3(57,23,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [23]
            instruct_3(57,21,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [21]
            instruct_3(57,22,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [22]
            instruct_3(57,24,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [24]
            instruct_3(57,28,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [28]
            instruct_3(57,27,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [27]
            instruct_3(57,26,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [26]
            instruct_3(57,25,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [25]
            instruct_3(57,6,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [6]
            instruct_3(57,5,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [5]
            instruct_3(57,2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [2]
            instruct_3(57,15,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [15]
            instruct_3(57,29,0,0,0,0,755,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [29]
            instruct_0();   --  0(0)::�����(����)
            instruct_13();   --  13(D):������ʾ����
			                                AddPersonAttrib(35, "��������", 30);
					QZXS("����屻��������̼����������������30��");
            instruct_1(3002,35,0);   --  1(1):[�����]˵: ���ʲô�£��Ż����ŵġ�
            instruct_0();   --  0(0)::�����(����)
            instruct_1(3003,195,0);   --  1(1):[???]˵: ��ʦ�֣������ˣ��ɲ�����*�����������������죬Ҫ��*ʦ���ó�����֮λ��
            instruct_0();   --  0(0)::�����(����)
            instruct_1(3004,35,0);   --  1(1):[�����]˵: ʲô��*�ߣ�����ȥ������
            instruct_0();   --  0(0)::�����(����)
            instruct_14();   --  14(E):�������
            instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [4]
            instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [3]
            instruct_0();   --  0(0)::�����(����)
            instruct_13();   --  13(D):������ʾ����
            do return; end
        end    --:Label1

        instruct_0();   --  0(0)::�����(����)
        instruct_13();   --  13(D):������ʾ����

        if instruct_29(35,150,9999,0,332) ==true then    --  29(1D):�ж����������150-9999������ת��:Label2
            instruct_1(2999,0,1);   --  1(1):[AAA]˵: ����ֵĽ��������뻯����*����������
            instruct_0();   --  0(0)::�����(����)
            instruct_1(3000,195,0);   --  1(1):[???]˵: ��ʦ�֣���ʦ�֡���
            instruct_0();   --  0(0)::�����(����)
            instruct_1(3001,249,0);   --  1(1):[???]˵: �л�ɽ�ɵ������ˣ���Ҫ��*�ˣ���ס�����ǲ�����κ�*�������ң�
            instruct_0();   --  0(0)::�����(����)
            instruct_14();   --  14(E):�������
            instruct_3(-2,2,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [2]
            instruct_3(-2,4,0,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [4]
            instruct_3(57,17,1,0,0,0,0,7018,7018,7018,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [17]
            instruct_3(57,19,1,0,0,0,0,7150,7150,7150,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [19]
            instruct_3(57,20,1,0,0,0,0,7158,7158,7158,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [20]
            instruct_3(57,18,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [18]
            instruct_3(57,23,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [23]
            instruct_3(57,21,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [21]
            instruct_3(57,22,1,0,0,0,0,5182,5182,5182,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [22]
            instruct_3(57,24,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [24]
            instruct_3(57,28,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [28]
            instruct_3(57,27,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [27]
            instruct_3(57,26,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [26]
            instruct_3(57,25,1,0,0,0,0,7160,7160,7160,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [25]
            instruct_3(57,6,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [6]
            instruct_3(57,5,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [5]
            instruct_3(57,2,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [2]
            instruct_3(57,15,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [15]
            instruct_3(57,29,0,0,0,0,755,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[��ɽ��]:�����¼���� [29]
            instruct_0();   --  0(0)::�����(����)
            instruct_13();   --  13(D):������ʾ����
			                                AddPersonAttrib(35, "��������", 30);
					QZXS("����屻��������̼����������������30��");
            instruct_1(3002,35,0);   --  1(1):[�����]˵: ���ʲô�£��Ż����ŵġ�
            instruct_0();   --  0(0)::�����(����)
            instruct_1(3003,195,0);   --  1(1):[???]˵: ��ʦ�֣������ˣ��ɲ�����*�����������������죬Ҫ��*ʦ���ó�����֮λ��
            instruct_0();   --  0(0)::�����(����)
            instruct_1(3004,35,0);   --  1(1):[�����]˵: ʲô��*�ߣ�����ȥ������
            instruct_0();   --  0(0)::�����(����)
            instruct_14();   --  14(E):�������
            instruct_3(-2,4,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [4]
            instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [3]
            instruct_0();   --  0(0)::�����(����)
            instruct_13();   --  13(D):������ʾ����
            do return; end
            instruct_0();   --  0(0)::�����(����)
        end    --:Label2

        instruct_1(2998,249,0);   --  1(1):[???]˵: �����������С�����ٽ���*���У��ٺ����ȹ���
        instruct_0();   --  0(0)::�����(����)
        instruct_14();   --  14(E):�������
        instruct_47(35,20);   --  47(2F):��������ӹ�����20
        instruct_48(35,50);   --  48(30):�������������50
        instruct_13();   --  13(D):������ʾ����
        do return; end
    end    --:Label0

    instruct_0();   --  0(0)::�����(����)
end


--�����壺�ﲮ�⣬��ɽ����������Сʦ��
OEVENTLUA[8017] = function()
	if inteam(29) and GetS(86,10,11,5) == 2 then
		Talk(CC.LTalk115, 29);
		say3(CC.LTalk116, 346, "����");
		Talk(CC.LTalk117, 29);
		
		instruct_3(-2, 40, 1, 0, 0, 0, 0, 2968*2, 2968*2, 2968*2, 0, 0, 0);
		instruct_3(-2, 41, 1, 0, 0, 0, 0, 5196, 5196, 5196, 0, 0, 0);
		instruct_3(-2, 42, 1, 0, 0, 0, 0, 5196, 5196, 5196, 0, 0, 0);
		
		Talk(CC.LTalk118, 21);
		
		if WarMain(242) == false then			--ս���У�ʧ������
			instruct_15();
			return;
		end
		
		Talk(CC.LTalk119, 29);
		Talk(CC.LTalk120, 21);
		Talk(CC.LTalk121, 29);
		
		instruct_3(-2, 43, 1, 0, 0, 0, 0, 4412*2, 4412*2, 4412*2, 0, 0, 0);
		MyTalk(CC.LTalk122, 593);		--
		
		if WarMain(243) then		--ս�������
			Talk(CC.LTalk123, 0);
			Talk(CC.LTalk124, 29);
			Talk(CC.LTalk125, 0);
			
			
			QZXS(JY.Person[29]["����"] .. " ѧ��ָ���˵�");
      GRTS[29] = "�˵�"
      GRTSSAY[29] = "Ч�������ι����л��ʴ���˵���ʽ*��������������50 ��������500*���ģ�����12�� ����500��"
			
			SetS(86,10,12,5,1);		--�����˸�
		else	--ս��
			MyTalk(CC.LTalk126, 593);
			lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_RED, 128)
      ShowScreen()
      lib.Delay(80)
      lib.ShowSlow(15, 1)
      Cls()
      lib.ShowSlow(100, 0)
      
      Talk(CC.LTalk127, 29);			--������������������ݶ���ͺ¿��
      JY.Person[29]["�Ա�"] = 2
      local add, str = AddPersonAttrib(29, "������", -15)
      DrawStrBoxWaitKey(JY.Person[29]["����"] .. str, C_ORANGE, CC.DefaultFont)
      add, str = AddPersonAttrib(29, "������", -15)
      DrawStrBoxWaitKey(JY.Person[29]["����"] .. str, C_ORANGE, CC.DefaultFont)
      
      QZXS(JY.Person[29]["����"] .. " ѧ��ָ���ɫ");
      GRTS[29] = "��ɫ"
      GRTSSAY[29] = "Ч�������غ������ͼ����ٶ���ߣ��ܵ��˺�����*��������������50 ��������500*���ģ�����10�� ����500��"
      
      SetS(86,10,12,5,2);		--���˸�
        
        
		end
		
		instruct_14();
		instruct_3(-2,7,0,0,0,0,0,0,0,0,0,0,0);			--�����ͼ
		instruct_3(-2,38,0,0,0,0,0,0,0,0,0,0,0);			--�����ͼ
		instruct_3(-2,39,0,0,0,0,0,0,0,0,0,0,0);			--�����ͼ
		instruct_3(-2,40,0,0,0,0,0,0,0,0,0,0,0);			--�����ͼ
		instruct_3(-2,41,0,0,0,0,0,0,0,0,0,0,0);			--�����ͼ
		instruct_3(-2,42,0,0,0,0,0,0,0,0,0,0,0);			--�����ͼ
		instruct_3(-2,43,0,0,0,0,0,0,0,0,0,0,0);			--�����ͼ
		instruct_13();
	end
end

--��д�����¹������¼�
OEVENTLUA[50] = function()

	local title = "������";
	local str = "�Ա��и������䣬��Ҫ��Щʲô��*������100������1�����*�ȱ����ж��پ����*͵�ԣ�����5����µ�100��*���٣�ȫ���˲���˵";
	local btn = {"����","�ȱ�","͵��","����", "·��"};
	local num = #btn;
	local r = JYMsgBox(title,str,btn,num);
	
	--���������������80
	if r == 1 then
		--instruct_1(236,0,1);			--����̫����Ҳûɶ�ã��ó�*100����������ҵ�ɡ�
		Talk("����̫����Ҳûɶ�ã��ó�*100����������ҵ��",0);
		instruct_0();
		if instruct_31(100) then			--��û�г���100��
			instruct_2(174,-100);		--��Ʒ[����]+[-100]
			if JY.Person[0]["Ʒ��"] < 65 then
	      instruct_37(1)
	    end
	  else
			instruct_1(237, 0, 1);
			instruct_0();
		end
	elseif r ==  2 then		--�ȱ�������Ϊ���80
		Talk("�������ڸû��ĵط�Ҳ��һ������",0);
		local gold = 0;
		for i=JY.Person[0]["Ʒ��"]+1, 65 do
			if JY.GOLD - gold >= 100 then			--��û�г���100��
				gold = gold + 100;
				JY.Person[0]["Ʒ��"] = i;
			end
		end
		instruct_2(174,-gold);
	elseif r == 3 then		--͵�ԣ�����5����µ�100��
		if instruct_28(0, 5, 999, 6, 0) == false then
	    instruct_1(235, 0, 1)
	    return 
	    instruct_0()
	  end
	  instruct_1(234, 0, 1)
	  instruct_0()
	  if instruct_11(0, 8) == true then
	    instruct_0()
	    if putong() ~= 6 then		--����û��Ǯ��
	    	instruct_2(174, 100)
	    end
	    instruct_0()
	    instruct_37(-5)
	    return 
	  end
		
	elseif r == 4 then			--���٣����ݵ����жϣ�ÿ�μ�5��
		if instruct_28(0, 5, 999, 6, 0) == false then
	    instruct_1(235, 0, 1)
	    return 
	    instruct_0()
	  end
		Talk("��˭�����ӣ�û��Ӧ�����˰���",0);
		local gold = 0;
		for i=JY.Person[0]["Ʒ��"]-5, 0, -5 do
			if putong() ~= 6 then		--����û��Ǯ��
	    	gold = gold + 100;
	    end
	    JY.Person[0]["Ʒ��"] = i;
		end
		if gold > 0 then
			instruct_2(174, gold);
		end
	end
	
end

OEVENTLUA[484] = function()		--��������þ���

    if instruct_28(0,80,999,11,0) ==false then    --  28(1C):�ж�AAAƷ��80-999������ת��:Label0
        instruct_1(1940,55,0);   --  1(1):[����]˵: ��֮���ߣ�Ϊ��Ϊ��
        instruct_0();   --  0(0)::�����(����)
        instruct_1(1941,56,0);   --  1(1):[����]˵: ����磬˵�úã�
        instruct_0();   --  0(0)::�����(����)
        do return; end
    end    --:Label0

    instruct_37(1);   --  37(25):���ӵ���1
    instruct_1(1936,55,0);   --  1(1):[����]˵: �ֵܣ�������������Ƿ�˳*����
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1937,244,1);   --  1(1):[???]˵: ����˵ʵ�������������˲�*�����Ѱ���
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1938,56,0);   --  1(1):[����]˵: ����磬����ȥ������ɡ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1939,55,0);   --  1(1):[����]˵: �ã������д��⡣�ֵܲ���*���ģ��Ҷ������ȥС�壬*����һ��֮����
    instruct_0();   --  0(0)::�����(����)
    instruct_14();   --  14(E):�������
    instruct_3(104,45,1,0,967,0,0,7238,7238,7238,-2,-2,-2);   --  3(3):�޸��¼�����:����[���㵺]:�����¼���� [45]
    instruct_3(104,52,1,0,968,0,0,7240,7240,7240,-2,-2,-2);   --  3(3):�޸��¼�����:����[���㵺]:�����¼���� [52]
    instruct_3(-2,42,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [42]
    instruct_3(-2,41,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [41]
    instruct_3(70,13,1,0,147,0,0,6088,6088,6088,-2,-2,-2);   --  3(3):�޸��¼�����:����[С��]:�����¼���� [13]
    instruct_3(70,14,1,0,149,0,0,6090,6090,6090,-2,-2,-2);   --  3(3):�޸��¼�����:����[С��]:�����¼���� [14]
    instruct_0();   --  0(0)::�����(����)
    instruct_13();   --  13(D):������ʾ����
	instruct_2(84,1);   --  2(2):�õ���Ʒ[�����澭][1]
	instruct_2(354,1)
end

OEVENTLUA[499] = function()		--������������
    instruct_1(2141,68,0);   --  1(1):[�𴦻�]˵: ���߽���������Ҫ�ľ���ʹ*�Լ�����������֮�ϡ�
    instruct_0();   --  0(0)::�����(����)

    if instruct_28(0,90,999,2,0) ==false then    --  28(1C):�ж�AAAƷ��90-999������ת��:Label0
        do return; end
        instruct_0();   --  0(0)::�����(����)
    end    --:Label0

    instruct_14();   --  14(E):�������
    instruct_3(-2,27,1,0,0,0,0,7102,7102,7102,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [27]
    instruct_0();   --  0(0)::�����(����)
    instruct_13();   --  13(D):������ʾ����
    instruct_30(38,25,39,25);   --  30(1E):�����߶�38-25--39-25
    instruct_30(39,25,39,22);   --  30(1E):�����߶�39-25--39-22
    instruct_1(1995,0,1);   --  1(1):[AAA]˵: ���μ���������
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1996,129,0);   --  1(1):[???]˵: ���ض������ڽ����ϵ���*�������ж��ţ��ҽ��յ���*����������ҪѰ�Һ��ʵĴ�*��
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1997,0,1);   --  1(1):[AAA]˵: ǰ������˼�ǡ���
    instruct_0();   --  0(0)::�����(����)
    instruct_1(1998,129,0);   --  1(1):[???]˵: ���������Ϊ�����ƴ�����*�������칦���ʹ��ڸ����*��
    instruct_0();   --  0(0)::�����(����)
    instruct_2(77,1);   --  2(2):�õ���Ʒ[���칦����][1]
    instruct_0();   --  0(0)::�����(����)
    instruct_3(-2,27,0,0,0,0,0,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [27]
    instruct_3(-2,0,1,0,497,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [0]
    instruct_0();   --  0(0)::�����(����)
end

OEVENTLUA[505] = function()	 --ŷ��������������
    instruct_26(61,0,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
    instruct_26(61,8,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
    instruct_26(61,17,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
    instruct_26(61,16,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
    instruct_1(2075,0,1);   --  1(1):[AAA]˵: ���μ��ð���
    instruct_0();   --  0(0)::�����(����)
    instruct_1(2076,67,0);   --  1(1):[��ǧ��]˵: ����˭�����˺θɣ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(2077,0,1);   --  1(1):[AAA]˵: ���������ɽ����ŷ������*�������ģ���˵��������Ȼ*֪����
    instruct_0();   --  0(0)::�����(����)
    instruct_1(2078,67,0);   --  1(1):[��ǧ��]˵: Ŷ����ŷ������������֪��*��֪����
    instruct_0();   --  0(0)::�����(����)
    instruct_1(2079,0,1);   --  1(1):[AAA]˵: �����ı�����ô��ô��֣�*��
    instruct_0();   --  0(0)::�����(����)
    instruct_1(2080,67,0);   --  1(1):[��ǧ��]˵: ��ŷ�������Լ�ã���һ��*�ܳ���ס�����Ƶ��ˣ�����*֮������ȥ�Ҷλ�ү���ˣ�*�����书�����Ա�û�����*�λ�ү������ǰ�������Ѵ�*�˻��أ��λ�үӦ���Ѿ���*�������ˣ����С�ӡ�����
    instruct_0();   --  0(0)::�����(����) 
	TalkEx("ŷ�����������ð���������������˫���Ṧ�˵�...������ƨ��...��˵ǰ����ָ��������֪����",0,1)	
	instruct_0();
    instruct_1(2082,67,0);   --  1(1):[��ǧ��]˵: ��������С�ӣ���ŷ������*�˻���֪����������������*�ֳ����λ�үҲ�á�������*˵ʲô�����ƣ��Ǻǣ���Ȼ*���á����֪���ϵ۶λ�ү*��
    instruct_0();   --  0(0)::�����(����)
	TalkEx("������������׹����<���˹ҵ���������������û������>",0,1)
    instruct_0();   --  0(0)::�����(����)
	say("��ָ����һ������ȥ����ɱ�˶λ�ү",67,0,"��ǧ��") 	
    instruct_0(); 
	TalkEx("���������������Ƕλ�ү�Ķ��֣�<�Ҵ�ù���Ͱѻ���а��ŷ����ɷ���>",0,1)
    instruct_0();   --  0(0)::�����(����)
	say("���ģ�������Ӧ���Ѿ�����ȫʧ�ˣ���ֻҪ�ܴ������ļ������������ˡ�",67,0,"��ǧ��") 	
    instruct_0(); 	
	TalkEx("��ŶŶŶ�������Ļ��ᣬ��������һ����������������ӣ����Ҳ�֪������",0,1)
    instruct_0();   --  0(0)::�����(����)	
	AddPersonAttrib(zj(), "�Ṧ", 5)	
	QZXS(JY.Person[zj()]["����"].."�Ṧ����5��")	
    instruct_0();   --  0(0)::�����(����)
    instruct_1(2088,67,0);   --  1(1):[��ǧ��]˵: �λ�ү���ڳ����ˣ�����ǰ*�ߵĴ�������Ž�һ�ơ�
    instruct_0();   --  0(0)::�����(����)
    instruct_3(-2,-2,1,0,506,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
    instruct_3(47,13,0,0,0,0,507,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:����[һ�ƾ�]:�����¼���� [13]
    instruct_3(47,5,1,0,482,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:����[һ�ƾ�]:�����¼���� [5]
    instruct_3(47,8,0,0,0,0,0,8002,8002,8002,-2,-2,-2);   --  3(3):�޸��¼�����:����[һ�ƾ�]:�����¼���� [8]
    instruct_3(47,7,0,0,0,0,0,8004,8004,8004,-2,-2,-2);   --  3(3):�޸��¼�����:����[һ�ƾ�]:�����¼���� [7]
	SetS(40,17,35,3,99)
	JY.Person[60]["����"] = 104
JY.Person[60]["�书5"] = 104
JY.Person[60]["�书�ȼ�5"] = 999
JY.Person[620]["����"] = 104
JY.Person[620]["�书5"] = 104
JY.Person[620]["�书�ȼ�5"] = 999	
end

OEVENTLUA[510] = function()		--���а������
	instruct_14();
	instruct_13();
    instruct_37(-3);   --  37(25):���ӵ���-3
    instruct_26(61,0,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
    instruct_26(61,8,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
    instruct_26(61,17,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
    instruct_26(61,16,1,0,0);   --  26(1A):���ӳ����¼���ŵ����������¼����
	instruct_30(41,31,41,26);
	Talk(CC.BTalk303,0);
	instruct_14();
	instruct_3(-2,27,0,0,0,0,0,7102,7102,7102,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [27]
    instruct_0();   --  0(0)::�����(����)
	instruct_13();
    instruct_1(2125,129,0);   --  1(1):[???]˵: ���˸���������������Ұ��
    instruct_0();   --  0(0)::�����(����)
    instruct_1(2126,123,0);   --  1(1):[???]˵: ʦ�����������ţ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(2127,64,0);   --  1(1):[�ܲ�ͨ]˵: ʦ�֣�������㣬̫���ˡ���
    instruct_0();   --  0(0)::�����(����)
    instruct_1(2128,57,0);   --  1(1):[��ҩʦ]˵: �������ˣ���Υ��
    instruct_0();   --  0(0)::�����(����)
    instruct_1(2129,69,0);   --  1(1):[���߹�]˵: �������ˣ���������Ͻл�*��������
    instruct_0();   --  0(0)::�����(����)
    instruct_1(2130,129,0);   --  1(1):[???]˵: ƶ��թ�����ø�λ�����ˡ�*�������Ǵ�����֣��Ը���*������
    instruct_0();   --  0(0)::�����(����)

    if instruct_6(185,3,0,0) ==false then    --  6(6):ս��[185]������ת��:Label3
        instruct_15(0);   --  15(F):ս��ʧ�ܣ�����
        do return; end
	end    --:Label3

    instruct_0();   --  0(0)::�����(����)
    instruct_13();   --  13(D):������ʾ����
    instruct_1(2131,129,0);   --  1(1):[???]˵: ���ǳ���������ǰ�ˣ�����*�����������ˣ�
    instruct_0();   --  0(0)::�����(����)
    instruct_14();   --  14(E):�������
	instruct_3(-2,25,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [25]
	instruct_3(-2,31,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [31]
	instruct_3(-2,26,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [26]
    instruct_3(-2,27,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [27]
    instruct_3(-2,28,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [28]
    instruct_3(-2,29,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [29]
    instruct_3(-2,30,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [30]
	instruct_3(-2,32,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [32]
	instruct_3(-2,33,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [33]
    instruct_0();   --  0(0)::�����(����)
    instruct_13();   --  13(D):������ʾ����
    instruct_2(148,1);   --  2(2):�õ���Ʒ[���mӢ�۴�][1]
    instruct_0();   --  0(0)::�����(����)
    instruct_2(84,1);   --  2(2):�õ���Ʒ[�����澭][1]
	if GetS(111,0,0,0) == 0 then 
	    say("�������صù���ģ���Ȼ����ö�����",0) 
	    instruct_0();
			    if DrawStrBoxYesNo(-1, -1, "�Ƿ����������Ҫ��", C_WHITE, 30) == true then 
	                 QZXS("���������Ҫ��")
	                 instruct_0();
	                 SetS(111, 0, 0, 0,107)
				else
				     say("���Ѿ������޵У���������������",0) 
					 instruct_0()
				end	
	end
    instruct_0();   --  0(0)::�����(����)
    instruct_3(-2,0,1,0,228,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [0]
	SetS(2, 0, 0, 0, 1) --���а���ж�
end

OEVENTLUA[494] = function() --
    if instruct_16(63,6,0) ==false then    --  �ĳ�Ӣ
        instruct_1(1968,122,0);   --  1(1):[???]˵: �����ĳ�¶�����£�������*��������������һ���*�����³������ͰѴ��˴�*�����ҡ�
        instruct_0();   --  0(0)::�����(����)
        do return; end
    end    --:Label0

    instruct_1(1969,122,0);   --  1(1):[???]˵: ��������������������*��һ��ָ�书���鷨�����*���ĵĶ������ţ���������*���ɡ�
    instruct_0();   --  0(0)::�����(����)
    instruct_2(172,1);   --  2(2):�õ���Ʒ[һ��ָ��][1]
    instruct_0();   --  0(0)::�����(����)
	if instruct_16(81) then
		say("Ϊʲô�Ҿ����㿴������ô���죿",81,0,"�����") 
		instruct_0();   --  0(0)::�����(����)
		say("˵��������֮ǰ�����������أ�������",122,0,"��") 
		instruct_0();   --  0(0)::�����(����)
		say("����ü������ɷ�����Һ���������Ҳ��������ұ����ˡ����Ѩ���ַ��������������ͶԵ�ķ��ϣ��ʹ��ڸ����ˡ�",122,0,"��") 
		instruct_0();   --  0(0)::�����(����)
		say("лл....",81,0,"�����") 
		instruct_0();   --  0(0)::�����(����)
		--JY.Person[81]["������"] = JY.Person[81]["������"]+50
		JY.Person[81]["�������"] = JY.Person[81]["�������"]+40
		JY.Person[81]["ȭ�ƹ���"] = JY.Person[81]["ȭ�ƹ���"]+20	
        instruct_35(81,1,81,0)
		JY.Person[81]["�书�ȼ�1"] = 900;
		QZXS("�����ȭ�ƺ���ϵֵ���ӣ�")
		QZXS("�����ѧ����һ��ָ�飡")		
		instruct_0();   --  0(0)::�����(����)
	end
    instruct_3(-2,-2,1,0,495,0,0,-2,-2,-2,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ����:��ǰ�����¼����
end

OEVENTLUA[17] = function()
    instruct_1(155,3,0);   --  1(1):[���˷�]˵: С�ֵܣ����߽����ǵö���*�����塣
    instruct_0();   --  0(0)::�����(����)
end


OEVENTLUA[487] = function()
    instruct_1(1958,69,0);   --  1(1):[���߹�]˵: ��ʵ��ؤҲ�Ǹ�����ǰ;��*ְҵ�������ϲ��������ȥ*ؤ�ﱨ����
    instruct_0();   --  0(0)::�����(����)
end

OEVENTLUA[842] = function()
    instruct_14();   --14(E):�������
    instruct_13();   --  13(D):������ʾ����
    instruct_25(25,42,31,36);   --  25(19):�����ƶ�25-42--31-36
    instruct_1(3350,161,0);   --  1(1):[161��Ī��]:һ����Ѿͷ�����и�ȳ����*���ٺ٣�����а��Ȼ����Щ*ŧ���������ӣ������϶���*���ۡ�
    instruct_0();   --  0(0)::�����(����)
    instruct_1(3351,236,0);   --  1(1):[236���½�ͽ]:����Ī˵�Ҷ�ʦ������
    instruct_0();   --  0(0):�����(����)
    instruct_1(3352,161,0);   --  1(1):[161��Ī��]:�˼��粻Ҫ���������ˣ���*����ʦ������ʦ�̵ģ�Ҳ��*����Ц�������ݡ�
    instruct_0();   --  0(0)::�����(����)
    if inteam(78) and inteam(92) and LWS(92) then
       say("�����Ҿ������ʶ��ʶ�������һ����书!",78,0,"÷����") 
       say("����һ��! ��Ī��! ���ҵ�������!",92,0,"½��˫") 
       instruct_0();   --  0(0)::�����(����)
       if instruct_6(52,5,0,0) == false then   --   6(6):ս��[52��Ӣ��ս��Ī��] ʤ����תLabel1
       instruct_0();   --  0(0)::�����(����)
       instruct_15()  --����
       do return end  --�����������¼�
    end
    AddPersonAttrib(78, "ȭ�ƹ���", 16)
    AddPersonAttrib(78, "��������", 16)
    AddPersonAttrib(78, "ˣ������", 16)
    AddPersonAttrib(78, "�������", 16)
    AddPersonAttrib(78, "��������", 16)
    AddPersonAttrib(78, "������", 40)	
    AddPersonAttrib(78, "������", 40)	
    AddPersonAttrib(78, "�Ṧ", 40)	
    QZXS("÷������ά������ֵ����16, �����������40.")	
    AddPersonAttrib(92, "ȭ�ƹ���", 16)
    AddPersonAttrib(92, "��������", 16)
    AddPersonAttrib(92, "ˣ������", 16)
    AddPersonAttrib(92, "�������", 16)
    AddPersonAttrib(92, "��������", 16)
    AddPersonAttrib(92, "������", 40)	
    AddPersonAttrib(92, "������", 40)	
    AddPersonAttrib(92, "�Ṧ", 40)
    QZXS("½��˫��ά����ֵ������16, �����������40.")
    AddPersonAttrib(63, "ȭ�ƹ���", 3)
    AddPersonAttrib(63, "��������", 3)
    AddPersonAttrib(63, "ˣ������", 3)
    AddPersonAttrib(63, "�������", 3)
    AddPersonAttrib(63, "��������", 3)
    AddPersonAttrib(63, "������", 8)	
    AddPersonAttrib(63, "������", 8)	
    AddPersonAttrib(63, "�Ṧ", 8)
    QZXS("��Ӣ��ά����ֵ������3, �����������8.")
    addthing(330, 1)    --�õ����������ؼ�  
    addthing(282, 1)    --�õ�����������ؼ�
    elseif instruct_16(78,0,8) == true then       -- 16(10):�ж϶����Ƿ���[78÷����]?������תLabel0
       instruct_1(3353,78,0);   --1(1):[78÷����]:˭��˵�Ҷ�ʦ����ʹ������*������ͽ�ܣ�����Ҳ��Զ��*������ʦ��
       instruct_0();   --  0(0)::�����(����)
       say("�����Ҿ������ʶ��ʶ�������һ����书!",78,0,"÷����") 
       instruct_0();   --  0(0)::�����(����)
       say("÷�����������!") 
       if instruct_6(52,5,0,0) == false then   --   6(6):ս��[52��Ӣ��ս��Ī��] ʤ����תLabel1
       instruct_0();   --  0(0)::�����(����)
       instruct_15()  --����
       do return end  --�����������¼�
    end
    AddPersonAttrib(78, "ȭ�ƹ���", 10)
    AddPersonAttrib(78, "��������", 10)
    AddPersonAttrib(78, "ˣ������", 10)
    AddPersonAttrib(78, "�������", 10)
    AddPersonAttrib(78, "��������", 10)
    QZXS(JY.Person[78]["����"].."��ά����ֵ������10.")
    say("ʦ��! ͽ��֪����! ���һ����书���Ⱦ����澭��, ͽ����ͷ�ȥ�������о����澭���书!",78,0,"÷����") 
    QZXS("÷�����ԷϾ����׹�צ!");
    JY.Person[78]["�书1"] = 0
    JY.Person[78]["�书�ȼ�1"] = 0 
    elseif inteam(92) and LWS(92) then    --:Label0
       instruct_0();   --  0(0)::�����(����)
       say("��Ī��! ���ҵ�������!",92,0,"½��˫") 
       say("С˫˫��������!") 
       if instruct_6(52,5,0,0) == false then   --   6(6):ս��[52��Ӣ��ս��Ī��] ʤ����תLabel1
       instruct_0();   --  0(0)::�����(����)
       instruct_15()  --����
       do return end  --�����������¼�
    end
    AddPersonAttrib(92, "ȭ�ƹ���", 10)
    AddPersonAttrib(92, "��������", 10)
    AddPersonAttrib(92, "ˣ������", 10)
    AddPersonAttrib(92, "�������", 10)
    AddPersonAttrib(92, "��������", 10)
    QZXS("½��˫��ά����ֵ������10.")
    say("ԭ�������ħͷֻ�������ܵ�ʱ��ſ�¶�����۹�Ĺ�����޵�����, ����!",92,0,"½��˫") 
    QZXS("½��˫�����Ĺ�Ṧ���޵���");
    instruct_35(92,0,119,0)	
    else
    instruct_1(3354,245,1);   --   1(1):[����]:��а��ҩʦ��������������*��������ǲ�֪��ߵغ�
    instruct_0();   --  0(0)::�����(����) 
    instruct_1(3355,161,0);  --   1(1):[161��Ī��]:�ߣ���������֪��ν��С��*��ȥ���ɣ�
    instruct_0();   --  0(0)::�����(����) 
    if instruct_6(52,5,0,0) == false then   --   6(6):ս��[52��Ӣ��ս��Ī��] ʤ����תLabel1
       instruct_0();   --  0(0)::�����(����)
       instruct_15()  --����
       do return end  --�����������¼�
    end
    end
    instruct_0();   --  0(0)::�����(����)
    instruct_19(30,37);   --  19(13):�����ƶ���30-37
    instruct_40(1);   --  40(28):�ı�����վ������1
    instruct_3(-2,3,0,0,0,0,0,0,0,0,0,0,0);   --  3(3):�޸��¼�����:��ǰ����:�����¼���� [3]
    instruct_0();   --  0(0)::�����(����)
    instruct_1(3356,247,1);   --   1(1):[����]:�ף����������һ���顭��*����������Ī�������˾�Ȼ*���������Ҳ���Ǵ�˵��*����ô���
    instruct_0();   --  0(0)::�����(����)
    instruct_2(110,1);   --  2(2):�õ���Ʒ[�嶾�ش�][1]
    instruct_0();   --  0(0)::�����(����)
    instruct_3(-2,2,0,0,0,0,846,0,0,0,-2,-2,-2);   --  3(3):�޸��¼�����:��ǰ���������¼����[2]
    say("������׬����׬���ˣ�")
    end                       --1(FFFF):�¼�����
	
--�޾Ʋ��������Ÿĳɿɰ�
OEVENTLUA[369] = function()
	instruct_37(1)  --����Ʒ��
	say("ʲô�ˣ�", 199, 0,"��������")  --�Ի�
	Cls()  --����
	say("�������ҡ�", 0, 1)  --�Ի�
	Cls()  --����
	say("����˭�����ʲô��", 199, 0,"��������")  --�Ի�
	Cls()  --����
	say("����������һ���Ǹ�ʲô\"�����̻��\"��", 0, 1)  --�Ի�
	Cls()  --����
	say("ԭ������͵�Ƶģ�С�ӣ��żһ", 199, 0,"��������")  --�Ի�
	Cls()  --����
	if WarMain(166, 0) == false then  --ս����ʼ
		instruct_0();   --  0(0)::�����(����)
	end
	instruct_3(-2, 22,0,0,0,0,0,0,0,0,0,0,0)  --�޸ĳ����¼�
	instruct_3(-2, 23,0,0,0,0,0,0,0,0,0,0,0)  --�޸ĳ����¼�
	instruct_3(-2, 24,0,0,0,0,0,0,0,0,0,0,0)  --�޸ĳ����¼�
	Cls()  --����
	instruct_13()  --��������
	TalkEx("�����αر��Ҷ����أ��α��أ��Ρ����ء����ء�����", 0, 1)  --�Ի�
	Cls()  --����
	do return end
end

OEVENTLUA[511] = function()
	say("һ�ƴ�ʦ���Ƶ����������*����λ����������������", 0,1)  --�Ի�
	Cls()  --����
	say("����������֪����Ҫ�ҡ���*��Ӣ�۴���һ�飬�������*���������С�", 65,0)  --�Ի�
	Cls()  --����
	say("����", 0,1)  --�Ի�
	Cls()  --����
	say("��Ȼ���Ѿ���а����������*�������㡣", 69,0)  --�Ի�
	Cls()  --����
	say("����������֮ǰ�����ǻ�Ҫ*���̿�������书��", 57,0)  --�Ի�
	Cls()  --����
	say("��׼��������", 65, 0)  --�Ի�
	Cls()  --����
	if instruct_5(2,0) == true then
		say("�мܴ������ٵ����ң���", 64, 0)  --�Ի�
		Cls()  --����
		if WarMain(186) == false then
			say("������������Ŭ��һ������", 65, 0)  --�Ի�
			Cls()
		else
			say("�����书��ǿ����������*�����������������;��", 65, 0)
			Cls()
			addthing(148,1)
			if (MPPD(0) == 2 or JY.Person[0]["Ʒ��"] >= 95) and PersonKF(0,197) then
				say("�Ͻл������͵ľ�������������;֪�������ˣ�������", 69,0)  --�Ի�
				Cls()  --����
				say("�����������", 0,1)  --�Ի�
				Cls()  --����
				say("�������ƣ����������ܺúܺ�", 69,0)  --�Ի�
				Cls()  --����
				say("�Ͻл���Ī��������ͽ���ˣ�", 57,0)  --�Ի�
				Cls()  --����
				say("���ҿɲ��볶��������̶��ˮ", 69,0)  --�Ի�
				Cls()  --����
				say("���ⲻ�����Ͻл��������ְ����ٺ�", 69,0)  --�Ի�
				Cls()  --����
				say("�Ͻл��͸���úý�������ң�Ρ��������ϰ�", 69,0)  --�Ի�
				Cls()  --����
				if DrawStrBoxYesNo(-1, -1, "�Ƿ���ϸ������", C_WHITE, 30) == true then 
	                 QZXS("������ң������")
	                 instruct_0();
	                 setLW2(197)
					 addthing(111,1)
					 say("��л�������", 0,1)
				else
				    say("����־���ڴˣ�ϣ�������������", 0,1)
					Cls()  --����
					say("�������޷��޷�", 69,0)  --�Ի�
					Cls()  --����
				end	
			end
			instruct_26(61,16,1,0,0)
			instruct_26(61,0,1,0,0)
			instruct_26(61,8,1,0,0)
			instruct_26(61,17,1,0,0)
			instruct_3(-2, 0,1,0,499,0,0,-2,-2,-2,-2,-2,-2)  --�޸ĳ����¼�
			instruct_3(-2, 30,0,0,0,0,0,0,0,0,0,0,0)  --�޸ĳ����¼�
			instruct_3(-2, 29,0,0,0,0,0,0,0,0,0,0,0)  --�޸ĳ����¼�
			instruct_3(-2, 28,0,0,0,0,0,0,0,0,0,0,0)  --�޸ĳ����¼�
			instruct_3(23, 0,1,0,487,0,0,6122,6122,6122,-2,-2,-2)  --�޸ĳ����¼�
		end	
	end	
end
