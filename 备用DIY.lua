-- DIY�ò�������
local nexty;	--�Ի��򳤶ȿ��Ʊ���
local s;		--�����ڶ����е�λ��(��Ա��)
local r;		--�书���(���)
local pid;		--���ѵľ��Ա��
local f;		--�书�ȼ�(���)
local kfid;		--�书ID
local i = nil
local j = nil

--[[
�����޵�DIY-3.1��˵����
1�������һ���װ��������װ�Ķ������������ָ���Ͷ�ת����

2�����δ����������⹦���ƣ�Ҳ����˵���Ժ�����µ��⹦����ֻҪ���ֶ�����ķ�ʽ����������
	�ڿ�����Ա��δ��������ǰ��Ҳ�����ñ�DIY��������ֻ����û��ɶЧ�����ѡ�
	
3����Ӻ�̨���ܣ��޸ġ��ҵĴ��롱������ÿ����Ϸ�У�ֻ�е�һ�����б�DIYʱ����ѯ���Ƿ�����DIY����

4��������ʾ������ñ�DIY�����˶��ѵ�����Ļ�����������ٴν�����Ϸʱ����һ�±�DIY��������Ϣ�ָ�һ��Ҳ���ԣ�
	��DIYû�����е�����£�������������Ч�ġ�
]]
--DIY��ʽ����
local ms=JYMsgBox("�����޵�",
		"���ʣ���Ҫʹ��DIY��ʲô���ܣ�                               ",
		{"��Ϣ�ָ�","��������","��Ʒӡ��","�������","ȫ�ֲ���","�ر�ȡ��","��Ѫ����"}
		,6,320)

	--��Ϣ�ָ����ָ�Ѫ���ڡ��壬���ⶾ����������ˣ�
	if ms == 1 then
		for i = 1, CC.TeamNum do                 
			local id = JY.Base["����" .. i];
			if id >= 0 then
				AddPersonAttrib(id, "����", 2000);
				AddPersonAttrib(id, "����", 10000);
				AddPersonAttrib(id, "����", 100);
			end
		end
		QZXS("��Ϣ~��Ϣһ��~")		
	end
	
	--������������ͬ������DIY��
	if ms == 2 then
		for i = 1, CC.TeamNum do                 
			local id = JY.Base["����" .. i];
			if id >= 0 then
				JY.Person[id]["��������"] = 30000
				War_PersonTrainBook(id)
				JY.Person[id]["����"] = 52000
				War_AddPersonLVUP(id);		
			end
		end
	end
	
	--��Ʒӡ�ţ�������Ʒ�������Ʒ�����ӡ�ţ�
	if ms == 3 then
		local ms3 = JYMsgBox("��Ʒӡ��",
				"��ѡ����Ҫ�����Ʒ����ӡ�š�              ",
				{"������Ʒ","�����Ʒ","���ӡ��","�ر�ȡ��"}
				,4,320)	
			
			--������Ʒ
			if ms3 == 1 then
				DrawStrBoxWaitKey("������Ʒ���", C_WHITE, CC.DefaultFont, 1)
				local thing = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				for i=thing,thing do
					instruct_2(i,1)
				end
			end
			
			--�����Ʒ
			if ms3 == 2 then
				DrawStrBoxWaitKey("������Ʒ���", C_WHITE, CC.DefaultFont, 1)
				local thing = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				DrawStrBoxWaitKey("������Ʒ����", C_WHITE, CC.DefaultFont, 1)
				local num = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				for i = thing, thing do
					for j = num, num do
						instruct_2(i,j)
					end
				end
			end
			
			--���ӡ��
			if ms3 == 3 then
				DrawStrBoxWaitKey("����ӡ�ű�š�", C_WHITE, CC.DefaultFont, 1)
	    		local yinxin = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				for i = yinxin, yinxin do
					addHZ(i)
				end
			end
	end
	
	--������أ����ʡ��츳�����ɡ������ڹ������⹦���򣩡���ȴ��
	if ms == 4 then
		local ms4 = JYMsgBox("�������",
				"��ѡ����Ҫ�޸ĵ�����������ݡ�",
				{"����","�츳","����","����","��ȴ","ȡ��"}
				,6,320)
				
		--��������		
		if ms4 == 1 then
			Cls()
			DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "˭��Ҫ��������?", C_WHITE, CC.DefaultFont);
			nexty = CC.MainSubMenuY + CC.SingleLineHeight;
			s = SelectTeamMenu(CC.MainSubMenuX, nexty);
			if s == 0 then 
			return end
			pid = JY.Base["����"..s];
			DrawStrBoxWaitKey("��������(1-100)", C_WHITE, CC.DefaultFont, 1)
			local zizhi = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
			for i = zizhi, zizhi do
				JY.Person[pid]["����"] = i
			end
			QZXS(JY.Person[pid]["����"].." �����ѵ���Ϊ "..zizhi);
		end
		
		--�����츳����
		if ms4 == 2 then
			Cls()
			DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "˭��Ҫ�����츳?", C_WHITE, CC.DefaultFont);
			nexty = CC.MainSubMenuY + CC.SingleLineHeight;
			s = SelectTeamMenu(CC.MainSubMenuX, nexty);
			if s == 0 then 
			return end
			pid = JY.Base["����"..s];
			local tianfumingcheng = {}
			for i = 1, 5 do
				if JY.Person[pid]["����"..i] ~= 0 and JY.Person[pid]["����"..i] ~= nil then
					tianfumingcheng[i] = CC.TFlist[JY.Person[pid]["����"..i]][1]
				else
					tianfumingcheng[i] = "��     "
				end
			end
			local ms42 = JYMsgBox(JY.Person[pid]["����"].." �츳����",
				JY.Person[pid]["����"].." Ŀǰ���츳�У�"..
				"*�츳1��"..tianfumingcheng[1].."   �츳2��"..tianfumingcheng[2].."   �츳3��"..tianfumingcheng[3]..
				"*�츳4��"..tianfumingcheng[4].."   �츳5��"..tianfumingcheng[5]..
				"*��ѡ����Ҫ�޸ĵ��츳 ",
				{"�츳1","�츳2","�츳3","�츳4","�츳5"," ȡ�� "}
				,6,320)
				
			if ms42 == 6 then
				return
			else
				DrawStrBoxWaitKey("�����츳��ţ��ο�ӡ�ţ�", C_WHITE, CC.DefaultFont, 1)
				local tianfu = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				for i = tianfu, tianfu do
					JY.Person[pid]["����"..ms42] = i
				end
				QZXS(JY.Person[pid]["����"].." �츳"..ms42.."��Ϊ "..CC.TFlist[JY.Person[pid]["����"..ms42]][1]);
			end
		end
		
		--�������ɵ���
		if ms4 == 3 then
			Cls()
			DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "˭��Ҫ��������?", C_WHITE, CC.DefaultFont);
			nexty = CC.MainSubMenuY + CC.SingleLineHeight;
			s = SelectTeamMenu(CC.MainSubMenuX, nexty);
			if s == 0 then 
			return end
			pid = JY.Base["����"..s];
			local menpaixianshi = "������ʿ"
			if MPPD(pid)~= 0 then
				local mptype, mpdj = MPDISPLAY(pid)
				if mptype ~= nil then
					menpaixianshi = mptype .. mpdj
				end
			end
			local ms43 = JYMsgBox(JY.Person[pid]["����"].." ���ɵ���",
				JY.Person[pid]["����"].."���ڵ�����Ϊ��"..menpaixianshi..
				"*�ɹ�ѡ��������У�"..
				"*01���� 02ؤ�� 03��Ĺ 04�䵱 05���� 06���� 07��ң 08���� 09����"..
				"*10�һ� 11���� 12���� 13���� 14���� 15���� 16ȫ�� 17��ü 18���� "..
				"*��ѡ����Ҫ��������ɣ�������������޷��ٴμ��룩 ",
				{"01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","ȡ��"}
				,19,320)
				
			if ms43 == 19 then
				return
			elseif ms43 == 18 then	--�ָ�������ʿ
				JoinMP(pid, 0, 0)
			elseif ms43 == 6 or ms43 == 9 or ms43 == 10 or ms43 == 15 then --�ȼ�Ϊ2�ļ�������
				JoinMP(pid, ms43, 2)
			elseif ms43 == 4 or ms43 == 12 or ms43 == 13 then	--�ȼ�Ϊ4�ļ�������
				JoinMP(pid, ms43, 4)
			elseif ms43 == 11 then	--����Ҫ����ϴ�书�Ĺ���
				JoinMP(pid, ms43, 3)
				JY.Person[pid]["�书1"] = 131
				JY.Person[pid]["�书�ȼ�1"] = 9999
			else		--�����ȼ�Ϊ3
				JoinMP(pid, ms43, 3)
			end
			if MPPD(pid)~= 0 then
				local mptype, mpdj = MPDISPLAY(pid)
				if mptype ~= nil then
					menpaixianshi = mptype .. mpdj
				end
			else
				menpaixianshi = "������ʿ"
			end
				QZXS(JY.Person[pid]["����"].."��Ϊ��"..menpaixianshi)
		end
		
		--�����������
		if ms4 == 4 then
			Cls()
			DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "˭��Ҫ��������?", C_WHITE, CC.DefaultFont);
			nexty = CC.MainSubMenuY + CC.SingleLineHeight;
			s = SelectTeamMenu(CC.MainSubMenuX, nexty);
			if s == 0 then 
			return end
			pid = JY.Base["����"..s];
			
			local ms44 = JYMsgBox(JY.Person[pid]["����"].." �������",
				"Ҫ������������                        ",
				{"�ڹ�����","�⹦����","�Ṧ����","�ر�ȡ��"}
				,4,320)
			
			--�ڹ��������
			if ms44 == 1 then
				local nglw = 0
				local ms441a = JYMsgBox(JY.Person[pid]["����"].."�ڹ�����",
					"��ѡ����Ҫ������ڹ���"..
					"*01���� 02���� 03��ϼ 04��Ԫ 05���� 06ʨ�� 07ʥ�� 08���� 09���"..
					"*10�޺� 11Ǭ�� 12���� 13���� 14���� 15�˻� 16̫�� 17���� 18����"..
					"*��һҳ����",
					{"01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","->"}
					,19,320)
				if ms441a ~= 19 then	--��ҳ�ڹ���˳���
					nglw = ms441a + 86
				else
					local ms441b = JYMsgBox(JY.Person[pid]["����"].."�ڹ�����",
						"��ѡ����Ҫ������ڹ���"..
						"*19���� 20���� 21���� 22�׽� 23��Ů 24���� 25��� 26��� 27����"..
						"*28�ټ� 29�̺� 30���� 31̫�� 32��ڤ 33���� 34���� 35��ң 36�ſ�",
						{"19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","X"}
						,19,320)
					if ms441b >= 1 and ms441b <= 4 then	--�������׽�
						nglw = ms441b + 104
					elseif ms441b == 5 then	--��Ů
							nglw = 121
					elseif ms441b == 6 then	--����
						nglw = 124
					elseif ms441b == 7 then --���
						nglw = 150
					elseif ms441b == 8 or ms441b == 9 or ms441b == 10 then	 --��ա����ϡ��ټ�
						nglw = ms441b + 143
					elseif ms441b == 11 then	--�̺�
						nglw = 6
					elseif ms441b == 12 then	--����
						nglw = 178
					elseif ms441b == 13 then 	--̫��
						nglw = 180
					elseif ms441b == 14 then	--��ڤ
						nglw = 85
					elseif ms441b == 15 then	--����
						nglw = 592	
					elseif ms441b == 16 then	--����
						nglw = 999
					elseif ms441b == 17 then	--��ң
						nglw = 998
					elseif ms441b == 18 then	--�ſ�
						nglw = 997
					elseif ms441b == 19 then	--ȡ��
						return
					end
				end
				
				--��û���������ժ������91���磬97Ǭ����111��أ�152���ϣ�153�ټã�
				if nglw == 91 then
					QZXS(JY.Wugong[nglw]["����"].."��δ��������")
				
				--��������
				elseif nglw == 592 then
					if pid == 0 then
						setLW(nglw);
					elseif pid > 0 then
						JY.Person[pid]["����13"] = nglw
					end
					QZXS(JY.Person[pid]["����"].."�����������")
					
				--��ң��ѧ����
				elseif nglw == 998 then
					if pid == 0 then
						setLW(nglw);
					elseif pid > 0 then
						JY.Person[pid]["����13"] = nglw
					end
					QZXS(JY.Person[pid]["����"].."������ң��ѧ")
					
				--���һ�������
				elseif nglw == 999 then
					if pid == 0 then
						setLW(nglw);
					elseif pid > 0 then
						JY.Person[pid]["����13"] = nglw
					end
					QZXS(JY.Person[pid]["����"].."�������һ���")
					
				--�ſ�����
				elseif nglw == 997 then
					if pid == 0 then
						setLW(nglw);
					elseif pid > 0 then
						JY.Person[pid]["����13"] = nglw
					end
					QZXS(JY.Person[pid]["����"].."�ſ�����")
				
				--����������
				else
					if pid == 0 then
						setLW(nglw);
					elseif pid > 0 then
						JY.Person[pid]["����13"] = nglw
					end
					QZXS(JY.Person[pid]["����"].."����"..JY.Wugong[nglw]["����"])				
				end
			end
			
			--�⹦�������
			if ms44 == 2 then
				local wailw = 0
				local ms442 = JYMsgBox(JY.Person[pid]["����"].."�⹦����",
					"��ѡ����Ҫ������⹦��"..
					"*01��Ȼ�� 02������ 03��Ӣ�� 04���｣ 05Ѫ�� "..
					"*06��ɽ�� 07̩ɽ�� 08��ɽ�� 09��ɽ�� 10��ɽ��"..
					"*11��ָ�� 12��ת�� 13�ֶ�����",
					{"01","02","03","04","05","06","07","08","09","10","11","12","13","X"}
					,14,320)
				if ms442 == 1 then	--������Ȼ
					wailw = 997
				elseif ms442 == 2 then --������
					wailw = 26
				elseif ms442 == 3 then	--������Ӣ
					wailw = 12
				elseif ms442 == 4 then	--��������
					wailw = 38
				elseif ms442 == 5 then	--����Ѫ��
					wailw = 63
				elseif ms442 >= 6 and ms442 <= 10 then	--��������
					wailw = ms442 + 24
				elseif ms442 == 11 then --������ָ��
					wailw = 155
				elseif ms442 == 12 then --����ת����
					wailw = 43
				elseif ms442 == 13 then	--��������
					DrawStrBoxWaitKey("�����⹦���", C_WHITE, CC.DefaultFont, 1)
					local waigong = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
					for i = waigong, waigong do
						wailw = i
					end
				end
				
				if pid == 0 then
					setLW1(wailw)
				elseif pid > 0 then
					JY.Person[pid]["����15"] = wailw
				end
				if wailw ~= 997 then
				QZXS(JY.Person[pid]["����"].."����"..JY.Wugong[wailw]["����"])
				else
				QZXS(JY.Person[pid]["����"].."��������ʮ����")
				end
			end
			if ms44 == 3 then
				local qinglw = 0
				DrawStrBoxWaitKey("�����Ṧ���", C_WHITE, CC.DefaultFont, 1)
					local qinggong = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
					for i = qinggong, qinggong do
						qinglw = i
					end
				if pid == 0 then
					setLW2(qinglw)
				elseif pid > 0 then
					JY.Person[pid]["����15"] = qinglw
				end
				QZXS(JY.Person[pid]["����"].."����"..JY.Wugong[qinglw]["����"])
			end
		end
		--�����书��ȴ
		if ms4 == 5 then
			Cls()
			DrawStrBox(CC.MainSubMenuX, CC.MainSubMenuY, "˭Ҫ��������?", C_WHITE, CC.DefaultFont);
			nexty = CC.MainSubMenuY + CC.SingleLineHeight;
			s = SelectTeamMenu(CC.MainSubMenuX, nexty);
			if s==0 then return end
			pid = JY.Base["����"..s];
			if JY.Person[pid]["�书1"]==0 then
				QZXS("δѧϰ�书���޷���ȴ")
				return
			end
			local kfmenu={{nil,nil,0},{nil,nil,0},{nil,nil,0},{nil,nil,0},{nil,nil,0},
						{nil,nil,0},{nil,nil,0},{nil,nil,0},{nil,nil,0},{nil,nil,0},{nil,nil,0},{nil,nil,0}};
			for i=1,12 do
				kfmenu[i][1]=JY.Wugong[JY.Person[pid]["�书"..i]]["����"]
				if JY.Person[pid]["�书"..i]~=0 then
					kfmenu[i][3]=1
				end
			end
			Cls();
			local r=ShowMenu(kfmenu,12,0,12,12,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE)
			if r==0 then return end
			if JY.Person[pid]["�书"..r]==91 or (JY.Person[pid]["�书"..r]>108 and 113>JY.Person[pid]["�书"..r]) then
				QZXS(JY.Wugong[JY.Person[pid]["�书"..r]]["����"].."���ܱ�������")
				return
			elseif JY.Person[pid]["�书2"]==91 and JY.Person[pid]["�书3"]==0 then
				QZXS("ѧ�˷��ֻ������������Ҫ��һ�����ܣ�����������")
				return
			end
			if DrawStrBoxYesNo(-1,-1,"ȷ��Ҫ����"..JY.Wugong[JY.Person[pid]["�书"..r]]["����"].."��",C_WHITE,CC.DefaultFont)==false then
				Cls();
			else
				QZXS(JY.Wugong[JY.Person[pid]["�书"..r]]["����"].."�Ѿ�������")
				if r > 0 then
					local i=nil
					for i=r,12 do
						if JY.Person[pid]["�书"..i]==0 then 
							break 
						end
						if JY.Person[pid]["�书2"]==91 and i==1 then
							JY.Person[pid]["�书�ȼ�1"]=JY.Person[pid]["�书�ȼ�3"]
							JY.Person[pid]["�书1"]=JY.Person[pid]["�书3"]
						elseif JY.Person[pid]["�书2"]==91 and i==2 then
						elseif i==12 then
							JY.Person[pid]["�书�ȼ�12"]=0
							JY.Person[pid]["�书12"]=0
						else
							JY.Person[pid]["�书�ȼ�"..i]=JY.Person[pid]["�书�ȼ�"..i+1]
							JY.Person[pid]["�书"..i]=JY.Person[pid]["�书"..i+1]
						end
					end
				end
			end
		end
	end
	
	--ȫ�ֲ���������ֵ�����ܵ㡢�Ѷ�ֵ����Ŀ��������ѣ�
	if ms == 5 then
		local ms5 = JYMsgBox("ȫ�ֲ���",
				"��ѡ����Ҫ�޸ĵ�����������ݡ�               ",
				{"����ֵ","���ܵ�","�Ѷ�ֵ","��Ŀ��","�����","ȡ��"}
				,6,320)
				
		--����ֵ
		if ms5 == 1 then
			Cls()
			DrawStrBoxWaitKey("������Ҫ�ĵ���ֵ��", C_WHITE, CC.DefaultFont, 1)
			local daode = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
			for i=daode, daode do
				JY.Person[0]["Ʒ��"] = i
			end
			QZXS("����ֵ��Ϊ"..JY.Person[0]["Ʒ��"])
		end
		
		--���ܵ�
		if ms5 == 2 then
			DrawStrBoxWaitKey("�������ӵļ��ܵ�", C_WHITE, CC.DefaultFont, 1)
	    	local jinengdian = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
			for i=jinengdian,jinengdian do
				CC.SKpoint = CC.SKpoint + i
			end
			QZXS("���ܵ��޸ģ���浵���ؿ���Ϸ");
		end
		
		--�Ѷ�ֵ
		if ms5 == 3 then
			DrawStrBoxWaitKey("�������Ѷȣ�1-6��", C_WHITE, CC.DefaultFont, 1)
			local nandu = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
			for i=nandu, nandu do
				JY.Thing[202] [WZ7] = i
			end
			QZXS("�޸��Ѷ�ֵò��û��ɶЧ��");
		end
		
		--��Ŀ��
		if ms5 == 4 then
			DrawStrBoxWaitKey("��������Ŀ����1-99��", C_WHITE, CC.DefaultFont, 1)
			local zhoumu = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
			for i=zhoumu, zhoumu do
				JY.Thing[203] [WZ6] = i
			end	
			QZXS("��Ŀ���޸ģ���浵���ؿ���Ϸ");
		end	

		--�����
		if ms5 == 5 then
			local ms55 = JYMsgBox("��Ӷ���", 
				"��ѡ����Ҫ�����ӵ���Ա��                                  ",
				{"�޾Ʋ���","  ����  "," ��ң�� ","�������","�ֶ�����","ȡ�����"}
				,6,320)
			
			--�����¶���λ��
			local duiyounum = 1
			for i = 1, CC.TeamNum do                 
				local id = JY.Base["����" .. i];
				if id >= 0 then
					duiyounum = duiyounum + 1
				end
			end
			if duiyounum > CC.TeamNum then
				duiyounum = CC.TeamNum
			end
			
			--����¶���
			if ms55 == 1 then --�޾Ʋ���
				JY.Base ["����"..duiyounum] = 455
			end
			if ms55 == 2 then --����
				JY.Base ["����"..duiyounum] = 599
			end
			if ms55 == 3 then --��ң��
				JY.Base ["����"..duiyounum] = 618
			end
			if ms55 == 4 then --�������
				JY.Base ["����"..duiyounum] = 592
			end	
			if ms55 == 5 then --�ֶ�����
				Cls()
				DrawStrBoxWaitKey("������ӵĶ��ѱ�š�", C_WHITE, CC.DefaultFont, 1)
				local duiyou = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				for i = duiyou, duiyou do
					JY.Base ["����"..duiyounum] = i
				end
			end
		end		
	end
	
	--���ع��ܣ���Ѫ������
	if ms == 7 then
		JY.Wugong[91]["����"] = "��Ѫ������"
		JY.ZLXF = 1
		for i = 1, CC.TeamNum do                 
			local id = JY.Base["����" .. i];
			if id >= 0 then
				local wg = 1
				local zl = 0
				for i = 1, 12 do
					if JY.Person[id]["�书"..i] ~= nil and JY.Person[id]["�书"..i] ~= 0 then
						wg = i + 1
					end
					if JY.Person[id]["�书"..i] == 91 then
						zl = 1
					end
				end
				if zl == 0 then
					if wg < 13 then
						JY.Person[id]["�书"..wg] = 91
						JY.Person[id]["�书�ȼ�"..wg] = 30000
					else
						JY.Person[id]["�书12"] = 91
						JY.Person[id]["�书�ȼ�12"] = 30000
					end
					AddPersonAttrib(id, "�������ֵ", 2000)
					AddPersonAttrib(id, "�������ֵ", 10000)
					QZXS(JY.Person[id]["����"].."�����Ѫ������")
				end
			end
		end
	end

	
--��̨����

--��Ӷ����ڹ�������
local wglw_old = wglw
function wglw(pid, f) --����
	local lwold = wglw_old(pid, f)
	if lwold then

	else
		if JY.Person[pid]["����13"] == f and PersonKF(pid,f) then
			lwold = true
  		end
	end
	return lwold
end

--��Ӷ����⹦������
local wglw1_old = wglw1
function wglw1(pid, f) --����
	local lw1old = wglw1_old(pid, f)
	if lw1old then

	else
		if JY.Person[pid]["����15"] == f and PersonKF(pid,f) then
			lw1old = true
  		end
	end
	return lw1old
end

--�޸��ҵĴ������ȡ����ѯ���Ƿ���
function Menu_MYDIY()
  Cls()
  dofile(CONFIG.ScriptPath .. "DIY.lua")
  return 1
end