--  �ҵ�ʹ���书���� ��������(�ƶ�λ�á�����λ��)ѡ��
--		����ҵ������ƶ�����λ�ã��ڸù���ʩ��λ�ý����书����
--		����Ҳ��������ƶ�һ�£�������������Ϣһ��
function unnamed(kfid)
	local pid=WAR.Person[WAR.CurID]["������"]
	local kungfuid=JY.Person[pid]["�书"..kfid]
    local kungfulv=JY.Person[pid]["�书�ȼ�" .. kfid];
	if kungfulv>=999 then 
		kungfulv=11
	else
		kungfulv=math.modf(kungfulv/100)+1
	end
	local m1,m2,a1,a2,a3,a4,a5= refw(kungfuid,kungfulv)
	local mfw={m1,m2}
	local atkfw={a1,a2,a3,a4,a5}
	if kungfulv>10 then kungfulv=10 end
	local kungfuatk=JY.Wugong[kungfuid]["������"..kungfulv]
	local atkarray={}
	local num=0
	
 	CleanWarMap(4,-1);
	local mv = math.min(WAR.Person[WAR.CurID]["�ƶ�����"], 15)
	local movearray=War_CalMoveStep(WAR.CurID,mv,0)		-- ��¼���п��ƶ�����λ��
	local starttime=lib.GetTime();
	for i=0,mv do
		local step_num=movearray[i].num ;
		if step_num==nil or step_num==0 then
			break;
		end
		
		for j=1,step_num do
			local xx=movearray[i].x[j]
			local yy=movearray[i].y[j]
			num=num+1
			atkarray[num]={}
			atkarray[num].x,atkarray[num].y=xx,yy																											-- ��¼ ������ƶ�����λ��
			atkarray[num].p,atkarray[num].ax,atkarray[num].ay=GetAtkNum(xx,yy,mfw,atkfw,kungfuatk)		-- ��¼ �����ƶ�����λ�ú�������� ���书ʩ�ŵ�λ�ã��Լ���Ӧ������ֵ
			atkarray[num].p=atkarray[num].p*5/(3+math.max(i,2))																				-- ����ѡ�������λ��
		end
		
	end

	--[[
	local function quickSort(array, piv, r)
		local function partition(array, piv, r)
			local x = array[r].p
			local i = piv - 1
			for j = piv, r - 1 do
				if array[j].p >= x then
					i = i + 1
					array[i], array[j] = array[j], array[i]
				end
			end
			array[i + 1], array[r] = array[r], array[i + 1]
			return i + 1
		end
		
		piv = piv or 1
		r = r or #array
		if piv < r then
			local q = partition(array, piv, r)
			quickSort(array, piv, q - 1)
			quickSort(array, q + 1, r)
		end
	end

	quickSort(atkarray)
	]]
	
	for i=1,num-1 do																				-- ������ֵ�����ƶ�λ�á�ʩ��λ�õ�ѡ�����	��������
		for j=i+1,num do
			if atkarray[i].p<atkarray[j].p then
				atkarray[i],atkarray[j]=atkarray[j],atkarray[i]
			end
		end
	end

	if atkarray[1].p>0 then
		for i=1,num do
			if atkarray[i].p==0 or atkarray[i].p<atkarray[1].p/2 then			-- ���˵� ����ֵ �����������ֵһ�����Щѡ��
				num=i-1
				break;
			end
		end
		for i=1,num do
			atkarray[i].p=atkarray[i].p+GetMovePoint(atkarray[i].x,atkarray[i].y)
		end
		for i=1,num-1 do														-- �ٴ�����
			for j=i+1,num do
				if atkarray[i].p<atkarray[j].p then
					atkarray[i],atkarray[j]=atkarray[j],atkarray[i]
				elseif atkarray[i].p==atkarray[j].p then
					if math.random(2)==1 then
						atkarray[i],atkarray[j]=atkarray[j],atkarray[i]
					end
				end
			end
		end
		--quickSort(atkarray)
		for i=2,num do
			if atkarray[i].p<atkarray[1].p-15 then		-- ���˵� ����ֵ �����������ֵ-15 ����Щѡ��
				num=i-1
				break;
			end
		end
		if num > 6 then																-- �����ǲ���Ӧ�øĳ� С�ڣ�����Ҳû��ϵ����������Ҳ����
			for i=num,6 do
				if atkarray[i]~=nil and atkarray[i].p~=nil and atkarray[i].p<atkarray[1].p-50 then
					num=i-1
					break
				end
			end
		end
		local endtime=starttime+100-lib.GetTime()
		if endtime>0 then
			lib.Delay(endtime)
		end
		local select
		select=1																		-- ���滹���˸�ɶ����������ѡ�˵�һ���������ֵ���Ǹ�
		War_CalMoveStep(WAR.CurID,mv,0)					-- չʾѡ���ƶ�λ�õĶ���
		War_MovePerson(atkarray[select].x,atkarray[select].y)										-- �ƶ��������ƶ�λ�õĶ���չʾ
		WAR.Person[WAR.CurID]["Action"]={'atk',kfid,atkarray[select].ax-atkarray[select].x,atkarray[select].ay-atkarray[select].y}
		War_Fight_Sub(WAR.CurID,kfid,atkarray[select].ax,atkarray[select].ay)		-- ������ʩ��λ�� �����书ʩ��
	else
		local endtime=starttime+100-lib.GetTime()		-- �Ҳ������������������(�ƶ�λ�á�����λ��)ѡ�������ƶ�һ�£�������������Ϣһ��
		if endtime>0 then
			lib.Delay(endtime)
		end
		local jl,nx,ny=War_realjl()
		if jl==-1 then
			AutoMove()
		else
			local vv
			vv=GetWarMap(nx+1,ny,2)
			if vv>-1 and WAR.Person[vv]["�ҷ�"]~=WAR.Person[WAR.CurID]["�ҷ�"] then
		
			else
				vv=GetWarMap(nx-1,ny,2)
				if vv>-1 and WAR.Person[vv]["�ҷ�"]~=WAR.Person[WAR.CurID]["�ҷ�"] then
			
				else
					vv=GetWarMap(nx,ny+1,2)
					if vv>-1 and WAR.Person[vv]["�ҷ�"]~=WAR.Person[WAR.CurID]["�ҷ�"] then
				
					else
						vv=GetWarMap(nx,ny-1,2)
					end
				end
			end
			local array={}
			local an=0
			local movearray=War_CalMoveStep(WAR.CurID,mv,0)
			War_CalMoveStep(vv,jl,0)
			for i=1,mv do
				local step_num=movearray[i].num ;
				if step_num==nil or step_num==0 then
					break;
				end		
				for j=1,step_num do
					local xx=movearray[i].x[j]
					local yy=movearray[i].y[j]
					local Dest=GetWarMap(xx,yy,3)
					if Dest<255 then
						an=an+1
						array[an]={}
						array[an].x=xx
						array[an].y=yy
						array[an].p=jl-Dest
					end
				end
			end
			for i=1,an-1 do
				for j=i+1,an do
					if array[i].p<array[j].p then
						array[i],array[j]=array[j],array[i]
					end
				end
			end
			for i=2,an do
				if array[i].p<array[1].p/2 then
					an=i-1
					break
				end
			end
			for i=1,an do
				array[i].p=array[i].p+GetMovePoint(array[i].x,array[i].y)
			end
			for i=1,an-1 do
				for j=i+1,an do
					if array[i].p<array[j].p then
						array[i],array[j]=array[j],array[i]
					end
				end
			end
			if an>0 then
				War_CalMoveStep(WAR.CurID,mv,0)
				War_MovePerson(array[1].x,array[1].y)
			else
				AutoMove()
			end
		end
		if JY.Person[pid]["����"] < 20 or JY.Person[pid]["����"] < War_GetMinNeiLi(pid) * 10 then
			War_RestMenu()
		elseif PersonKF(pid, 103) then
			War_ActupMenu()
		elseif PersonKF(pid, 101) then
			War_DefupMenu()
		elseif JY.Person[pid]["����"] > math.modf(JY.Person[pid]["�������ֵ"] * 0.5) then
			War_ActupMenu()
		else
			War_DefupMenu()
		end
	end
	return
end
function ReadKDEF(id)
	--id�¼����
	local kidx=Byte.create(id*4+4)
	Byte.loadfile(kidx,CC.KDX,0,id*4+4)
	local idx1,idx2
	if id<1 then
		idx1=0
	else
		idx1=Byte.get32(kidx,(id-1)*4)
	end
	idx2=Byte.get32(kidx,id*4)
	--idx,���Ϊid���¼�������ֵ
	local len=idx2-idx1
	local kdef=Byte.create(len)
	Byte.loadfile(kdef,CC.KRP,idx1,len)
	local E={}
	len=len/2
	--lib.Debug(len)
	for i=0,len-1 do
		--lib.Debug(lib.GetTime())
		E[i]=Byte.get16(kdef,2*i)
	end
	local idx=0		--
	
local function NewInstruct_50(code,e1,e2,e3,e4,e5,e6)
	lib.Debug(string.format('50code::[%d:%d:%d:%d:%d:%d:%d]start:%d',code,e1,e2,e3,e4,e5,e6,lib.GetTime()))
	local function getb(b,num)
		num=math.modf(num/(2^b))
		num=math.fmod(num,2)
		return num
	end
	local function getvaule(b,t,ee)
		if getb(b,t)==1 then
			return Byte.get16(x50,ee*2)
		else
			return ee
		end
	end
	local newinstruct_50_sub={
							[0]=function()	--3.1.	������ֵ50(0,x,v,-1,-1,-1,-1)
								Byte.set16(x50,e1*2,e2)
							end,
							[1]=function()	--3.2.	���������ֵ50(1, type1,type2,x, I , y , -1)
								--e3=Byte.get16(x50,e3*2)
								e4=getvaule(0,e1,e4)
								e5=getvaule(1,e1,e5)
								--lib.Debug((e3+e4)..','..e5)
								if e2==0 then
									Byte.set16(x50,(e3+e4)*2,e5)
								elseif e2==1 then
									local num=Byte.get16(x50,(e3+e4)*2)
									num=math.modf(num/256)
									e5=math.fmod(num,256)
									e5=num*256+e5
									Byte.set16(x50,(e3+e4)*2,e5)
								end
								lib.Debug(e3..','..e4..'|'..e5)
							end,
							[2]=function()	--3.3.	ȡ�������ֵ50(2, type1,type2,x, I , y , -1)
								--e3=Byte.get16(x50,e3*2)
								e4=getvaule(0,e1,e4)
								--e5=Byte.get16(x50,e5*2)
								local num=Byte.get16(x50,(e3+e4)*2)
								if e2==1 then
									num=math.fmod(num,256)
								end
								Byte.set16(x50,e5*2,num)
							end,
							[3]=function()	--3.4.	��������(3, type1,type2,y, a , b , -1 )
								if e2==5 then
									e4=Byte.getu16(x50,e4*2)
									e2=3
								else
									e4=Byte.get16(x50,e4*2)
								end
								--e3=Byte.get16(x50,e3*2)
								e5=getvaule(0,e1,e5)
								if e2==0 then
									Byte.set16(x50,e3*2,e4+e5)
								elseif e2==1 then
									Byte.set16(x50,e3*2,e4-e5)
								elseif e2==2 then
									Byte.set16(x50,e3*2,e4*e5)
								elseif e2==3 then
									Byte.set16(x50,e3*2,math.modf(e4/e5))
								elseif e2==4 then
									Byte.set16(x50,e3*2,math.fmod(e4,e5))
								end
								lib.Debug(e3..','..e4..'|'..e5)
							end,
							[4]=function()	--3.5.	�����ж�(4, Type1, Type2,a, b , -1, -1 )
								Byte.set16(x50,28672,1)
								lib.Debug(e3)
								e3=Byte.get16(x50,e3*2)
								lib.Debug(e3)
								e4=getvaule(0,e1,e4)
								if e2==0 and e3<e4 then
									Byte.set16(x50,28672,0)
								elseif e2==1 and e3<=e4 then
									Byte.set16(x50,28672,0)
								elseif e2==2 and e3==e4 then
									Byte.set16(x50,28672,0)
								elseif e2==3 and e3~=e4 then
									Byte.set16(x50,28672,0)
								elseif e2==4 and e3>=e4 then
									Byte.set16(x50,28672,0)
								elseif e2==5 and e3>e4 then
									Byte.set16(x50,28672,0)
								elseif e2==6 then
									Byte.set16(x50,28672,0)
								end
							end,
							[5]=function()	--3.6.	ȫ����������(5,-1,-1,-1,-1,-1,-1)
								for i=0,32764,4 do
									Byte.set32(x50,i,0)
								end
							end,
							[8]=function()	--4.1.	���Ի����ַ���(8,type,id,x ,-1 , -1, -1)
								e2=getvaule(0,e1,e2)
								--e3=Byte.get16(x50,e3*2)
								local tidx=Byte.create(e2*4+4)
								Byte.loadfile(tidx,CC.TDX,0,e2*4+4)
								local idx1,idx2
								if e2<1 then
									idx1=0
								else
									idx1=Byte.get32(tidx,(e2-1)*4)
								end
								idx2=Byte.get32(tidx,e2*4)
								local len=idx2-idx1
								local talk=Byte.create(len)
								Byte.loadfile(talk,CC.TRP,idx1,len)
								local str=''
								for i=0,len-2 do
									local byte=Byte.getu16(talk,i)
									byte=255-math.fmod(byte,256)
									str=str..string.char(byte)
									--Byte.setu16(x50,e3*2+i,byte)
								end
								str=lib.CharSet(str,0)
								for i=0,len-1 do
									local byte=string.byte(str,i+1)
									Byte.setu16(x50,e3*2+i,byte)
								end
								lib.Debug(e3..','..str)
							end,
							[9]=function()	--4.2.	sprintf(9, type,s, format, x, -1, -1)
								e4=getvaule(0,e1,e4)
								local str=''
								for i=0,1000 do
									local byte=Byte.getu16(x50,e3*2+i)
									byte=math.fmod(byte,256)
									if byte>0 then
										str=str..string.char(byte)
									else
										break
									end
								end
								str=string.format(str,e4)
								for i=0,string.len(str)-1 do
									Byte.setu16(x50,e2*2+i,string.byte(str,i+1))
								end
								lib.Debug('50-9[['..str..'[['..e4)
							end,
							[10]=function()	--4.3.	ȡ�ַ�������(10,s,l,-1,-1,-1)
								for i=0,1000 do
									local byte=Byte.getu16(x50,e1*2+i)
									byte=math.fmod(byte,256)
									if byte==0 then
										Byte.setu16(x50,e2*2,i)
										break
									end
								end
							end,
							[11]=function()	--4.4.	�ַ����ϲ�(11,x,a,b,-1,-1)
								local stra,strb,strx='',''
								for i=0,1000 do
									local byte=Byte.getu16(x50,e2*2+i)
									byte=math.fmod(byte,256)
									if byte>0 then
										stra=stra..string.char(byte)
									else
										break
									end
								end
								for i=0,1000 do
									local byte=Byte.getu16(x50,e3*2+i)
									byte=math.fmod(byte,256)
									if byte>0 then
										strb=strb..string.char(byte)
									else
										break
									end
								end
								strx=stra..strb	
								for i=0,string.len(strx)-1 do
									Byte.setu16(x50,e1*2+i,string.byte(strx,i+1))
								end
								lib.Debug('50-10[['..strx)
							end,
							[12]=function()	--4.5.	�����ո��ַ���(12,type,s,n,-1,-1)
								if e1==1 then
									e3=Byte.get16(x50,e3*2)
								end
								for i=0,e3-1 do
									Byte.setu16(x50,e2*2+i,32)
								end
							end,
							[16]=function()	--5.1.	����������Ʒ������(16, type1,type2,id, i , x, -1)
								e3=getvaule(0,e1,e3)
								e4=getvaule(1,e1,e4)
								e5=getvaule(2,e1,e5)
								local v
								if e2==0 then
									Byte.set16(JY.Data_Person,CC.PersonSize*e3+e4,e5)
								elseif e2==1 then
									Byte.set16(JY.Data_Thing,CC.ThingSize*e3+e4,e5)
								elseif e2==2 then
									Byte.set16(JY.Data_Scene,CC.SceneSize*e3+e4,e5)
								elseif e2==3 then
									Byte.set16(JY.Data_Wugong,CC.WugongSize*e3+e4,e5)
								elseif e2==4 then
									Byte.set16(JY.Data_Shop,CC.ShopSize*e3+e4,e5)
								end
								lib.Debug('OOO|'..e3..','..e4..','..e5)
							end,
							[17]=function()	--5.2.	ȡ������Ʒ������(17, type1,type2��id, i , x, -1)
								e3=getvaule(0,e1,e3)
								e4=getvaule(1,e1,e4)
								--e5=Byte.get16(x50,e5*2)
								local v
								if e2==0 then
									v=Byte.get16(JY.Data_Person,CC.PersonSize*e3+e4)
								elseif e2==1 then
									v=Byte.get16(JY.Data_Thing,CC.ThingSize*e3+e4)
								elseif e2==2 then
									v=Byte.get16(JY.Data_Scene,CC.SceneSize*e3+e4)
								elseif e2==3 then
									v=Byte.get16(JY.Data_Wugong,CC.WugongSize*e3+e4)
								elseif e2==4 then
									v=Byte.get16(JY.Data_Shop,CC.ShopSize*e3+e4)
								end
								Byte.set16(x50,e5*2,v)
								lib.Debug(e2..','..e3..','..e4..','..v)
							end,
							[18]=function()	--5.3.	�����(18, type,id, x , -1, -1, -1)
								e2=getvaule(0,e1,e2)
								e3=getvaule(1,e1,e3)
								JY.Base['����'..e2]=e3
							end,
							[19]=function()	--5.4.	ȡ����(19, type,id, x , -1, -1, -1)
								e2=getvaule(0,e1,e2)
								--e3=Byte.get16(e3*2)
								Byte.set16(x50,e3*2,JY.Base['����'..(e2+1)])
							end,
							[20]=function()	--5.5.	�õ�����Я������Ʒ���� (20,type,i, x , -1, -1, -1)
								e2=getvaule(0,e1,e2)
								--e3=Byte.get16(e3*2)
								for i=1,CC.MyThingNum do
									if JY.Base['��Ʒ'..i]==e2 then
										Byte.set16(x50,e3*2,JY.Base['��Ʒ����'..i])
										break
									end
								end
							end,
							[21]=function()	--5.6.	��D*����(21,type,id, i , j, x, -1)
								e2=getvaule(0,e1,e2)
								e3=getvaule(1,e1,e3)
								e4=getvaule(2,e1,e4)
								e5=getvaule(3,e1,e5)
								lib.SetD(e2,e3,e4,e5)
							end,
							[22]=function()	--5.7.	ȡD*����(22,type,id, i , j, x, -1)
								e2=getvaule(0,e1,e2)
								e3=getvaule(1,e1,e3)
								e4=getvaule(2,e1,e4)
								--e5=Byte.get16(x50,e5*2)
								Byte.set16(x50,e5*2,lib.GetD(e2,e3,e4))
							end,
							[23]=function()	--5.8.	��S*����(23,type,id, i , x, y, v)
								e2=getvaule(0,e1,e2)
								e3=getvaule(1,e1,e3)
								e4=getvaule(2,e1,e4)
								e5=getvaule(3,e1,e5)
								e6=getvaule(4,e1,e6)
								lib.SetS(e2,e3,e4,e5,e6)
							end,
							[24]=function()	--5.9.	ȡS*����(24,type,id, i , x, y, v)
								e2=getvaule(0,e1,e2)
								e3=getvaule(1,e1,e3)
								e4=getvaule(2,e1,e4)
								e5=getvaule(3,e1,e5)
								--e6=Byte.get16(x50,e6*2)
								Byte.set16(x50,e6*2,lib.GetS(e2,e3,e4,e5))
							end,
							[25]=function()	--5.10.	������ڴ��ַ����(25,type1,type2, AddressL ,AddressH , x, i)	
								e5=getvaule(0,e1,e5)
								e6=getvaule(1,e1,e6)
								local v
								local address=e4*65536+e3+e6
								if e2==1 then
									local num=Byte.get16(x50,e5*2)
									num=math.modf(num/256)
									v=math.fmod(num,256)
									v=num*256+v
								end
								if address==1838072 then	--������ͼ��
									JY.MyPic=e5
								elseif address==345330 then
									JY.Base['�˷���']=e5
								elseif address==1911134 then
									JY.SubScene=e5
								elseif address==1911132 then
									JY.Base['��X1']=e5
								elseif address==1911130 then
									JY.Base['��Y1']=e5
								elseif address==1911128 then
									JY.Base['��X']=e5
								elseif address==1911126 then
									JY.Base['��Y']=e5
								end
							end,
							[26]=function()	--5.11.	ȡ�����ڴ��ַ����(26,type1,type2, AddressL ,AddressH , x, i)
								--e5=getvaule(0,e1,e5)
								--e6=getvaule(1,e1,e6)
								local v
								local address=e4*65536+e3+e6
								if address==1838072 then	--������ͼ��
									v=JY.MyPic
								elseif address==345330 then
									v=JY.Base['�˷���']
								elseif address==1911134 then
									v=JY.SubScene
								elseif address==1911132 then
									v=JY.Base['��X1']
								elseif address==1911130 then
									v=JY.Base['��Y1']
								elseif address==1911128 then
									v=JY.Base['��X']
								elseif address==1911126 then
									v=JY.Base['��Y']
								end
								if e2==0 then
									Byte.set16(x50,e5*2,v)
								elseif e2==1 then
									local num=Byte.get16(x50,e5*2)
									num=math.modf(num/256)
									v=math.fmod(num,256)
									v=num*256+v
									Byte.set16(x50,e5*2,v)
								end
							end,
							[27]=function()	--5.12.	ȡ������Ʒ����������(27, type1,type2,id, s , -1, -1)
								e3=getvaule(0,e1,e3)
								--e4=Byte.get16(x50,e4*2)
								local str
								lib.Debug('50-27[['..e3)
								if e2==0 then
									str=JY.Person[e3]['����']
								elseif e2==1 then
									str=JY.Thing[e3]['����']
								elseif e2==2 then
									str=JY.Scene[e3]['����']
								elseif e2==3 then
									str=JY.Wugong[e3]['����']
								end
								for i=0,string.len(str)-1 do
									Byte.setu16(x50,e4*2+i,string.byte(str,i+1))
								end
							end,
							[32]=function()	--6.1.	�޸�ָ�����(32, type ,x,i,-1 , -1, -1)
								e3=getvaule(0,e1,e3)
								E[idx+8+e3]=Byte.get16(x50,e2*2)
							end,
							[33]=function()	--6.2.	��ʾ�ַ���(33,type,s,x,y ,color,-1)
								--e2=Byte.get16(x50,e2*2)
								e3=getvaule(0,e1,e3)
								e4=getvaule(1,e1,e4)
								e5=getvaule(2,e1,e5)
								local str=''
								for i=0,1000 do
									local byte=Byte.getu16(x50,e2*2+i)
									byte=math.fmod(byte,256)
									if byte>0 then
										str=str..string.char(byte)
									else
										break
									end
								end
								DrawStrBox(e3,e4,str,C_ORANGE,CC.DefaultFont)
								ShowScreen()
							end,
							[34]=function()	--6.3.	������(34,type,x,y,w , h,-1)
								--e2=getvaule(0,e1,e2)
								--e3=getvaule(1,e1,e3)
								--e4=getvaule(2,e1,e4)
								--e5=getvaule(3,e1,e5)
								--DrawBox(e2,e3,e2+e4,e3+e5,C_WHITE)
								--ShowScreen()
								return
							end,
							[35]=function()	--6.4.	������(35,x,-1,-1,-1 , -1,-1)
								--e1=Byte.get16(x50,e1*2)
								local key=WaitKey()
								Byte.set16(x50,e1*2)
							end,
							[36]=function()	--6.5.	��ʾ�ַ������ȴ�����(36,type,s,x,y ,color,-1)
								--e2=Byte.get16(x50,e2*2)
								e3=getvaule(0,e1,e3)
								e4=getvaule(1,e1,e4)
								e5=getvaule(2,e1,e5)
								local str=''
								for i=0,1000 do
									local byte=Byte.getu16(x50,e2*2+i)
									byte=math.fmod(byte,256)
									if byte>0 then
										str=str..string.char(byte)
									else
										break
									end
								end
								DrawStrBox(e3,e4,str,C_ORANGE,CC.DefaultFont)
								ShowScreen()
								Byte.set16(x50,28672,1)
								if WaitKey()==121 then
									Byte.set16(x50,28672,0)
								end
							end,
							[37]=function()	--6.6.	��ʱ(37,type,n, -1,-1 , -1, -1, -1)
								e2=getvaule(0,e1,e2)
								lib.Delay(e2)
							end,
							[38]=function()	--6.7.	�����(38,type, n,x , -1, -1, -1)
								e2=getvaule(0,e1,e2)
								--e3=Byte.get16(x50,e3*2)
								Byte.set16(x50,e3*2,math.random(e2)-1)
							end,
							[39]=function()	--6.8.	�˵�ѡ��(39,type,n,s,r,x,y)
								e2=getvaule(0,e1,e2)
								e5=getvaule(1,e1,e5)
								e6=getvaule(2,e1,e6)
								local mymenu={}
								for i=1,e2 do
									local str=''
									local start=Byte.get16(x50,(e3+i-1)*2)
									lib.Debug(i..','..e3..','..start)
									for i=0,1000 do
										local byte=Byte.getu16(x50,start*2+i)
										byte=math.fmod(byte,256)
										if byte>0 then
											str=str..string.char(byte)
										else
											break
										end
									end
									lib.Debug(str)
									mymenu[i]={str,nil,1}
								end
								local select
								select=ShowMenu(mymenu,e2,e2,e5,e6+10,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE)
								Byte.set16(x50,e4*2,select)
							end,
							[40]=function()
								e2=getvaule(0,e1,e2)
								e5=getvaule(1,e1,e5)
								e6=getvaule(2,e1,e6)
								local mymenu={}
								for i=1,e2 do
									local str=''
									local start=Byte.getu16(x50,e3+i)
									for i=0,1000 do
										local byte=Byte.getu16(x50,start*2+i)
										byte=math.fmod(byte,256)
										if byte>0 then
											str=str..string.char(byte)
										else
											break
										end
									end
									mymenu[i]={str,nil,1}
								end
								local select
								select=ShowMenu(mymenu,e2,e2,e5,e6,0,0,1,0,CC.DefaultFont,C_WHITE,C_ORANGE)
								Byte.set16(x50,e4*2,select)
							end,
							[41]=function()	--6.10.	��ʾͼƬָ��(41,type1,type2,x,y,n,-1)
								e3=getvaule(0,e1,e3)
								e4=getvaule(1,e1,e4)
								e5=getvaule(2,e1,e5)
								local id
								if e2==0 then
									id=0
								elseif e2==1 then
									id=1
								end
								lib.PicLoadCache(id,e5,e3,e4)
							end,
							[42]=function()	--6.11.	�ı�����ͼ����(42,type,x,y,0,0,0)
								e2=getvaule(0,e1,e2)
								e3=getvaule(1,e1,e3)
								JY.Base['��X']=e2
								JY.Base['��Y']=e3
							end,
							[43]=function()	--6.12.	���������¼�(43,type,n,x1,x2,x3,x4)
								e2=getvaule(0,e1,e2)
								e3=getvaule(1,e1,e3)
								e4=getvaule(2,e1,e4)
								e5=getvaule(3,e1,e5)
								e6=getvaule(4,e1,e6)
								Byte.set16(x50,28928,e3)
								Byte.set16(x50,28930,e4)
								Byte.set16(x50,28932,e5)
								Byte.set16(x50,28934,e6)
								ReadKDEF(e2)
							end,
						}

	newinstruct_50_sub[code]()--(e1,e2,e3,e4,e5,e6)
	--lib.Debug('50code::['..code..']end:'..lib.GetTime())
