--[[
10000 - stuff
20000 - team
30000 - trial patch, 0 - betray; 1 - teach; 2 - own MP
30010 on - quest
31000 - MP
����31000-31009��0-��ְ����1-ս����2-���ţ�3-����
ؤ��31010-31019��0��1-��ְ����3-����
�䵱31020-31029��0-���ţ�2-����
����31030-31039��0-���ţ�2-����
Ѫ��31040-31049��0-���ţ�1-����
��ң31050-31059��0-�������ţ�1-�������ţ�2-��������3-����а
����31052-31053
nevent105 - ��������
]]
OEVENTLUA[30000] = function() --�ѽ�
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
			say("�͹��������������ţ���ô���������Ӷ������أ�",220,0,"����С��") 			
		elseif (CC.MPDJ[MPPD(0)][MPDJ(0)] == "����") or (CC.MPDJ[MPPD(0)][MPDJ(0)] == "����") 
			or (CC.MPDJ[MPPD(0)][MPDJ(0)] == "ׯ��") or (CC.MPDJ[MPPD(0)][MPDJ(0)] == "����") then
			instruct_0()
			say("�͹��������������ţ���ô���������Ӷ������أ�",220,0,"����С��") 				
		else
			instruct_0()
			say("�͹������ƸǶ�ӡ�÷��ڣ����ձ���Ѫ��֮�֡�",220,0,"����С��") 	
			instruct_0()
			say("������ָ��һ��....���ˣ��϶��ǿ͹��������ڵ�ְҵ������",220,0,"����С��") 			
			instruct_0()
			say("����ȫ������⣬�뵱����Ҳ�����������ƹ�ģ����ȴ���䵽����ز���",220,0,"����С��") 	
			instruct_0()
			say("�л���˵����Ҫ�ѽ����Ҳ����ڽ�����Ŷ���������˼�����С����������ҿɲ��ܡ�",220,0,"����С��") 	
			instruct_0()
			if DrawStrBoxYesNo(-1, -1, "Ҫ�ѽ���", C_WHITE, 30) == true then	
				SetS(106, MPPD(0), 0, 0, 1)
				SetS(106, MPPD(0), 1, 0, 0)
				instruct_0()
				JY.Person[931]["����13"] = 1
				say("�͹����Ѿ�����"..tmp.."�ˣ���С�ġ�",220,0,"����С��")
				--[[
				for i = 1 , JY.PersonNum - 1 do
					if (MPPD(0) == 10 or MPPD(0) == 11) and MPPD(i) == MPPD(0) and inteam(i) then
						say("��ͽ���ߣ�",i) 				
						instruct_21(i) 
					end
                end 
				]]
				JoinMP(0, 0, 0)
			end
		end
	else
		instruct_0()
		say("�͹�������û�м����κ����ɡ�",220,0,"����С��") 	
	end
end

