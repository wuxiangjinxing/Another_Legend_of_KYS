if DrawStrBoxYesNo(-1, -1, "Ҫ�����˲���ô��", C_WHITE, 30) == true then
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

if DrawStrBoxYesNo(-1, -1, "Ҫ����NPCô��", C_WHITE, 30) == true then
instruct_10(50)
instruct_10(592)
instruct_10(455)
instruct_10(597)
instruct_10(607)
instruct_10(419)
instruct_10(430)
instruct_10(440)
instruct_10(580)
instruct_10(613)
end

if DrawStrBoxYesNo(-1, -1, "Ҫ��ʼ����������ô��", C_WHITE, 30) == true then
JoinMP(7,14,4) --��̫��
JoinMP(24,14,4) --��׺�
JoinMP(25,12,5) --�����
JoinMP(43,14,4) --����
JoinMP(67,18,5) --��ǧ��
JoinMP(71,13,5) --�鰲ͨ
JoinMP(83,12,5) --������
JoinMP(87,13,2) --����
JoinMP(137,14,1) --�´ﺣ
JoinMP(166,14,3) --�����
JoinMP(176,12,2) --�κ�ҩ
JoinMP(180,14,2) --����
JoinMP(181,14,2) --���ӻ�
JoinMP(184,14,3) --������
JoinMP(596,13,5) --�鰲ͨ
JoinMP(626,14,4) --�����
JoinMP(629,14,2) --����
JoinMP(661,14,2) --����

for i = 211, 220 do --��ǵ���
	JoinMP(i,14,1)
end

for i = 221, 230 do --�嶾��ͽ
	JoinMP(i,12,1)
end

for i = 241, 250 do --ѩɽ����
	JoinMP(i,14,1)
end

for i = 281, 290 do --���ư���
	JoinMP(i,18,1)
end

for i = 340, 349 do --���ص���
	JoinMP(i,14,1)
end

for i = 390, 398 do --������ͽ
	JoinMP(i,13,1)
end
JoinMP(399,13,2)

for i = 669, 678 do --��ǵ���
	JoinMP(i,14,1)
end

for i = 679, 688 do --�嶾��ͽ
	JoinMP(i,12,1)
end

for i = 699, 708 do --ѩɽ����
	JoinMP(i,14,1)
end

for i = 739, 748 do --���ư���
	JoinMP(i,18,1)
end

for i = 798, 807 do --���ص���
	JoinMP(i,14,1)
end

for i = 848, 856 do --������ͽ
	JoinMP(i,13,1)
end
JoinMP(857,13,2)
end

--[[
for id = 0, JY.ThingNum - 1 do
	if JY.Thing[id]["����"] <= 2 then
		instruct_32(id)
	end
end

for i = 1, CC.HZNum do
	addHZ(i);
end

--DIYר���˺�����
function War_DIY_WugongHurtLife(emenyid, wugong, hurt, ang, dng)
	local eid = WAR.Person[emenyid]["������"]
	return hurt, ang, dng;
end

--�����壺DIYս���Ӻ���ר��
function War_DIY_Fight(id, wugong, level, ng)
	return ng;
end
]]