end

	
	while idx<len do
		if E[idx]==0 then	--OK
			Cls()
			idx=idx+1
		elseif E[idx]==1 then	--OKing
			--instruct_1(E[idx+1],E[idx+2],E[idx+3])
			TalkEx(ReadTALK(E[idx+1]),E[idx+2],E[idx+3],"�����������������")
			idx=idx+4
		elseif E[idx]==2 then	--OK
			instruct_2(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==3 then	--OK
			instruct_3(
							E[idx+1],E[idx+2],E[idx+3],
							E[idx+4],E[idx+5],E[idx+6],
							E[idx+7],E[idx+8],E[idx+9],
							E[idx+10],E[idx+11],E[idx+12],
							E[idx+13]
						)
			idx=idx+14
		elseif E[idx]==4 then	--OK
			if instruct_4(E[idx+1]) then
				idx=idx+E[idx+2]
			else
				idx=idx+E[idx+3]
			end
			idx=idx+4
		elseif E[idx]==5 then	--OK
			if instruct_5() then
				idx=idx+E[idx+1]
			else
				idx=idx+E[idx+2]
			end
			idx=idx+3
		elseif E[idx]==6 then	--OK
			if WarMain(E[idx+1],E[idx+4]) then
				idx=idx+E[idx+2]
			else
				idx=idx+E[idx+3]
			end
			idx=idx+5
		elseif E[idx]==7 then	--OK
			idx=idx+1
			break
		elseif E[idx]==8 then	--OK
			instruct_8(E[idx+1])
			idx=idx+2
		elseif E[idx]==9 then	--OK
			if instruct_9() then
				idx=idx+E[idx+1]
			else
				idx=idx+E[idx+2]
			end
			idx=idx+3
		elseif E[idx]==10 then	--OK
			instruct_10(E[idx+1])
			idx=idx+2
		elseif E[idx]==11 then	--OK
			if instruct_11() then
				idx=idx+E[idx+1]
			else
				idx=idx+E[idx+2]
			end
			idx=idx+3
		elseif E[idx]==12 then	--OK
			instruct_12()
			idx=idx+1
		elseif E[idx]==13 then	--OK
			instruct_13()
			idx=idx+1
		elseif E[idx]==14 then	--OK
			instruct_14()
			idx=idx+1
		elseif E[idx]==15 then	--OK
			instruct_15()
			idx=idx+2
		elseif E[idx]==16 then	--OK
			if instruct_16(E[idx+1]) then
				idx=idx+E[idx+2]
			else
				idx=idx+E[idx+3]
			end
			idx=idx+4
		elseif E[idx]==17 then	--OK
			instruct_17(E[idx+1],E[idx+2],E[idx+3],
						E[idx+4],E[idx+5])
			idx=idx+6
		elseif E[idx]==18 then	--OK
			if instruct_18(E[idx+1]) then
				idx=idx+E[idx+2]
			else
				idx=idx+E[idx+3]
			end
			idx=idx+4
		elseif E[idx]==19 then	--OK
			instruct_19(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==20 then	--OK
			if instruct_20() then
				idx=idx+E[idx+1]
			else
				idx=idx+E[idx+2]
			end
			idx=idx+3
		elseif E[idx]==21 then	--OK
			instruct_21(E[idx+1])
			idx=idx+2
		elseif E[idx]==22 then	--OK
			instruct_22()
			idx=idx+1
		elseif E[idx]==23 then	--OK
			instruct_23(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==24 then	--OK
			instruct_24()
			idx=idx+1
		elseif E[idx]==25 then	--OK
			instruct_25(E[idx+1],E[idx+2],E[idx+3],E[idx+4])
			idx=idx+5
		elseif E[idx]==26 then	--OK
			instruct_26(E[idx+1],E[idx+2],E[idx+3],
						E[idx+4],E[idx+5])
			idx=idx+6
		elseif E[idx]==27 then	--OK
			instruct_27(E[idx+1],E[idx+2],E[idx+3])
			idx=idx+4
		elseif E[idx]==28 then	--OK
			if instruct_28(E[idx+1],E[idx+2],E[idx+3]) then
				idx=idx+E[idx+4]
			else
				idx=idx+E[idx+5]
			end
			idx=idx+6
		elseif E[idx]==29 then	--OK
			if instruct_29(E[idx+1],E[idx+2],E[idx+3]) then
				idx=idx+E[idx+4]
			else
				idx=idx+E[idx+5]
			end
			idx=idx+6
		elseif E[idx]==30 then	--OK
			instruct_30(E[idx+1],E[idx+2],E[idx+3],E[idx+4])
			idx=idx+5
		elseif E[idx]==31 then	--OK
			if instruct_31(E[idx+1]) then
				idx=idx+E[idx+2]
			else
				idx=idx+E[idx+3]
			end
			idx=idx+4
		elseif E[idx]==32 then	--OK
			instruct_32(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==33 then	--OK
			instruct_33(E[idx+1],E[idx+2],E[idx+3])
			idx=idx+4
		elseif E[idx]==34 then	--OK
			instruct_34(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==35 then	--OK
			instruct_35(E[idx+1],E[idx+2],E[idx+3],E[idx+4])
			idx=idx+5
		elseif E[idx]==36 then	--OK
			if E[idx+1]<256 then
				if instruct_36(E[idx+1]) then
					idx=idx+E[idx+2]
				else
					idx=idx+E[idx+3]
				end
			else
				local tzflag=Byte.get16(x50,28672)
				if tzflag==0 then
					idx=idx+E[idx+2]
				elseif tzflag==1 then
					idx=idx+E[idx+3]
				end
			end
			idx=idx+4
		elseif E[idx]==37 then	--OK
			instruct_37(E[idx+1])
			idx=idx+2
		elseif E[idx]==38 then	--OK
			instruct_38(E[idx+1],E[idx+2],E[idx+3],E[idx+4])
			idx=idx+5
		elseif E[idx]==39 then	--OK
			instruct_39(E[idx+1])
			lib.Debug('xx')
			idx=idx+2
		elseif E[idx]==40 then	--OK
			instruct_40(E[idx+1])
			idx=idx+2
		elseif E[idx]==41 then	--OK
			instruct_41(E[idx+1],E[idx+2],E[idx+3])
			idx=idx+4
		elseif E[idx]==42 then	--OK
			if instruct_42() then
				idx=idx+E[idx+1]
			else
				idx=idx+E[idx+2]
			end
			idx=idx+3
		elseif E[idx]==43 then	--OK
			if instruct_43(E[idx+1]) then
				idx=idx+E[idx+2]
			else
				idx=idx+E[idx+3]
			end
			idx=idx+4
		elseif E[idx]==44 then	--OK
			instruct_44(E[idx+1],E[idx+2],E[idx+3],
						E[idx+4],E[idx+5],E[idx+6])
			idx=idx+7
		elseif E[idx]==45 then
			instruct_45(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==46 then
			instruct_46(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==47 then
			instruct_47(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==48 then
			instruct_48(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==49 then
			instruct_49(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==50 then
			if E[idx+1]>128 then
				instruct_50(E[idx+1],E[idx+2],E[idx+3],E[idx+4],
							E[idx+5],E[idx+6],E[idx+7])
			else
				NewInstruct_50(E[idx+1],E[idx+2],E[idx+3],E[idx+4],
								E[idx+5],E[idx+6],E[idx+7])
			end
			idx=idx+8
		elseif E[idx]==51 then
			instruct_51()
			idx=idx+1
		elseif E[idx]==52 then
			instruct_52()
			idx=idx+1
		elseif E[idx]==53 then
			instruct_53()
			idx=idx+1
		elseif E[idx]==54 then
			instruct_54()
			idx=idx+1
		elseif E[idx]==55 then	--OK
			if instruct_55(E[idx+1],E[idx+2]) then
				idx=idx+E[idx+3]
			else
				idx=idx+E[idx+4]
			end
			idx=idx+5
		elseif E[idx]==56 then
			instruct_56(E[idx+1])
			idx=idx+2
		elseif E[idx]==57 then
			instruct_57()
			idx=idx+1
		elseif E[idx]==58 then
			instruct_58()
			idx=idx+1
		elseif E[idx]==59 then
			instruct_59()
			idx=idx+1
		elseif E[idx]==60 then
			if instruct_60(E[idx+1],E[idx+2],E[idx+3]) then
				idx=idx+E[idx+4]
			else
				idx=idx+E[idx+5]
			end
			idx=idx+6
		elseif E[idx]==61 then
			if instruct_61() then
				idx=idx+E[idx+1]
			else
				idx=idx+E[idx+2]
			end
			idx=idx+3
		elseif E[idx]==62 then
			instruct_62(E[idx+1],E[idx+2],E[idx+3],E[idx+4],E[idx+5],E[idx+6])
			idx=idx+7
		elseif E[idx]==63 then	--OK
			instruct_63(E[idx+1],E[idx+2])
			idx=idx+3
		elseif E[idx]==64 then
			instruct_64()
			idx=idx+1
		elseif E[idx]==65 then
			instruct_65()
			idx=idx+1
		elseif E[idx]==66 then
			instruct_66(E[idx+1])
			idx=idx+2
		elseif E[idx]==67 then
			instruct_67(E[idx+1])
			idx=idx+2
		else
			break
		end
	end
end

function cxlist()
	local plist = {}
	local menu = {}

	say("����������ȼ���2~8��", 585)
	local T = {}
	for a = 1, 1000 do
	  local b = "" .. a
	  T[b] = a
	end
	local dj = -1
	while dj == -1 do
		local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
		if T[r] ~= nil and T[r] >= 2 and T[r] <= 8 then
		  dj = T[r]
		else
			DrawStrBoxWaitKey("�������", C_WHITE, 30)
		end
	end
	
	for i = 1, JY.PersonNum - 1 do
		local pid = i
		if not xiaobin(i) and JY.Person[pid]["����"] == dj and CC.NLJS[JY.Person[pid]["����"]] ~= nil and i ~= 92
			and i ~= 456 and i ~= 457 and i ~= 594 and i ~= 595 and i ~= 596 and i ~= 620 and i ~= 597 and i ~= 598 
			and i ~= 600 and i ~= 617 and i ~= 665 and i ~= 666 and i ~= 667 and JY.Person[i]["����"] > 1 then
			--and JY.Person[pid]["����1"] > 0 then					
			menu [#menu + 1] = 700 + 300 * (JY.Person[i]["����"] - 2)
			plist[#plist + 1]	= {}
			local person = {}
			person[0] = i		
			person[1] = JY.Person[pid]["����"]
			person[2] = "�ȼ�"..JY.Person[pid]["����"].."���������"..menu[#menu].."���ܵ�"		
			person[3] = ""
			if CC.NLJS[JY.Person[pid]["����"]][1] ~= "�ƺţ�" then
				for j = 1, #CC.NLJS[JY.Person[pid]["����"]] do
					person[#person+1] = CC.NLJS[JY.Person[pid]["����"]][j]
				end			
				person[#person+1] = ""
			end
			for i = 1, 5 do
				if JY.Person[pid]["����"..i] > 0 then				
					if i == 1 and JY.Person[pid]["����"..i + 1] <= 0 then
						person[#person+1] = "�츳".."��"..CC.TFlist[JY.Person[pid]["����"..i]][1]	
					else
						person[#person+1] = "�츳"..CC.NUM[i].."��"..CC.TFlist[JY.Person[pid]["����"..i]][1]	
					end
					person[#person+1] = CC.TFlist[JY.Person[pid]["����"..i]][2]
				else
					break
				end
				if i ~= 5 then
					person[#person+1] = ""
				end
			end			
			--[[person[#person+1] = "��ϰ�书��"
			for i = 1, 10 do
				if JY.Person[pid]["�书"..i] > 0 then]]
					--person[#person] = person[#person]..JY.Wugong[JY.Person[pid]["�书"..i]]["����"]
					--[[if i ~= 10 and JY.Person[pid]["�书"..i + 1] ~= nil and 
						JY.Person[pid]["�书"..i + 1] > 0 then
						person[#person] = person[#person].."��"
					end
				elseif i == 1 then
					person[#person] = person[#person].."��"
					break
				else
					break
				end
			end]]
			breakdown(person, 50)		
			plist[#plist] = person
		end	
	end	
	return plist
end	

function newgame()
	CC.ICONPICFILE = {CONFIG.DataPath .. "icon.idx", CONFIG.DataPath .. "icon.grp"}
	lib.PicLoadFile(CC.ICONPICFILE[1], CC.ICONPICFILE[2], 54)
	say("��ӭ����������⽣Ӱ�����磬������ɽ�ͣ��г�կ���н�������ƣ���ɽկ������", 585)
	local hard, mode, fight = gamemode()
	JY.Thing[202][WZ7] = hard
	JY.DIFF = JY.Thing[202][WZ7] --�Ѷ� 
	if fight == 1 then --ս��ģʽ
		SetS(4, 7, 7, 5, 0)	
	elseif fight == 2 then
		SetS(4, 7, 7, 5, 1)
	elseif fight == 3 then
		SetS(4, 7, 7, 5, 2)
	end
	
	for p = 1, JY.PersonNum - 1 do
		if (not duiyou(p)) and (JY.Person[p]["����"] == 10 or JY.Person[p]["����"] == 60) and xiaobin(p) then
			JY.Person[p]["����"] = math.random(10, 90)
		end
	end  
	Cls()
	SetS(103, 0, 0, 1, 0)
	if mode == 3 then
		local menu = {}
		local r
		say("�ڿ�ʼ����ó�֮ǰ����ش𼸸����⡣", 585)
		say("������ģ��Ա���ǣ�", 585)
		menu = {
			{"  ��ü  ", nil, 1},
			{"  ����  ", nil, 1},	
		}
		r = ShowMenu3(menu,#menu,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,nil, nil,M_DimGray,C_RED)
		JY.Person[0]["�Ա�"] = r - 1
		say("����������մ����ף�", 585)	
		JY.Person[0][CC.s23] = "";
		while JY.Person[0][CC.s23] == "" do
			JY.Person[0][CC.s23] = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
			if JY.Person[0][CC.s23] == "" then
				DrawStrBoxWaitKey("û������ô����Ϸ", C_WHITE, 30)
			end
		end	
		say("����������������һ��������һ�������ĳƺŰɣ���ģϳƺţ��ǣ�", 585)
		JY.Person[578]["����"] = "";
		while JY.Person[578]["����"] == "" do
			JY.Person[578]["����"] = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
			if JY.Person[578]["����"] == "" then
				DrawStrBoxWaitKey("���Լ�����ƺŰ�", C_WHITE, 30)
			end
		end		
		
		say("��Ȼ��Щð��������ģϳ��������ô�����أ�", 585)
		JY.Person[0]["������"] = pickhead()
		say("��Ȼ��һ���˲ţ���ô���ڣ�ս��������ʲô���ӣ׵��أ�", 585)
		local body = pickbody()
		JY.Person[0]["ͷ�����"] = JY.Person[body]["ͷ�����"]
		for i = 1, 5 do
			JY.Person[0]["���ж���֡��" .. i] = JY.Person[body]["���ж���֡��" .. i]
			JY.Person[0]["���ж����ӳ�" .. i] = JY.Person[body]["���ж����ӳ�" .. i]
			JY.Person[0]["�书��Ч�ӳ�" .. i] = JY.Person[body]["�书��Ч�ӳ�" .. i]
		end	
		say("��������Ϊ�Լ��ģ����ʣ���Σ���", 585)
		--DrawStrBoxWaitKey(CC.EVB124, C_WHITE, 30)
		local T = {}
		for a = 1, 1000 do
		  local b = "" .. a
		  T[b] = a
		end
		JY.Person[0]["����"] = -1
		while JY.Person[0]["����"] == -1 do
			local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
			if T[r] ~= nil and T[r] > -1 and T[r] < 101 then
			  JY.Person[0]["����"] = T[r]
			else
				DrawStrBoxWaitKey(CC.EVB125, C_WHITE, 30)
			end
		  end	
		say("��ô����ѧ�ģ��������ʣ���������һ�����أ�", 585)
		Cls()
		local nl = JYMsgBox(CC.EVB122, CC.EVB123, CC.EVB126, 3, 280)
		if nl == 1 then
		  JY.Person[0]["��������"] = 0
		elseif nl == 2 then
		  JY.Person[0]["��������"] = 1
		else
		  JY.Person[0]["��������"] = 2
		end	
		say("��̤�Ͻ���·֮ǰ������һ��ѧϰ�Ļ���ɣ���������ļ��ܵ�����", 585)
		tb("������������ѧϰ"..4 + JY.Thing[203][WZ6].."������")

		learnSK()
		say("��ʵ�㻹���Դ����Լ���ս�⼼����������ļ��ܵ�����", 585)
		tb("����������������".."3".."��ս�����")
		learnDZ()
		say("��Ȼ��������ô��ս�⼼ȡ�����ְɡ�", 585)
		JY.Person[579]["����"] = "";
		while JY.Person[579]["����"] == "" do
			JY.Person[579]["����"] = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
			if JY.Person[579]["����"] == "" then
				DrawStrBoxWaitKey("���Լ�ս�⼼������ְ�", C_WHITE, 30)
			end
		end	
		tb("�õģ����ս�⼼���ھ��Ѻ���")
		say("���һ�����⣬��Ȼ�ǲ��԰棬��ô�͸����ر����ɡ�����С����ϲ���ĳƺ���ʲô���ش�����Ļ��н�Ŷ��", 585)
		local ss = "";
		while ss == "" do
			ss = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
			if ss == "ɱ����ҽ" then
				say("��ϲ�����ˣ�", 585)
				instruct_2(174, math.random(10) * 1000)
				--10%ѧ�书��10%ӡ�£�10%�ؼ�
				local gift = math.random(10)
				if gift <= 7 then
					instruct_2(math.random(14, 17), math.random(5))
				elseif gift == 8 then
					local thing = randomwugong2(8, 15)
					JY.Person[0]["�书1"] = JY.Thing[thing]["�����书"]
					JY.Person[0]["�书�ȼ�1"] = 900			
				elseif gift == 9 then
					local thing = randomwugong2(7, 10)
					instruct_2(thing, 1)
				else
					addHZ(CC.HZ[math.random(#CC.HZ)][1])
				end

			else
				say("��ϧ����ˣ�����û��ϵ���´���Ŭ���ɡ�", 585)
			end
		end		   
		JY.Person[0]["�������ֵ"] = 50
		JY.Person[0]["�������ֵ"] = 100
		JY.Person[0]["������"] = 30
		JY.Person[0]["������"] = 30
		JY.Person[0]["�Ṧ"] = 30
		JY.Person[0]["ҽ������"] = 30
		JY.Person[0]["�ö�����"] = 30
		JY.Person[0]["�ⶾ����"] = 30
		JY.Person[0]["��������"] = 30
		JY.Person[0]["ȭ�ƹ���"] = 40
		JY.Person[0]["��������"] = 40
		JY.Person[0]["ˣ������"] = 40
		JY.Person[0]["�������"] = 40
		JY.Person[0]["��������"] = 40
		zjtype(4)
	elseif mode == 2 then
		local r = -1
		local plist = cxlist()
		r = sidetoside(plist, 3)
		CC.SKpoint = CC.SKpoint - (700 + 300 * (JY.Person[r]["����"] - 2))
		SetS(103, 0, 0, 1, r)
		zjtype(3)
		Cls()
		JY.Person[0]["����"] = JY.Person[r]["����"]
		JY.Person[0]["�Ա�"] = JY.Person[r]["�Ա�"]
		JY.Person[0]["ͷ�����"] = JY.Person[r]["ͷ�����"]
		JY.Person[0]["������"] = JY.Person[r]["������"]
		JY.Person[0]["����"] = JY.Person[r]["����"]
		JY.Person[0]["����"] = JY.Person[r]["����"]
		JY.Person[0]["��������"] = JY.Person[r]["��������"]	
		JY.Person[0]["�������ֵ"] = limitX(math.modf(JY.Person[r]["�������ֵ"]/3),100,500)
		JY.Person[0]["����"] = JY.Person[0]["�������ֵ"]
		JY.Person[0]["�������ֵ"] = limitX(math.modf(JY.Person[r]["�������ֵ"]/3),100,1000)
		JY.Person[0]["����"] = JY.Person[0]["�������ֵ"]
		JY.Person[0]["������"] = 30
		JY.Person[0]["������"] = 30
		JY.Person[0]["�Ṧ"] = 30
		JY.Person[0]["��������"] = limitX(JY.Person[r]["��������"],0,50)		
		JY.Person[0]["��ѧ��ʶ"] = limitX(JY.Person[r]["��ѧ��ʶ"],0,20)
		JY.Person[0]["ҽ������"] = limitX(JY.Person[r]["ҽ������"],30,50)
		JY.Person[0]["�ö�����"] = limitX(JY.Person[r]["�ö�����"],30,50)
		JY.Person[0]["�ⶾ����"] = limitX(JY.Person[r]["�ⶾ����"],30,50)
		JY.Person[0]["��������"] = limitX(JY.Person[r]["��������"],30,50)
		JY.Person[0]["ȭ�ƹ���"] = limitX(JY.Person[r]["ȭ�ƹ���"],20,50)
		JY.Person[0]["��������"] = limitX(JY.Person[r]["��������"],20,50)
		JY.Person[0]["ˣ������"] = limitX(JY.Person[r]["ˣ������"],20,50)
		JY.Person[0]["�������"] = limitX(JY.Person[r]["�������"],20,50)
		JY.Person[0]["��������"] = limitX(JY.Person[r]["��������"],20,50) --�������ǣ�΢��
		JY.Person[0]["����"] = JY.Person[r]["����"]
		JY.Person[0]["���һ���"] = JY.Person[r]["���һ���"]
		if r == 76 then
			JY.Person[0]["�ȼ�"] = 20
			JY.Person[0]["������"] = 1
			JY.Person[0]["������"] = 1
			JY.Person[0]["�Ṧ"] = 1			
		end			
		if r == 75 then
			JY.Person[0]["ȭ�ƹ���"] = 5
			JY.Person[0]["��������"] = 5
			JY.Person[0]["ˣ������"] = 5
			JY.Person[0]["�������"] = 5
		end
		for i = 1, 10 do
			JY.Person[0]["�书"..i] = JY.Person[r]["�书"..i]
			JY.Person[0]["�书�ȼ�"..i] = JY.Person[r]["�书�ȼ�"..i]
				    for ii = 0,JY.ThingNum - 1 do
					if JY.Thing[ii]["�����书"] == JY.Person[0]["�书"..i] then
						local level = math.modf((JY.Person[0]["�书�ȼ�" ..i])/100) + 1
						if level > 10 then level = 10 end
						AddPersonAttrib(0, "�������ֵ", JY.Thing[ii]["���������ֵ"]*2* level)
						AddPersonAttrib(0, "������", JY.Thing[ii]["�ӹ�����"]*2* level)
						AddPersonAttrib(0, "�Ṧ", JY.Thing[ii]["���Ṧ"]*2* level)
						AddPersonAttrib(0, "������", JY.Thing[ii]["�ӷ�����"]*2* level)	
						AddPersonAttrib(0, "ҽ������", JY.Thing[ii]["��ҽ������"]*2* level)
						AddPersonAttrib(0, "�ö�����", JY.Thing[ii]["���ö�����"]*2* level)
						AddPersonAttrib(0, "�ⶾ����", JY.Thing[ii]["�ӽⶾ����"]*2* level)
						AddPersonAttrib(0, "��������", JY.Thing[ii]["�ӿ�������"]*2* level)
						AddPersonAttrib(0, "ȭ�ƹ���", JY.Thing[ii]["��ȭ�ƹ���"]*2* level)
						AddPersonAttrib(0, "��������", JY.Thing[ii]["����������"]*2* level)
						AddPersonAttrib(0, "ˣ������", JY.Thing[ii]["��ˣ������"]*2* level)
						AddPersonAttrib(0, "�������", JY.Thing[ii]["���������"]*2* level)	
						AddPersonAttrib(0, "��������", JY.Thing[ii]["�Ӱ�������"]*2* level)
						break
					end
				end
		end
		for i = 1, 5 do
			JY.Person[0]["���ж���֡��" .. i] = JY.Person[r]["���ж���֡��" .. i]
			JY.Person[0]["���ж����ӳ�" .. i] = JY.Person[r]["���ж����ӳ�" .. i]
			JY.Person[0]["�书��Ч�ӳ�" .. i] = JY.Person[r]["�书��Ч�ӳ�" .. i]
		end		
		for i = 1, 5 do
			JY.Person[0]["����" .. i] = JY.Person[r]["����" .. i]
		end	
		Cls()
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
		Cls()
		DrawStrBoxWaitKey("�������ɫ������ ��Χ1-10", C_WHITE, 30)
		JY.Person[0]["��������"] = -1
		while JY.Person[0]["��������"] == -1 do
			local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
			if T[r] ~= nil and T[r] > 0 and T[r] < 11 then
				JY.Person[0]["��������"] = T[r]
			else
				DrawStrBoxWaitKey("������� ��Χ1-10 ����������", C_WHITE, 30)
			end
		end
		Cls()
		local nl = JYMsgBox(CC.EVB122, CC.EVB123, CC.EVB126, 3, 280)
		if nl == 1 then
		  JY.Person[0]["��������"] = 0
		elseif nl == 2 then
		  JY.Person[0]["��������"] = 1
		else
		  JY.Person[0]["��������"] = 2
		end		
	else
		local t, c = newselect()	
		JY.Person[0]["�������ֵ"] = 50
		JY.Person[0]["�������ֵ"] = 100
		JY.Person[0]["������"] = 30
		JY.Person[0]["������"] = 30
		JY.Person[0]["�Ṧ"] = 30
		JY.Person[0]["ҽ������"] = 30
		JY.Person[0]["�ö�����"] = 30
		JY.Person[0]["�ⶾ����"] = 30
		JY.Person[0]["��������"] = 30
		JY.Person[0]["ȭ�ƹ���"] = 30
		JY.Person[0]["��������"] = 30
		JY.Person[0]["ˣ������"] = 30
		JY.Person[0]["�������"] = 30
		JY.Person[0]["��������"] = 30	
		JY.Person[0]["��������"] = math.random(1, 10)
		JY.Person[0]["���һ���"] = 0
		if t == 1 then
			DrawStrBoxWaitKey(CC.EVB156, C_WHITE, 30)
			JY.Person[0][CC.s23] = "";
			while JY.Person[0][CC.s23] == "" do
				JY.Person[0][CC.s23] = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
				if JY.Person[0][CC.s23] == "" then
					DrawStrBoxWaitKey("û������ô����Ϸ", C_WHITE, 30)
				end
			end	
			local T = {}
			for a = 1, 1000 do
				local b = "" .. a
				T[b] = a
			end
			DrawStrBoxWaitKey("��ѡ���Ա�", C_WHITE, 30)
			local mm = {
				{"  ��ü  ", nil, 1},
				{"  ����  ", nil, 1},	
			}
			Cls()
			local aa = ShowMenu3(mm,#mm,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,nil, nil,M_DimGray,C_RED)
			JY.Person[0]["�Ա�"] = aa - 1				
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
			DrawStrBoxWaitKey("�������ɫ������ ��Χ1-10", C_WHITE, 30)
			JY.Person[0]["��������"] = -1
			while JY.Person[0]["��������"] == -1 do
				local r = GetPinyin1(32, CC.ScreenH - CC.Fontbig * 6)
				if T[r] ~= nil and T[r] > 0 and T[r] < 11 then
					JY.Person[0]["��������"] = T[r]
				else
					DrawStrBoxWaitKey("������� ��Χ1-10 ����������", C_WHITE, 30)
				end
			end				
			zjtype(1)
			putong(c)
				SetS(112,1,0,0,0)
				SetS(112,2,0,0,0)
				SetS(112,3,0,0,0)
			if c == 1 then         --ȭ
			  JY.Person[0][CC.s15] = 60
			elseif c == 2 then     --��
			  JY.Person[0][CC.s16] = 60   
			elseif c == 3 then     --��
			  JY.Person[0][CC.s17] = 60
			elseif c == 4 then		 --�� 
			  JY.Person[0][CC.s18] = 60
			elseif c == 13 then
			  JY.Person[0]["��������"] = 60	
			elseif c == 5 then		 --�
			  JY.Person[0][CC.s19] = 500
			  JY.Person[0]["����"] = 500
			  JY.Person[0][CC.s20] = 2
			elseif c == 6 or c == 9 or c == 12 then		 --�� �������ǣ���ȫ����趨
			  JY.Person[0][CC.s15] = 40
			  JY.Person[0][CC.s16] = 40
			  JY.Person[0][CC.s17] = 40
			  JY.Person[0][CC.s18] = 40
			  JY.Person[0]["��������"] = 40	
			elseif c == 7 then		 --ҽ 
			  --JY.Person[0][PSX[37]] = 200
			  --JY.Person[0][PSX[38]] = 200
			  --JY.Person[0][PSX[39]] = 200	  
			end	

			if c == 6 then JY.Person[0][CC.s21] = 100 end
			if c == 9 then 
				RWWH[0] = "Ѫ��Ʈ��";
				RWTFLB[0] = "Ѫ������";
			end
			Cls()
			local nl = JYMsgBox(CC.EVB122, CC.EVB123, CC.EVB126, 3, 280)
			if nl == 1 then
			  JY.Person[0]["��������"] = 0
			elseif nl == 2 then
			  JY.Person[0]["��������"] = 1
			else
			  JY.Person[0]["��������"] = 2
			end				
			DrawStrBoxWaitKey("��ѡ��ͷ��", C_WHITE, 30)			
			JY.Person[0]["������"] = pickhead()
			DrawStrBoxWaitKey("��ѡ��ս������", C_WHITE, 30)	
			local body = pickbody()
			JY.Person[0]["ͷ�����"] = JY.Person[body]["ͷ�����"]
			for i = 1, 5 do
				JY.Person[0]["���ж���֡��" .. i] = JY.Person[body]["���ж���֡��" .. i]
				JY.Person[0]["���ж����ӳ�" .. i] = JY.Person[body]["���ж����ӳ�" .. i]
				JY.Person[0]["�书��Ч�ӳ�" .. i] = JY.Person[body]["�书��Ч�ӳ�" .. i]
			end	
            tfkf()				
		else
			zjtype(2)
			teshu(c)
			JY.Thing[201][WZ7] = 8
			JY.Person[0]["������"] = 40
			JY.Person[0]["������"] = 40
			JY.Person[0]["�Ṧ"] = 40
				SetS(112,1,0,0,0)
				SetS(112,2,0,0,0)
				SetS(112,3,0,0,0)
			--JY.Person[0]["��������"] = 50 �������ǣ�ȡ��
			if c == 1 then
				JY.Person[0]["��������"] = 8
				JY.Person[0]["ȭ�ƹ���"] = 50
				JY.Person[0]["��������"] = 50
				JY.Person[0]["ˣ������"] = 50
				JY.Person[0]["�������"] = 50
				JY.Person[0]["����"] = 100
				JY.Person[0]["�������ֵ"] = 300
				JY.Person[0]["�������ֵ"] = 100
				JY.Person[0][CC.s23] = "�����"
				JY.Person[0]["������"] = 577
				JY.Person[0]["����1"] = 10
				JY.Person[0]["����2"] = 16
				SetS(112,2,0,0,105)
				SetS(112,1,0,0,0)
				SetS(112,3,0,0,0)
			elseif c == 2 then 
				JY.Person[0]["��������"] = 4
				JY.Person[0]["ȭ�ƹ���"] = 50
				JY.Person[0]["��������"] = 50
				JY.Person[0]["ˣ������"] = 50
				JY.Person[0]["�������"] = 50	
				JY.Person[0]["���һ���"] = 1
				JY.Person[0]["����"] = 50
				JY.Person[0][CC.s23] = "ˮ������"
				JY.Person[0]["������"] = 565
				JY.Person[0]["����1"] = 112
				JY.Person[0]["����2"] = 16
			elseif c == 3 then
				JY.Person[0]["��������"] = 7
				JY.Person[0]["�������ֵ"] = 200
				JY.Person[0]["ȭ�ƹ���"] = 40
				JY.Person[0]["��������"] = 40
				JY.Person[0]["ˣ������"] = 40
				JY.Person[0]["�������"] = 40
				JY.Person[0]["��������"] = 50
				JY.Person[0]["����"] = 80
				JY.Person[0]["���һ���"] = 1
				JY.Person[0][CC.s23] = "�����"
				JY.Person[0]["������"] = 450
				JY.Person[0]["����1"] = 65
				JY.Person[0]["����2"] = 16
				JY.Person[0]["ͷ�����"] = 349
				for i = 1, 5 do
					if i == 5 then 
						JY.Person[0]["���ж���֡��"..i] = 17
						JY.Person[0]["���ж����ӳ�"..i] = 14
						JY.Person[0]["�书��Ч�ӳ�"..i] = 13
					else
						JY.Person[0]["���ж���֡��"..i] = 0
						JY.Person[0]["���ж����ӳ�"..i] = 0
						JY.Person[0]["�书��Ч�ӳ�"..i] = 0
					end
				end
			elseif c == 4 then
				JY.Person[0]["��������"] = 8
				JY.Person[0]["��������"] = 60
				JY.Person[0]["ˣ������"] = 60
				JY.Person[0]["���һ���"] = 1
				JY.Person[0]["����"] = 80
				JY.Person[0][CC.s23] = "��Сʯ"
				JY.Person[0]["������"] = 536
				JY.Person[0]["����1"] = 31
				JY.Person[0]["����2"] = 16
			elseif c == 5 then
				JY.Person[0]["��������"] = 2
				JY.Person[0]["ȭ�ƹ���"] = 60
				JY.Person[0]["����"] = 90
				JY.Person[0][CC.s23] = "�׳��"
				JY.Person[0]["������"] = 543
				JY.Person[0]["����1"] = 38
				JY.Person[0]["����2"] = 16
				JY.Person[0]["ͷ�����"] = 353
				for i = 1, 5 do
					if i == 2 then 
						JY.Person[0]["���ж���֡��"..i] = 10
						JY.Person[0]["���ж����ӳ�"..i] = 8
						JY.Person[0]["�书��Ч�ӳ�"..i] = 7
					else
						JY.Person[0]["���ж���֡��"..i] = 0
						JY.Person[0]["���ж����ӳ�"..i] = 0
						JY.Person[0]["�书��Ч�ӳ�"..i] = 0
					end
				end
			elseif c == 6 then
				JY.Person[0]["��������"] = 5
				JY.Person[0]["�������ֵ"] = 300
				JY.Person[0]["��������"] = 50
				JY.Person[0]["����"] = 90
				JY.Person[0][CC.s23] = "����ˮ"	
				JY.Person[0]["������"] = 334	
				JY.Person[0]["����1"] = 40	
				JY.Person[0]["����2"] = 16	
				JoinMP(0,0,0)
			elseif c == 7 then
				JY.Person[0]["ȭ�ƹ���"] = 20
				JY.Person[0]["��������"] = 20
				JY.Person[0]["ˣ������"] = 20
				JY.Person[0]["�������"] = 20
				JY.Person[0]["����"] = 90
				JY.Person[0][CC.s23] = "����δ��"	
				JY.Person[0]["������"] = 534
				JY.Person[0]["����1"] = 51
				JY.Person[0]["����2"] = 16
				SetS(112,1,0,0,43)
				SetS(112,2,0,0,97)
				SetS(112,3,0,0,0)
			elseif c == 8 then
                for i,v in pairs(CC.Person_S) do
                JY.Person[0][i] = JY.Person[7][i]
				end
				JY.Person[0]["����1"] = 0
	            JY.Person[0]["����2"] = 0
				JY.Person[0]["����3"] = 0
				JY.Person[0]["����4"] = 0
				JY.Person[0]["Я����Ʒ1"] = -1
	            JY.Person[0]["Я����Ʒ����1"] = 0
				JY.Person[0]["Я����Ʒ2"] = -1
	            JY.Person[0]["Я����Ʒ����2"] = 0
				JY.Person[0]["Я����Ʒ3"] = -1
	            JY.Person[0]["Я����Ʒ����3"] = 0
				JY.Person[0]["Я����Ʒ4"] = -1
	            JY.Person[0]["Я����Ʒ����4"] = 0
				JY.Person[0]["�ȼ�"] = 1
				JY.Person[0]["�������ֵ"] = 50
				JY.Person[0]["ҽ������"] = 30
				JY.Person[0]["�ö�����"] = 30
				JY.Person[0]["�ⶾ����"] = 30
				JY.Person[0]["ʵս"] = 0
				JY.Person[0]["ͷ�����"] = 345
				JY.Person[0]["�������ֵ"] = 200
				JY.Person[0]["�书1"] = 0
				JY.Person[0]["�书�ȼ�1"] = 0
				JY.Person[0]["��������"] = 3
				JY.Person[0]["������"] = 50
				JY.Person[0]["������"] = 30
				JY.Person[0]["�Ṧ"] = 40
				JY.Person[0]["ȭ�ƹ���"] = 30
				JY.Person[0]["��������"] = 60
				JY.Person[0]["ˣ������"] = 30
				JY.Person[0]["�������"] = 30
				JY.Person[0]["��������"] = 80
				JY.Person[0]["����"] = 90
				JY.Person[0][CC.s23] = "����ң"
				JY.Person[0]["������"] = 440
				JY.Person[0]["ͷ�����"] = 345
				JY.Person[0]["����1"] = 83
				JY.Person[0]["����2"] = 16
				JY.Person[0]["����"] = 0
				for z = 2, 12 do 
					JY.Person[0]["�书"..z] = 0
					JY.Person[0]["�书�ȼ�"..z] = 0
				end	
				JoinMP(0,0,0)
				instruct_10(655) --�������ǣ����ɽ���Ůֱ�Ӽ���
				instruct_10(656)
				instruct_10(657)				
			elseif c == 9 then --�������ǣ�����ѡ������
                for i,v in pairs(CC.Person_S) do
                JY.Person[0][i] = JY.Person[592][i]
				end
				JY.Person[0]["�ȼ�"] = 1
				JY.Person[0]["�������ֵ"] = 50
				JY.Person[0]["������"] = 40
				JY.Person[0]["������"] = 40
				JY.Person[0]["ҽ������"] = 30
				JY.Person[0]["�ö�����"] = 30
				JY.Person[0]["�ⶾ����"] = 30
				JY.Person[0]["�Ṧ"] = 40
				JY.Person[0]["ʵս"] = 0
				JY.Person[0]["ͷ�����"] = 344
				JY.Person[0]["����1"] = 0
	            JY.Person[0]["����2"] = 0
				JY.Person[0]["����3"] = 0
				JY.Person[0]["����4"] = 0
				JY.Person[0]["�书1"] = 0
				JY.Person[0]["�书�ȼ�1"] = 0
				JY.Person[0]["��������"] = 7
				JY.Person[0]["�������ֵ"] = 200
				JY.Person[0]["�������"] = 60
				JY.Person[0]["����"] = 80
				JY.Person[0][CC.s23] = "����"
				JY.Person[0]["������"] = 575
				JY.Person[0]["ȭ�ƹ���"] = 40
				JY.Person[0]["��������"] = 50
				JY.Person[0]["ˣ������"] = 40
				JY.Person[0]["�������"] = 60
				JY.Person[0]["��������"] = 40
				JY.Person[0]["�书2"] = 0
				JY.Person[0]["�书�ȼ�2"] = 0
				JY.Person[0]["�书3"] = 0
				JY.Person[0]["�书�ȼ�3"] = 0
				JY.Person[0]["����1"] = 69
				JY.Person[0]["����2"] = 16
				SetS(112,1,0,0,112)
				SetS(112,2,0,0,0)
				SetS(112,3,0,0,0)
			elseif c == 10 then --�������ǣ�����ѡ����Ц��
				JY.Person[0][CC.s23] = "��Ц��"
				JY.Person[0]["������"] = 576
				JY.Person[0]["����"] = 100
				JY.Person[0]["ȭ�ƹ���"] = 40
				JY.Person[0]["��������"] = 40
				JY.Person[0]["ˣ������"] = 40
				JY.Person[0]["�������"] = 40
				JY.Person[0]["��������"] = 40
				JY.Person[0]["��������"] = 10
				JY.Person[0]["����1"] = 21
				JY.Person[0]["����2"] = 16
			elseif c == 11 then --�������ǣ����Ӳؾ���
				for i,v in pairs(CC.Person_S) do--л����
                JY.Person[0][i] = JY.Person[930][i]
				end
				JY.Person[0][CC.s23] = "�ؾ���"
				JY.Person[0]["������"] = 492
				JY.Person[0]["����"] = 70
				JY.Person[0]["ȭ�ƹ���"] = 70
				JY.Person[0]["��������"] = 7
				JY.Person[0]["ͷ�����"] = 346
				JY.Person[0]["����1"] = 27
				JY.Person[0]["����2"] = 16
			elseif c == 12 then --�������ǣ�����������
			for i,v in pairs(CC.Person_S) do
                JY.Person[0][i] = JY.Person[636][i]
			end
				JY.Person[0]["�ȼ�"] = 1
	            JY.Person[0]["�书2"] = 0
	            JY.Person[0]["�书�ȼ�2"] = 999
	            JY.Person[0]["�书3"] = 0
				JY.Person[0]["ҽ������"] = 30
				JY.Person[0]["�ö�����"] = 30
				JY.Person[0]["�ⶾ����"] = 30
	            JY.Person[0]["�书�ȼ�3"] = 999
				JY.Person[0]["������"] = 120
				JY.Person[0]["������"] = 120
				JY.Person[0]["�Ṧ"] = 120
				JY.Person[0]["�书1"] = 0
                JY.Person[0]["�书�ȼ�1"] = 999
				JY.Person[0]["����1"] = 0
	            JY.Person[0]["����2"] = 0
				JY.Person[0]["����3"] = 0
				JY.Person[0]["Я����Ʒ1"] = -1
	            JY.Person[0]["Я����Ʒ����1"] = 0
				JY.Person[0]["Я����Ʒ2"] = -1
	            JY.Person[0]["Я����Ʒ����2"] = 0
				JY.Person[0][CC.s23] = "������"
				JY.Person[0]["������"] = 92
				JY.Person[0]["ͷ�����"] = 343
				JY.Person[0]["����"] = 50
				JY.Person[0]["�������"] = 60
				JY.Person[0]["��������"] = 4
				JY.Person[0]["�Ա�"] = 1
				JY.Person[0]["����1"] = 79
				JY.Person[0]["����2"] = 16
				SetS(112,1,0,0,112)
				SetS(112,2,0,0,0)
				SetS(112,3,0,0,0)		
			elseif c == 13 then --�������ǣ���������ɽ
				JY.Person[0][CC.s23] = "����ɽ"
				JY.Person[0]["������"] = 502
				JY.Person[0]["����"] = 80
				JY.Person[0]["ȭ�ƹ���"] = 50
				JY.Person[0]["ˣ������"] = 50
				JY.Person[0]["�������"] = 50
				JY.Person[0]["��������"] = 10
			elseif c == 14 then --�������ǣ�����л����
                for i,v in pairs(CC.Person_S) do
                JY.Person[0][i] = JY.Person[72][i]
				end
				JY.Person[0][CC.s23] = "л����"
				JY.Person[0]["�ȼ�"] = 1
				JY.Person[0]["ͷ�����"] = 302
				JY.Person[0]["�������ֵ"] = 50
				JY.Person[0]["�������ֵ"] = 100
				JY.Person[0]["������"] = 40
				JY.Person[0]["������"] = 40
				JY.Person[0]["ҽ������"] = 30
				JY.Person[0]["�ö�����"] = 30
				JY.Person[0]["�ⶾ����"] = 30
				JY.Person[0]["�Ṧ"] = 40
				JY.Person[0]["ʵս"] = 0
				JY.Person[0]["������"] = 494
				JY.Person[0]["����"] = 50
				JY.Person[0]["��������"] = 90
	            JY.Person[0]["����"] = 1104
                JY.Person[0]["��������"] = 10
                JY.Person[0]["��ѧ��ʶ"] = 20
				JY.Person[0]["�书1"] = 0
				JY.Person[0]["�书�ȼ�1"] = 0
				JY.Person[0]["�书2"] = 0
				JY.Person[0]["�书�ȼ�2"] = 0
				JY.Person[0]["����1"] = 0
				JY.Person[0]["���ж���֡��3"] = 20
				JY.Person[0]["���ж����ӳ�3"] = 13
				JY.Person[0]["�书��Ч�ӳ�3"] = 11
				SetS(112,1,0,0,131)
				SetS(112,2,0,0,180)
				SetS(112,3,0,0,115)
			elseif c == 15 then --�������ǣ���������
			for i,v in pairs(CC.Person_S) do
                JY.Person[0][i] = JY.Person[1][i]
			end
				JY.Person[0][CC.s23] = "����"
				JY.Person[0]["������"] = 312
				JY.Person[0]["ͷ�����"] = 1
				JY.Person[0]["����"] = 100
				JY.Person[0]["ȭ�ƹ���"] = 80
				JY.Person[0]["��������"] = 80
				JY.Person[0]["ˣ������"] = 90
				JY.Person[0]["�������"] = 80
				JY.Person[0]["��������"] = 80
				JY.Person[0]["��������"] = 8
				JY.Person[0]["�Ṧ"] = 200
				JY.Person[0]["�书1"] = 88
				JY.Person[0]["�书�ȼ�1"] = 1
				JY.Person[0]["�书2"] = 155
				JY.Person[0]["�书�ȼ�2"] = 1
				JY.Person[0]["�书3"] = 98
				JY.Person[0]["�书�ȼ�3"] = 1
				JY.Person[0]["����1"] = 83
				JY.Person[0]["����2"] = 105
				JY.Person[0]["����3"] = 114
				SetS(112,1,0,0,111)
				SetS(112,2,0,0,181)
				SetS(112,3,0,0,179)			
			elseif c == 16 then --�����Σ����Ӳ�����
			for i,v in pairs(CC.Person_S) do
                JY.Person[0][i] = JY.Person[668][i]
			end
				JY.Person[0][CC.s23] = "������"
				JY.Person[0]["ͷ�����"] = 300
				JY.Person[0]["������"] = 473
				JY.Person[0]["����"] = 90
				JY.Person[0]["ȭ�ƹ���"] = 90
				JY.Person[0]["��������"] = 90
				JY.Person[0]["ˣ������"] = 80
				JY.Person[0]["�������"] = 80
				JY.Person[0]["��������"] = 80
				JY.Person[0]["��������"] = 10
				JY.Person[0]["������"] = 200
				JY.Person[0]["������"] = 100
				JY.Person[0]["�Ṧ"] = 100
				JY.Person[0]["�书1"] = 88
				JY.Person[0]["�书�ȼ�1"] = 1
				JY.Person[0]["�书2"] = 132
				JY.Person[0]["�书�ȼ�2"] = 1
				JY.Person[0]["����1"] = 31
				JY.Person[0]["����2"] = 52
				JY.Person[0]["����3"] = 83
				JY.Person[0]["���ж���֡��2"] = 15
				JY.Person[0]["���ж����ӳ�2"] = 14
				JY.Person[0]["�书��Ч�ӳ�2"] = 13
				JY.Person[0]["���ж���֡��3"] = 9
				JY.Person[0]["���ж����ӳ�3"] = 8
				JY.Person[0]["�书��Ч�ӳ�3"] = 7
				SetS(112,1,0,0,25)
				SetS(112,2,0,0,103)
				SetS(112,3,0,0,116)
			end			
			Cls()
			local nl = JYMsgBox(CC.EVB122, CC.EVB123, CC.EVB126, 3, 280)
			if nl == 1 then
			  JY.Person[0]["��������"] = 0
			elseif nl == 2 then
			  JY.Person[0]["��������"] = 1
			else
			  JY.Person[0]["��������"] = 2
			end	
		--if c ~= 14 and c ~= 12 and c ~= 9 and c ~= 7 and c ~= 1 then
        tfkf() 
		--end
		end	
	end 

	JY.Person[0]["����"] = JY.Person[0]["�������ֵ"]
	JY.Person[0]["����"] = JY.Person[0]["�������ֵ"]
	Cls()
	ShowScreen()	
end

function tfkf()
        if GetS(112,1,0,0) < 1 then 
        DrawStrBoxWaitKey("��ѡ���츳�⹦", C_WHITE, 30)
		--DrawStrBoxWaitKey("��ѡ���Ա�", C_WHITE, 30)
			local mm = {
				{"  ȭ  ", nil, 1},
				{"  ��  ", nil, 1},	
				{"  ��  ", nil, 1},
				{"  ��  ", nil, 1},
				{"  ��  ", nil, 1},
			}
			Cls()
			local aa = ShowMenu3(mm,#mm,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,nil, nil,M_DimGray,C_RED)
		local list = {}
		local x1 = CC.MainSubMenuX
		local y1 = CC.MainSubMenuY		
			if aa == 1 then
				list = {1,3,4,5,7,8,9,10,11,12,13,14,15,16,17,19,20,21,22,23,24,25,26,126,127,128,129,130,132,133}
			elseif aa == 2 then
				list = {27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,114,123,125,134,135,136,137,154}
			elseif aa == 3 then
				list = {50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,138,139,140,141,155,156,157}
			elseif aa == 4 then
				list = {68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,86,120,142,144,145,146,147,202}
			elseif aa == 5 then
				list = {148,149,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,18,175,176,177}
			end
		local menu = {}
		for i = 1, #list do
			menu[i] = {JY.Wugong[list[i]]["����"], nil, 1}
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);	
		SetS(112,1,0,0,list[r])
		end
		if GetS(112,2,0,0) < 1 then 
        DrawStrBoxWaitKey("��ѡ���츳�ڹ�", C_WHITE, 30)
		local list = {}
		local x1 = CC.MainSubMenuX
		local y1 = CC.MainSubMenuY		
		list = {6,85,88,87,89,90,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,121,124,150,151,152,153,189,178,180,181,182,183,184,185,186,187,188,203}
		local menu = {}
		for i = 1, #list do
			menu[i] = {JY.Wugong[list[i]]["����"], nil, 1}
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);	
		SetS(112,2,0,0,list[r])
		end 
		if GetS(112,3,0,0) < 1 then 
        DrawStrBoxWaitKey("��ѡ���츳�Ṧ", C_WHITE, 30)
		local list = {}
		local x1 = CC.MainSubMenuX
		local y1 = CC.MainSubMenuY		
		list = {115,116,117,118,119,143,179,190,191,192,193,194,195,196,197,199,200}
		local menu = {}
		for i = 1, #list do
			menu[i] = {JY.Wugong[list[i]]["����"], nil, 1}
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);	
		SetS(112,3,0,0,list[r])
		end
end

function mmtfkf()
        DrawStrBoxWaitKey("��ѡ���츳�书", C_WHITE, 30)
--		JY.Person[578]["������"] = 0
		local list = {}
		local x1 = CC.MainSubMenuX
		local y1 = CC.MainSubMenuY		
		list = {1,3,4,5,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,
                27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,
				50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,
				68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,86,
				109,110,111,112,114,120,123,125,126,127,128,129,130,132,133,134,
				135,136,137,138,139,140,141,142,144,145,146,147,148,149,154,155,156,
				157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177}
		local menu = {}
		for i = 1, #list do
			menu[i] = {JY.Wugong[list[i]]["����"], nil, 1}
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
		if r <= 0 then
		JY.Person[578]["������"]=0
		else
		JY.Person[578]["������"]=list[r]
		end
        DrawStrBoxWaitKey("��ѡ���츳�ڹ�", C_WHITE, 30)
--		JY.Person[578]["������"]=0
		local list = {}
		local x1 = CC.MainSubMenuX
		local y1 = CC.MainSubMenuY		
		list = {6,85,88,87,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,121,124,150,151,152,153,189,178,180,181,182,183,184,188}
		local menu = {}
		for i = 1, #list do
			menu[i] = {JY.Wugong[list[i]]["����"], nil, 1}
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);	
		if r <= 0 then
		JY.Person[578]["������"]=0
		else
		JY.Person[578]["������"]=list[r]
		end
        DrawStrBoxWaitKey("��ѡ���츳�Ṧ", C_WHITE, 30)
	--	JY.Person[578]["�Ṧ"]=0
		local list = {}
		local x1 = CC.MainSubMenuX
		local y1 = CC.MainSubMenuY		
		list = {197,115,116,117,118,119,143,179,190,191,192,193,194,195,196}
		local menu = {}
		for i = 1, #list do
			menu[i] = {JY.Wugong[list[i]]["����"], nil, 1}
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);	
		if r <= 0 then
		JY.Person[578]["�Ṧ"]=0
		else
		JY.Person[578]["�Ṧ"]=list[r]
		end
        DrawStrBoxWaitKey("��ѡ��һ���츳����", C_WHITE, 30)
		local menu = {}
	    for i = 1, #CC.TFlist do
		menu[i] = {CC.TFlist[i][1], nil, 1}
		if hasTF(92,i) then 
		menu[i][3] = 0
		end
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);	
		if r <= 0 then
		JY.Person[92]["����3"]=0
		else
		JY.Person[92]["����3"]= r
		end
end

function gamemode()
	local s1 = "��"..JY.Thing[203][WZ6].."��Ŀ"
	local s2 = "ʣ��"..CC.SKpoint.."���ܵ�"
	local size = 25
	local a = {
		{"����С��", "�������ã��з������ܵ�"}, 
		{"��������", "�������ã��з������ϵͣ���ϰ������ڹ�"}, 
		{"һ����ʦ", "�������ã��з�������������ϰ�����������"}, 
		{"����̩��", "�ǻ����ã��з������ϸߣ���ϰ������������Լ��츳"}, 
		{"���ܴ�˵", "��ս���ã��з������ܸߣ���ϰ������������Լ��츳�������һ���������ƺ�Ч��"}, 
		{"���¶���", "����������"}, 
	}
	local b = {
		{"һ��ģʽ", "ѡ����ͨ���ǻ�����������"},
		{"����ģʽ", "�ü��ܵ�������NPC������Ϸ��������1000�㼼�ܵ�"},
		{"����ģʽ", "��ѡ�����Լ��ü��ܵ�ϰ�ø��ּ��ܣ�������1000�㼼�ܵ�"},
	}
	local c = {
		{"һ��ģʽ", "һ���ս��ģʽ��ϲ��ȺŹ�Ŀ�ѡ"},
		{"��ͨģʽ", "�󲿷�ս��ֻ�������ϳ�������ӵ�ж����ж��ѵ���Ч"},
		{"�յ�ģʽ", "���ڸ�����ս��ģʽ���󲿷�ս��ֻ�������ϳ��Ҳ��ܻ�ö��ѵ���Ч"},
	}
	local t = {a, b, c}
	local t2 = {1, 1, 1}
	local count1 = 1
	local count2 = 1
	local x1 = 240 --110
	local y1 = 230 --50
	local x2 = 110
	local y2 = 50

	while true do
		Cls()
		lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 93)
		lib.FillColor(0, 0, CC.ScreenW, CC.ScreenH, C_BLACK)
		lib.PicLoadCache(93,8, 500, 300)
		--lib.LoadPicture(CONFIG.PicturePath.."scroll2.png", -1, -1)  
		tb2(s1, -1, 130, C_ORANGE)
		tb2(s2, -1, 160, C_ORANGE)
		DrawBox(x1 + x2 * (count2 - 1) - 5, y1 + y2 * (count1 - 1) - 5, x1 + x2 * (count2 - 1) + 105, y1 + y2 * (count1 - 1) + 30, C_WHITE)	
		DrawStrBox(-1, 390, t[count1][count2][2], C_ORANGE, 22)
		DrawString(120, 230, "�Ѷ�", C_ORANGE, 25)
		DrawString(240, 230, "����С��", C_GOLD, 25)
		DrawString(350, 230, "��������", C_GOLD, 25)
		DrawString(460, 230, "һ����ʦ", C_GOLD, 25)
		DrawString(570, 230, "����̩��", C_GOLD, 25)
		DrawString(680, 230, "���ܴ�˵", C_GOLD, 25)
		DrawString(790, 230, "���¶���", C_GOLD, 25)
		DrawString(120, 280, "����ģʽ", C_ORANGE, 25)
		DrawString(240, 280, "һ��ģʽ", C_GOLD, 25)
		DrawString(350, 280, "����ģʽ", C_GOLD, 25)
		DrawString(460, 280, "����ģʽ", C_GOLD, 25)
		DrawString(120, 330, "ս��ģʽ", C_ORANGE, 25)
		DrawString(240, 330, "һ��ģʽ", C_GOLD, 25)
		DrawString(350, 330, "��ͨģʽ", C_GOLD, 25)
		DrawString(460, 330, "�յ�ģʽ", C_GOLD, 25)
		tb2("�������Ҽ��ƶ�ѡ��  ���س���ѡ��  ȫ�������Y��ȷ��", -1, 450, C_ORANGE)
		DrawString(x1 + x2 * (t2[1] - 1), y1, t[1][t2[1]][1], C_RED, 25)
		DrawString(x1 + x2 * (t2[2] - 1), y1 + y2, t[2][t2[2]][1], C_RED, 25)
		DrawString(x1 + x2 * (t2[3] - 1), y1 + y2 * 2, t[3][t2[3]][1], C_RED, 25)
		--DrawString(x1 + x2 * (count2 - 1), y1 + y2 * (count1 - 1), t[count1][count2][1], C_RED, 25)
		if CC.SKpoint < 1000 then
			DrawString(350, 280, "����ģʽ", M_Gray, 25)
			DrawString(460, 280, "����ģʽ", M_Gray, 25)
		end
		ShowScreen()
		local p = WaitKey()
		if p == VK_SPACE or p == VK_RETURN then
			if count1 == 2 then
				if (count2 == 2 or count2 == 3) and CC.SKpoint < 1000 then
					
				else
					t2[count1] = count2
				end
			else
				t2[count1] = count2
			end		
		elseif p == VK_ESCAPE then
			--break
		elseif p == VK_UP then
			count1 = count1 - 1
			if count1 < 1 then count1 = #t end
		elseif p == VK_DOWN then			
			count1 = count1 + 1
			if count1 > #t then count1 = 1 end
		elseif p == VK_LEFT then
			count2 = count2 - 1
			if count2 < 1 then count2 = #t[count1] end		
		elseif p == VK_RIGHT then
			count2 = count2 + 1
			if count2 > #t[count1] then count2 = 1 end
		elseif p == 121 then
			return t2[1], t2[2], t2[3]
		end
		if count2 > #t[count1] then count2 = #t[count1] end
	end
end

function newselect()
	local function ph(t, c)
		if t == 1 then
			if c <= 7 then
				return 280 + c
			else
				return 340 - 8 + c
			end
		else
			return 287 + c
		end
	end
	local function disable(t, c)
		local dd = {}
		local dd2 = {}
		if t == 1 then
			for i = 1, #dd do
				if c == dd[i] then
					return true
				end
			end
		end
		if t == 2 then
			for i = 1, #dd2 do
				if c == dd2[i] then
					return true
				end
			end
		end		
		return false
	end
	local start = {80, 100}
	local t = 1
	local c = 1
	local maxc = {13, 16} --�������ǣ�����ѡ�����ƺ���Ц��
	local tmp = {280, 287}
	CleanMemory()
	CC.ICONPICFILE = {CONFIG.DataPath .. "icon.idx", CONFIG.DataPath .. "icon.grp"}
	CC.HeadPicFile = {CONFIG.DataPath .. "atmb.idx", CONFIG.DataPath .. "atmb.grp"}
	--lib.PicLoadFile(CC.HeadPicFile[1], CC.HeadPicFile[2], 53)	
	CC.HeadPicFile = {CONFIG.DataPath .. "shead.idx", CONFIG.DataPath .. "shead.grp"}
	lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 93)

	while true do
		Cls()
		lib.PicLoadCache(93, 0, 500, 300)
		--lib.LoadPicture(CONFIG.PicturePath .. "bj0.png", 0, 0)
		--lib.LoadPicture(CC.STA, -1, -1)
		if disable(t,c ) then
			lib.PicLoadCache(53, ph(t, c) * 2, 495, 300)	
			lib.PicLoadCache(54, 80 * 2, 495, 300)			
		else
			lib.PicLoadCache(53, ph(t, c) * 2, 495, 300)	
			lib.PicLoadCache(54, (start[t] + c) * 2, 495, 300)
		end
		--lib.PicLoadCache(54, 75 * 2, CC.ScreenW/2 - 125, CC.ScreenH / 2 - 152, 1, 256)
		if c > 1 then
			lib.PicLoadCache(54, 71 * 2, CC.ScreenW/2 - 210, CC.ScreenH / 2 - 40, 1, 256)
		end
		if c < maxc[t] then
			lib.PicLoadCache(54, 72 * 2, CC.ScreenW/2 + 110, CC.ScreenH / 2 - 40, 1, 256)
		end
		if t ~= 1 then
			lib.PicLoadCache(54, 73 * 2, CC.ScreenW/2 - 15, CC.ScreenH / 2 - 240, 1, 256)
		else
			lib.PicLoadCache(54, 74 * 2, CC.ScreenW/2 - 15, CC.ScreenH / 2+120, 1, 256)
		end
		tb2("��/�¼��л���׼����/��������  ��/�Ҽ�ѡ������  ����󰴿ո��ȷ��", -1, 670, C_ORANGE)
		ShowScreen()
		local p = WaitKey()
		if p == VK_SPACE or p == VK_RETURN then
			if not disable(t, c) then
				return t, c
			end
		elseif p == VK_ESCAPE then
			--break
		elseif p == VK_UP then
			if t ~= 1 then
				c = 1
			end
			t = 1		
		elseif p == VK_DOWN then
			if t ~= 2 then
				c = 1
			end	
			t = 2
		elseif p == VK_LEFT then
			c = limitX(c - 1, 1, maxc[t])
		elseif p == VK_RIGHT then
			c = limitX(c + 1, 1, maxc[t])
		end
	end
	
end

function gettitle(pid)
	local title = ""
	local name = JY.Person[pid]["����"]
	if pid == 77 and GetS(99,0,1,0) > 0 then 
	   name = "���л�1"
	end  
	if pid == 0 then
		if zjtype() == 1 then
			title = ZJTF[putong()]
		elseif zjtype() == 2 then
			title = ZJTF2[teshu()]
		elseif zjtype() == 3 then
			title = gettitle(GetS(103, 0, 0, 1))
		elseif zjtype() == 4 then
			title = JY.Person[578]["����"]
		end
	elseif pid == 92 and name ~= "����" and name ~= "½��˫" and name ~= "������" and name ~= "ɭ���" and name ~= "����ǳ" then --�������ǣ���������ɽ��Ů��
		title = "��������"
	else
		if CC.NLJS[name] ~= nil and CC.NLJS[name][1] ~= nil then		
			title = string.sub(CC.NLJS[name][1], 7)
		end
	end
	return title
end


function jiadian(a) --����ϵͳ
	JY.Base["����"] = limitX(JY.Base["����"] + a, 0, 32000)
	if a < 0 then
		return "���ֵ�������"..math.abs(a).."��"
	else
		return "���ֵ�������"..a.."��"
	end
end

function skpoint(a)
	CC.SKpoint = limitX(CC.SKpoint + a, 0, 32000)
	if a < 0 then
		return "���ܵ����"..math.abs(a).."��"
	else
		return "���ܵ�����"..a.."��"
	end	
end

function hasSK(sk)
	--[[if CC.SKlist[sk][3] == 1 then
		return true
	end]]
	--if hasTF(zj(), sk) then return true end
	return false
end

function setSK(sk, n)
	if n == nil then n = 1 end
	CC.SKlist[sk][3] = n
end

function setDZ(dz, n)
	if n == nil then n = 1 end
	CC.DZlist[dz][3] = n
end

function hasTF(pid, tf)
	if JY.Status == GAME_WMAP then
		if WAR.NOTF ~= nil then
			if pid == 0 and putong() == 10 and tf == WAR.NOTF[2] then
				return true
			end
			if WAR.NOTF[1] == pid and WAR.NOTF[2] == tf and WAR.NOTF[3] > 0 then
				return false
			end
		end
	end
	if pid == zj() and zjtype() == 4 then
		if tf <= #CC.SKlist and CC.SKlist[tf][3] == 1 then
			return true
		end
	end
	for i = 1, 5 do
		if JY.Person[pid]["����"..i] == tf then
			return true
		end
	end
	if getHZ2(pid, tf) then
		return true
	end
	if DT(pid, 455) then return true end --�������ǣ��޾Ʋ����ж�
	if WAR.ZDDH == 226 and GetS(86, 1, 9, 5) == 1 and GetS(86, 2, 12, 5) == 3 and (pid == 5 or pid == 27 or pid == 50 or pid == 114) 
	and (tf == 48 or tf == 53 or tf == 93 or tf == 17 or tf == 127 or tf == 7 or tf == 31 or tf == 47 or tf == 137 or tf == 115 or tf == 29) then --������
	return true
	end
	return false
end

function hasDZ(pid, dz)
	if pid == zj() and zjtype() == 4 then
		if dz <= #CC.DZlist and CC.DZlist[dz][3] == 1 then
			return true
		end
	end
end

function setTF(pid, tf, n)
	if not hasTF(pid, tf) then
		if n ~= nil then
			JY.Person[pid]["����"..n] = tf
		else
			for i = 1, 5 do
				if JY.Person[pid]["����"..i] == 0 then
					JY.Person[pid]["����"..i] = tf
					break
				end
			end
		end
	end
end


function sidetoside(menu, flag)	--1 �쳣״̬ 2 ѧ���� 3 ����
	local size = CC.DefaultFont - 5
	local start = 1
	local stop = 20
	local stop2 = 20
	local menu2 = {}
	if flag == 1 then
		local tmpmenu = {}
		for i = 1, #menu do
			tmpmenu[i] = {}
			menu2[i] = {}
			for j = 1, #menu[i] - 1 do				
				tmpmenu[i][j] = menu[i][j]
			end
			menu2[i] = menu[i][#menu[i]]
		end
		menu = tmpmenu
	end	
	if #menu < stop2 then stop2 = #menu end
	local current = 1	
	local size1 = size - 5
	local h = size + CC.PersonStateRowPixel
	local height = h * stop2 + 10
	if flag==3 then 
	height = h * 20 + 10 
	end
	local width = 5 * size + 10
	local x0 = 10
	local y0 = 5
	local i = 0
	local p
	while true do
		i = 0
		Cls()
		if flag == 3 or flag == 2 then
			lib.LoadPicture(CONFIG.PicturePath.."scroll.png", -1, -1)  
		elseif flag ~= 2 then
			lib.LoadPicture(CC.STA, -1, -1)  
		end
		DrawBox(x0, y0, x0 + width, y0 + height, C_WHITE)
		
		for j = start, stop do
			if menu[j] ~= nil and menu[j][1] ~= nil then				
				if current == j then
					DrawString(x0 + 5, y0 + h * (i) + 5, menu[j][1], C_WHITE, size)
				else
					if flag == 2 and menu[j][0] == 0 then
						DrawString(x0 + 5, y0 + h * (i) + 5, menu[j][1], M_DimGray, size)
					elseif flag == 3 then
						if CC.SKpoint >= 700 + 300 * (JY.Person[menu[j][0]]["����"] - 2) then
							DrawString(x0 + 5, y0 + h * (i) + 5, menu[j][1], C_GOLD, size)
						else
							DrawString(x0 + 5, y0 + h * (i) + 5, menu[j][1], M_DimGray, size)
						end
					else
						DrawString(x0 + 5, y0 + h * (i) + 5, menu[j][1], C_GOLD, size)
					end
				end
				i = i + 1
			end
		end
		if flag == 3 then
			DrawBox(x0 + x0 + width, y0, CC.ScreenW - 10, y0 + height, C_WHITE)
		else
			DrawBox(x0 + x0 + width, y0, CC.ScreenW - 10,  #menu[current] * h + y0 + 10, C_WHITE)
		end
		for j = 1, #menu[current] do
			if menu[current][j] ~= nil then
				if j == 1 then
					DrawString(x0 + 15 + width, y0 + h * (j - 1) + 5, menu[current][j], C_ORANGE, size)
					if flag == 1 then
						lib.PicLoadFile(CC.WMAPPicFile[1], CC.WMAPPicFile[2], 11)
						lib.PicLoadCache(11,menu2[current]*2,x0 + 15 + width + size * 3, y0 + h * (j - 1) + 5 + 13, 0, 256);	
					end
					if flag == 3 then
						lib.PicLoadCache(55, gethead(menu[current][0]) * 2, CC.ScreenW - 10 - 442, y0 + height - 398, 1)
					end
				else
					DrawString(x0 + 15 + width, y0 + h * (j - 1) + 5, menu[current][j], M_Wheat, size)
				end
			end
		end
		
		ShowScreen()
		p = WaitKey()
		if p == VK_ESCAPE then
			if flag ~= 3 then
				return -1
			else
				local plist = cxlist()
				return sidetoside(plist, 3)
			end
		elseif p == VK_SPACE or p == VK_RETURN then
			if flag == 3 then
				if CC.SKpoint >= 700 + 300 * (JY.Person[menu[current][0]]["����"] - 2) then
					return menu[current][0]
				end
			elseif flag == 2 and (menu[current][0] ~= nil and menu[current][0] == 0) then
			else
				return current
			end
		elseif p == VK_DOWN then
			if current == #menu then
				current = 1
				start = 1
				stop = 20
			else
				current = limitX(current + 1, 1, #menu)
				if current > stop then
					start = limitX(start + 1, 1, #menu)
					stop = limitX(stop + 1, stop2, #menu)
				end
			end
		elseif p == VK_UP then
			if current == 1 then
				current = #menu
				stop = #menu
				start = stop - 19
			else
				current = limitX(current - 1, 1, #menu)
				if current < start then
					start = limitX(start - 1, 1, #menu)
					stop = limitX(stop - 1, stop2, #menu)
				end	
			end
		elseif p == VK_LEFT then
			current = current - 20
			start = start - 20
			stop = stop - 20
			if start < 1 then
				current = 1
				start = 1
				stop = 20
			end
		elseif p == VK_RIGHT then
			current = current + 20
			start = start + 20
			stop = stop + 20			
			if stop > #menu then
				current = #menu
				stop = #menu
				start = stop - 19
			end			
		end
	end
end

function JYZTB() --��Ϸ��ʾ
  local mode = 0
  if JY.Thing[202][WZ7] == 1 then
    mode = "��"
  elseif JY.Thing[202][WZ7] == 2 then
    mode = "��"
  else
    mode = "��"
  end
  
  local day = {
	{1, "��һ"},
	{2, "����"},
	{3, "����"},
	{4, "����"},
	{5, "����"},
	{6, "����"},
	{7, "����"},
	{8, "����"},
	{9, "����"},
	{10, "��ʮ"},
	{11, "ʮһ"},
	{12, "ʮ��"},
	{13, "ʮ��"},
	{14, "ʮ��"},
	{15, "ʮ��"},
	{16, "ʮ��"},
	{17, "ʮ��"},
	{18, "ʮ��"},
	{19, "ʮ��"},
	{20, "إʮ"},
	{21, "إһ"},
	{22, "إ��"},
	{23, "إ��"},
	{24, "إ��"},
	{25, "إ��"},
	{26, "إ��"},
	{27, "إ��"},
	{28, "إ��"},
	{29, "إ��"},
	{30, "��ʮ"},  
  }
  
  local month = {
	--[[{1, "����"},
	{2, "î��"},
	{3, "����"},
	{4, "����"},
	{5, "����"},
	{6, "δ��"},
	{7, "����"},
	{8, "����"},
	{9, "����"},
	{10, "����"},
	{11, "����"},
	{12, "����"}, ]]
	{1, "һ��"},
	{2, "����"},
	{3, "����"},
	{4, "����"},
	{5, "����"},
	{6, "����"},
	{7, "����"},
	{8, "����"},
	{9, "����"},
	{10, "ʮ��"},
	{11, "ʮһ��"},
	{12, "ʮ����"}, 	
  }
  
  local year = {
	{1, "����"},
	{2, "�ҳ�"},
	{3, "����"},
	{4, "��î"},
	{5, "�쳽"},
	{6, "����"},
	{7, "����"},
	{8, "��δ"},
	{9, "����"},
	{10, "����"},
	{11, "����"},
	{12, "�Һ�"},
	{13, "����"},
	{14, "����"},
	{15, "����"},
	{16, "��î"},
	{17, "����"},
	{18, "����"},
	{19, "����"},
	{20, "��δ"},
	{21, "����"},
	{22, "����"},
	{23, "����"},
	{24, "����"},
	{25, "����"},
	{26, "����"},
	{27, "����"},
	{28, "��î"},
	{29, "�ɳ�"},
	{30, "����"},
	{31, "����"},
	{32, "��δ"},
	{33, "����"},
	{34, "����"},
	{35, "����"},
	{36, "����"},
	{37, "����"},
	{38, "����"},
	{39, "����"},
	{40, "���"},
	{41, "�׳�"},
	{42, "����"},
	{43, "����"},
	{44, "��δ"},
	{45, "����"},
	{46, "����"},
	{47, "����"},
	{48, "����"},
	{49, "����"},
	{50, "���"},
	{51, "����"},
	{52, "��î"},
	{53, "����"},
	{54, "����"},
	{55, "����"},
	{56, "��δ"},
	{57, "����"},
	{58, "����"},
	{59, "����"},
	{60, "�ﺥ"},
  }
	if JY.RANDOM == 0 and JY.Status == GAME_MMAP then --����¼�
		local str = "��"..JY.MONTH.."��"..JY.DAY.."�������޴��·���"
		if CC.SuiName ~= "" then
			str = "��"..JY.MONTH.."��"..JY.DAY.."��".. CC.SuiName.." "..CC.SuiThing.." "..CC.SuiResult 
		end
		lib.Background(0, CC.ScreenH - 20, CC.ScreenW, CC.ScreenH, 128)

		if CC.SuiType == 0 then
			DrawString(10, CC.ScreenH - 20, str, C_WHITE, 20)
		elseif CC.SuiType == 1 then
			DrawString(10, CC.ScreenH - 20, str, C_GOLD, 20)
		end  
	end
  local t = math.modf((lib.GetTime() - JY.LOADTIME) / 60000 + GetS(14, 2, 1, 4))
  --[[local t1, t2 = 0, 0
  while t >= 60 do
    t = t - 60
    t1 = t1 + 1
  end
  t2 = t]]
--[[
  local dd, mm, yy = 1, 1, 1
  while t >= 360 do
	t = t - 360
	yy = yy + 1
  end

  while t >= 30 do
	t = t - 30
	mm = mm + 1
  end 
  dd = dd + t]]
	if JY.Thing[203][WZ6] < 1 then JY.Thing[203][WZ6] = 1 end
  
  DrawBox(10, 10, 225, 130, C_GOLD)
  DrawString(15, 15, string.format("��Ŀ%d ��%d ����:%d", JY.Thing[203][WZ6], JY.Thing[202][WZ7], tianshu()), M_Orange, 20) --�������ǣ�����
  DrawString(15, 40, string.format(CC.s54, JY.Person[0]["Ʒ��"], JY.GOLD), M_Orange, 20)
  if JY.WGLVXS == 1 then
    --DrawString(15, 40, string.format(CC.s55, t1, t2) .. mode, C_GOLD, 20)
	--DrawString(15, 40, year[JY.YEAR][2].."�� "..month[JY.MONTH][2].." "..day[JY.DAY][2], M_Orange, 20)
	DrawString(15, 65, "��"..year[JY.YEAR][1].."�� "..month[JY.MONTH][2].." "..day[JY.DAY][2], M_Orange, 20)
  else
    --DrawString(15, 40, string.format(CC.s55, t1, t2), C_GOLD, 20)
	DrawString(15, 65, "��"..year[JY.YEAR][1].."�� "..month[JY.MONTH][2].." "..day[JY.DAY][2], M_Orange, 20)
  end
  DrawString(16, 90, "��", M_Orange, 15)
  DrawString(16, 105, "��", M_Orange, 15)
	lib.SetClip(35, 92, 35 + math.modf(JY.TL/100 * 160), 92 + 75)
	lib.PicLoadCache(0, 498 * 2, 35, 92 + 75, 1)
	lib.PicLoadCache(0, 499 * 2, 35, 92, 1)  	
end


function NLJS(id, page) --����˵�� 
	local size = CC.DefaultFont
	local size1 = 24
	local p = JY.Person[id]
	local p0 = JY.Person[0]
	local width = 18 * size + 15
	local h = size + CC.PersonStateRowPixel
	local h1 = size1 + CC.PersonStateRowPixel
	local height = 13 * h + 10
	local dx = (CC.ScreenW - width) / 2
	local dy = (CC.ScreenH - height) / 2
	dx = 0
	dy = 0
	local x1, y1 = nil, nil
	local start = 1
	local over = 14 
	local gap = 3
	local gap2 = 14
	local name = p["����"]
	local hid = gethead(id)
	--if id > JY.PersonNum then return 1 end
	if zjtype() == 1 and id == 0 then
		name = tostring(putong())
	end	
	if id == 77 and GetS(99,0,1,0) > 0 then 
	   name = "���л�1"
	end   
	if id == 92 and name ~= "����" and name ~= "½��˫" and name ~= "������" and name ~= "ɭ���" and name ~= "����ǳ" then name = "92" end --�������ǣ���������ɽ��Ů��
	x1 = dx + 5 + size
	y1 = dy + 5
	--��ݼ�ESC�������Խ���\���»���\���ҷ�ҳ
	local realname = p["����"]
	local NLJS = {}
	NLJS[name] = {}
	if CC.NLJS[name] ~= nil and string.sub(CC.NLJS[name][1], 7) ~= "" then --��ͨ������˵
		for i = 1, #CC.NLJS[name] do
			NLJS[name][i] = CC.NLJS[name][i]
			if i == #CC.NLJS[name] then
				NLJS[name][#NLJS[name] + 1] = ""
			end
		end
	end
	if duiyou(id) and CC.NLJS[name] ~= nil and CC.NLJS2[name] ~= nil then --����������˵
		NLJS[name][#NLJS[name]] = nil
		if JX(id) then
			local lc = #NLJS[name]
			for i = 1, #CC.NLJS2[name] do
				NLJS[name][lc + i] = CC.NLJS2[name][i]
				if i == #CC.NLJS2[name] then
					NLJS[name][#NLJS[name] + 1] = ""
				end
			end
		else
			local lc = #NLJS[name]
			for i = 1, #CC.NLJS2[name] do
				local length = string.len(CC.NLJS2[name][i])
				NLJS[name][lc + i] = ""
				for ll = 1, math.modf(length / 2) do
					NLJS[name][lc + i] = NLJS[name][lc + i].."��"			
				end		
				if i == #CC.NLJS2[name] then
					NLJS[name][#NLJS[name] + 1] = ""
				end						
			end
		end
	end
	if JY.Thing[202][WZ7] >= 5 and (JY.Person[id]["����12"] or 0) > 0 and (not duiyou(id)) and (#CC.NLJS[JY.Person[JY.Person[id]["����12"]]["����"]] or 0) > 1 then
		NLJS[name][#NLJS[name] + 1] = "��"..CC.NLJS[JY.Person[JY.Person[id]["����12"]]["����"]][2].."��"
	end
	if id > 0 or (id == 0 and zjtype() == 3) or (id == 0 and T10XXZ(id)) then
		for i = 1, 5 do
			if JY.Person[id]["����"..i] > 0 then
				local ss = JY.Person[id]["����"..i]			
				if i == 1 and JY.Person[id]["����"..i + 1] <= 0 then
					NLJS[name][#NLJS[name] + 1] = "�츳".."��"..CC.TFlist[ss][1]
				else
					NLJS[name][#NLJS[name] + 1] = "�츳"..CC.NUM[i].."��"..CC.TFlist[ss][1]
				end
				NLJS[name][#NLJS[name] + 1]  = CC.TFlist[ss][2]
				NLJS[name][#NLJS[name] + 1] = ""
			end
		end
	end

	local title = gettitle(id)
	if title ~= "" then
		title = "��"..title.."��"
	else
		title = "������"
	end	
	if NLJS[name][#NLJS[name]] == "" then NLJS[name][#NLJS[name]] = nil end
	while true do
		Cls()
		--lib.LoadPicture(CONFIG.PicturePath .. "bk6.png", 0, 0)
		--lib.LoadPicture(CONFIG.PicturePath .. "bt0.png", 0, CC.ScreenH-34)
		lib.PicLoadFile(CC.ThingPicFile[1], CC.ThingPicFile[2], 93)
		lib.PicLoadCache(93, 6, 500, 300)
		DrawBox(dx, dy, CC.ScreenW, CC.ScreenH, C_WHITE)
		--[[lib.PicLoadCache(55, hid * 2, CC.ScreenW - dx - 441, CC.ScreenH - dy - 397, 1)
		lib.PicLoadCache(55, 0, CC.ScreenW - dx - 330, CC.ScreenH - dy - 147, 1)
		MyDrawString(CC.ScreenW - dx - 260, CC.ScreenW, CC.ScreenH - dy - 77, realname, C_WHITE, 30) 
		MyDrawString(CC.ScreenW - dx - 260, CC.ScreenW, CC.ScreenH - dy - 47, title, C_GOLD, 30) ]]
		DrawString(x1, y1, realname.."������˵", C_ORANGE, size - 3)
		DrawString(x1 + size * 5, y1 + h + h * 15 , "���¼���������Ҽ��л���ESC�˳�", C_ORANGE, size - 3)	
		if id == 0 then
			if zjtype() == 1 then
				name = tostring(putong())
			elseif zjtype() == 3 then
				name = JY.Person[cxzj()]["����"]
			elseif zjtype() == 4 then
				name = "�Դ�"
				NLJS[name] = {"�ƺţ�"..JY.Person[578]["����"], "", "���ܣ�"}
				local cc = 4
				for i = 1, #CC.SKlist do
					if hasTF(zj(), i) then				
						NLJS[name][cc] = CC.SKlist[i][1].."��"..CC.SKlist[i][2]
						cc = cc + 1
					end
				end
				for i = 1, #CC.DZlist do
					if hasDZ(zj(), i) then				
						NLJS[name][cc] = CC.DZlist[i][1].."��"..CC.DZlist[i][2]
						cc = cc + 1
					end
				end
			end
		end

		local j = 0
		DrawString(x1, y1 + h + h1 * j + 10, "ӡ�ţ�", M_Wheat, size1)
		local function tmp(aa)
			if aa ~= 0 then
				return true
			else
				return false
			end
		end
		local m = limitX(2 + math.modf(JY.Person[id]["ʵս"] / 250), 2, 4) --m = limitX(m + math.modf(JY.Person[id]["ʵս"] / 250), 0, 4) 
		if MPPD(id) ~= 0 then 
			m = 2
		end		
		for i = 1, m do
			local chk = JY.Person[id]["HZ"..i]
			if tmp(chk) then
				DrawString(x1 + size1 * (3 * (math.modf(i / 3) * 2 + 1)), y1 + h + h1 * j + 10 + h1 - (h1 * math.fmod(i, 2)), CC.HZ[chk][2], M_Wheat, size1)
			else
				DrawString(x1 + size1 * (3 * (math.modf(i / 3) * 2 + 1)), y1 + h + h1 * j + 10 + h1 - (h1 * math.fmod(i, 2)), "��������", M_Wheat, size1)
			end	
		end
		
		if NLJS[name] ~= nil then
			breakdown(NLJS[name], 62)
			local i = gap
			if start > 1 then
				DrawString(x1 - size1 - 3, y1 + h + h1 * i, "��", C_ORANGE, size1)
			end
			if over < #NLJS[name] then
				DrawString(x1 - size1 - 3, y1 + h + h1 * 17, "��", C_ORANGE, size1)
			end
			if #NLJS[name] <= gap2 then
				for j = 1, #NLJS[name] do
					local tt = string.sub(NLJS[name][j], 1, 4)
					if tt == "�츳" or tt == "�ƺ�" or tt == "ָ��" or tt == "����" 
						or tt == "����" then
						DrawString(x1, y1 + h + h1 * i + 10, NLJS[name][j], C_GOLD, size1)	
					else
						DrawString(x1, y1 + h + h1 * i + 10, NLJS[name][j], C_WHITE, size1)	
					end
					i = i + 1					
				end		
			else
				for j = start, over do
					local tt = string.sub(NLJS[name][j], 1, 4)
					if tt == "�츳" or tt == "�ƺ�" or tt == "ָ��" or tt == "����" 
						or tt == "����" then
						DrawString(x1, y1 + h + h1 * i + 10, NLJS[name][j], C_GOLD, size1)	
					else
						DrawString(x1, y1 + h + h1 * i + 10, NLJS[name][j], C_WHITE, size1)	
					end
					i = i + 1	
				end
			end
		end	
		ShowScreen()
		local keypress = WaitKey()
		lib.Delay(100)
		if keypress == VK_SPACE or keypress > 1999999 then
		
		elseif keypress == VK_ESCAPE then
			return -1
		elseif NLJS[name] ~= nil and keypress == VK_UP then
			if start > 1 then
				start = start - 1
				over = over - 1
			end
		elseif NLJS[name] ~= nil and keypress == VK_DOWN then
			if over < #NLJS[name] then
				start = start + 1
				over = over + 1
			end
		elseif keypress == VK_LEFT then
			break
		elseif keypress == VK_RIGHT then
			
		end
	end
	return 1
end

------------------------------------------

function cheat()
	if CONFIG.Cheat == "����ʳ��������̸" then
		return true
	else
		return false
	end
end


function pickhead()
	local sx = 60
	local sy = 60
	--local bg = CONFIG.PicturePath .. "game.jpg"
	local tmp = {} --x, y, num
	local current = 1
	local count = 0
	local count2 = 0
	local count3 = 0
	local dx, dy = 1, 1
	local start = 1
	local stop = 56
	local result = -1
	local maxhead = 589
	local x0 = 50
	local y0 = CC.ScreenH/2 - (sy/2 + 10) * 5
	local headfile = {CONFIG.DataPath .. "shead.idx", CONFIG.DataPath .. "shead.grp"}
	--lib.PicLoadFile(headfile[1], headfile[2], 1)		
	local list = {}
	for i = 1, maxhead do 
		list[#list + 1] = i
	end	
	maxhead = #list
	for i = 1, maxhead do		
		tmp[i] = {x0, y0, i - 1}
		count = count + 1
		count2 = count2 + 1
		x0 = x0 + 62
		if count >= 7 then
			count = 0
			x0 = 50
			y0 = y0 + 62
		end
		if count2 >= 56 then
			count2 = 0
			y0 = CC.ScreenH/2 - (sy/2 + 10) * 5	
		end
	end		
	while true do	
		Cls()
		lib.LoadPicture(CC.STA, -1, -1)
		DrawStrBox(-1, 10, "��ѡ��ͷ��", C_GOLD, 30)	
		local count3 = 1
		current = start + 7 * (dy - 1) + dx - 1
		--tb2("dx"..dx.." dy"..dy.." c"..current, 0, 0, C_GOLD, 20)
		for i = start, stop do	
			if tmp[count3] ~= nil and list[i] ~= nil then
				DrawBox(tmp[count3][1] - 31, tmp[count3][2] - 31, tmp[count3][1] + 31,  tmp[count3][2] + 31, C_WHITE)	
				lib.PicLoadCache(1, list[i] * 2, tmp[count3][1], tmp[count3][2])	
			end			
			if i == current then
				DrawBox(tmp[count3][1] - 31, tmp[count3][2] - 31, tmp[count3][1] + 31,  tmp[count3][2] + 31, C_RED)	
			end
			count3 = count3 + 1
		end
		if current <= maxhead then
			lib.PicLoadCache(55, current * 2, CC.ScreenW - 440, CC.ScreenH - 396, 1)
		end
		ShowScreen()
		local p = WaitKey()

		if (p == VK_SPACE or p == VK_RETURN) and list[current] ~= nil then
			result = list[current]
			break
		elseif p == VK_UP then
			current = limitX(current - 7, 1, maxhead)
			dy = limitX(dy - 1, 1, 8)
			if current < start then
				start = limitX(start - 7, 1, maxhead)
				stop = limitX(stop - 7, 56, maxhead)
			end
		elseif p == VK_DOWN then
			current = limitX(current + 7, 1, maxhead)
			dy = limitX(dy + 1, 1, 8)
			if current > stop then
				start = limitX(start + 7, 1, maxhead)
				stop = limitX(stop + 7, 1, maxhead)
				if stop == maxhead then
					if math.fmod(math.fmod(maxhead, 56), 7) ~= 0 then
						stop = stop + 7 - math.fmod(math.fmod(maxhead, 56), 7)
					end
				end
			end
		elseif p == VK_LEFT then
			current = limitX(current - 1, 1, maxhead)
			if start == 1 and dy == 1 and dx == 1 then
			else
				dx = dx - 1
			end
			if dx < 1 then
				dy = limitX(dy - 1, 1, 8)
				dx = 7
			end
			if current < start then
				start = limitX(start - 7, 1, maxhead)
				stop = limitX(stop - 7, 56, maxhead)
			end
		elseif p == VK_RIGHT then
			current = limitX(current + 1, 1, maxhead)
			local tt = math.fmod(maxhead, 56)
			if stop == maxhead and dy == 8 and dx == tt then			
			else
				dx = dx + 1
			end
			if dx > 7 then
				dy = limitX(dy + 1, 1, 8)
				dx = 1
			end			
			if current > stop then
				start = limitX(start + 7, 1, maxhead)
				stop = limitX(stop + 7, 1, maxhead)
			end
		end		
	end
		
	return result
end


function calbody(id)
  local n = 2554*2
  n = n + JY.Person[id]["ͷ�����"] * 8 
  if JY.Person[id]["ͷ�����"] >= 314 then
	n = 4402 * 2 + (JY.Person[id]["ͷ�����"] - 314) * 8 
  end
  if JY.Person[id]["ͷ�����"] >= 340 then
	n = 4511 * 2 + (JY.Person[id]["ͷ�����"] - 340) * 8 
  end 
  if JY.Person[id]["ͷ�����"] >= 342 then
    n = 4519 * 2 + (JY.Person[id]["ͷ�����"] - 342) * 8
  end
  return n
end

function pickbody()
	local sx = 65
	local sy = 65
	--local bg = CONFIG.PicturePath .. "game.jpg"
	local tmp = {} --x, y, num
	local current = 1
	local count = 0
	local count2 = 0
	local count3 = 0
	local dx, dy = 1, 1
	local start = 1
	local stop = 70
	local result = -1
	local list = {}
	for i = 0, JY.PersonNum - 1 do 
		local dup = false
		for j = 1, #list do
			if list[j] ~= nil then
				if list[j][2] == calbody(i) then
					dup = true
					break
				end
			end
		end
		if not dup and i ~= 579 then
			list[#list + 1] = {i, calbody(i)}
		end
	end
	local maxhead = #list
	local x0 = CC.ScreenW/2 - (sx/2 + 10) * 8
	local y0 = CC.ScreenH/2 - (sy/2 + 10) * 5	
	for i = 1, maxhead do		
		tmp[i] = {x0, y0, i - 1}
		count = count + 1
		count2 = count2 + 1
		x0 = x0 + 75
		if count >= 10 then
			count = 0
			x0 = CC.ScreenW/2 - (sx/2 + 10) * 8
			y0 = y0 + 75
		end
		if count2 >= 70 then
			count2 = 0
			y0 = CC.ScreenH/2 - (sy/2 + 10) * 5	
		end
	end	
	lib.PicLoadFile(CC.WMAPPicFile[1], CC.WMAPPicFile[2], 12)
	lib.PicLoadFile(CC.WMAPPicFile[1], CC.WMAPPicFile[2], 13, 50)	
	while true do	
		Cls()
		lib.LoadPicture(CC.STA, -1, -1)
		DrawStrBox(-1, 10, "��ѡ��ս������", C_GOLD, 25)	
		local count3 = 1
		current = start + 10 * (dy - 1) + dx - 1
		for i = start, stop do	
			if tmp[count3] ~= nil and list[i] ~= nil then
				local w1, h1, x1_off, y1_off = lib.PicGetXY(12, list[i][2]) 
				local x0, y0
				if CONFIG.Zoom == 1 then
					x1_off = x1_off / 2
					x1_off = x1_off - 32 
					y1_off = y1_off / 2
					y1_off = y1_off - 62 
					x0 = tmp[count3][1] - x1_off - 40
					y0 = tmp[count3][2] - y1_off - 35		
				else
					x0 = tmp[count3][1]
					y0 = tmp[count3][2] + 25
				end
				--DrawStrBox(tmp[count3][1] - 40, tmp[count3][2] - 40, ""..i, C_GOLD, 25)
				DrawBox(tmp[count3][1] - 40, tmp[count3][2] - 40, tmp[count3][1] + 35,  tmp[count3][2] + 35, C_WHITE)	
				lib.PicLoadCache(12 + CONFIG.Zoom, list[i][2], x0, y0, 2, 256)	
			end			
			if i == current then
				--DrawStrBox(tmp[count3][1] - 40, tmp[count3][2] - 40, ""..current.."::"..start.."::"..stop, C_GOLD, 25)
				DrawBox(tmp[count3][1] - 40, tmp[count3][2] - 40, tmp[count3][1] + 35,  tmp[count3][2] + 35, C_RED)	
			end
			count3 = count3 + 1
		end
		ShowScreen()
		local p = WaitKey()

		if (p == VK_SPACE or p == VK_RETURN) and list[current] ~= nil then
			result = list[current][1]
			break
		elseif p == VK_UP then
			current = limitX(current - 10, 1, maxhead)
			dy = limitX(dy - 1, 1, 7)
			if current < start then
				start = limitX(start - 10, 1, maxhead)
				stop = limitX(stop - 10, 70, maxhead)
			end
		elseif p == VK_DOWN then
			current = limitX(current + 10, 1, maxhead)
			dy = limitX(dy + 1, 1, 7)
			if current > stop then
				start = limitX(start + 10, 1, maxhead)
				stop = limitX(stop + 10, 1, maxhead)
				if stop == maxhead then
					if math.fmod(math.fmod(maxhead, 70), 10) ~= 0 then
						stop = stop + 10 - math.fmod(math.fmod(maxhead, 70), 10)
					end
				end
			end
		elseif p == VK_LEFT then
			current = limitX(current - 1, 1, maxhead)
			if start == 1 and dy == 1 and dx == 1 then
			else
				dx = dx - 1
			end
			if dx < 1 then
				dy = limitX(dy - 1, 1, 7)
				dx = 10
			end
			if current < start then
				start = limitX(start - 10, 1, maxhead)
				stop = limitX(stop - 10, 70, maxhead)
			end
		elseif p == VK_RIGHT then
			current = limitX(current + 1, 1, maxhead)
			local tt = math.fmod(maxhead, 70)
			if stop == maxhead and dy == 7 and dx == tt then			
			else
				dx = dx + 1
			end
			if dx > 10 then
				dy = limitX(dy + 1, 1, 7)
				dx = 1
			end			
			if current > stop then
				start = limitX(start + 10, 1, maxhead)
				stop = limitX(stop + 10, 1, maxhead)
			end
		end		
	end
	lib.PicLoadFile(CC.HeadPicFile[1], CC.HeadPicFile[2], 1)	
	return result
end

function learnSK()
	local num = 0
	local nummax = 4 + JY.Thing[203][WZ6]
	local m = {
		{"ѧϰ����", nil, 1},
		{"��ʼ�ó�", nil, 1},
	}
	local menu = {}
	for i = 1, #CC.SK do
		menu[i] = {}
		menu[i][1] = CC.SK[i][1]
		menu[i][2] = CC.SK[i][2]
		breakdown(menu[i], 50)
		menu[i][#menu[i] + 1] = "��Ҫ"..CC.SK[i][3].."��".."����ʣ"..CC.SKpoint.."�����ܵ�"
		menu[i][0] = 1

		if hasTF(zj(), i) then
			menu[i][0] = 0
		end
	end
	
	while true do
		Cls()
		local r = ShowMenu3(m,#m,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"��ѧ"..num.."������", nil,M_DimGray,C_RED)
		if r == 2 then
			break
		end
		if r == 1 and num >= nummax then
			tb("�ѳ�������ѧ���������")
			break
		end
		local s = sidetoside(menu, 2)
		if s > 0 then
			if CC.SKpoint < CC.SK[s][3] then
				tb("���ܵ������㣡")
			else
				CC.SKpoint = CC.SKpoint - CC.SK[s][3]
				menu[s][0] = 0
				setSK(s, 1)
				num = num + 1
				for i = 1, #CC.SK do
					menu[i][3] = "��Ҫ"..CC.SK[i][3].."��".."����ʣ"..CC.SKpoint.."�����ܵ�"
				end
			end
		end
	end
end

function learnDZ()
	local num = 0
	local nummax = 3
	local m = {
		{"ѧϰ����", nil, 1},
		{"��ʼ�ó�", nil, 1},
	}
	local menu = {}
	for i = 1, #CC.DZ do
		menu[i] = {}
		menu[i][1] = CC.DZ[i][1]
		menu[i][2] = CC.DZ[i][2]
		breakdown(menu[i], 50)
		menu[i][#menu[i] + 1] = "��Ҫ"..CC.DZ[i][3].."��".."����ʣ"..CC.SKpoint.."�����ܵ�"
		menu[i][0] = 1

		if hasDZ(zj(), i) then
			menu[i][0] = 0
		end
	end
	
	while true do
		Cls()
		local r = ShowMenu3(m,#m,1,-2,-2,-2,-2,1,0,24,C_GOLD,C_WHITE,"��ѧ"..num.."��ս�����", nil,M_DimGray,C_RED)
		if r == 2 then
			break
		end
		if r == 1 and num >= nummax then
			tb("�ѳ�������ѧ���������")
			break
		end
		local s = sidetoside(menu, 2)
		if s > 0 then
			if CC.SKpoint < CC.DZ[s][3] then
				tb("���ܵ������㣡")
			else
				CC.SKpoint = CC.SKpoint - CC.DZ[s][3]
				menu[s][0] = 0
				setDZ(s, 1)
				num = num + 1
				for i = 1, #CC.DZ do
					menu[i][3] = "��Ҫ"..CC.DZ[i][3].."��".."����ʣ"..CC.SKpoint.."�����ܵ�"
				end
			end
		end
	end
end

function setRW(n, flag)
	if flag ~= nil then
		SetS(103, 63, n, 0, flag)
	else
		if GetS(103, 63, n, 0) ~= 1 then
			return false
		else
			return true
		end
	end
end

function setteam(id, n)
	if n == nil then
		n = 1
	end
	JY.Person[id]["YES"] = n
end

function hasteam(id)
	if JY.Person[id]["YES"] == 1 then
		return true
	else
		return false
	end
end

function DIYglobal()
	JY.nglist = {6,89,90,92,93,94,95,96,97,98,99,121,124,150,151,152,153,178,185,186,187}
	JY.nglist2 = {100,101,102,103,104,105,106,107,108,180,181,182,183,184,188,189,203,204}
	JY.qglist = {115,116,117,118,119,143,179,190,191,192,193,194,195,196,197,198,199,200,205}
	CC.HZlist = {} --id, ӵ��0/1��ʹ����id-1/id
	for i = 1, CC.HZNumMax do 
		CC.HZlist[i] = {i, 0, 0}
	end
	CC.SKlist = {} --0/1
	for i = 1, #CC.SK do
		CC.SKlist[i] = {CC.SK[i][1], CC.SK[i][2], 0}
	end
	CC.DZlist = {} --0/1
	for i = 1, #CC.DZ do
		CC.DZlist[i] = {CC.DZ[i][1], CC.DZ[i][2], 0}
	end
	--CC.SKpoint = 0
	BJ.fame = 0
	BJ.cash = 0
	BJ.bouncer = 0
	BJ.team = 0
	BJ.total = 0
	BJ.win = 0
	BJ.lose = 0  	
	RW = {}
	RW.event = -1
	RW.scene = -1
	RW.location = -1
	RW.targetscene = -1
	RW.target = -1
	RW.tmp = -1
	RW.current = -1	
	RW.type = -1
	RW.t1 = -1
	RW.n1 = -1
	RW.t2 = -1
	RW.n2 = -1
	RW.t3 = -1
	RW.n3 = -1
	RW.t4 = -1
	RW.n4 = -1
	RW.t5 = -1
	RW.n5 = -1	
	RW.fame = 0
	RW.list = {
	[1] = {0, 1, 7, 10, 3, 5},
	[3] = {1, 9, 10, 11, 2, 3, 6, 8, 0},
	[12] = {12, 10, 9, 11},
	[16] = {11, 12, 13, 17, 18, 14},
	[17] = {1, 2},
	[19] = {4, 5, 6},
	[26] = {12, 13, 14, 15, 16, 23, 24, 26, 25, 27, 7, 8, 9, 10, 11, 32, 33, 34, 35,28, 29, 30, 31, 18, 19, 20, 21},
	[27] = {2, 3, 51, 52},
	[28] = {8, 9, 10, 11, },
	[29] = {3, 4, 5, 6},
	[31] = {6},
	[35] = {4, 5, 6, 7, 8, 9, 10, 12, 13, 14},
	[37] = {0, 1, 2, 3, 4},
	[39] = {5, 6, 7, 8},
	[40] = {1, 13, 14, 15, 17, 18, 10, 12},
	[43] = {1, 2},
	[48] = {4, 5, 23, 24, 6, 7, 8, 9, 10, 11},
	--[51] = {6, 7, 8, 9, 10, 11, 12, 13},
	[58] = {1, 2, 12, 13},
	[60] = {1, 27, 28, 29, 4, 5, 7, 8, 9},
	[61] = {4, 0, 8, 17, 18, 19},
	[69] = {20, 21, 1, 2, 3, 4, 5, 6},
	[71] = {5, 6, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18},
	[76] = {7, 8, 9, 10},
	--[96] = {1, 2, 3, 4, 5, 6, 7, 8},
	[107] = {3, 4, 5, 6, 7, 8},
	[108] = {0, 1, 2, 3, 4, 5, 6, 7},
	--[] = {},
	}	
	RW.zb = {36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,58,59,60,61,62,63,230,236,243,244,245,246,247,248,249,250,253,255,256}
	RW.wg = {}
	RW.mp = {
		{"ȫ���", 19, 291, 300},
		{"�������", 26, 231, 240},
		{"��ɽ��", 27, 191, 200},
		{"������", 28, 461, 469}, --461-478, 479-496, 400-409
		{"̩ɽ��", 29, 201, 210},
		{"��ɽ��", 31, 380, 389},
		{"������", 33, 330, 339},
		{"�����", 34, 350, 359},
		{"������", 35, 261, 270},
		{"�����", 36, 211, 220},
		{"�嶾��", 37, 221, 230},
		{"ѩɽ��", 39, 241, 250},
		{"�䵱��", 43, 320, 329},
		{"���ư�", 48, 281, 290},		
		{"ؤ��", 51, 271, 280},
		{"��ɽ��", 57, 360, 369},
		{"��ɽ��", 58, 370, 379},
		{"������", 68, 340, 349},
		{"������", 71, 390, 399},
		--{"����", 11, 301, 310},
	}
	--�ر�����
	RW.special = {
		{101, 41, 39, 15},
		{102, 46, 18, 40}, 
		{104, 40, 22, 45}, 
		{104, 40, 24, 42}, 
		{106, 108, 11, 41},
		{107, 10, 22, 37},
		{107, 10, 22, 39},
		{108, 109, 24, 26},
		{108, 109, 22, 28},	
		{109, 107, 34, 12},	
		{109, 107, 36, 8},	
		{109, 107, 40, 8},			
	}
	RW.s = {
		{101, "����������", "��������Դ", "��", "����ɽ��"},
		{102, "������", "����", nil, "����ɽ��"},
		{103, "������", "ʤ����", "��", "�м��ջ"},
		{104, "��ؤ�����", "������", "��", "����"},
		{105, "��������", "������", "������", "������"},
		{106, "��Թ����", "������", "��", "���ɽׯ"},
		{107, "��������", "������", "��", "ɳĮɽ��"},
		{108, "��Գ����Ů", "������", "��", "����"},
		{109, "��������", "������", "��", "����"},
	}
	YC.BG = "home"
	YC.PET = {3, 2, 1, 1}
	CC.SuiType = 0
	CC.SuiName = ""
	CC.SuiThing = ""
	CC.SuiResult = ""
	YC.PLOT = {}
	for i = 1, 1000 do
		YC.PLOT[i] = {0, 0, 0, 0, 0, 0, 0, 0, 0, "", 0} 
		--��ʼ1��2��3�գ��ر�4��5��6�գ�7�¼���ţ�8��� - 0δ����1����δ���2���3�����9�ص㣬10��ʾ, 11�������
	end
end

function saveConstant()
	--�����������
	local data=Byte.create(JY.PersonNum*2)
	Byte.set16(data,0,JY.Thing[203][WZ6])
	for i = 1, JY.PersonNum - 1 do
		Byte.set16(data,i*2,JY.Person[i]["����"])
	end
	Byte.savefile(data,'.\\data\\SAVE\\week.data',0,JY.PersonNum*2)
	--save skpoint
	local data = Byte.create(8)
	Byte.set32(data, 0, CC.SKpoint)	
	Byte.set32(data, 2, JY.Thing[203][WZ6])	
	Byte.savefile(data, CC.R_GRPFilename[0], 1652, 4)	
	
end

function loadConstant()
	--��ȡ��Ŀ����
	local data=Byte.create(JY.PersonNum*2)
	Byte.loadfile(data,'.\\data\\SAVE\\week.data',0,JY.PersonNum*2)
	JY.Thing[203][WZ6] = Byte.get16(data,0)
	if JY.Thing[203][WZ6] < 1 then JY.Thing[203][WZ6] = 1 end
	for i = 1, JY.PersonNum - 1 do
		JY.Person[i]["����"] = Byte.get16(data,i*2)
	end		
	--load skpoint
	local data = Byte.create(8)
	Byte.loadfile(data, CC.R_GRPFilename[0], 1652, 2)
	CC.SKpoint = Byte.get32(data, 0, 2)
	Byte.loadfile(data, CC.R_GRPFilename[0], 1654, 2)
	JY.Thing[203][WZ6] = Byte.get32(data, 0)	
end

function DIYsave(r)
	savebj(r)
	saveConstant()
	--save RW
	local size = 20 * 4
	local data = Byte.create(size * 4)
	local tmp = r - 1
	Byte.set32(data, 0, RW.event)	
	Byte.set32(data, 4, RW.scene)	
	Byte.set32(data, 8, RW.location)	
	Byte.set32(data, 12, RW.targetscene)	
	Byte.set32(data, 16, RW.target)		
	Byte.set32(data, 20, RW.tmp)	
	Byte.set32(data, 24, RW.current)	
	Byte.set32(data, 28, RW.type)	
	Byte.set32(data, 32, RW.t1)	
	Byte.set32(data, 36, RW.n1)	
	Byte.set32(data, 40, RW.t2)	
	Byte.set32(data, 44, RW.n2)	
	Byte.set32(data, 48, RW.t3)	
	Byte.set32(data, 52, RW.n3)	
	Byte.set32(data, 56, RW.t4)	
	Byte.set32(data, 60, RW.n4)	
	Byte.set32(data, 64, RW.t5)	
	Byte.set32(data, 68, RW.n5)	
	Byte.set32(data, 72, RW.fame)	
	--Byte.savefile(data, '.\\data\\SAVE\\rwdata', tmp * size, size)
	Byte.savefile(data, '.\\data\\SAVE\\rwdata' .. r, 0, size)
	
	--save HZ
	local size = 4 * 2 * CC.HZNumMax
	local data = Byte.create(size * 4)
	local tmp = r - 1
	for i = 1, CC.HZNumMax do
		Byte.set32(data, (i - 1) * 8, CC.HZlist[i][2])	
		Byte.set32(data, (i - 1) * 8 + 4, CC.HZlist[i][3])	
	end
	--Byte.savefile(data, '.\\data\\SAVE\\hzdata', tmp * size, size)	
	Byte.savefile(data, '.\\data\\SAVE\\hzdata' .. r, 0, size)	
	
	--save SK
	local size = 4 * #CC.SK
	local data = Byte.create(size * 4)
	local tmp = r - 1
	for i = 1, #CC.SK do
		Byte.set32(data, (i - 1) * 4, CC.SKlist[i][3])	
	end
	--Byte.savefile(data, '.\\data\\SAVE\\skdata', (tmp * size) + 4, size)	
	Byte.savefile(data, '.\\data\\SAVE\\skdata' .. r, 4, size)	
		--save DZ
	local size = 4 * #CC.DZ
	local data = Byte.create(size * 4)
	local tmp = r - 1
	for i = 1, #CC.DZ do
		Byte.set32(data, (i - 1) * 4, CC.DZlist[i][3])	
	end
	--Byte.savefile(data, '.\\data\\SAVE\\dzdata', (tmp * size) + 4, size)
	Byte.savefile(data, '.\\data\\SAVE\\dzdata' .. r, 4, size)	
end

function DIYload(r)
	loadbj(r)
	loadConstant()
	--load RW
	local size = 20 * 4
	local data = Byte.create(size * 4)
	local tmp = r - 1
	--Byte.loadfile(data, '.\\data\\SAVE\\rwdata', tmp * size, r * size)
	Byte.loadfile(data, '.\\data\\SAVE\\rwdata' .. r, 0, size)
	RW.event = Byte.get32(data, 0)
	RW.scene = Byte.get32(data, 4)
	RW.location = Byte.get32(data, 8)
	RW.targetscene = Byte.get32(data, 12)
	RW.target = Byte.get32(data, 16)	
	RW.tmp = Byte.get32(data, 20)	
	RW.current = Byte.get32(data, 24)		
	RW.type = Byte.get32(data, 28)	
	RW.t1 = Byte.get32(data, 32)	
	RW.n1 = Byte.get32(data, 36)		
	RW.t2 = Byte.get32(data, 40)	
	RW.n2 = Byte.get32(data, 44)		
	RW.t3 = Byte.get32(data, 48)	
	RW.n3 = Byte.get32(data, 52)		
	RW.t4 = Byte.get32(data, 56)	
	RW.n4 = Byte.get32(data, 60)	
	RW.t5 = Byte.get32(data, 64)	
	RW.n5 = Byte.get32(data, 68)	
	RW.fame = Byte.get32(data, 72)
	
	--load HZ
	local size = 4 * 2 * CC.HZNumMax
	local data = Byte.create(size * 4)
	local tmp = r - 1	
	--Byte.loadfile(data, '.\\data\\SAVE\\hzdata', tmp * size, r * size)
	Byte.loadfile(data, '.\\data\\SAVE\\hzdata' .. r, 0, size)
	for i = 1, CC.HZNumMax do
		CC.HZlist[i][2] = Byte.get32(data, (i - 1) * 8)
		CC.HZlist[i][3] = Byte.get32(data, (i - 1) * 8 + 4)	
	end
	
	--load SK
	local size = 4 * #CC.SK
	local data = Byte.create(size * 4)
	local tmp = r - 1
	--Byte.loadfile(data, '.\\data\\SAVE\\skdata', (tmp * size) + 4, r * size)
	Byte.loadfile(data, '.\\data\\SAVE\\skdata' .. r, 4, size)
	for i = 1, #CC.SK do
		CC.SKlist[i][3] = Byte.get32(data, (i - 1) * 4)	
	end	
		--load DZ
	local size = 4 * #CC.DZ
	local data = Byte.create(size * 4)
	local tmp = r - 1
	--Byte.loadfile(data, '.\\data\\SAVE\\dzdata', (tmp * size) + 4, r * size)
	Byte.loadfile(data, '.\\data\\SAVE\\dzdata' .. r, 4, size)
	for i = 1, #CC.DZ do
		CC.DZlist[i][3] = Byte.get32(data, (i - 1) * 4)	
	end	
end

function resetRW()
	RW.event = -1
	RW.scene = -1
	RW.location = -1
	RW.targetscene = -1
	RW.target = -1
	RW.tmp = -1
	RW.current = -1		
	RW.type = -1
	RW.t1 = -1
	RW.n1 = -1
	RW.t2 = -1
	RW.n2 = -1
	RW.t3 = -1
	RW.n3 = -1
	RW.t4 = -1
	RW.n4 = -1
	RW.t5 = -1
	RW.n5 = -1		
end

function rwlocation(a, s, l)
	if a == 1 then
		if s == nil or l == nil then
			s = RW.scene
			l = RW.location
		end		
	elseif a == 2 then
		if s == nil or l == nil then
			s = RW.targetscene
			l = RW.target
		end	
	end
	return GetD(s, l, 9), GetD(s, l, 10)
end

function randomlocation()
	local a
	while true do
		a = math.random(106)
		if RW.list[a] == nil then
		else
			break
		end
	end
	return a, RW.list[a][math.random(#RW.list[a])]
end
	
function initializerw(flag,teshu)
	local event = -1
	local scene = -1
	local location = -1
	local targetscene = -1
	local target = -1
	local mp = false
	for i = 1, #RW.mp do
		if JY.SubScene == RW.mp[i][2] then
			mp = true
			break
		end
	end

	local special = 109
	--if JLSD(10, 20 + math.modf(RW.fame * 0.5), 0) then
	--	event = math.random(101, special)
	--	if setRW(event - 100) then --or event == 105 then
	--		event = -1
	--	end
	--end

	if teshu ~= nil then event = teshu end
	
	local total = 6
	if event == -1 then
		if mp then --������Ҫ�޸�
			event = math.random(total)
		else
			event = math.random(total - 1)
		end	
	end
	if JY.Person[0]["�ȼ�"] == 1 then event = 3 end --�������ǣ�һ��ʼֻ���ͻ�
	--event = math.random(5) --����
	--event = 101 --����   �ر�����

	if event == 1 then --Ѱ��
		if math.random(100) <= 50 then
			target = RW.zb[math.random(#RW.zb)]
		else
			target = randomwugong(1, 15)
		end
	elseif event == 2 or event == 3 then --���� and �ͻ�
		while true do
			targetscene, target = randomlocation()
			if targetscene ~= JY.SubScene then
				break
			end
		end
	elseif event == 4 or event == 5 then --ɱ��/ɱ��
		
	elseif event == 6 then --Ѳ��
		local enemy
		while true do
			enemy = math.random(#RW.mp)
			if RW.mp[enemy][2] ~= JY.SubScene then
				break
			end
		end
		target = enemy
	end
	
	if event >= 101 and event <= special then --�ر�����
		local num = 1
		for i = 1, #RW.special do
			if RW.special[i][1] == event then
				if targetscene == -1 then
					targetscene = RW.special[i][2]
				end
				local b = RW.special[i][3]
				local c = RW.special[i][4]
				SetS(targetscene, b, c, 3, 109 + num)		
				SetD(targetscene, 109 + num, 9, b)
				SetD(targetscene, 109 + num, 10, c)
				num = num + 1
			end
		end
		target = 110
		if event == 103 then
			targetscene = 3
			target = 1
		end		
	end
	
	scene = JY.SubScene
	local x, y = RWpoint()
	location = GetS(scene, x, y, 3)
	return event, scene, location, targetscene, target
end

function getRW(k,teshu)
	--�����������ʼ���������ӿ���Ҫ�Ӹ���α���񡱣�ֻ��ͼ�ꣿֻ�н����˲Ÿ�ȫ�ֱ���
	local function createhead()	
		local h = math.random(350, 575)
		--[[
		while true do
			h = math.random(1, 596)
			if h == 190 or (h >= 311 and h <= 319) or (h >= 410 and h <= 440) or h == 580 or h == 582 then
				
			else
				break
			end
		end]]
		return h
	end
	if teshu == nil and (RWPD() == 0 or k ~= VK_SPACE) then
		do return end
	end
	if (teshu ~= nil or RWPD() == 1) and k == VK_SPACE then		
		local flag = 1 --�������
		local e, s, l, ts, t = initializerw(flag,teshu)
		local pid = 584
		randomstats(pid)
		local head = JY.Person[pid]["ͷ�����"]
		if RW.event == 102 then
			nEvent[102]()
			do return end
		elseif RW.event == 105 then
			nEvent[105]()
			do return end
		elseif RW.fame < 0 then
			say("���ⲻ�����õĻ��򣬰׳ղŻ�ί������¡�", head, 0, "ί����")
			do return end
		elseif RW.event ~= -1 then
			if l ~= RW.location then
				say("�һ����Ȱ����ϵ����������˵�ɡ�")			
			else
				say("�ǾͰ������ˡ�", RW.tmp, 0, "ί����")	
			end
			do return end			
		end		
		--local tmp = GetD(s, l, 2)	
		
		if teshu ~= nil then e = teshu end
		if e == 1 then
			local name = JY.Thing[t]["����"]
			say("��ô��������һֱ��Ѱ�ң�"..name.."�ף���ϧһ���������˭�ܰ����ҵ��Ļ���һ�����س�л��", head, 0, "ί����")
			if yesno("Ҫ����������") == false then
				say("���һ���ȥ�������˰ɡ�", head, 0, "ί����")
				displayRW(3, s, l)
				do return end
			else
				tb("��������Ѱ��"..name.."��")
				
			end
		elseif e == 2 then
			local name = JY.Scene[ts]["����"]
			say("����һ�⼱����Ҫ�͵���"..name.."�ף���Ը���������һ����", head, 0, "ί����")
			if yesno("Ҫ����������") == false then
				say("���һ���ȥ�������˰ɡ�", head, 0, "ί����")
				displayRW(3, s, l)
				do return end
			else
				tb("�����������ŵ�"..name.."��")	
				displayRW(2, ts, t)
			end		
		elseif e == 3 then
			local name = JY.Scene[ts]["����"]
			say("����һЩ������Ҫ�͵���"..name.."�ף���Ը���������һ����", head, 0, "ί����")
			if yesno("Ҫ����������") == false then
				say("���һ���ȥ�������˰ɡ�", head, 0, "ί����")
				displayRW(3, s, l)
				do return end
			else
				tb("���������ͻ���"..name.."��")	
				displayRW(2, ts, t)
				My_Enter_SubScene(s, JY.Scene[s]["���X"], JY.Scene[s]["���Y"], -1)
				say("��Щ��������ģ��ƺ���ֵǮ��....")
				if yesno("Ҫ˽����") == false then
					say("�����ˣ�����Ǯ���������֣�������һ�˾����ˡ�")
				else
					say("��������û�ˣ��̵�Ҳû��֪����")
					rewardRW(3)
					displayRW(3, s, l)
					displayRW(3, ts, t)
					e, s, l, ts, t = -1, -1, -1, -1
					resetRW()
					AddPersonAttrib(zj(), "Ʒ��", -3)
					tb("Ʒ�¼��٣�")
					tb(addfame(-2))
				end
			end				
		elseif e == 4 then
			local name = JY.Scene[s]["����"]
			say("��������У�Ұ�ޣ׺������ˣ������ȥ���Ҹ���������", head, 0, "ί����")
			if yesno("Ҫ����������") == false then
				say("���һ���ȥ�������˰ɡ�", head, 0, "ί����")
				displayRW(3, s, l)
				do return end
			else
				tb("������������"..name.."������Ұ�ޣ�")	
			end			
		elseif e == 5 then
			local name = JY.Scene[s]["����"]
			say("�����ģ�ɽ����Խ��Խ�����ˣ����������ȥ�ַ����Ǿͺ��ˡ�", head, 0, "ί����")
			if yesno("Ҫ����������") == false then
				say("���һ���ȥ�������˰ɡ�", head, 0, "ί����")
				displayRW(3, s, l)
				do return end
			else
				tb("���������ַ�"..name.."������ɽ����")	
			end	
		elseif e == 6 then
			local name = RW.mp[t][1]
			say("������ɵ�����ɽ�¸������֣�"..name.."�׵���Ӱ������������̽���л��ܵġ����������������ֲ�������Ҫ��æѲ����", head, 0, "ί����")
			if yesno("Ҫ����������") == false then
				say("���һ���ȥ�������˰ɡ�", head, 0, "ί����")
				displayRW(3, s, l)
				do return end
			else
				tb("�����������������"..name.."���ˣ�")	
			end			
		end
		
		--�ر�����
		if e == 101 then			
			say("��˵���������ջ�����ģ�ɽ��������һҹ����˺�����Ҳ��֪�������Ǽ٣���Ҫȥ������", head, 0, "ί����")
			if yesno("Ҫȥ̽����") == false then
				displayRW(3, s, l)
				do return end
			else
				tb("��������"..RW.s[e - 100][2])	
				addevent(41, 110, 1, nil, nil, 2529 * 2)
				displayRW(2, ts, t)
				displayRW(3, s, l)
				l = -1
				s = -1				
			end			
		elseif e == 102 then
			say("��������ȥ�ǽ���ɽ����̽�յ�ʱ��һ������Ϯ�������������˶�����Σ�ڵ�Ϧ�����˵��Ҫ�����������ߵ��Զ��������ܾ��Ρ����������ǰɣ�", head, 0, "ί����")
			if yesno("Ҫ��æ��") == false then
				say("������˭�ܰ�����ǣ�", head, 0, "ί����")
				displayRW(3, s, l)
				do return end
			else
				tb("��������"..RW.s[e - 100][2])	
				addevent(46, 110, 1, nil, nil, 4685 * 2)
				displayRW(2, ts, t)
			end				
		elseif e == 103 then
			say("��˵�Ƕ����ߵĿ�ջ���������ھ��������������˵��Ʒ�ܷḻŶ��", head, 0, "·��")
			if yesno("Ҫȥ������") == false then
				displayRW(3, s, l)
				do return end
			else
				tb("��������"..RW.s[e - 100][2])	
				displayRW(3, s, l)
				l = -1
				s = -1				
				displayRW(2, ts, t)
			end				
		elseif e == 104 then
			say("�����ڣ������׼�������������Ī���˵ؤ�����͵�������嶾�ؼ������������ڵ�����ؤ��Ļ����ء�", head, 0, "·��")
			if yesno("Ҫȥ̽����") == false then
				displayRW(3, s, l)
				do return end
			else
				tb("��������"..RW.s[e - 100][2])	
				addevent(40, 110, 1, nil, nil, 7174)
				displayRW(2, ts, t)
				displayRW(3, s, l)
				l = -1
				s = -1						
			end					
		elseif e == 105 then
			head = 589
			say("������һ��������ˣ����Ǹ�����ҩ�ﶼ������ˣ����....", head, 0, "����ǳ") --�������ǣ�����ǳ������ĳ���ҩ
			say("�ѵ����¼ҵ��������֣��ɶ�....", head, 0, "����ǳ")
			say("����������������Ҫ������İɣ���û����Ȥ�����ҵ�ί�а���", head, 0, "����ǳ")
			if yesno("Ҫ����������") == false then
				say("���һ���ȥ�������˰ɡ�", head, 0, "����ǳ")
				displayRW(3, s, l)
				do return end
			else
				say("����ȥ�����Ҹ�ʽ��ҩÿ����������м��á�", head, 0, "����ǳ")
				ts = s
				t = l
				displayRW(2, s, l)
			end					
		elseif e == 106 then --Ԭ�����¼�
			say("��˵��Է����ϲк����������ڱ��������۵����ͱƵòֻʳ��ӡ���˵��������ڣ����ɽׯ���ּ����������ƺ����ڻ����������˭������������", head, 0, "·��")
			if yesno("Ҫȥ������") == false then
				displayRW(3, s, l)
				do return end
			else
				tb("��������"..RW.s[e - 100][2])	
				addevent(108, 110, 1, nil, nil, 5926)
				displayRW(2, ts, t)
				displayRW(3, s, l)
				l = -1
				s = -1						
			end					
		elseif e == 107 then --�����¼�
			say("��˵ɳĮɽ���������֩�뾫���֣����˿���һȺ֩��������һ��Ů�����ء�", head, 0, "·��")
			if yesno("Ҫȥ������") == false then
				displayRW(3, s, l)
				do return end
			else
				tb("��������"..RW.s[e - 100][2])	
				addevent(10, 110, 1, nil, nil, 7038)
				displayRW(2, ts, t)
				displayRW(3, s, l)
				l = -1
				s = -1						
			end				
		elseif e == 108 then --�����¼�
			say("��˵�ϱ�ɭ���������������һֻ�����İ�ëԳ�����Ϯ��·�ˣ���������ܰ������ܾͺ��ˡ�", head, 0, "·��")
			if yesno("Ҫȥ������") == false then
				displayRW(3, s, l)
				do return end
			else
				tb("��������"..RW.s[e - 100][2])	
				addevent(109, 110, 1, nil, nil, 9404)
				displayRW(2, ts, t)
				displayRW(3, s, l)
				l = -1
				s = -1						
			end				
		elseif e == 109 then --������¼�
			say("�����������λ������˸���̨�������ף���ҲӦ��ȥ�����������ǡ�", head, 0, "·��")
			if yesno("Ҫȥ������") == false then
				displayRW(3, s, l)
				do return end
			else
				tb("��������"..RW.s[e - 100][2])	
				addevent(107, 110, 1, nil, nil, 9130)
				displayRW(2, ts, t)
				displayRW(3, s, l)
				l = -1
				s = -1						
			end			
		end				
		RW.event = e
		RW.scene = s
		RW.location = l
		RW.targetscene = ts
		RW.target = t
		RW.tmp = head
		RW.current = 0			
	elseif RWPD() == 2 and k == VK_SPACE then
		doneRW()
	end
end

function doneRW()
	local function dowar(id)
		return WarMain(id)
	end
	local function dead()
		instruct_15(0)
		instruct_0()
	end
	local pid = 584
	if RW.current == 1 then --�������
		local lv = 1
		if RW.event == 1 and hasthing(RW.target) then
			addthing(RW.target, -1)
			say("��Ȼ��ı����ҵ��ˣ�������Ȼ�����鴫��СС���񣬲��ɾ��⡣", RW.tmp, 0, "ί����")
			tb(addfame(3))
			tb(jiadian(math.modf(JY.Thing[RW.target]["��Ǯ"] / 1.5)))		
		elseif RW.event == 2 and RW.scene == JY.SubScene then
			if RW.type == 1 then --1��ͨ 2ս�� 3�ڵ�
				say("��һ���������ˣ�������ĳ��", RW.tmp, 0, "ί����")
				tb(addfame(1))
			elseif RW.type == 2 then
				say("��һ���������ˣ�������ĳ��", RW.tmp, 0, "ί����")
				if yesno("Ҫ����һ����ѵ��") then
					say("�Ǹ��һ�ķ�Ӧ��Σ���������", RW.tmp, 0, "ί����")
					say("�ɶ�����һﾹȻ��������ˮ�����Ҹ�����ѵ��")
					say("��������һ�£�����Ĳ�֪���Ǹ��һ�ķ�Ӧ����ô�󰡡��Ҷ����㲹�����ˡ�", RW.tmp, 0, "ί����")
					lv = 2
				else
					tb(addfame(2))
				end
			elseif RW.type == 3 then
				say("�㣡����ôû�£�", RW.tmp, 0, "ί����")
				say("�׷���Ȼ�׵����������ˣ��ҽ����ҪΪ�������")
				JY.Person[pid]["����"] = "ǿ��"
				if not dowar(294) then
					dead()
					do return end
				end
				light()
				say("���������������Ǳ�������ɽ�ģ����Ҹ�����Ĺ����°ɣ�", RW.tmp, 0, "ί����")
				say("����ô�����˶���˵��һ�仰���ߣ�����ֻ��С�ʹ�룬�����ٷ����������ģ�")	
				say("�ǣ��ǣ�", RW.tmp, 0, "ί����")
				tb(addfame(1))				
			end
		elseif RW.event == 3 and RW.scene == JY.SubScene then
			say("�����úܺã�������ĳ��", RW.tmp, 0, "ί����")
			tb(addfame(2))			
		elseif RW.event == 4 then
			say("������㣬�������˲�����Ұ��ɧ���ˡ�������ĳ��", RW.tmp, 0, "ί����")
			if JY.Person[0]["Ʒ��"] < 75 then
	                instruct_37(1)
		        tb("Ʒ������1�㣡")
	                end
			lv = 3
			tb(addfame(2))			
		elseif RW.event == 5 then
			say("лл���ɽ�������ˣ�������ĳ��", RW.tmp, 0, "ί����")
			if JY.Person[0]["Ʒ��"] < 75 then
	                instruct_37(1)
		        tb("Ʒ������1�㣡")
	                end
			lv = 3
			tb(addfame(2))			
		elseif RW.event == 6 then
			say("лл���æѲ�ߣ���Ȼ���ܸ���ʲôǮ������������Щ���ŵĲ�ҩ���԰���������Ϊ��", RW.tmp, 0, "ί����")
			lv = 4
			tb(addfame(3))		
		end
		
		--�ر�����
		
		if RW.event == 102 then
			if RW.type == 1 then
				say("��ƿ�ӣ������ߵ�����", RW.tmp, 0, "ί����")
				say("�������ѣ�����������Ч�ø�ʤ�ߵ���")
				say("���....�����ˣ�����������ҽ��", RW.tmp, 0, "ί����")
				dark()
				light()
				say("���ˣ����ˣ���������������٢����Щҩ�ﱾ���Ǵ���������֮�õģ�������Ц�ɣ�", RW.tmp, 0, "ί����")
				lv = 5
			else
				say("�ߵ���̫���ˣ��о��ˣ���л��������֮����", RW.tmp, 0, "ί����")
				lv = 2
			end
			setRW(RW.event - 100, 1)
			tb(addfame(2))
		end
		
		if RW.event == 105 then --��������Ҳ�еڶ���
			nEvent[105]()
			do return end
		end
		
		
		--��ӽ�Ʒ
		
		displayRW(3, RW.scene, RW.location)		
		rewardRW(lv)
		resetRW()	
	
	elseif RW.current == 0 then --����ڶ���
		local pid = 583
		local str = ""
		randomstats(pid)
		local head = JY.Person[pid]["ͷ�����"]	
		if RW.event == 2 and RW.targetscene == JY.SubScene then
			str = "������"
			say("���Ǹ��ҵ��ţ����ҿ�����д����ʲô....", head, 0, str)
			dark()
			light()
			local tmp = math.random(3) --1��ͨ 2ս�� 3�ڵ�
			RW.type = tmp
			if tmp == 1 then
				say("ԭ����ˡ����������Զ����һ�ˣ������ڿ��Ի�ȥ�����ˡ�", head, 0, str)
			elseif tmp == 2 then
				JY.Person[pid]["����"] = "��ŭ����"
				str = "��ŭ����"
				say("ʲô���ɶ��ǼһﾹȻ���������ң���С��һ���ǰ��ף�", head, 0, str)		
				say("ι����ʲô��û������")
				if not dowar(293) then
					dead()
					do return end
				end
				light()	
				say("������侲һ�£�")
				say("�ߣ�����һ�ȥ�����Ǹ��һ�������������ƣ�", head, 0, str)		
				say("�������ұ��޹�ǣ�������һ�ȥ���Ǹ��һ����ˣ���")				
			else
				JY.Person[pid]["����"] = "ǿ��"
				str = "ǿ��"
				say("�ٺ٣�ԭ����ˡ���С�Ӿ�����εķ��򰡡������ϵĶ�������������", head, 0, str)		
				say("����ɣ��ұ��������ˣ�")	
				if not dowar(293) then
					dead()
					do return end
				end
				light()		
				say("���������������Ǳ�������ɽ�ģ����Ҹ�����Ĺ����°ɣ�", head, 0, str)
				say("����������ĲƲ�ȫ���乫���Ժ�Ҫ���ٸҷ��£�С������Դ���")	
				say("�ǣ��ǣ�", head, 0, str)			
				rewardRW(2)
				tb(addfame(2))
			end
		
		elseif RW.event == 3 and RW.targetscene == JY.SubScene then
			str = "�ջ���"
			say("�������һ��....��������һ�����١������Զ����һ��Ҳ�����ף����Ǯ����ȥ��ưɡ�����Ի�ȥ�����ˡ�", head, 0, str)			
			addthing(174, math.random(5) * 100)
		end
		RW.current = 1
		displayRW(2, RW.scene, RW.location)	
		displayRW(3, RW.targetscene, RW.target)	--��һ������
		
		--�ر�����
		if RW.targetscene == JY.SubScene and RW.event >= 101 and RW.event <= 111 then
			if RW.event == 101 then
				nEvent[RW.event]()
				setRW(RW.event - 100, 1)
				displayRW(3, RW.scene, RW.location)		
				resetRW()				
			elseif RW.event == 102 then
				nEvent[RW.event]()
			elseif RW.event == 103 then
				nEvent[RW.event]()
				setRW(RW.event - 100, 1)
				displayRW(3, RW.scene, RW.location)		
				resetRW()			
			elseif RW.event == 104 then
				nEvent[RW.event]()
				setRW(RW.event - 100, 1)
				displayRW(3, RW.scene, RW.location)		
				resetRW()			
			elseif RW.event == 105 then
				nEvent[RW.event]()
			elseif RW.event == 106 then
				nEvent[RW.event]()
				setRW(RW.event - 100, 1)
				displayRW(3, RW.scene, RW.location)		
				resetRW()		
			else
				nEvent[RW.event]()
				setRW(RW.event - 100, 1)
				displayRW(3, RW.scene, RW.location)		
				resetRW()				
			end			
		end
	end
end

function RWpoint()
	local x, y = -1, -1
	if JY.Base["�˷���"] == 0 then
		x = JY.Base["��X1"]
		y = JY.Base["��Y1"] - 1
	elseif JY.Base["�˷���"] == 1 then
		x = JY.Base["��X1"] + 1
		y = JY.Base["��Y1"]  
	elseif JY.Base["�˷���"] == 2 then
		x = JY.Base["��X1"] - 1
		y = JY.Base["��Y1"]
	elseif JY.Base["�˷���"] == 3 then
		x = JY.Base["��X1"]
		y = JY.Base["��Y1"] + 1
	end
	return x, y
end

function RWPD()
	local x, y = RWpoint()
	if GetS(JY.SubScene, x, y, 2) == 4683 * 2 then
		return 1
	elseif GetS(JY.SubScene, x, y, 2) == 4684 * 2 then
		return 2
	end
	return 0
end

function displayRW(a, s, l) --1? 2! 3cls
	local x, y = rwlocation(a, s, l)
	if s == nil or l == nil then
		s = RW.scene
		l = RW.location	
	end
	if a == 1 then
		SetS(s, x, y, 2, 4683*2)
		SetS(s, x, y, 5, 80)	
	elseif a == 2 then
		SetS(s, x, y, 2, 4684*2)
		SetS(s, x, y, 5, 80)		
	else
		SetS(s, x, y, 2, 9999*2)
		SetS(s, x, y, 5, 80)			
	end
end

function drawRW()
	if RW.list[JY.SubScene] ~= nil then
		for i = 1, #RW.list[JY.SubScene] do
			if JY.SubScene == RW.scene and RW.list[JY.SubScene][i] == RW.location then
				if RW.current == 0 then
					displayRW(1, JY.SubScene, RW.list[JY.SubScene][i])		
				elseif RW.current == 1 then
					displayRW(2, JY.SubScene, RW.list[JY.SubScene][i])		
				end
				if RW.event == 105 then
					displayRW(2, JY.SubScene, RW.list[JY.SubScene][i])	
				end
			elseif JY.SubScene == RW.targetscene and RW.list[JY.SubScene][i] == RW.target then
				--displayRW(2, JY.SubScene, RW.list[JY.SubScene][i])
			else
				displayRW(3, JY.SubScene, RW.list[JY.SubScene][i])	
				if math.random(10) == 1 then
					displayRW(1, JY.SubScene, RW.list[JY.SubScene][i])				
				end
			end
		end
	end
end

function checkRW()
	if RW.event == 1 then
		if hasthing(RW.target) then
			RW.current = 1
			displayRW(2, RW.scene, RW.location)		
		end
	end
end

function randomplace()
	local a = 70
	while true do
		a = math.random(0, 105)
		if a == 5 or a == 7 or a == 10 or a == 13 or a == 14 or a == 15 or a == 25 or 
			a == 41 or a == 65 or a == 67 or a == 70 or a == 79 or a == 82 or a == 83 
			or a == 84 or a == 85 or (a >= 86 and a <= 91) or a == 104 then
		
		else
			break
		end
	end
	return a
end

function randomstats(pid, flag, name)
	local r = math.random(1, 654)
	while animal(r) or JY.Person[r]["����"] < 1 do
		r = math.random(1, 654)
	end
	if flag ~= nil then
		r = flag
	end
	if name ~= nil then
		JY.Person[pid]["����"] = name
	end
	JY.Person[pid]["�ȼ�"] = 30
	JY.Person[pid]["����"] = 0
	JY.Person[pid]["��������"] = math.random(0, 2)
	JY.Person[pid]["�Ա�"] = JY.Person[r]["�Ա�"]
	JY.Person[pid]["ͷ�����"] = JY.Person[r]["ͷ�����"]
	JY.Person[pid]["������"] = JY.Person[r]["������"]
	JY.Person[pid]["��������"] = JY.Person[r]["��������"]	
	JY.Person[pid]["������"] = math.random(100, 400) 
	JY.Person[pid]["������"] = math.random(100, 400) 
	JY.Person[pid]["�Ṧ"] = math.random(100, 300) 
	JY.Person[pid]["��������"] = math.random(0, 240)
	JY.Person[pid]["��ѧ��ʶ"] = math.random(0, 50)
	JY.Person[pid]["ҽ������"] = 0
	JY.Person[pid]["�ⶾ����"] = 0
	JY.Person[pid]["�ö�����"] = 0
	JY.Person[pid]["��������"] = math.random(0, 240)
	JY.Person[pid]["ȭ�ƹ���"] = math.random(0, 150)
	JY.Person[pid]["��������"] = math.random(0, 150) 
	JY.Person[pid]["ˣ������"] = math.random(0, 150)
	JY.Person[pid]["�������"] = math.random(0, 150)
	JY.Person[pid]["��������"] = math.random(0, 150)
	for i = 1, 5 do
		JY.Person[pid]["���ж���֡��" .. i] = JY.Person[r]["���ж���֡��" .. i]
		JY.Person[pid]["���ж����ӳ�" .. i] = JY.Person[r]["���ж����ӳ�" .. i]
		JY.Person[pid]["�书��Ч�ӳ�" .. i] = JY.Person[r]["�书��Ч�ӳ�" .. i]
	end		
	JY.Person[pid]["����"] = math.random(1, 100)
	JY.Person[pid]["���һ���"] = 0
	if JY.Person[pid]["����"] <= 70 and math.random(5) == 1 then
		JY.Person[pid]["���һ���"] = 1
	end
	JY.Person[pid]["����"] = 0
	JoinMP(pid, 0, 0)
	local nglist = {6,89,90,92,93,94,95,96,97,98,99,121,124,150,151,152,153,178}
	local nglist2 = {100,101,102,103,104,105,106,107,108,180}
	if math.random(10) == 1 then
		JY.Person[pid]["����"] = nglist2[math.random(#nglist2)]
		JY.Person[pid]["�书2"] = JY.Person[pid]["����"]
		JY.Person[pid]["�书�ȼ�2"] = 999	
	else
		JY.Person[pid]["����"] = nglist[math.random(#nglist)]
		JY.Person[pid]["�书2"] = JY.Person[pid]["����"]
		JY.Person[pid]["�书�ȼ�2"] = 999		
	end
	if math.random(5) == 1 then
		JoinMP(pid, math.random(#CC.MP), 1)
	end	
	local thing = randomwugong2(5, 15, 1)
	JY.Person[pid]["�书1"] = JY.Thing[thing]["�����书"]	
	JY.Person[pid]["�书�ȼ�1"] = 999
	JY.Person[pid]["ʵս"] = math.random(300)
	local m = limitX(2 + math.modf(JY.Person[pid]["ʵս"] / 250), 2, 4)
	--local m = m + math.modf(JY.Person[pid]["ʵս"] / 250)
	if MPPD(pid) ~= 0 then
		m = 1
	end		
	for i = 1, m do
		JY.Person[pid]["HZ"..i] = 0
		if math.random(3) == 1 then
			JY.Person[pid]["HZ"..i] = CC.HZ[math.random(#CC.HZ)][1]
		end
	end
	JY.Person[pid]["�������ֵ"] = math.random(1000, 1500)
	JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"]
	JY.Person[pid]["�������ֵ"] = math.random(2000, 5000)
	JY.Person[pid]["����"] = JY.Person[pid]["�������ֵ"]	
end

function addfame(n)
	RW.fame = limitX(RW.fame + n, -999, 999)
	local str = "��������"..n.."�㣡"
	if n < 0 then str = "��������"..-n.."�㣡" end
	return str
end

function rewardRW(n)
	local list = {0, 1, 3, 4, 5, 9, 10, 12} --�ͼ�ҩ
	local list2 = {2, 6, 7, 8, 11, 13} --�߼�ҩ
	local list3 = {14, 15, 16, 17, 26, 27} --��ҩ
	local list4 = {18, 19, 20, 21} --��
	local list5 = {22, 23, 24, 25} --��
	local list6 = {28, 29, 30, 31, 32, 33, 34, 35} --����
	if n == 1 then
		addthing(174, math.random(36, 45) * 100)
	elseif n == 2 then
		addthing(174, math.random(5) * 100)
		addthing(list[math.random(#list)], math.random(2,3))
		addthing(list[math.random(#list)], math.random(2,3))
	elseif n == 3 then
		addthing(174, math.random(5) * 100)
		addthing(list2[math.random(#list2)], math.random(2,3))
		addthing(list2[math.random(#list2)], math.random(2,3))		
	elseif n == 4 then
		for i = 1, CC.TeamNum do
			if JY.Base["����"..i] >= 0 then
				AddPersonAttrib(JY.Base["����"..i], "ʵս", 15)
			end
		end	
		tb("ȫ�����ʵս����15��")
		addthing(174, math.random(5) * 100)	
	elseif n == 5 then
		for i = 1, CC.TeamNum do
			if JY.Base["����"..i] >= 0 then
				local tmp = {"������", "�Ṧ", "������"}
				local r = math.random(#tmp)
				local r2 = math.random(5)
				JY.Person[JY.Base["����"..i]][tmp[r]] = JY.Person[JY.Base["����"..i]][tmp[r]] + r2
				tb(JY.Person[JY.Base["����"..i]]["����"].."��"..tmp[r].."����"..r.."�㣡")
			end
		end		
	elseif n == 6 then
		for i = 1, CC.TeamNum do
			if JY.Base["����"..i] >= 0 then
				local tmp = {"ȭ�ƹ���", "��������", "ˣ������", "�������"}
				local r2 = math.random(3)
				JY.Person[JY.Base["����"..i]][tmp[r]] = JY.Person[JY.Base["����"..i]][tmp[r]] + r2
				tb(JY.Person[JY.Base["����"..i]]["����"].."��"..tmp[r].."����"..r.."�㣡")
			end
		end		
	elseif n == 7 then
		addthing(174, math.random(5) * 100)
		local list = {}
		local x1 = CC.MainSubMenuX
		local y1 = CC.MainSubMenuY		
		for i = 1, #CC.HZ do
			list[i] = i
		end
		local menu = {}
		for i = 1, #list do
			menu[i] = {string.format("%-12s",CC.HZ[list[i]][2]), nil, 1}
			if hasHZ(i) then
				menu[i][3] = 0
			end
		end
		local r = ShowMenu(menu,#menu,15,x1,y1+CC.SingleLineHeight,0,0,1,1,CC.DefaultFont,C_ORANGE,C_WHITE);
		if r <= 0 then do return end end
		addHZ(r)		
		do return end
	end
	tb(jiadian(n * 20))
end

function RWstatus()

	local size = CC.DefaultFont
	local width = 13 * size 
	local h = size + CC.PersonStateRowPixel
	local height = 6 * h 
	local dx = (CC.ScreenW - width) / 2
	local dy = (CC.ScreenH - height) / 2
	local i = 1  
	Cls()
	--lib.LoadPicture(CC.STA, -1, -1)
	DrawBox(dx, dy, CC.ScreenW - dx, CC.ScreenH - dy, C_WHITE)
	DrawString(math.modf((CC.ScreenW - dx)/2) + size, dy, "����״̬", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "������", C_RED, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 4 * size, dy + h * i, ""..RW.fame, C_GOLD, size)
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "����", C_ORANGE, size)
	local a = "��"
	local b = "��"
	local c = "��"
	local d = "��"
	
	if RW.event == -1 then
		
	else
		if RW.event >= 101 and RW.event <= 111 then		
			for i = 1, #RW.s do
				if RW.s[i][1] == RW.event then
					a = RW.s[i][2]
					b = RW.s[i][3]
					d = RW.s[i][5]
					if RW.s[i][4] ~= nil then
						c = RW.s[i][4]
					else
						c = JY.Scene[RW.scene]["����"]
					end
				end
			end
		else
			if RW.event == 1 then
				a = "Ѱ����Ʒ"
				b = JY.Thing[RW.target]["����"]
			elseif RW.event == 2 then
				a = "����"
				b = JY.Scene[RW.targetscene]["����"]
			elseif RW.event == 3 then
				a = "�ͻ�"
				b = JY.Scene[RW.targetscene]["����"]
			elseif RW.event == 4 then
				a = "����Ұ��"
				d = JY.Scene[RW.scene]["����"].."����"
			elseif RW.event == 5 then
				a = "����ɽ��"
				d = JY.Scene[RW.scene]["����"].."����"
			elseif RW.event == 6 then
				a = "����Ѳ��"
				b = RW.mp[RW.target][1]
				d = JY.Scene[RW.scene]["����"].."����"	
			end		
			c = JY.Scene[RW.scene]["����"]
		end	
	end
		

	DrawString(math.modf((CC.ScreenW - dx)/2) + 4 * size, dy + h * i, ""..a, M_Wheat, size)
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "Ŀ�꣺", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 4 * size, dy + h * i, ""..b, C_GOLD, size)
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "�����أ�", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 4 * size, dy + h * i, ""..c, M_Wheat, size)
	i = i + 1
	DrawString(math.modf((CC.ScreenW - dx)/2) - size, dy + h * i, "Ŀ�ĵأ�", C_ORANGE, size)
	DrawString(math.modf((CC.ScreenW - dx)/2) + 4 * size, dy + h * i, ""..d, M_Wheat, size)	
	ShowScreen()
	lib.Delay(500)
	WaitKey()
end

OEVENTLUA[30011] = function() --���ͼ����
	local yes = 0
	if math.random(10) == 5 then
		yes = 1
	end
	if yes == 0 then
		do return end
	end
	if yes == 1 then
		if GetS(106, 63, 3, 0) == 1 then
			Cls()	
			say("��·���ҿ������������ԣ�Ҫ��Ӵ˹���������·�ƣ�", math.random(100, 200), 0, "ɽ��")		
			if WarMain(287) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end			
			light()
			do return end
		elseif RW.event == 5 and RW.current == 0 then	
			say("˭�Ҵ�ɽ��", math.random(100, 200), 0, "ɽ����")		
			say("��ɽ�������ٷ�������Ͷ����")				
			say("�������������˸������ġ�", math.random(100, 200), 0, "ɽ����")	
			say("�ֵ����ϣ�", math.random(100, 200), 0, "ɽ����")				
			if WarMain(286) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end		
			RW.current = 1
			displayRW(2, RW.scene, RW.location)		
			light()
			say("���ڽ�����ˡ���ȥ����ɡ�")	
			do return end	
		elseif GetS(106, 63, 3, 0) == 3 and GetS(106, 63, 4, 0) ~= 1 then
			Cls()	
			say("�����ˣ�Ӧ�þ����Ǹ��ˡ���Ȼ�е�Բ�����....����û�취��....")				
			if WarMain(290) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end		
			SetS(106, 63, 4, 0, 1)	
			light()
			say("�����������ˣ���ȥ����ɡ�")	
			do return end				
		elseif RW.event == 4 and RW.current == 0 then
			say("�������ˣ���Ȼ�ܶ�Ұ�޺��У�")							
			if WarMain(286) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end		
			RW.current = 1
			displayRW(2, RW.scene, RW.location)		
			light()
			say("���ڽ�����ˡ���ȥ����ɡ�")	
			do return end			
		elseif RW.event == 6 and RW.current == 0 then
			say("ǰ����Щ���м�����ѵ����ǵж����ɵļ����")		
			say("�����������ˣ�������", math.random(100, 200), 0, "���")	
			say("���ܣ�")					
			if WarMain(286) == false then
				instruct_15(0);   
				instruct_0();  
				do return; end			
			end		
			RW.current = 1
			displayRW(2, RW.scene, RW.location)		
			light()
			say("���ڽ�����ˡ���ȥ����ɡ�")	
			do return end			
		end				
	end		
end

function petAttrib(str, n)
	local pid = 606
	local n2, s = AddPersonAttrib(pid, str, n)
	if n2 ~= 0 then
		tb(JY.Person[pid]["����"].."��"..s)
	end
end

function feedPet()
	local thing = {}
	local thingnum = {}
	for i = 0, CC.MyThingNum - 1 do
		thing[i] = -1
		thingnum[i] = 0
	end
	local num = 0
	for i = 0, CC.MyThingNum - 1 do
		local id = JY.Base["��Ʒ" .. i + 1]
		if id >= 0 then
			if JY.Thing[id]["����"] == 1 or JY.Thing[id]["����"] == 3 or JY.Thing[id]["����"] == 4 then
				thing[num] = id
				thingnum[num] = JY.Base["��Ʒ����" .. i + 1]
				num = num + 1
			end
		end 
	end
	local r = SelectThing(thing, thingnum)
	if r >= 0 then
		local pid = 606
		local jl = 15
		local pet = JY.Base["����"]
		local love = math.random(2)
		local others = math.modf(JY.Person[pid]["����"] / 10)
		local list = {
			{1, 14, 15, 16, 17, 18, 19, 20, 21}, --��ҩ+ʳ��
			{2, 10, 11, 12, 13}, --�����ⶾҩ
			{3, 18, 19, 20, 21}, --ʳ��
			{4, 2, 6, 7, 8, 18, 19, 20, 21}, --�߼�ҩ+ʳ��
			{5, 20, 21, 24, 25}, --����
			{6, 22, 23, 24, 25}, --��			
		}
		local bonus = false
		for i = 2, #list[pet] do
			if r == list[pet][i] then
				bonus = true
				jl = jl + limitX(JY.Person[pid]["����"], 40, 70)
				others = others + 5
				love = love + 2
				break
			end
		end		
		--����ҩ��󸰮�ⶾ������ʳ�����ҩ���밮������Գ���ƣ�
		
		if JLSD(10, 10 + jl, pid) then
			petAttrib("������", math.random(others))
			petAttrib("������", math.random(others))
			petAttrib("�Ṧ", math.random(others))
			petAttrib("�������ֵ", math.random(others) * 10)
			petAttrib("�������ֵ", math.random(others) * 20)
		else
			tb(JY.Person[pid]["����"].."�����Ǻ����������")
		end
		petAttrib("�Ѻö�", love)
		instruct_32(r, -1)
	end
end

function readPet()
	local thing = {}
	local thingnum = {}
	for i = 0, CC.MyThingNum - 1 do
		thing[i] = -1
		thingnum[i] = 0
	end
	local num = 0
	for i = 0, CC.MyThingNum - 1 do
		local id = JY.Base["��Ʒ" .. i + 1]
		if id >= 0 then
			if JY.Thing[id]["����"] == 2 then
				thing[num] = id
				thingnum[num] = JY.Base["��Ʒ����" .. i + 1]
				num = num + 1
			end
		end 
	end
	local r = SelectThing(thing, thingnum)
	if r >= 0 then
		local pid = 606
		local jl = JY.Person[pid]["����"]
		local pet = JY.Base["����"]
		local love = math.random(2)
		local others = math.modf(JY.Person[pid]["����"] / 10)
		local list = {"ȭ�ƹ���", "��������", "ˣ������", "�������"}
		
		if JLSD(10, 15 + jl, pid) then
			for i = 1, #list do
				if JY.Thing[r]["��"..list[i]] > 0 then
					petAttrib(list[i], JY.Thing[r]["��"..list[i]])
				end
			end
			petAttrib("�������ֵ", math.random(others) * 10)
			petAttrib("�������ֵ", math.random(others) * 20)			
			JY.Person[pid]["�书�ȼ�1"] = JY.Person[pid]["�书�ȼ�1"] + others + math.random(50)
			JY.Person[pid]["�书�ȼ�2"] = JY.Person[pid]["�书�ȼ�2"] + others + math.random(50)
			if JY.Person[pid]["�书�ȼ�1"] > 999 then JY.Person[pid]["�书�ȼ�1"] = 999 end
			if JY.Person[pid]["�书�ȼ�2"] > 999 then JY.Person[pid]["�书�ȼ�2"] = 999 end
			tb(JY.Person[pid]["����"].."����ѧ�ȼ���΢�����ˣ�")
		else
			tb(JY.Person[pid]["����"].."һ���Ժ�������")
		end	
		petAttrib("�Ѻö�", love)
	end
end

function playPet(tmp)
	local pid = 606
	local love = math.random(2)	
	local jl = 10 + math.modf(JY.Person[pid]["�Ѻö�"] / 5)
	local name = JY.Person[pid]["����"]
	if JLSD(10, jl, zj()) then
		say("��ͻȻͣ����һ����ֻ��������ͣ����", 606)	
		say("���ؿ�������Щ�Ź�....")	
		if yesno("Ҫ���ڿ���") == false then
		
		else			
			if math.random(10) <= 5 then	
				JY.Status = tmp
				say("��Σ�գ�С�ģ�")	
				if WarMain(295) then
					say("ԭ��������Ұ�޵ĳ�Ѩ�����´β�Ҫ���������ˡ�")
					say("��~~��һ�������ͷ�����ӣ�", 606)		
				else
					say("��~~���������ˣ�����������ӣ�", 606)	
					say("�´�ҪС��һ�㰡��")
				end						
				return 1
			else
				--JY.Status = tmp
				local win = false
				win = mining()
				--JY.Status = GAME_PET
			end
		end
	end
	petAttrib("�Ѻö�", love)
	return 0
end


function petMenu()
	if JY.Base["����"] <= 0 then
		tb("����û�г���")
		do return end
	end

	local menu = {
		{"ι��", "ʳΪ�죡������Χ�����ܶ�"},
		{"����", "���ܿ���ô��������ϵ�����ܶ�"},
		{"��ˣ", "Ԣ�����֡��������ܶȣ����У�����"},
		{"����", "�����������𣬰�����������������"},
		{"��Ϣ", "�������ף����ö��ߡ�"},
		{"״̬", "��������͸��"},
		{"����", "�������Ƿ�������"},
	}
	local size = CC.DefaultFont
	local start = 1
	local stop = 7
	local stop2 = 7
	if #menu < stop2 then stop2 = #menu end
	local current = 1	
	local size1 = size - 5
	local h = size + CC.PersonStateRowPixel
	local height = h * stop2 + 10
	local width = 2 * size + 10
	local x0 = 20
	local y0 = 5
	local i = 0
	local p
	local pid = 606
	local tmp = JY.Status --��¼����״̬
	while true do
		local name = JY.Person[pid]["����"]
		local hp = JY.Person[pid]["����"]
		local mhp = JY.Person[pid]["�������ֵ"]
		local mp = JY.Person[pid]["����"]
		local mmp = JY.Person[pid]["�������ֵ"]	
		local atk = JY.Person[pid]["������"]	
		local def = JY.Person[pid]["������"]	
		local spd = JY.Person[pid]["�Ṧ"]	
		local love = JY.Person[pid]["�Ѻö�"]		
		JY.Status = GAME_PET
		i = 0
		Cls()
		--lib.LoadPicture(CONFIG.PicturePath .. "p1.png", -1, -1)
		DrawBox(x0, y0, x0 + width, y0 + height, C_WHITE)
		
		for j = start, stop do
			if menu[j] ~= nil and menu[j][1] ~= nil then
				if current == j then
					DrawString(x0 + 5, y0 + h * (i) + 5, menu[j][1], C_WHITE, size)
				else
					
					DrawString(x0 + 5, y0 + h * (i) + 5, menu[j][1], C_GOLD, size)
				end
				i = i + 1
			end
		end
		
		DrawBox(x0 + x0 + width, y0, CC.ScreenW - 10,  #menu[current] * h + y0 + 10, C_WHITE)
		for j = 1, #menu[current] do
			if menu[current][j] ~= nil then
				if j == 1 then
					DrawString(x0 + 25 + width, y0 + h * (j - 1) + 5, menu[current][j], C_RED, size)
				else
					DrawString(x0 + 25 + width, y0 + h * (j - 1) + 5, menu[current][j], M_Wheat, size)
				end
			end
		end
		
		DrawBox(x0, y0 + h * 10, math.modf(CC.ScreenW / 2),  CC.ScreenH - 10, C_WHITE)
		i = 10
		DrawString(x0 + 5, y0 + h * i + 5, "����    "..name, C_ORANGE, size)
		i = i + 1
		DrawString(x0 + 5, y0 + h * i + 5, "����    "..hp.."��"..mhp, C_GOLD, size)
		i = i + 1
		DrawString(x0 + 5, y0 + h * i + 5, "����    "..mp.."��"..mmp, C_GOLD, size)
		i = i + 1
		DrawString(x0 + 5, y0 + h * i + 5, "������  "..atk, C_GOLD, size)
		i = i + 1
		DrawString(x0 + 5, y0 + h * i + 5, "������  "..def, C_GOLD, size)
		i = i + 1
		DrawString(x0 + 5, y0 + h * i + 5, "�Ṧ    "..spd, C_GOLD, size)
		i = i + 1
		local ll
		if love < 80 then
			ll = "�����ս"
		else
			ll = "���Բ�ս"
		end
		DrawString(x0 + 5, y0 + h * i + 5, "���ܶ�  "..love.."  "..ll, C_RED, size)
		ShowScreen()
		p = WaitKey()
		if p == VK_ESCAPE then
			JY.Status = tmp
			break
		elseif p == VK_DOWN then
			current = current + 1
			if current > #menu then
				current = 1
			end
		elseif p == VK_UP then
			current = current - 1
			if current == 0 then
				current = #menu
			end
		elseif p == VK_RETURN or VK_SPACE then
			if current >= 1 and current <= 4 then
				if YC.PET[current] > 0 then
					YC.PET[current] = YC.PET[current] - 1
					if current == 1 then
						feedPet()
					elseif current == 2 then
						if love < 20 then
							say("��̧ͷ������һ�ۣ�û���㣬��˯��ȥ�ˡ���", 606)	
						else
							readPet()
						end
					elseif current == 3 then
						if love < 50 then
							say("��̧ͷ������һ�ۣ�û���㣬��˯��ȥ�ˡ���", 606)	
						else
							say("��Χ����������ͣ������ȸԾ�����ӡ���", 606)	
							if playPet(tmp) == 1 then
								break
							end
						end
					elseif current == 4 then
						--JY.Status = tmp
						say("�ϰɣ������ǿ���ѵ���ɹ������ӣ�")
						say("��ȫ��䱸���ƺ��ص���Ұ�Ե�״̬����", 606)		
						if WarMain(295) then
							say("���úã���ͷ�������óԵģ�")
							say("���۾�һ�����յ����ǰ������ͣ��һ���ֺõ����ӡ���", 606)	
							petAttrib("�Ѻö�", 5)
						else
							say("��~~���������ˣ�����������ӣ�", 606)	
							say("��������Ӧ���ٺú�ѵ��һ������")
							petAttrib("�Ѻö�", -10)
						end
						--JY.Status = GAME_PET
						--break
					end				
				else
					tb(name.."�����᲻����Ȥ������")
				end
			end
			if current == 5 then
				dark()
				JY.Person[pid]["���˳̶�"] = 0
				JY.Person[pid]["�ж��̶�"] = 0
				AddPersonAttrib(pid, "����", math.huge)
				AddPersonAttrib(pid, "����", math.huge)
				AddPersonAttrib(pid, "����", math.huge)
				light()				
			elseif current == 6 then
				Cls()
				ShowPersonStatus_sub(pid, 1)
				ShowScreen()
				local q = WaitKey()
				while q ~= VK_ESCAPE and q ~= VK_SPACE and q ~= VK_RETURN do
					q = WaitKey()
				end
			elseif current == 7 then
				if yesno("ȷ��Ҫ��������") then
					say("��ʱ������ص��������ĵط��ˣ��ౣ�ذ���")	
					say("��~~����ͷ����һ�ۣ�����������뿪�ˡ���", 606)		
					JY.Base["����"] = 0
					JY.Status = tmp
					break
				end
			end
		end
	end	
	
end

function joinPet()
	if JY.Base["����"] <= 0 or JY.Person[606]["�Ѻö�"] < 80 then
		return
	end
	local x0, y0
	local p = false
	local p2 = false
	for k = 0, WAR.PersonNum - 1 do
		if WAR.Person[k]["������"] == zj() then
			x0 = WAR.Person[k]["����X"]
			y0 = WAR.Person[k]["����Y"]
			p = true
			break
		end
	end

	if WAR.Data["�Զ�ѡ���ս��1"] ~= 0 then
		p2 = true
	elseif WAR.Data["�Զ�ѡ���ս��1"] == 0 and WAR.Data["�Զ�ѡ���ս��2"] ~= -1 then
		p2 = true
	end
	if p and p2 and yesno("Ҫ�ó����ս��") then
		local x, y = WE_xy(x0, y0)	
		NewWARPersonZJ(606, true, x, y, false, 2)
		petAttrib("�Ѻö�", -10)
		--AddPersonAttrib(zj(), "����", -20)	
		--tb(JY.Person[zj()]["����"].."��������20��")
	end
end

function hasPet()
	if JY.Base["����"] <= 0 then
		return false
	else
		return true
	end
end

function setPet(n, flag)
	if n == 0 then
		JY.Base["����"] = 0
		return
	end
	local start = 607
	local pid = 606
	for i = 1, #PSX - 8 do
		JY.Person[pid][PSX[i]] = JY.Person[start + n][PSX[i]]
	end
	--local t = math.modf(JY.Person[pid]["����"] * 0.5)
	--JY.Person[pid]["�������ֵ"] = 200
	--JY.Person[pid]["����"] = 200
	--JY.Person[pid]["�������ֵ"] = 500
	--JY.Person[pid]["����"] = 500
	--JY.Person[pid]["������"] = t + math.random(t)
	--JY.Person[pid]["������"] = t + math.random(t)
	--JY.Person[pid]["�Ṧ"] = t + math.random(t)
	--JY.Person[pid]["�书�ȼ�1"] = 10
	--JY.Person[pid]["�书�ȼ�2"] = 10
	--JY.Person[pid]["ȭ�ƹ���"] = 10
	--JY.Person[pid]["��������"] = 10
	--JY.Person[pid]["ˣ������"] = 10
	--JY.Person[pid]["�������"] = 10
	JY.Base["����"] = n
	local str = "�շ�"..JY.Person[start + n]["����"].."Ϊ���"
	if flag == nil then
		tb(str)
		tb("���������һ������")
		JY.Person[pid]["����"] = "";
		while JY.Person[pid]["����"] == "" do
			JY.Person[pid]["����"] = Shurufa(32, CC.ScreenH - 6 * CC.Fontbig)
			if JY.Person[pid]["����"] == "" then
				tb("���������һ������")
			end
		end	
	else
		return str
	end	
end

nEvent = {}
nEvent[101] = function()
	TalkEx("һ�����ڣ�ֻ�����溮���ǣ����ܶ��ڱ����ң��������������Ա�֮���������졣",0,2)	
	say("������ô����䷨���ף�ǰ���Ǹ��ǣ�")
	TalkEx("ֻ��ǰ����һ������ɫ�Ĳ϶�������˱�����Զ����ĸ��ֶ���Ķ�Һ��",0,2)	
	if not hasppl(47) or not hasppl(48) then
		say("�������Ĳ϶��������ܵĺ������ѵ����������Ϸų����ģ�������ǰ��һ�¡�")
		TalkEx("��ֻ�ϻ����쳣������������ǰ����Ȼһ�ݣ����һ�������Ӷݶ�ȥ��",0,2)
		dark()
		addevent(RW.targetscene, RW.target, 0, -2, -2, 0)
		displayRW(3, RW.targetscene, RW.target)
		light()
		say("�����������ĳ��ӣ��������ˣ����¶������к������������˹��Ƴ����С�")
		dark()
		AddPersonAttrib(zj(), "�������ֵ", 500)
		light()
		say("��һ���˹��ֿ���������Ȼ���ҹ����������ǲ϶��������챦����ϧ����ϧ��")
		tb(JY.Person[zj()]["����"].."����������")
	else
		say("�����϶��������������Ƕ����еĴ����ˡ���ͷ��������׽ס��", 47)	
		say("�ǣ�", 48)	
		local pid = 583
		randomstats(pid, 496)
		JY.Person[pid]["����"] = "�۾�"
		say("ס�֣������ӵĲ϶���", 583)	
		if WarMain(296) == false then
			instruct_15()
			return
		end
		addevent(RW.targetscene, RW.target, 0, -2, -2, 0)
		displayRW(3, RW.targetscene, RW.target)
		say("��ͺ���ӵ���졣�������ˣ�׽�����϶�Ҫ����", 47)	
		say("���Ϲ���....��϶�....�ղŴ򶷵�ʱ��û�ҧ����һ�ڣ�Ȼ���һ��������....", 48)	
		say("ʲô�����㣡������µļһ���Ҳ������㣡", 47)	
		say("�������һ�¡������϶���Ȼ���������Ǻ������ڣ��ҿ�����Ҳ������Щҩ�����������Ϊ����ͷ��Ҳ������֮���������㲻Ҫ�����������")	
		say("�ߣ��Ҳ����ˣ�������Ҫ��������������ҩ��", 47)	
		say("�ã������Ժ�")	
		dark()
		light()
		instruct_2(257, 1)
		say("�⻹��࣬��ξͷŹ���ɡ�", 47)	
		say("���ǣ�лл���Ϲ��лл������", 48)	
		say("���ոձ�ҧ��һ�ڣ���϶��ĺ���һֱ���������޷����⡣�����ô��ź�......��", 48)
		if hasppl(2) and PersonKF(2,87) and PersonKF(2,21) and JX(2) then --
			say("������ǧ�����û���ˣ���ͷ����ôһҧ������취����...��", 2)
			tb("�����ؿ�����̹֮ɪɪ������ȴ��ǿ���������µ���Ӱ��ƴ��˼������")
			say("���ȵȣ�������Ի����󷨵ķ�����������������ڤ����ʹ�����ķ�ʽ...��", 2)
			say("�����Ŷ������²��˳٣�����", 2)
			say("��ͷ����ר������˵����", 2)
			tb("�����ؼ����ٵĽ�������ʹ�����ķ��š������������㾭�İ�������ͷ��ǿ�����˳����أ�ƴ�������㾭��������׽��������ʵ�����ĺ���������")
			dark()
			light()
			say("��...��...", 48)
			say("��ͷ���о���Σ�")
			say("��л�̹���İ�������...��������ͦ�����ˣ����񻹹����������ٵ�����", 48)
			tb("��̹֮����Ħ�����Ȱ��壡")
			setJX(48)
			say("��л����Ҳ�������ջ�������η�����ڤ�Ƶ����������и��������ˡ�", 2)
			say("��ϲ������")
			if JY.Person[0]["�Ա�"] == 0 then
				say("Ҫ�����д����ҳ��������⽭������Ҳ�벻������취��", 2)
				say("Ҫ�����Ҳ��ϸ�����Ҷ���ڤ�Ƶ���᣿", 2)
			else
				say("Ҫ�����н����ҳ��������⽭������Ҳ�벻������취��", 2)
				say("Ҫ�����Ҳ��ϸ�����Ҷ���ڤ�Ƶ���᣿", 2)
			end	
			if DrawStrBoxYesNo(-1, -1, "Ҫ������ô��", C_WHITE, 30) == true then
				say("���Ҿ͹�����������ˣ�����")
				QZXS("������ڤ���ƺ������壡")
				setLW1(21)
				say("��л����")
				say("������һЦ��", 2)
			else
				say("��л���ú����ˣ��������ҵ��书·�Ӳ���ѽ...")
				say("��...������ͻ��...", 2)
				say("û��û�£����õ��������Ѿ�֣�ص������ˣ�")
				say("������һЦ��", 2)
			end
		else	
			tb("�����ޱȵ���̹֮�ּ��ֻţ�����ʶ�����������㾭������ȥ��׽�ǹɺ�������")
			say("���ף��⺮����ôͻȻ��С����Ƶģ���ôѱ������", 48)
			say("��...���ˣ��벻ͨ�Ͳ����ˣ���֮û�¾ͺá���" , 48)
			say("����ɲ��ܱ����Ϲ���֪������Ȼ�һᱻ������....��", 48)
			tb("��̹֮����Ħ�����Ȱ��壡")
			setJX(48)
		end	
	end
	tb("���������")	
end

nEvent[102] = function()
	say("�ô��һ���ߣ�һ���������ˡ�����Ҫ��������׽������....")
	if hasppl(61) then
		local t = 1
		say("���߲������£���ֻ�������Ƿ�Ҫ����ѱ�������ֻ����Ҫȡ���Ļ���ֱ�����ۻ�޹֮�������������Ҫѱ���Ļ�����Ҫ��ѵ���˼��", 61)
		if hasthing(18) and not hasPet() then
			if yesno("Ҫ���в�����") then
				t = 2
			end
		end
		if t == 1 then
			say("����Ҫ����ֱ��ȡ���ɡ�")
			if WarMain(298) == false then 
				instruct_15()
				return
			end
			addevent(46, 110, 0, nil, nil, 0)
			instruct_2(259, 1)
			say("�ߵ������ˣ���ȥ�ɡ�")

		else
			say("���߿���ȥ���������������˾޴�ʵ�����ף����ǻ��ǰ���ѱ������������ɡ�")
			say("����̰�ԣ�ֻ��Ҫ��ʳ����֮���ɡ�", 61)
			say("�ã���ǡ�ô���ֻ�л����������������ԡ�")
			instruct_2(18, -1)
			TalkEx("�����������磬�Ǿ�����֮��ϲ���������˽�����", 0, 2)
			say("�������ڣ�", 61)
			if WarMain(298) == false then 
				instruct_15()
				return
			end
			addevent(46, 110, 0, nil, nil, 0)
			say("���˺ô󾢣����ڰ���ѱ���ˡ�ֻ���ǽⶾҩ����ô�죿")	
			say("����Ҳ�ɽⶾ��ֻ����Ҫ��������ȡ�侫������Ȼ�ֵܲ���ɱ֮ȡ�����ٲ���Ҫ����һ���ˡ�", 61)		
			say("Ҳ�գ����˰ﵽ�ף�����������һ������Ҳ��һ׮�컯��")	
			dark()
			light()
			AddPersonAttrib(zj(), "�������ֵ", -500)
			tb(JY.Person[zj()]["����"].."�������ֵ���٣�")
			say("���ˣ���ȥ���˰ɡ�")		
			setPet(3)
			tb(addfame(3))
			RW.type = 1
		end
	else
		TalkEx("˼��֮�䣬ֻ���Ǿ�����������Ѩ���", 0, 2)
		say("�ٲ���������Ҫ���ˣ�ֱ���ϰɣ�")	
		TalkEx("�Ǿ������˾��������˲�����������һ��˻����", 0, 2)
		say("���ã��Ǽһ��ں���ͬ�࣡")	
		if WarMain(297) == false then 
			instruct_15()
			return
		end
		addevent(46, 110, 0, nil, nil, 0)
		instruct_2(259, 1)
		say("���ڰ��ߵ�Ū�����ˣ���ȥ�ɡ�")	
			if MPPD(0) == 0 then 
	       say("��С�ӣ���һ����",60)
           say("�ҿ��˶�ʱ�ˣ�������������������һ����ū�ɡ�",60)
		    say("���������㣬����Ժ������ˡ�",60)
	      if DrawStrBoxYesNo(-1, -1, "Ҫ�������ɽׯô��", C_WHITE, 30) == true then 
	       say("��лׯ��������",0)
	       say("�������������ǰ���ɽ���ķ��伮����ȥ������",60)
	       instruct_2(73,1) 
	       say("��л��ү",0)
	        say("�������������ܶ���θ��",60)
	       JoinMP(0, 8, 1)
		   else
		   	        say("�ߣ���ʶ̧�ٵĶ���",60)
	     end
		 end		
	end
end

nEvent[103] = function()
	say("��������С�������������������Ʒ�ḻ�������зݣ��߹�·����Ҫ�������", 220, 0, "С��") 	
	say("����������ô���ȷ���")
	say("�˵�ʢ��ѩ�������ݣ�����������֮������ı��������Դ���ΪĿ�꣬������������ȴ�����������������ǲ�����", 220, 0, "С��") 	
	say("�͹ٿ�����Ҳ�Ǹ���ѧ�мң���û����Ȥ���������֣�������ֻ��������ʮ����", 220, 0, "С��") 
	local t = false
	if JY.Person[zj()]["�Ṧ"] >= 350 and hasppl(55) and JY.GOLD >= 500 and yesno("Ҫ�μ���") then
		t = true
	end
	if not t then
		say("���¹��򲻼ã���θ��׳󣬻������Թ�ս���ˡ�")
		dark()
		light()
		say("���������������䣬����һ����Ȼ���²��顣������Ų���������ޱȣ��ƺ�������ѧ��Ӧ���칫����֮����Ȼ���")
		AddPersonAttrib(zj(), "�Ṧ", 10)
		tb(JY.Person[zj()]["����"].."�Ṧ������")
	else		
		say("�����ֵ�������ӣ�����ԾԾ�����ˣ�")
		say("��������Ĳ���˵������С�ڲ�ԭ���󣬼�������ƽ���Ժ�����֮һ����ô����������һ��ȥ���ԣ�", 55)
		say("�ã��Ҿ����ֵܱ���һ�ˡ�")
		instruct_2(174, -500)
		say("���֣��͹����Դ����������Ͽ�ʼ��", 220, 0, "С��") 			
		dark()
		light()
		say("������ʽ��ʼ��һ������λѡ�֣�˭�Ȱ���ѩ���������ʤ��", 220, 0, "С��") 	
		local tt = false
		local pid = 583
		local pid2 = 584
		randomstats(pid, nil, "����")
		randomstats(pid2, nil, "����")
		
		instruct_21(55)
		if WarMain(299) == false then --xxx
			tt = false
		else
			tt = true
		end
		instruct_10(55)
		if not tt then
			say("��ѽ����ε�ѩ��ͬ��������Ȼ�������ˡ�������������ϧ���˻�ʤ��", 220, 0, "С��") 	
			say("��ѩ��Ȼ������������ڼ���һ�����а�������ο����Ǵ��۽硣", 55)
			say("������������ȥ�����ǻ�ȥ��Ŭ������һ�����´�һ���ܰ������������ߣ����ǺȾ�ȥ��")
		else
			if RW.type == 1 then --xxx
				say("�������ֵܺñ��£�", 55)
				say("��Ҳ�Ƕ���˹��ֵ�ƽ����ָ�̡�")
				say("��ϲ��λ��ү���������Ľ�Ʒ��", 220, 0, "С��") 		
				rewardRW(5)
				tb(addfame(5))
				addHZ(26)
				if not hasPet() then
					say("���������ƣ�ֻ�輸����ܸ�ԭ���ֵ����ܰ����շ����Ժ�����ô���", 55)
					setPet(1)
				end
			elseif RW.type == 2 then
				say("���ֵܹ�Ȼ�ñ��£���Ȼ���Լ���Ͱ��ǵ������������")
				say("����������Ҳ�ǲ�������Ȼ�������ˣ���غ������������ݡ���ϧ���������������͸��ض�����һ�����ġ�", 55)	
				say("��ϲ��λ��ү���������Ľ�Ʒ��", 220, 0, "С��") 		
				rewardRW(2)
				tb(addfame(2))
			JY.Person[55]["�书4"] = 148
	        JY.Person[55]["�书�ȼ�4"] = 999
			setJX(55,1)
			say("����֮������Ҳ�����µ������Ҳ������������Ӣ�ۡ�", 55)
			say("�����ý������������һ����Ĺ����Լ��Ҵ���ȭ����������", 55)				
			QZXS("�����ƺž���,��ʹ�ð��������ս�⼼�������ɼ���")
			say("�������Ҳ������������Ӣ�ۡ�", 55)	
			say("��������ʶ�˹�����˼�����Ҳ�ǲ�����а����ߣ��Ⱦ�ȥ��")
			say("�ã��ֵ��룡", 55)	
			else
				say("���ղ�֪���������죬������Ҫ�ӽ����в��ǰ���", 55)
				say("������������Ȼ��ʤ������ʶ����˼�����Ҳ�ǲ�����а����ߣ��Ⱦ�ȥ��")
				say("�ã��ֵ��룡", 55)				
			end
		end		
	end
	tb("���������")
end

nEvent[104] = function()	
	local t = false
	say("�������ӣ�����ؤ���������޳�Թ��Ϊ��Ϊ���ҵȶ��ˣ�", 207, 0, "ؤ�����") 	
	say("��λ���˳������ƣ��ǲ��õ��ģ�ֻҪ����ȥ����ͻ���ƶ���Ի����λҽ�Ρ�", 161)
	say("ʲô�飿", 207, 0, "ؤ�����") 	
	say("�Ȿ���飬˵����Ҳ��ֵ������Ǯ�����������Ȼ������ԭҲ�㲻��ʲô��ƶ��ֻ����ȡһǧ���л����������ֱ��ˡ�", 161)
	say("����Ī����ֺ�������Ӧ��ȥ���Ƕ���һ��֮���𣿣�")
	if yesno("Ҫ������") then
		t = true
	end
	local pid = 161
	if not t then
		say("��ؤ���˶����ڣ��⸽�����������ֶ棬�һ��Ǿ������ĺá���")
		dark()
		addevent(-2, 111, 0, -2, -2, 3530 * 2)
		light()
		say("����Ү���룬ȫ�������¡��ɹ����ֹ��ںݶ������µ�Ҫ�ֽ̼��С�", 619)
		say("�ٺ٣�ԭ����ȫ����ǰ�����ʿ��ͽ����У�", 161)
		TalkEx("��������Ȼ������������ս�������٣��������������ޣ���ʮ���к�������·�", 0, 2)
		say("����һ������Ӣ������Ӧ�ýύһ�£�Ү����Ī�ţ��������㣡")
		say("�ߣ�������£�������", 161)
		if WarMain(300) == false then
			instruct_15()
			return
		end
		addevent(RW.targetscene, 110, 0, nil, nil, 0)
		say("�ÿ���Ṧ�����������������ˡ�")
		say("��л��λ����������", 207, 0, "ؤ�����") 
		say("��λ���ؿ������������нⶾҩ�����������¡�")
		dark()
		light()
		say("��л�����Ľ�ҩ��������Ҫ���̸��������ֶ������¸�֪�������ԣ���͸���ˡ���Щ������Ц�ɡ�", 207, 0, "ؤ�����") 
		addthing(18, 2)
		dark()
		light()
		say("��λ��̨���մ�����", 619)
		say("����"..JY.Person[zj()]["����"].."����̨�ղ������С��������粻������С����������̨�Ⱦ���Ρ�")
		say("�ã������¾�ȴ֮�����ˡ�", 619)
		TalkEx("���˸ղž����ո�һ��������ս������������ϧ��һ�����ĺ�˴���Ϊ֪����", 0, 2)
		if MPPD(0) == 0 then
	          say("������̨����Ҳ��ȫ���һ�ŵĵ��ӣ���̨����һ����ʡ�",619) 
	          say("��������̨�໥����һ����ѧ���໥ӡ֤һ�¡�",619) 
			  say("������ã������漰����̨���µ���ѧ��Ҫ����������ʦ֮�ӡ�",0) 
			  say("���кη�����ʦ��������Ϸ�˼䣬Ҳ�������ڴˡ�",619) 
			  say("������̨��˷�Ȥ������ʦ��Ҳ��ϲ���ģ��ҿ���̨Ҳû����ʲô���ɣ�Ҫ����������ȫ��̡�",619) 
			  say("�����Ϊͬ�ţ�Ҳ�Ͳ������˰ɡ�",619) 
	    if DrawStrBoxYesNo(-1, -1, "Ҫ����ȫ���ô��", C_WHITE, 30) == true then 
	       say("Ү���ּ�Ȼ���ʢ�飬��С����Ҳ��ȴ֮������",0) 
           say("������ʹ�죬������ǾͿ��Գ���������",619) 
		   JoinMP(0,16,3)
			QZXS(JY.Person[0]["����"].."��Ϊȫ��̵��ӣ�")		   
	     end
	    end
		if JY.Person[zj()]["Ʒ��"] >= 70 then
			say("Ү���ּ�Ȼ��δ�ҵ�ס��������С����ס��Σ�")	
			say("�ã��Ǿ��鷳�ֵ��ˡ�", 619)
			dark()
			addevent(RW.targetscene, 111, 0, nil, nil, 0)
			setteam(619, 1)
			addthing(353)
			light()
		else
			say("Ү���ּ�Ȼ��δ�ҵ�ס��������С����ס��Σ�")	
			say("��ϧ�������²��������пգ�һ���������ֵܺȼ�����", 619)
			say("�ã��Ǿͺ�����ڣ�")
			say("������ڣ�", 619)	
			dark()
			addevent(RW.targetscene, 111, 0, nil, nil, 0)
			light()			
		end
	else
		say("ס�֣�")
		say("��С�ӣ�������£�", 161)	
		if WarMain(301) == false then
			instruct_15()
			return
		end
		addevent(RW.targetscene, 110, 0, nil, nil, 0)				
		tb(addfame(3))
		say("�������нⶾҩ������λ�������¡�")		
		dark()
		light()
		say("��л��������������������Ҫ���̸��������ֶ������¸�֪�������ԣ���͸���ˡ���Щ������Ц�ɡ�", 207, 0, "ؤ�����") 
		addthing(18, 2)
		addthing(111, 1)
		dark()
		light()		
	end
	tb("���������")
end

nEvent[105] = function()	
	say("�ҵ�����", 589, 0, "����ǳ")
	displayRW(2, RW.targetscene, RW.target)
	local t = true
	for i = 0, 13 do --28, 35 �������ǣ�����ǳ������ĳ���ҩ
		if not hasthing(i) or thingnum(i) < 5 then
			t = false
			break
		end
	end
	if not t then
		do return end
	end
	for i = 0, 13 do --28, 35 �������ǣ�����ǳ������ĳ���ҩ
		instruct_32(i, -5)
	end	
	say("���ò���л��~~������Ľ�����", 589, 0, "����ǳ")
	setRW(RW.event - 100, 1)
	rewardRW(2)
	displayRW(3, RW.scene, RW.location)		
	resetRW()
	addthing(352)
	if string.sub(JY.Person[0]["����"], 0, 2) == "��" and MPPD(0) == 0 then 
		say("�ţ�ԭ����Ҳ���ƣ�������书Ҳ�㲻���������������������յ��ӣ�����û����Ȥ��", 589, 0, "����ǳ") 
		if yesno("Ҫ����������") == false then
			say("��Ҫ�����ˣ�����������ʧŶ��", 589, 0, "����ǳ")
		else
			say("�ã��ӽ�����������������ŵĴ��ӣ��������µ����ˡ�������Щ�����ķ������������аɡ�", 589, 0, "����ǳ")
			JoinMP(0, 9, 2)
			QZXS(JY.Person[0]["����"].."��Ϊ���ŵ��ӣ�")	
		end
	end
	if JY.Person[0]["�Ṧ"] >= 600 and sixi(0,5) >= 200 then
		say("��˵�����������ͦ����ģ���С�����ͺ��������װɣ�",589,0,"����ǳ")
		say("������������׷����Ӱ����һЩ�ĵã��͸����",589,0,"����ǳ")
		if DrawStrBoxYesNo(-1, -1, "Ҫ������", C_WHITE, 30) == true then
			QZXS("����׷����Ӱ����")
			instruct_0();
			setLW2(191)
			say("�������ѵõ������˵ĸо�ͦ�����",589,0,"����ǳ")
		else
			say("�ߣ�������Ҫ������",589,0,"����ǳ")
			say("�أ���",0)
			JY.Person[0]["����"] = 100
			JY.Person[0]["���˳̶�"] = 100
			JY.Person[0]["�ж��̶�"] = 100
		end
	end	
	if JY.GOLD >= 30000 then
		if instruct_9() then
			say("(��һ￴������ͷ���ԣ������������Ǯ��)",93)
			say("���뱾С������æ���Ƽ��շѿ��Ǻܹ��Ӵ��",93)
			instruct_2(174, -30000)
			instruct_10(93)
			tb(JY.Person[93]["����"].."�������")
			setteam(93, 0)			
			if MPPD(0) == 0 then
				say("�����ɣ�������ô�г��⣬��С����������������ࡣ", 93)
				if DrawStrBoxYesNo(-1, -1, "Ҫ���ƴ�С��ĸ���ô��", C_WHITE, 30) == true then JoinMP(0, 9, 1) end
			end
		end
	end
	dark()
	light()		
end

nEvent[106] = function()	
	say("�����ϣ��������ˣ������Ӱ���һ����С�����кλ���˵��")
	say("�ߣ�С��������", 637) 	
	if WarMain(316) == false then
		instruct_15()
		return
	end		
	light()
	bgtalk("ͻȻ���������������������ס�˷����ϣ������ϼ����ÿ죬ת�����ˡ�")
	dark()
	null(-2, 110)
	light()	
	say("......", 636) 	
	bgtalk("ֻ�����Ͻ�����Ӱһ����ٿ����ʧ���ټ�����ӰС������������Ů��ģ��")
	say("��Ů����˭....�ÿ��Ĺ���ֻ��Ϊ����Ҫ���Ƕ���....")
	say("Ҳ�գ���ξ���ʱ�Ź������ϣ��´�������һ��Ҫ���ÿ���")
	tb(addfame(3))
	tb("���������")
	JY.Person[637]["������"] = JY.Person[637]["������"] + 50
	JY.Person[637]["������"] = JY.Person[637]["������"] + 50
	JY.Person[637]["�Ṧ"] = JY.Person[637]["�Ṧ"] + 50
	addevent(107, 21, 1, 1322, 1, 5926)
end

nEvent[107] = function()	
	say("��λ�����Ϊ��һ���˴�����������ɽ������ﵽ������֩�룬��Σ�յġ�")
	say("....", 631) 
	say("��Ϊʲô����������ô��ɭɭ�ĸо�....������ѵ�������֩�뾫����")		
	dark()
	addevent(-2, 111, 0, 0, 0, 5304)
	light()
	say("�����ҵ����ˣ��������ǻ�ȥ�ɣ�", 301, nil, nil, 1)	
	say("�����̵��ˣ���ô˵�����������ˣ��ȵȣ���������һ��С�����ʲô�ú���")
	say("С�ӣ�����û��˵���ķݣ�����", 301, nil, nil, 1)	
	if WarMain(319) == false then
		instruct_15()
		return
	end		
	null(-2, 111)
	light()
	say("������û�°ɡ�")
	say("....�ҵ����....�ҵ����������....", 631) 	
	say("������ѵ�������ֻ֩�뵱����....")
	if hasthing(66) then
		say("���Ҽǵô���������������ľ��������������㶾�棬�������԰ɣ�С����𼱣��Ұ����ҡ�")
		dark()
		light()
		say("�����ö�֩�룡")
		if WarMain(63) == false then
			instruct_15()
			return
		end				
		say("��������ֻ�ɣ�С���������������")
		say("....лл��", 631)
		if not hasPet() and not instruct_20() then			
			say("С������һ������������Ż���̫Σ���ˣ���Щ�˳���������������ģ��㻹�Ǹ�����һ���и���Ӧ��")
			say("....�á�", 631)
			dark()
			null(-2, 110)
			light()			
			instruct_10(631)
			setPet(5)
		else
			dark()
			null(-2, 110)
			light()
			say("�ף���ô������....������һ��ҩ��....")
			addthing(256, 1)
		end
	else
		say("��һ�²�����һ��....�����¾���֩���ˣ�����Ϊ��....")
		say("....��Ҫȥ���ҵ�����ˡ�", 631)
		dark()
		null(-2, 110)
		light()
	end
	tb(addfame(3))
	tb("���������")
end

nEvent[108] = function()	
	say("�໡�", 613)
	say("�������ֻ��Գ�ɣ������ʲô����������������ע�����ͺ���....")
	if hasthing(24) then
		say("�Ҽǵ�����˵������Ⱦƣ��Ҿ����⼴ī�Ͼ�����....")
		addthing(24, -1)
		dark()
		light()
		say("....", 613)
		say("�ɹ��ˣ����������ˣ�Ҫ����ȥ׽������")
		local t = true
		if hasPet() then
			t = false
		end
		if t then
			if not yesno("Ҫ׽����") then
				t = false
			end
		end
		if t then
			say("����������", 613)
			say("�������������ˣ�")
			if WarMain(320) == false then
				instruct_15()
				return
			end	
			null(-2, 110)
			light()
			say("�����������׽ס��....")
			setPet(6)
	    else
			dark()
			addevent(-2, 111, 0, 0, 0, 9168)
			light()
			say("�׹���������ô���������ˡ�", 614)
			say("��λС�����ֻ��Գԭ������ģ�")
			say("�Ų����أ��׹���������������棬���ҵ�����������ˣ����������ϰ��ء�", 614)
			say("���ϰ�����˭....�ѵ���������֣�����������������ƺ���ͨ���£������ˣ������㼸ֻ��ɡ�")
			say("�Ǿ�˵����Ŷ���������Ǿ���Ǯ�����ˡ�", 614)
			say("����������", 613)
			say("�׹�����Ҫ��", 614)
			JY.Person[613]["������"] = JY.Person[613]["������"] + 200
			JY.Person[613]["������"] = JY.Person[613]["������"] + 150
			JY.Person[613]["�Ṧ"] = JY.Person[613]["�Ṧ"] + 150				
			if WarMain(321) == false then
				instruct_15()
				return
			end	
			null(-2, 110)
			JY.Person[613]["������"] = JY.Person[613]["������"] - 200
			JY.Person[613]["������"] = JY.Person[613]["������"] - 150
			JY.Person[613]["�Ṧ"] = JY.Person[613]["�Ṧ"] - 150			
			light()		
			if hasthing(8) and hasthing(16) then
			   if JY.Person[zj()]["Ʒ��"] <= 99 then
			    say("�����׹��������ˣ����⻵�ˡ�", 614)
				say("��������������")
			JY.Person[614]["������"] = JY.Person[614]["������"] + 250
			JY.Person[614]["������"] = JY.Person[614]["������"] + 250
			JY.Person[614]["�Ṧ"] = JY.Person[614]["�Ṧ"] + 250
			JY.Person[614]["�书2"] = 106
			JY.Person[614]["�书3"] = 107
			JY.Person[614]["�书4"] = 108
			JY.Person[614]["�书�ȼ�2"] = 999
			JY.Person[614]["�书�ȼ�3"] = 999
			JY.Person[614]["�书�ȼ�4"] = 999
				SetS(106, 63, 1, 0, 0)
				SetS(106, 63, 2, 0, 614)
				if WarMain(288) == false then
                  say("�����۸��׹�����", 614)
				  dark()
				  null(-2, 111)
				  light()
	            else
			JY.Person[614]["������"] = JY.Person[614]["������"] - 250
			JY.Person[614]["������"] = JY.Person[614]["������"] - 250
			JY.Person[614]["�Ṧ"] = JY.Person[614]["�Ṧ"] - 250
			JY.Person[614]["�书2"] = 0
			JY.Person[614]["�书3"] = 0
			JY.Person[614]["�书4"] = 0
			JY.Person[614]["�书�ȼ�2"] = 0
			JY.Person[614]["�书�ȼ�3"] = 0
			JY.Person[614]["�书�ȼ�4"] = 0
			      say("�����򲻹��㡣", 614)
			      say("��������书��������ޱȣ���")
			      say("ι���𷢴���������ȥ����ɡ�", 614)
			      say("����")
			      if not instruct_20() then		
				      instruct_10(614)
				      dark()
				      null(-2, 111)
				      light()
			      else
				      say("��Ķ����������Ҿͻ�С�����ɡ�", 614)
				      dark()
				      null(-2, 111)
				      setteam(614)
				      light()
			      end
				end
			   elseif JY.Person[zj()]["Ʒ��"] >= 100 then
			      say("�����׹���������ס�", 614)
			      say("����Գ�ﾹȻ�ƺ����������书������֮���������治�У�")
				  say("�����ҩ���ڹ����ˡ�")
			      say("лл��������㡣", 614)
			      say("����")
				  dark()
				  null(-2, 111)
				  light()
				  addHZ(142)
			   end
			else
			    say("�����׹��������ˣ����⻵�ˡ�", 614)
				say("��������������")
                say("�ߣ��������ˡ�", 614)
				  dark()
				  null(-2, 111)
				  light()
			end
		end
	else
		say("����������", 613)
		say("�������������ˣ�")
		if WarMain(320) == false then
			instruct_15()
			return
		end	
		null(-2, 110)
		light()
		say("�����������������....")
		addthing(15, 3)
		addthing(14, 3)
		addthing(24, 5)
	end
	tb(addfame(3))
	tb("���������")	
end
nEvent[109] = function()	
	dark()
	addevent(-2, 111, 0, 0, 0, 9398)
	light()
	say3("��λ���ѣ������������ף�ɽ�����ϡ���СŮ���Ѽ��ǣ���δ����żң���������һԸ�������������󣬵�Ը�Ǹ����ճ�Ⱥ�ĺú�������϶����������ס������ڶ�ʮ�����£���δȢ�ף���ʤ��СŮһȭһ�ŵģ����¼���СŮ�����������������Ի�����֮�أ����˺ú��ض࣬�������»��ƣ����λ����������", 64, "����")
	if JY.Person[zj()]["�Ա�"] == 0 and yesno("Ҫ����̨��") then
		say("�������ԣ�")
		say("�����롣", 635)
		JY.Person[635]["������"] = JY.Person[635]["������"] + 200
		JY.Person[635]["������"] = JY.Person[635]["������"] + 100
		JY.Person[635]["�Ṧ"] = JY.Person[635]["�Ṧ"] + 200
		if WarMain(337) == false then
			say3("��λС�ֵ���Ȼ������������ϧ������СŮ�����䣬���ǶԲ�ס�ˡ�", 64, "����")
			say("����ֻ����ѧ�ղ���....")
			dark()
			null(-2, 110)
			null(-2, 111)
			light()			
		else
			say("��������Σ�����ͷ��˫��ȴ����������", 635)
			say("��Ҳ�Ǻ��������¹���....")
			say3("�úã���λС�ֵ��书��տ���ҾͰ�����и������ˡ�", 64, "����")
			say("��������ģ���һ�����չ˺��¹���ġ�")
			say3("������������������������Ϸ�Ҳ���Է���ȥѰ�����ˡ�", 64, "����")
			dark()
			null(-2, 110)
			light()
			say("�¹�������߰ɡ�")
			say("��....", 635)
			teammate(635)
			null(-2, 111)
			tb(addfame(2))
		end	
		JY.Person[635]["������"] = JY.Person[635]["������"] - 200
		JY.Person[635]["������"] = JY.Person[635]["������"] - 100
		JY.Person[635]["�Ṧ"] = JY.Person[635]["�Ṧ"] - 200			
		tb("���������")	
	else
		dark()
		addevent(-2, 112, 0, 0, 0, 9400)
		light()
		say("���������ԡ�", 616)
		say("�����롣", 635)
		bgtalk("�����书������������������ֻ���ǹ����������ߣ����Ͻ��۲�Ȼ���⣻����Ů�������ܣ������ȹ���ƺ�������һ�ź��ơ�")
		say("����С������", 616)
		bgtalk("�ǹ��Ӿö����£�ͻȻ����һЦ���ٲ����ã��Ʒ����������˷�������Ů��Ҳ�۲����������������ڡ�")
		say("��ѽ��", 635)
		bgtalk("��Ů���У��ۼ�Ҫ������̨���ǹ����ұ۳�ȥ���ѽ������ڻ���Թ������ֺȲʣ������֣��ҳ�һƬ��")
		say("���ߵ�����ͨ�죩�ſ��ң�", 635)
		say("�����һ���׸�磬�Ҿͷ��㡣", 616)
		bgtalk("����Ů���ˣ��ɽ�����̫��Ѩ��ȥ��Ҫ�������ܲ��ſ����֡��ǹ����ұ����ѣ����ֵ��ܣ����󹳳���������ס�����߹������ҽš��������ù��򾹵���Ӧ�֣��������������㡣����Ů�������������㣬�������ź컨����Ь�������ȥ�������������������������ڵ��£����ߵ�ͷ�����Űײ����ӡ��ǹ���������Ц������Ь���ڱǱ�����һ�š��Թ۵����������в��˻���Ȥ֮��������塣")
		say3("����ʤ����������մ�����", 64, "����")
		say("����˵�˰ɣ��Ҹ��Żؼҡ�", 616)
		say3("���ʤ��СŮ�����������ȣ���Ȼ��Ů��������㡣������£���������", 64, "����")
		say("������ȭ�������棬��Ҳ��Ȥ��������������ɶ�л�ˣ�", 616)
		say3("��....����....��", 64, "����")
		say("ι���������ɲ��԰���")
		say("����ƨ�£��߿���", 616)	
		JY.Person[616]["������"] = JY.Person[616]["������"] + 200
		JY.Person[616]["������"] = JY.Person[616]["������"] + 150
		JY.Person[616]["�Ṧ"] = JY.Person[616]["�Ṧ"] + 150			
		if WarMain(338) == false then
			instruct_15(0);   
			instruct_0();  
			do return; end		
		end
		JY.Person[616]["�书�ȼ�1"] = 400
		JY.Person[616]["������"] = JY.Person[616]["������"] - 200
		JY.Person[616]["������"] = JY.Person[616]["������"] - 150
		JY.Person[616]["�Ṧ"] = JY.Person[616]["�Ṧ"] - 150			
		say("�ߣ���С�ӣ�Сү���£������������ˣ�", 616)
		dark()
		null(-2, 112)
		light()
		say3("лл��λС�ֵ����Ҹ�Ů����ͷ��������ȣ������߰ɡ�", 64, "����")
		if (GetS(113,0,0,0) == 0 and PersonKF(zj(),68)) and sixi(zj(),4) >= 300 then
			say3("�Եȣ�С�϶�ͻȻ����һ�����������", 64, "����")
			say3("��˵���������õ������ǹ����", 64, "����")
			say("���ǣ�������Ϊ���д�һ�ʣ�")
			say3("ûʲô��ֻ�Ǿ�������������ᣬ��ǹ�Ϲ���ȴ�����������˳Ծ�", 64, "����")
			say("�����������ˣ��ٺ�")
			say3("�Ǻǣ�С�϶�����һ���ӵ����ǹ�������ܶ������������߲�������", 64, "����")
			say3("��������һ˵", 64, "����")
			say3("���ų�������������С�϶�ûʲô�ûر���", 64, "����")
			say3("����һ������õ���ǹ�ף�С�϶��书̫�Σ��ǿ�����Ҳ��������", 64, "����")
			say3("�͸������ο�������", 64, "����")
			if DrawStrBoxYesNo(-1, -1, "Ҫ������", C_WHITE, 30) == true then
				QZXS("���ǹ����������ԭǹ�⣡��")
				setLW1(68)
				say("������������������ǹ֮����ˣ���")
				say("С�Ӷ�������֮���ʵ��������л��")
				say("���պ�����������Ҫ������С��Ѱ�ң�С�ӱض���æ��")
				say3("��������˵��˵", 64, "����")
			else
				say("��...ʵ�ں��������ǻ���ʲô�ö�����")
				say("����������������Ͳ����ˣ�")
				say3("��ע�⵽����ɫ�ѿ�������������գ�С�϶��������һ��", 64, "����")
				say3("֮������������Ե��С�϶����б���", 64, "����")
				say("...����������")
			end
		end	
		dark()
		null(-2, 110)
		null(-2, 111)
		for i = 4, 7 do
			addevent(108, i, 1, 1351, 1, -2)
		end
		light()
		daode(2)
		tb(addfame(2))
		tb("���������")	
	end
end
nEvent[110] = function()	

end
nEvent[111] = function()	

end
nEvent[112] = function()	

end