OEVENTLUA[30001] = function() --���Ѿ�ְ
	if MPPD(0) == 0 then
		instruct_0()
		say("�͹�������û�м����κ����ɡ�",220,0,"����С��") 	
		do return end
	end
	local tmp = ""
	if ownMP() and MPPD(0) == 63 then
		tmp = ownMPstat(1)[1]
	else
		tmp = CC.MP[MPPD(0)][1]
	end
	instruct_0()
	say("�͹�����ɶ�Ը���",220,0,"����С��") 	
	instruct_0()
	say("Ҫ����ָ������"..tmp.."���书�����ҿ�������û����ҵ�ʸ�....",220,0,"����С��") 
	local teamnum = 1
	for i = 2, CC.TeamNum do
		if JY.Base["����" .. i] > 0 then
			teamnum = teamnum + 1
		end
	end
	if teamnum < 2 then
		instruct_0()
		say("��������û�к��ʵ�ѧ����",220,0,"����С��") 			
		do return end	
	end
	if MPPD(0) ~= 0 and MPDJ(0) > 1 then
		local menu = {}
		local PD = false
		for i = 1, teamnum do
			local pid = JY.Base["����" .. i]
			menu[i] = {JY.Person[pid]["����"], nil, 0, pid}
		end

		for i = 2, teamnum do
			if MPReq(menu[i][4], MPPD(0)) and MPPD(menu[i][4])== 0 then
				menu[i][3] = 1
				PD = true
			end
		end
		if PD == false then
			instruct_0()
			say("��������û�к��ʵ�ѧ����",220,0,"����С��") 			
			do return end		
		end
		Cls();
		DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY,"ѡ���ڿζ���", C_WHITE, CC.DefaultFont);		
		local r = ShowMenu(menu,#menu,0,CC.MainSubMenuX,CC.MainSubMenuY+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
		if r < 1 then
			instruct_0()
			say("�������𣿺ðɡ�",220,0,"����С��") 		
			do return end
		else
			local pid = menu[r][4]
			if MPPD(0) == 7 then 
			JoinMP(pid, MPPD(0), 1)
			else 
			JoinMP(pid, MPPD(0), MPDJ(0) - 1)
			end
			if MPPD(0) == 11 then
			   JY.Person[pid]["�书1"] = 131
			   JY.Person[pid]["�书�ȼ�1"] = 999
			end   
			instruct_0()
			say(JY.Person[pid]["����"].."ѧ����"..tmp.."�ļ��ܡ�",220,0,"����С��") 			
		end
		
	else
		instruct_0()
		say("�ܱ�Ǹ������ʱû����ҵ���ʸ�",220,0,"����С��") 	
	end
end

OEVENTLUA[30002] = function() --�Դ�����
	local yes = 0	
	if math.random(300) == 150 and MPPD(0) == 0 and GetS(106, 0, 0, 0) ~= 1 and tianshu() >= 8
		and JY.Person[zj()]["ʵս"] >= 500 then
		local count = 0		
		for i = 1, CC.HZNum do --Ҫ����
			if hasHZ(i) then --and i ~= 21 and i ~= 15 then �������ǣ�����BUG
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
	say("��ǰ��һƬ������ˮ����������������ѧ������ӳ����һ��˼���������������һ��治ǳ��")
	Cls()
	say("�뵱���ҳ���é®֮ʱ�������º���Ҫվ����ѧ֮�ۡ������������������˵����������ɳ�������ܿ������ɣ�����Ϊ�β��ܣ�")
	Cls()		
	if DrawStrBoxYesNo(-1, -1, "Ҫ����������", C_WHITE, 30) == false then		
		do return end
	end	
	Cls()
	say("Ӧ�ø��ҵ��������ʲô���������أ�")		
	Cls()
	JY.Wugong[wugong]["����"] = "";
	while JY.Wugong[wugong]["����"] == "" do
		JY.Wugong[wugong]["����"] = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
		if JY.Wugong[wugong]["����"] == "" then
			DrawStrBoxWaitKey("������������һ������", C_WHITE, 30)
		end
	end
	
	Cls()
	say("�ҵ�����Ӧ�ò����ĸ������أ�")				
	local menu = {
		{"����", nil, 1},
		{"����", nil, 1},
		{"����", nil, 1},
		{"ҽ��", nil, 1},
		{"�ö�", nil, 1},
		{"�ⶾ", nil, 0},
		{"����", nil, 1},
		{"����", nil, 1},
		{"����", nil, 1},
	}
	local r = ShowMenu3(menu,#menu,8,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"��ѡ�����ɲ��ص�","",M_DimGray,C_RED)
	for i = 1, 3 do
		JY.Wugong[wugong]["ɱ����"..i] = 10
	end
	for i = 4, 7 do
		JY.Wugong[wugong]["ɱ����"..i] = 0
		
	end		
	for i = 8, 9 do
		JY.Wugong[wugong]["ɱ����"..i] = 10
	end		
	if (r >= 1 and r <= 3) or (r >= 8 and r <= 9) then
		JY.Wugong[wugong]["ɱ����"..r] = 11
	end
	if r >= 4 and r <= 7 then
		JY.Wugong[wugong]["ɱ����"..r] = 1000
	end
	
	
	Cls()
	say("�ҵ�����Ӧ��������Щ�����أ�")			
	Cls()
	local menu = {}
	for i = 1, #CC.HZ do
		menu[i] = {}
		if hasHZ(i) then --i ~= 21 and i ~= 15 then �������ǣ�����BUG
			menu[i][1] = CC.HZ[i][2]
			menu[i][3] = 1
		else
			menu[i][1] = "�޷�ʹ��"
			menu[i][3] = 2			
		end
	end
	for i = 1, 5 do
		Cls()
		--local r = ShowMenu3(menu,#menu,7,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"��ѡ���"..i.."�����ɱ�������","",M_DimGray,C_RED)
		local r = ShowMenu3(menu,#menu,7,-2,-2,-2,-2,1,1,24,C_GOLD,C_WHITE,"��ѡ���"..i.."�����ɱ�������","",M_DimGray,C_RED,13)
		JY.Wugong[wugong]["δ֪"..i] = r
		menu[r][3] = 2	
	end

	
	local menu = {}
	local teamnum = 1
	for i = 2, CC.TeamNum do
		if JY.Base["����" .. i] > 0 then
			local pid = JY.Base["����" .. i]
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
		if JY.Base["����" .. i] > 0 then
			local pid = JY.Base["����" .. i]
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
		say("����һ·������������Ҳ�������������Ƿ�Ӧ������һ�����ǵ��ؼ��أ�")					
		Cls()
		local r = ShowMenu3(menu,#menu,5,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"��ѡ��һ��������������","",M_DimGray,C_RED)
		JY.Wugong[wugong]["δ֪4"] = menu[r][4]
		menu[r][3] = 2	
		if teamnum > 2 then
			Cls()
			local r = ShowMenu3(menu,#menu,5,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"��ѡ��ڶ���������������","",M_DimGray,C_RED)
			JY.Wugong[wugong]["δ֪5"] = menu[r][4]
			menu[r][3] = 2				
		end
	end
	Cls()
	say("�ã���һ��Ҫ���ҵ����ɷ�����")			
	QZXS(JY.Person[zj()]["����"].."������"..JY.Wugong[wugong]["����"].."��")
	JoinMP(0, 63, 3)
	SetS(106, 0, 0, 0, 1)
end

OEVENTLUA[31000] = function() --���޾�ְ����
    Cls()
	if MPPD(0) == 0 then
	say("С�ӣ��ҿ������ʲ���Ҫ��Ҫ�����������ɣ�",46,0,"������")
	end
	if instruct_18(200) == false and JY.Person[0]["Ʒ��"] <= 30 and MPPD(0) == 0 and PJPD(1) == false then
		Cls()
		if DrawStrBoxYesNo(-1, -1, "Ҫ��ʦ��", C_WHITE, 30) == true then	
			Cls()
			say("ʦ�����ϣ����ܵ���һ�ݣ�")
			Cls()
			say("����������һ�����񽻸��㡣�����֮��������ʽ�������š�",46,0,"������")	
			Cls()
			say("�������������ȥ�޹�ɽ�����߱�ָ����С���๦�õ��֡�",46,0,"������")			
			Cls()
			say("������")	
			instruct_3(53,0,-2,-2,31001,-2,-2,-2,-2,-2,-2,-2,-2)	
			instruct_3(-2,0,-2,-2,31002,-2,-2,-2,-2,-2,-2,-2,-2)	
			do return end
		end
	end
	
	if MPPD(0) == 1 and MPDJ(0) == 1 and tianshu() >= 5 then
		Cls()
		say("���������Ȼû������ʧ����ֻҪ��Ӯ�����Ǽ������Ҿ���������ʦ�֣�",46,0,"������")
		if WarMain(276) == false then
			instruct_15(0);   
			instruct_0();  
			do return; end			
		end
		Cls()
		instruct_13()
		Cls()
		say("�ܺã��ӽ��쿪ʼ����Ǵ�ʦ�֣�",46,0,"������")	
		Cls()
		say("лʦ��")		
		SetS(106, 1, 0, 0, 2)
		instruct_3(-2,0,-2,-2,31003,-2,-2,-2,-2,-2,-2,-2,-2)
		JoinMP(0, 1, 2)
		do return end
	end	
end

OEVENTLUA[31001] = function() --�޹�ɽ������
	Cls()
	say("��������������ٽ��߱�ָ����С���๦���������㲻����")	
	Cls()
	say("����ͽ��Ȼ��������������ʦ��ӡ�ţ����ҹ���",115,0,"���Ǻ�")	
	Cls()
	say("���Һ������������ԣ���ֱ����ȡ������")		
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

OEVENTLUA[31002] = function() --���޾�ְ����2
	if instruct_18(200) and instruct_18(75) then
		Cls()
		say("����ʦ����ʦ��鸣�������Ѿ����֡�")			
		instruct_2(200,-1)
		Cls()
		instruct_2(75,-1)		
		Cls()
		say("�ã����úã������ڳ�Ϊ��ң�ɵ������ˣ�����������",46,0,"������")	
		Cls()
		say("�����ھ���ʽ���������ӡ���Щ���Ź�������ѧ�ţ������ڻ��ͨ���ҾͰ�����Ϊ��ʦ�֣�",46,0,"������")	
		Cls()
		say("лʦ��")
		JoinMP(0, 1, 1)
		instruct_3(-2,0,-2,-2,31003,-2,-2,-2,-2,-2,-2,-2,-2)	
		Cls()
		QZXS(JY.Person[zj()]["����"].."��Ϊ�����ɵ��ӣ�")
	else
		Cls()
		say("�����õ�������",46,0,"������")		
	end
end

OEVENTLUA[31003] = function() --���޵ȼ�����
	if MPPD(0) == 1 and MPDJ(0) == 2 and (tianshu() >= 7 or (JX(0) and tianshu() >= 6)) and JY.Person[0]["Ʒ��"] <= 20 then
		Cls()
		say("��������к���������",46,0,"������")	
		Cls()
		say("��ʦ����������Ϸ�����һ������....���������ӽ���")				
		Cls()
		say("�������㾹Ȼ�Ұ����ң���",46,0,"������")	
		Cls()
		say("��������ʦ���ǳ�˵���߾�֮��������������������ô�ã�Ҳ��ʱ����λ�����ˡ�")	
		Cls()
		say("�Һ���ƴ�ˣ�",46,0,"������")			
		JY.Person[46]["������"] = JY.Person[46]["������"] + 150
		JY.Person[46]["�Ṧ"] = JY.Person[46]["�Ṧ"] + 50
		JY.Person[46]["������"] = JY.Person[46]["������"] + 150		
		if WarMain(278) == false then
			instruct_15(0);   
			instruct_0();  
			do return; end			
		end		
		JY.Person[46]["������"] = JY.Person[46]["������"] - 150
		JY.Person[46]["�Ṧ"] = JY.Person[46]["�Ṧ"] - 50
		JY.Person[46]["������"] = JY.Person[46]["������"] - 150					
		if PersonKF(0,20) then
			say("�ȡ���һ�£���Ҫɱ�ң���",46,0,"������")				
			Cls()
			say("�ţ��㲻����Ϊ�һ����ʲôʦͽ֮��ɣ�")
			Cls()
			say("������������ȱ���С�����ﹻ����������ʦ����",46,0,"������")
			Cls()
			say("�ң��ҷ�������Ӧ����ѧ�������ɡ��ġ���צ�֡��԰ɣ�",46,0,"������")
			Cls()
			say("...�л���˵����ƨ��ţ���˵�ϻ��͸�������")	
			Cls()
			say("�۰�����������������������˵����",46,0,"������")	
			Cls()
			say("��צ�������־�������Ȼ��֪����������ô�õ����ż��յ�",46,0,"������")
			Cls()
			say("����Ȼ�޷�ϰ�����о�Ҫ...�԰ɣ�",46,0,"������")
			Cls()
			say("�ߣ�����˵��")
			Cls()
			say("�����ǡ�С�����޷���������ȫ��צ�ֵľ�Ҫ",46,0,"������")
			Cls()
			say("��С������һ��צ�����������צ��",46,0,"������")
			Cls()
			say("�����������Ȼ����֮�𣬵����пɻ�����֮��",46,0,"������")
			Cls()
			say("С��ԸΪ������������������书...",46,0,"������")
			if DrawStrBoxYesNo(-1, -1, "�Ƿ��ö�������㣿", C_WHITE, 30) == true then
				Cls()
				say("��֪���ҿ��Ĵ����ǲ����ڸ��ɣ�")
				Cls()
				say("Ҫ�����ҷ�����������...�����Ŀ���ȥ����")
				Cls()
				say("���������ġ�����",46,0,"������")
				dark()
				light()
				QZXS("���������צ��")
				setLW1(20)
				AddPersonAttrib(0, "��������", 100)
				Cls()
				say("������������צ�����������⡣�����ĺܺð���")
				Cls()
				say("���������ˣ�����צ����δ������������ϰ������צ�������Ը�ǿ��",46,0,"������")
				Cls()
				say("�á��ǳ��ã�лл�㰢����ʦ������")
				Cls()
				say("�����ɱС��...��......�㣬������...",46,0,"������")
				Cls()
				bgtalk("������˫�۴�����ãȻ�Ŀ��������ƶǵ�һצ���������Լ�Ϊ�������������г��ġ�������צ�֡�")
				Cls()
				say("����ǡ�ͽ�����͸������������ˣ�����������")
			else
				Cls()
				say("����ô�����������أ����ɣ�����")
				Cls()
				say("���ۣ���������",46,0,"������")
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
		say("�������������ڳ�Ϊ�����ˣ�����")				
		Cls()
		say("���Ϲֵ���֮�𣬾�ȻҲ�Һ��������⡣��������ʦ�ֳ�Ϊ��һ���������ɡ�",206,0,"��������") 
		Cls()
		say("�������ɣ�������ԭ����ͨ��󣬷����ޱߡ�",206,0,"��������")
		Cls()
		say("��������������������")			
		do return end
	end	
	
	if MPPD(0) == 1 and MPDJ(0) == 1 and tianshu() >= 5 then
		Cls()
		say("���������Ȼû������ʧ����ֻҪ��Ӯ�����Ǽ������Ҿ���������ʦ�֣�",46,0,"������")
		if WarMain(276) == false then
			instruct_15(0);   
			instruct_0();  
			do return; end			
		end
		Cls()
		instruct_13()
		Cls()
		say("�ܺã��ӽ��쿪ʼ����Ǵ�ʦ�֣�",46,0,"������")	
		Cls()
		say("лʦ��")		
		SetS(106, 1, 0, 0, 2)
		JoinMP(0, 1, 2)
		do return end
	end
	if MPPD(0) == 0 then
		Cls()
		say("��ͽ���㻹�е������ң�",46,0,"������")		
		JY.Person[46]["������"] = JY.Person[46]["������"] + 150
		JY.Person[46]["�Ṧ"] = JY.Person[46]["�Ṧ"] + 50
		JY.Person[46]["������"] = JY.Person[46]["������"] + 150		
		if WarMain(278) == false then
			instruct_15(0);   
			instruct_0();  
			do return; end			
		end		
		JY.Person[46]["������"] = JY.Person[46]["������"] - 150
		JY.Person[46]["�Ṧ"] = JY.Person[46]["�Ṧ"] - 50
		JY.Person[46]["������"] = JY.Person[46]["������"] - 150	
		instruct_3(35,0,-2,-2,0,0,0,0,0,0,0,0,0)
		SetS(60,34,30,3,99);
		instruct_3(60,99,1,0,10001,0,0,6376,6376,6376,-2,-2,-2); 	
		Cls()
		instruct_13()
		instruct_2(66,1)
		do return end
	end
	Cls()
	say("����ѹ�����������Щ�������ҡ�",46,0,"������")	
end

OEVENTLUA[31010] = function() --ؤ���ְ1
	local aa = 18 --math.random(18, 21)
	local bb = 22 --math.random(22, 25)
	Cls()
	say("�����ٳ�һ��"..JY.Thing[aa]["����"].."��"..JY.Thing[bb]["����"].."��ζ����....",207,0,"����ؤ")		
	if hasthing(aa) and hasthing(bb) then
		Cls()
		if DrawStrBoxYesNo(-1, -1, "Ҫ���ô��", C_WHITE, 30) == false then	
			do return end
		end	
		addthing(aa, -1, 1)
		addthing(bb, -1, 1)
		Cls()
		say("��������������⣬������������")		
		dark()
		light()
		Cls()
		say("��������С�Ӻܺá��Ͻл�Ƿ��һ�����飬��Ե�ٻ�ɡ�",207,0,"����ؤ")	
		dark()
		instruct_3(-2,-2,0,0,0,0,0,2,2,2,-2,-2,-2); 	
		SetS(51, 25, 16, 3, 100)
		instruct_3(51,100,1,0,31011,0,0,6266,6266,6266,-2,-2,-2); 				
		light()		
	end
end

OEVENTLUA[31011] = function() --ؤ���ְ2
	Cls()
	say("С�ӣ������ּ����ˡ�",207,0,"³�н�")	
	if PDReq(0, "Ʒ��", 60, 100) and MPPD(0) == 0 and PJPD(2) == false then
		Cls()
		say("�ϴ�Ƿ��������Ͻл�������������������ɣ����㹦����Ʒ������Ҫ��Ҫ��������ؤ�",207,0,"³�н�")		
		if DrawStrBoxYesNo(-1, -1, "Ҫ��ʦ��", C_WHITE, 30) == true then	
			Cls()
			say("ʦ�����ϣ����ܵ���һ�ݣ�")
			Cls()
			say("�ã��ã������ھͽ���ؤ������Ź���",207,0,"³�н�")			
			JoinMP(0, 2, 1)
			instruct_3(-2,-2,-2,-2,31012,-2,-2,-2,-2,-2,-2,-2,-2)	
			Cls()
			QZXS(JY.Person[zj()]["����"].."��Ϊؤ�ɵ��ӣ�")
			addHZ(60)
		end
	else
		Cls()
		say("������������Ϊͽ����ϧؤ���ƺ����ʺ��㣬��ȥ����������һ�°ɡ�",207,0,"³�н�")	
	end	
end

OEVENTLUA[31012] = function() --ؤ��ȼ�����
	if MPPD(0) == 2 and MPDJ(0) == 3 then
		Cls()
		say("������������ѧ�������塣",207,0,"³�н�")				
		Cls()
		say("�ǣ����Ӷ�����ʦ���̻壡")			
		do return end	
	end
	if MPPD(0) == 2 and MPDJ(0) == 2 and tianshu() >= 7 and hasthing(147)
		and GetS(106, 2, 2, 0) ~= 1 and PDReq(0, "Ʒ��", 70, 100) then
		Cls()
		say("����Ϊ��ؤ��������ô���£�Ϊʦ������ο��",207,0,"³�н�")		
		Cls()
		say("һ������ʤ���ˣ���Ҳ׼����λ�����ˡ�������ܴ�����һ�أ���������֮λ��������ˡ�",207,0,"³�н�")			
		local name = JY.Person[458]["����"]
		JY.Person[458]["����"] = "³�н�"
		if WarMain(280) == false then
			Cls()
			say("�����㻹�ǵ��ڼ���ϰ����",207,0,"³�н�")
			JY.Person[458]["����"] = name
			do return; end			
		end		
		JY.Person[458]["����"] = name			
		JoinMP(0, 2, 3)		
		instruct_0()
		instruct_13()
		Cls()
		say("�ã��ӽ���������Ǵ��������ˡ�������������ѧ�������塣",207,0,"³�н�")				
		Cls()
		say("�ǣ����Ӷ�����ʦ���̻壡")			
		do return end
	end		
	if MPPD(0) == 2 and MPDJ(0) == 1 and tianshu() >= 5 then
		Cls()
		say("�����㹦����г������������������Ρ�",207,0,"³�н�")	
		if WarMain(279) == false then
			Cls()
			say("�����㻹�ǵ��ڼ���ϰ����",207,0,"³�н�")
			do return; end			
		end
		Cls()
		instruct_13()
		say("�ܺã��������ҿ��Խ�����������ѧ�ˡ�",207,0,"³�н�")		
		Cls()
		say("ллʦ����")		
		JoinMP(0, 2, 2)
		do return end
	end
	if MPPD(0) == 0 then
		Cls()
		say("�������߰ɣ��Ҳ����ټ����㡣",207,0,"³�н�")	
		do return end
	end
	Cls()
	say("����ѹ�����������Щ�������ҡ�",207,0,"³�н�")	
end

OEVENTLUA[31020] = function() --�䵱����
    if PDReq(0, "Ʒ��", 90, 100) and  PJPD(4) == false then
		if JY.Person[zj()]["ʵս"] >= 50 and MPPD(0) == 0 then
		Cls()
		--say("С�ֵ��������ã�����ոն�̫�������µ��������д�һ����Σ�",5,0,"������")	
		--Cls()
		--say("��ǰ��ָ�㡣")		
		--if WarMain(281) == false then
		--	Cls()
		--	say("�����㻹�ǵ��ڼ���ϰ����",5,0,"������")
		--	do return; end			
		--end
		Cls()
		instruct_13()		
		Cls()
		say("С�ֵ���Ʒ��ֱ���书��ǿ���������¼�������ǿ���ˡ�",5,0,"������")	
		Cls()
		say("ǰ�������ˣ������ܸ��䵱�����ȼ硣")			
		Cls()
		say("��������������Ϊ���ӣ���ϧ�ҿ�С�ֵ���ǳ���֮�ֻ���䵱ɽҲ���������չȭ�š�",5,0,"������")	
		Cls()
		say("С�Ӻεº��ܣ��ܹ���ǰ�����ۡ�")	
		Cls()
		say("�������㲻�ü��ҡ������ɣ��Ҵ����书��������Ҫ���ʦ�������䵱����ѧ֮�ʣ����ҵ��ӣ�����֮�⣬ȴ���ҵ����ѡ�������ô��",5,0,"������")		
		Cls()
		say("�ǣ���лǰ��ָ�㣡")	
		JoinMP(0, 4, 1)
		instruct_3(-2,-2,1,0,31021,0,0,-2,-2,-2,-2,-2,-2)
		Cls()
		QZXS(JY.Person[zj()]["����"].."�����䵱����ѧ��Ҫ��")	
			if GetS(113,0,0,0) == 0 and JY.Person[0]["��������"] >= 200 then 
				say("��С��Ҳ���ý�֮�ˣ�����̫���������ϵ��������򣬽�������������졢�����ˣ�Ҳһ���������츣���֣�",5) 
				instruct_0();
				if instruct_11(0,188) == true then 
					QZXS("����̫������Ҫ��")
					say("��ס�����׽������ⲻ��������Īǿ����ʽ��",5)
					say("�ٴθ�лǰ��ָ��",0)
					instruct_0();
					setLW1(46)
				else
					say("�ϵ��Ͳ���ǿ���ˡ�",5) 
				end	
			end
		elseif MPPD(0) == 4 and MPDJ(0) ~= nil then
		instruct_13()		
		Cls()
		say("��������ͽ����������",5,0,"������")	
		Cls()
		say("ͽ���μ�ʦ��ʦ����������ƺ�����")			
		Cls()
		say("���������ϵ���֪ͽ����ɽ֮���������壬������������ɽ���������ϵ��ܲ�����ô",5,0,"������")	
		Cls()
		say("���ǵ�̝ʦ��ƽ�յĽ̵���ͽ�������ҵ���")	
		Cls()
		say("�������ˣ���ɽ����ѧ�˷����Ƚڻ���(���˻�����)�����ѽ��٣��ϵ���Ҳ�ɷ��Ĵ��²��ˣ�ͽ��������Σ�",5,0,"������")		
		Cls()
		say("�ǣ���лʦ��")
			if GetS(113,0,0,0) == 0 and JY.Person[0]["��������"] >= 200 then 
				say("����ͽ���ڽ�֮һ�����ߵ���Զ���ϵ������о���һ��̫����������������԰ת���⡢���ڽ��ȣ��ʹ���ͽ���ɣ�",5) 
				instruct_0();
				if instruct_11(0,188) == true then 
					QZXS("����̫������Ҫ��")
					say("��ס�����׽������ⲻ��������Īǿ����ʽ��",5)
					say("�ǣ�",0)
					instruct_0();
					setLW1(46)
				else
					say("�ϵ��Ͳ���ǿ���ˡ�",5) 
				end	
			end
			if GetS(113,0,0,0) == 0 and JY.Person[0]["ȭ�ƹ���"] >= 200 then 
				say("����ͽ����ȭ֮һ�������н������ϵ������о���һ��̫��ȭ�����������Ǹ�����á������������ʹ���ͽ���ɣ�",5) 
				instruct_0();
				if instruct_11(0,188) == true then 
					QZXS("����̫��ȭ��Ҫ��")
					say("��ס������ȭ���мɼ��꣬�Ծ��ƶ���Ϊ���裡",5)
					say("�ǣ�",0)
					instruct_0();
					setLW1(16)
				else
					say("�ϵ��Ͳ���ǿ���ˡ�",5) 
				end	
			end
		end
	else
		Cls()
		say("�����书�ѵ���˾��磬�ϵ�Ҳûʲ��ý�����ˡ�",5,0,"������")		
	end
end

OEVENTLUA[31021] = function() --�䵱����
	if MPPD(0) == 4 and MPDJ(0) == 3 then
		Cls()
		say("��С�ֵ��պ����߽���ʱ���������ˡ�",5,0,"������")					
		Cls()
		say("�ǣ�С�Ӷ�����ǰ���̻壡")			
		do return end	
	end
	if MPPD(0) == 4 and MPDJ(0) == 1 and tianshu() >= 5 and PDReq(0, "Ʒ��", 80, 100) then
		Cls()
		say("С�ֵ����д�һ��ô��",5,0,"������")		
		Cls()
		say("��ǰ��ָ�㡣")			
		if WarMain(281) == false then
			Cls()
			say("�����㻹�ǵ��ڼ���ϰ����",5,0,"������")
			do return; end			
		end		
		JoinMP(0, 4, 2)		
		instruct_0()
		instruct_13()
		Cls()
		say("�ã��ã�С�ֵ��书��Ȼһ��ǧ�",5,0,"������")				
		Cls()
		say("�ⶼ��ǰ��ָ���з���")		
		Cls()
		QZXS(JY.Person[zj()]["����"].."���䵱����ѧ������")			
		do return end
	end		
	if MPPD(0) == 4 and MPDJ(0) == 2 and tianshu() >= 7 and PDReq(0, "Ʒ��", 80, 100) then
		Cls()
		say("С�ֵ����д�һ��ô��",5,0,"������")		
		Cls()
		say("��ǰ��ָ�㡣")			
		if WarMain(281) == false then
			Cls()
			say("�����㻹�ǵ��ڼ���ϰ����",5,0,"������")
			do return; end			
		end		
		JoinMP(0, 4, 3)		
		instruct_0()
		instruct_13()
		Cls()
		say("�ã��ã�С�ֵ��书��Ȼһ��ǧ�",5,0,"������")				
		Cls()
		say("�ⶼ��ǰ��ָ���з���")	
		Cls()
		if GetS(113,0,0,0) == 0 and JY.Person[0]["ȭ�ƹ���"] >= 250 and JY.Person[0]["Ʒ��"] >= 100 then 
	        say("�ѵ�С�ֵ���Ʒ����ѧ���֮�ߣ���������̫��ȭ���ʹ������츣������",5) 
	        instruct_0();
			if instruct_11(0,188) == true then 
	            QZXS("����̫��ȭ��Ҫ��")
				say("̫��ȭ��ټ���ѧ��Ȼ��ͬ�������Ծ��ƶ��������ˣ�",5)
				say("��лǰ��ָ��",0)
	            instruct_0();
	            setLW1(16)
			else
				say("����Ͳ���ǿ���ˡ�",5) 
			end	
	    end		
		say("������һ���������Ժ����߽���������а�����",5) 
		addHZ(149)
		QZXS(JY.Person[zj()]["����"].."���䵱����ѧ������")		
		do return end
	end
	if MPPD(0) == 0 then
		Cls()
		say("��С�ֵ��պ���������ˣ�Ҳ����������һ�����ġ�",5,0,"������")	
		do return end
	end
	Cls()
	say("С�ֵܻ��ǵ��ڼ���ϰ����",5,0,"������")		
end

OEVENTLUA[31030] = function() --��������
    if PDReq(0, "Ʒ��", 80, 100) and MPPD(0) == 0 and PJPD(5) == false and JY.Person[0]["�Ա�"] == 0 then
		Cls()
		say("���ݼ����Ŵ�ʦ��")			
		Cls()
		say("���Ŀ�Сʩ�����л۸������ѵõ�����Ʒ��������֪Сʩ���ɷ�Ը������������£�",169,0,"����")
		if DrawStrBoxYesNo(-1, -1, "Ҫ��ʦ��", C_WHITE, 30) == false then	
			do return end
		end
		Cls()
		say("��Ը�⣡")		
		Cls()
		say("�ã��á����ľ�����Ϊ�׼ҵ��ӡ�",169,0,"����")
		Cls()
		say("ʦ�����ϣ����ܵ���һ�ݣ�")
		addHZ(32)
		JoinMP(0, 5, 1)
		instruct_3(-2,-2,1,0,31031,0,0,-2,-2,-2,-2,-2,-2)
		Cls()
		QZXS(JY.Person[zj()]["����"].."��Ϊ�����׼ҵ��ӣ�")	
		if GetS(113,0,0,0) == 20 then
			setLW1(0)
		end	
	else
		Cls()
		say("�����ӷ�",169,0,"����")		
	end
end

OEVENTLUA[31031] = function() --��������
	if MPPD(0) == 5 and MPDJ(0) == 3 then
		Cls()
		say("�����ӷ�Ϊʦ�������ܾ�����ѧ�츣���֡�",169,0,"����")	
		Cls()
		say("�ǣ�ʦ����")		
		do return end	
	end
	if MPPD(0) == 5 and MPDJ(0) == 2 and hasthing(85) then
		Cls()
		say("�����ӷ𡣼�Ȼ���Ѿ�ͨ��ͭ���֤�����ѿ��Գ�ʦ�ˡ�",169,0,"����")		
		Cls()
		say("�ֱ��ڼ���Ϊʦ���ٴ���һЩ���򣬶������߽���Ӧ�����á�",169,0,"����")
		Cls()
		say("ллʦ����")			
		JoinMP(0, 5, 3)		
		Cls()
		QZXS(JY.Person[zj()]["����"].."��������ѧ������")	
		Cls()
		say("���ˣ����Ѿ�������ɽ�ˡ�Ϊʦ�������ܾ�����ѧ�츣���֡�",169,0,"����")	
		Cls()
		say("�ǣ�ʦ����")		
		do return end
	end		
	if MPPD(0) == 5 and MPDJ(0) == 1 and hasthing(168) then
		Cls()
		say("�����ӷ��㾹Ȼ�ܹ��ڶ̶�ʱ��֮��ͨ��ľ������Ǻ�����η��",169,0,"����")		
		Cls()
		say("������ʦ��Ϥ�Ľ̻塣")			
		JoinMP(0, 5, 2)		
		Cls()
		say("�ҽ���ʹ����������书��ϣ�����ڼ���ϰ��",169,0,"����")			
		Cls()
		say("�ǣ�")	
		Cls()
		if PersonKF(0, 86) and GetS(113,0,0,0) == 0 then 
	        say("Ϊʦ�����ħ�ȷ�С�����ɣ���ָ����һ�������и��õļ��⡣",169) 
	        instruct_0();
			if instruct_11(0,188) == true then 
	            QZXS("�����ħ�ȷ���")
				say("��лʦ����",0)
	            instruct_0();
	            setLW1(86)
			else
				say("Ҳ�ա�",169) 
			end	
	    end
		QZXS(JY.Person[zj()]["����"].."��������ѧ������")		
		do return end
	end
	if MPPD(0) == 0 then
		Cls()
		say("�����ӷ�",169,0,"����")	
		do return end
	end
	Cls()
	say("�����ӷ�",169,0,"����")			
end

OEVENTLUA[31040] = function() --Ѫ������
    if PDReq(0, "Ʒ��", 0, 30) and MPPD(0) == 0 and PJPD(6) == false and JY.Person[0]["�Ա�"] == 0 then
		Cls()
		--say("��ô�����ı��������������Ѫ�����ˣ�",97,0,"Ѫ������")
		--Cls()
		if DrawStrBoxYesNo(-1, -1, "Ҫ����Ѫ������", C_WHITE, 30) == true then
			say("��Ѫ����ʵ�ڰ����ޱȣ����ʦ����Ϊͽ��")		
			Cls()
			say("�ٺ٣����������ҵķ��ϣ�����ΪͽҲ�У���Ͱ���Ѫ���ŵ��������ｭ���ɡ�",97,0,"Ѫ������")	
			Cls()
			say("ллʦ��")					
			JoinMP(0, 6, 1)
			instruct_3(-2,-2,1,0,31041,0,0,-2,-2,-2,-2,-2,-2)
			Cls()
			QZXS(JY.Person[zj()]["����"].."����Ѫ���ţ�")
		else
			OEVENTLUA[42]()			
		end
	else
		Cls()
		OEVENTLUA[42]()	
		--say("û��һ��ȥ��",97,0,"Ѫ������")	
	end
end

OEVENTLUA[31041] = function() --Ѫ������
	if MPPD(0) == 6 and MPDJ(0) == 1 and tianshu() >= 6 and PDReq(0, "Ʒ��", 0, 20) then
		Cls()
		say("ͽ���μ�ʦ��")		
		Cls()
		say("����ʲô�£�",97,0,"Ѫ������")	
		Cls()
		say("ͽ����˵������һ���֮����ԻѪ������Ѫ�������ʹ������������ͽ�����������Ѫ��һ�ۡ�")		
		Cls()
		say("Ѫ��������������֮����˲��ùۿ���",97,0,"Ѫ������")	
		Cls()
		say("Ҳ����˵������ҳ��������Ϳ��Եõ�Ѫ����")		
		Cls()
		say("�󵨣�������ʲô��˼��",97,0,"Ѫ������")	
		Cls()
		say("���������˼�����У�")	
		JY.Person[97]["������"] = JY.Person[97]["������"] + 150
		JY.Person[97]["�Ṧ"] = JY.Person[97]["�Ṧ"] + 150
		JY.Person[97]["������"] = JY.Person[97]["������"] + 150	
		JY.Person[97]["�������ֵ"] = JY.Person[97]["�������ֵ"] + 700	
		JY.Person[97]["����"] = JY.Person[97]["�������ֵ"]			
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
		QZXS(JY.Person[zj()]["����"].."���ӹ�����20��")
		instruct_2(44, 1)
		instruct_2(356,1)
		JoinMP(0, 6, 2)
		say("��������Ȼ�Ǻõ���")			
		do return end
	end		
	if MPPD(0) == 0 then
		Cls()
		say("��ͽ��������",97,0,"Ѫ������")	
		JY.Person[97]["������"] = JY.Person[97]["������"] + 150
		JY.Person[97]["�Ṧ"] = JY.Person[97]["�Ṧ"] + 150
		JY.Person[97]["������"] = JY.Person[97]["������"] + 150	
		JY.Person[97]["�������ֵ"] = JY.Person[97]["�������ֵ"] + 700	
		JY.Person[97]["����"] = JY.Person[97]["�������ֵ"]			
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
	say("Ѫ����������ô���ˣ�",97,0,"Ѫ������")			
end

OEVENTLUA[31050] = function() --��ң���ţ�����
	Cls()
	say("���¶�����С���о���ǰ���ɷ�������һ�ԣ�")
	Cls()
	say("�ã������롣",115,0,"���Ǻ�")		
	dark()
	light()
	Cls()
	say("�������ʹ��ˣ���Ȼ�������������֡����ǿ�ϲ�ɺء�",115,0,"���Ǻ�")	
	Cls()
	say("����",115,0,"���Ǻ�")
	Cls()
	say("ǰ��������ô�ˣ�")	
	Cls()
	say("����....����....",115,0,"���Ǻ�")	
	Cls()
	say("���������")	
	if WarMain(285) == false then
		instruct_15(0);   
		instruct_0();  
		do return; end			
	end		
	Cls()
	light()
	say("ǰ��������ô���ˣ�")
	Cls()
	say("������....������....����Ц....��ңɢ....������....��....���....��������....",115,0,"���Ǻ�")	
	Cls()
	say("ǰ������")		
	dark()
	instruct_3(-2,-2,1,0,0,0,0,0,0,0,0,0,0)
	light()
	Cls()
	say("�����ﵽ����ʲô....")	
    instruct_3(-2,2,0,0,0,0,0,2566*2,2566*2,2566*2,-2,-2,-2)	
	My_Enter_SubScene(JY.SubScene,24,19,0)
	Cls()
	say("���ǣ�")		
	Cls()
	say("����������....���Ұ�һ�ж��������....",116,0,"������")		
	dark()
	light()		
	Cls()
	say("�������Ѿ�������ʮ����ڹ��������Ұ�����֮λ�����㡣��ȥ�Ҷ�������Һ���ʦ���ֻع�����....",116,0,"������")	
	Cls()
	if GetS(113, 0, 0, 0) == 0 then
	say("Ϊʦ..�ȿ�..���ڱ㽫������ɽ..�ȿ�..������..�ȿ�..������..��ѧ����..�ȿ�..�����Լ��ˣ�",116) 
	SetS(106, 63, 1, 0, 0)
    SetS(106, 63, 2, 0, 116)
		if WarMain(288) == false then
	        instruct_13()  --��������
		    say("���ǿ�ϧ",0) 
			else
			say("���������书",0) 
	        QZXS("������ɽ�����ƣ�")
	        instruct_0();
	        SetS(113, 0, 0, 0, 8)
		end
    end 
	say("��ǰ������ǰ��....ʦ������")
	JoinMP(0, 7, 2)
	addHZ(37)
	My_Enter_SubScene(JY.SubScene,18,29,3)
	instruct_3(-2,2,0,0,0,0,0,0,0,0,-2,-2,-2)
	addthing(200, 1)
	addthing(247, 1)
	addthing(75, 1)
	addthing(105, 1)	
end

OEVENTLUA[31051] = function() --��ң���ţ�����
	Cls()
	say("��ϧ��������³�ۣ���Ȼ��Ҫ���������һ����")
	Cls()
	say("������ǫ�ˡ���ʵҪ������֣�������֣�����Ҫ���֡������η�һ�ԣ�",115,0,"���Ǻ�")		
	Cls()
	say("�����¾��׳��ˡ�")	
	dark()
	light()
	Cls()
	say("����һ����ɱ��һ����壬��Ȼ���������·���",115,0,"���Ǻ�")	
	Cls()
	say("����־�Ȼ�����ֽⷨ����ִ��������ʤ�ܣ������ܵõ����ѡ�",115,0,"���Ǻ�")
	Cls()
	say("�������ֹ��ˣ�������һ��",115,0,"���Ǻ�")	
	Cls()
    instruct_3(-2,2,0,0,0,0,0,2566*2,2566*2,2566*2,-2,-2,-2)
	instruct_3(-2,3,0,0,0,0,0,2965*2,2965*2,2965*2,-2,-2,-2)
	My_Enter_SubScene(JY.SubScene,18,29,3)		
	Cls()
	say("���ǣ�")		
	Cls()
	say("����������....���Ұ�һ�ж��������....",116,0,"������")		
	dark()
	light()		
	Cls()
	say("�������Ѿ�������ʮ����ڹ��������Ұ�����֮λ�����㡣��ȥ�Ҷ�������Һ���ʦ���ֻع����ɡ�",116,0,"������")	
	Cls()
	say("��ǰ��....")
	Cls()
	say("�µ�����㻹���Ͻ���һ��ʦ����",116,0,"������")	
	Cls()
	say("ʦ��....����")	
	if GetS(113, 0, 0, 0) == 0 then
	say("Ϊʦ..�ȿ�..���ڱ㽫������ɽ..�ȿ�..������..�ȿ�..������..��ѧ����..�ȿ�..�����Լ���",116) 
	SetS(106, 63, 1, 0, 0)
    SetS(106, 63, 2, 0, 116)
		if WarMain(288) == false then
	        instruct_13()  --��������
		    say("���ǿ�ϧ",0) 
		else
			say("���������书",0) 
	        QZXS("������ɽ�����ƣ�")
	        instruct_0();
	        SetS(113, 0, 0, 0, 8)
		end
    end 
	Cls()
	say("��ͽ��...�ȿ�..Ҫ����ң�ɷ�����.....",116,0,"������")	
	SetS(106, MPPD(0), 0, 0, 1)
	SetS(106, MPPD(0), 1, 0, 0)	
	JoinMP(0, 7, 2)
	addHZ(37)
	instruct_40(3)
	dark()
	instruct_3(-2,2,0,0,0,0,0,0,0,0,-2,-2,-2)
	light()
	Cls()
	say("�����ţ�����������������޺�Ϊ��һ����",115,0,"���Ǻ�")
	Cls()
	say("ʦ��ʦ�֣��һ��ʦ�����㱨��ġ�")	
	Cls()
	say("��л���š��һ��а˸�����ɢ����أ���׼������һ�ˣ��������һ����ؽ���ң�ɡ�",115,0,"���Ǻ�")	
	Cls()
	say("�Ǿ�����ʦ���ˡ�")		
	My_Enter_SubScene(JY.SubScene,18,29,3)	
	instruct_3(-2,3,0,0,0,0,0,0,0,0,-2,-2,-2)
	instruct_3(-2,-2,1,0,0,0,0,0,0,0,0,0,0)	
	addthing(200, 1)
	addthing(247, 1)
	addthing(75, 1)	
	addthing(105, 1)	
end

--[[�𵶾���δ���--tony
OEVENTLUA[31032] = function() --��������
	if hasthing(195) then
		say("�����ӷ�",169,0,"�ռ�")
		addevent(70,4,1,-2,1)
		addevent(70,4,1,31032,1)
	end	
end
OEVENTLUA[31033] = function() --��������
	--if hasthing(195) then
		say("ȥ��ƽһָ��",256,0,"����")
		addevent(70,4,1,698,1)
	--else
		
	--end	
end]]



